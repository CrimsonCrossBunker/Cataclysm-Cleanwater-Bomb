#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"

TEST_CASE( "lua_platform_exact_creature_subtypes_fail_closed", "[lua][platform]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 6 );
    monster value;
    value.set_hp( 1 );
    const cata::lua_platform::game_handle handle =
        cata::lua_platform::game_handle::from_creature(
            value, { "monster", 0, 0, 0, 0, {} }, runtime, 2 );

    std::optional<cata::lua_platform::game_handle_error> error;
    CHECK( handle.subtype_name() == "monster" );
    CHECK( cata::lua_platform::resolve_exact_monster(
               handle, runtime, 2, error ) == &value );
    CHECK_FALSE( error );
    CHECK( cata::lua_platform::resolve_exact_character(
               handle, runtime, 2, error ) == nullptr );
    REQUIRE( error );
    CHECK( error->code == "wrong_subtype" );
    CHECK( cata::lua_platform::resolve_exact_npc(
               handle, runtime, 2, error ) == nullptr );
    REQUIRE( error );
    CHECK( error->code == "wrong_subtype" );

    value.set_hp( 0 );
    CHECK( cata::lua_platform::resolve_exact_monster(
               handle, runtime, 2, error ) == nullptr );
    REQUIRE( error );
    CHECK( error->code == "dead" );
}

TEST_CASE( "lua_platform_npc_and_avatar_handles_require_exact_subtypes", "[lua][platform]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 47 );
    monster value;
    value.set_hp( 1 );

    const cata::lua_platform::game_handle npc_labeled_monster =
        cata::lua_platform::game_handle::from_creature(
            value, { "npc", 1, 0, 0, 0, {} }, runtime, 5 );
    std::optional<cata::lua_platform::game_handle_error> error;
    CHECK( cata::lua_platform::resolve_exact_npc(
               npc_labeled_monster, runtime, 5, error ) == nullptr );
    REQUIRE( error );
    CHECK( error->code == "wrong_subtype" );

    const cata::lua_platform::game_handle avatar_labeled_monster =
        cata::lua_platform::game_handle::from_creature(
            value, { "avatar", 1, 0, 0, 0, {} }, runtime, 5 );
    CHECK( cata::lua_platform::resolve_exact_avatar(
               avatar_labeled_monster, runtime, 5, error ) == nullptr );
    REQUIRE( error );
    CHECK( error->code == "wrong_subtype" );
}

TEST_CASE( "lua_platform_npc_identity_generation_rejects_id_replacement",
           "[lua][platform][npc]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 48 );
    npc original;
    original.normalize();
    original.setID( character_id( 1201 ), true );
    const cata::lua_platform::game_handle original_handle =
        cata::lua_platform::game_handle::from_creature(
            original, { "npc", 1201, 0, 0, 0, {} }, runtime, 6 );

    std::optional<cata::lua_platform::game_handle_error> error;
    REQUIRE( cata::lua_platform::resolve_exact_npc(
                 original_handle, runtime, 6, error ) == &original );
    CHECK_FALSE( error );

    original.setID( character_id( 1202 ), true );
    CHECK( cata::lua_platform::resolve_exact_npc(
               original_handle, runtime, 6, error ) == nullptr );
    REQUIRE( error );
    CHECK( error->code == "stale_identity" );
}

TEST_CASE( "lua_platform_npc_identity_generation_rejects_same_id_replacement",
           "[lua][platform][npc]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 49 );
    npc original;
    original.normalize();
    original.setID( character_id( 1203 ), true );
    const cata::lua_platform::game_handle original_handle =
        cata::lua_platform::game_handle::from_creature(
            original, { "npc", 1203, 0, 0, 0, {} }, runtime, 7 );

    npc replacement;
    replacement.normalize();
    replacement.setID( character_id( 1203 ), true );
    const cata::lua_platform::game_handle replacement_handle =
        cata::lua_platform::game_handle::from_creature(
            replacement, { "npc", 1203, 0, 0, 0, {} }, runtime, 7 );

    std::optional<cata::lua_platform::game_handle_error> error;
    CHECK( cata::lua_platform::resolve_exact_npc(
               original_handle, runtime, 7, error ) == nullptr );
    REQUIRE( error );
    CHECK( error->code == "stale_identity" );
    CHECK( cata::lua_platform::resolve_exact_npc(
               replacement_handle, runtime, 7, error ) == &replacement );
    CHECK_FALSE( error );
}

TEST_CASE( "lua_platform_npc_unload_reload_and_death_fail_closed",
           "[lua][platform][npc]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 50 );
    npc value;
    value.normalize();
    value.setID( character_id( 1204 ), true );
    cata::lua_platform::register_npc_handle_identity( value );
    const cata::lua_platform::game_handle before_unload =
        cata::lua_platform::game_handle::from_creature(
            value, { "npc", 1204, 0, 0, 0, {} }, runtime, 8 );

    cata::lua_platform::retire_npc_handle_identity( value );
    std::optional<cata::lua_platform::game_handle_error> error;
    CHECK( cata::lua_platform::resolve_exact_npc(
               before_unload, runtime, 8, error ) == nullptr );
    REQUIRE( error );
    CHECK( error->code == "stale_identity" );

    cata::lua_platform::register_npc_handle_identity( value );
    const cata::lua_platform::game_handle after_reload =
        cata::lua_platform::game_handle::from_creature(
            value, { "npc", 1204, 0, 0, 0, {} }, runtime, 8 );
    CHECK( cata::lua_platform::resolve_exact_npc(
               after_reload, runtime, 8, error ) == &value );
    CHECK_FALSE( error );

    value.set_part_hp_cur( bodypart_id( "torso" ), 0 );
    REQUIRE( value.is_dead_state() );
    CHECK( cata::lua_platform::resolve_exact_npc(
               after_reload, runtime, 8, error ) == nullptr );
    REQUIRE( error );
    CHECK( error->code == "dead" );
    cata::lua_platform::retire_npc_handle_identity( value );
}

TEST_CASE( "lua_platform_npc_handles_reject_stale_owner_world_and_runtime",
           "[lua][platform][npc]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const auto other_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 51 );
    const cata::lua_platform::game_handle_runtime other_runtime( other_owner, 51 );
    const cata::lua_platform::game_handle_runtime newer_runtime( owner, 52 );
    npc value;
    value.normalize();
    value.setID( character_id( 1205 ), true );
    const cata::lua_platform::game_handle handle =
        cata::lua_platform::game_handle::from_creature(
            value, { "npc", 1205, 0, 0, 0, {} }, runtime, 9 );

    std::optional<cata::lua_platform::game_handle_error> error;
    CHECK( cata::lua_platform::resolve_exact_npc(
               handle, runtime, 10, error ) == nullptr );
    REQUIRE( error );
    CHECK( error->code == "stale_world" );
    CHECK( cata::lua_platform::resolve_exact_npc(
               handle, other_runtime, 9, error ) == nullptr );
    REQUIRE( error );
    CHECK( error->code == "stale_runtime" );
    CHECK( cata::lua_platform::resolve_exact_npc(
               handle, newer_runtime, 9, error ) == nullptr );
    REQUIRE( error );
    CHECK( error->code == "stale_runtime" );
}

TEST_CASE( "lua_platform_npc_write_gate_precedes_exact_resolution",
           "[lua][platform][npc]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 53 );
    const auto current_runtime = [&]() {
        return runtime;
    };
    const auto current_world = []() {
        return std::size_t( 10 );
    };
    npc target;
    target.normalize();
    target.setID( character_id( 1206 ), true );
    avatar explicit_owner;
    explicit_owner.normalize();
    explicit_owner.setID( character_id( 1207 ), true );
    const cata::lua_platform::game_handle target_handle =
        cata::lua_platform::game_handle::from_creature(
            target, { "npc", 1206, 0, 0, 0, {} }, runtime, 10 );
    const cata::lua_platform::game_handle owner_handle =
        cata::lua_platform::game_handle::from_creature(
            explicit_owner, { "avatar", 1207, 0, 0, 0, {} }, runtime, 10 );

    bool write_gate_called = false;
    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_game_handle_api(
        lua, services, current_runtime, current_world, []() {} );
    cata::lua_platform::install_npc_api(
        services, current_runtime, current_world, []() {},
        [&]() {
        write_gate_called = true;
        owner->retire();
    }, []() {} );

    const sol::table npc_services = services["npcs"];
    const sol::protected_function set_radio =
        npc_services["set_radio_representative"];
    const sol::protected_function_result result =
        set_radio( target_handle, owner_handle, true );
    REQUIRE( result.valid() );
    CHECK( write_gate_called );
    const sol::table envelope = result.get<sol::table>();
    CHECK_FALSE( envelope["ok"].get<bool>() );
    CHECK( envelope["error"].get<sol::table>()["code"].get<std::string>() ==
           "stale_runtime" );
}

TEST_CASE( "lua_platform_open_dialogue_reports_synchronous_native_outcomes",
           "[lua][platform][npc][dialogue]" )
{
    sol::state lua;
    sol::state_view state( lua.lua_state() );

    const sol::table not_started =
        cata::lua_platform::detail::make_npc_dialogue_result(
            state, avatar_talk_to_result::not_started );
    REQUIRE( not_started["ok"].get<bool>() );
    const sol::table not_started_value =
        not_started["value"].get<sol::table>();
    CHECK( not_started_value["status"].get<std::string>() == "not_started" );
    CHECK_FALSE( not_started_value["started"].get<bool>() );
    CHECK_FALSE( not_started_value["completed"].get<bool>() );
    CHECK_FALSE( not_started_value["session"].valid() );

    avatar speaker;
    speaker.normalize();
    speaker.setID( character_id( 1273 ), true );
    npc refusing_npc;
    refusing_npc.normalize();
    refusing_npc.setID( character_id( 1274 ), true );
    refusing_npc.set_attitude( NPCATT_KILL );
    const avatar_talk_to_result rejected_native = speaker.talk_to(
                get_talker_for( refusing_npc ), false, false, false,
                "TALK_EXPLICIT_TEST", std::string(), false );
    REQUIRE( rejected_native == avatar_talk_to_result::rejected );
    const sol::table rejected =
        cata::lua_platform::detail::make_npc_dialogue_result(
            state, rejected_native );
    const sol::table rejected_value =
        rejected["value"].get<sol::table>();
    CHECK( rejected_value["status"].get<std::string>() == "rejected" );
    CHECK_FALSE( rejected_value["started"].get<bool>() );
    CHECK_FALSE( rejected_value["completed"].get<bool>() );

    CHECK( speaker.talk_to( std::unique_ptr<talker>() ) ==
           avatar_talk_to_result::not_started );

    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 73 );
    dialogue conversation(
        std::make_unique<talker_topic>(), std::make_unique<talker_topic>() );
    const cata::lua_platform::dialogue::dialogue_session_ptr session =
        cata::lua_platform::dialogue::begin_session(
            conversation, runtime, 18 );
    REQUIRE( session->active() );
    cata::lua_platform::dialogue::end_session( conversation );
    REQUIRE_FALSE( session->active() );

    const sol::table completed =
        cata::lua_platform::detail::make_npc_dialogue_result(
            state, avatar_talk_to_result::completed );
    REQUIRE( completed["ok"].get<bool>() );
    const sol::table completed_value =
        completed["value"].get<sol::table>();
    CHECK( completed_value["status"].get<std::string>() == "completed" );
    CHECK( completed_value["started"].get<bool>() );
    CHECK( completed_value["completed"].get<bool>() );
    std::set<std::string> completed_fields;
    for( const auto &entry : completed_value ) {
        REQUIRE( entry.first.is<std::string>() );
        completed_fields.insert( entry.first.as<std::string>() );
    }
    CHECK( completed_fields == std::set<std::string> {
        "completed", "started", "status"
    } );
}

TEST_CASE( "lua_platform_open_dialogue_requires_exact_handles_and_topic",
           "[lua][platform][npc][dialogue][contract]" )
{
    platform_npc_dialogue_fixture fixture;
    const sol::protected_function open = fixture.open_dialogue();

    const sol::protected_function_result missing_topic =
        open( fixture.target_handle, fixture.speaker_handle );
    CHECK_FALSE( missing_topic.valid() );

    const sol::protected_function_result illegal_topic =
        open( fixture.target_handle, fixture.speaker_handle, "TALK\nINVALID" );
    CHECK_FALSE( illegal_topic.valid() );

    const sol::protected_function_result unknown_topic =
        open( fixture.target_handle, fixture.speaker_handle,
              "TALK_CCB_PLATFORM_UNKNOWN" );
    CHECK_FALSE( unknown_topic.valid() );

    const sol::protected_function_result missing_avatar =
        open( fixture.target_handle, "TALK_CCB_PLATFORM_UNKNOWN" );
    CHECK_FALSE( missing_avatar.valid() );
    const sol::protected_function_result no_participants =
        open( "TALK_CCB_PLATFORM_UNKNOWN" );
    CHECK_FALSE( no_participants.valid() );

    const sol::table npcs = fixture.services["npcs"];
    CHECK_FALSE( npcs["open_current_dialogue"].valid() );
    CHECK_FALSE( npcs["open_nearby_dialogue"].valid() );
    CHECK( fixture.services["dialogue"].get_type() == sol::type::none );
}

TEST_CASE( "lua_platform_open_dialogue_scopes_platform_topics_to_calling_runtime",
           "[lua][platform][npc][dialogue][runtime]" )
{
    cata::lua_platform::clear_active_runtimes();
    on_out_of_scope cleanup( []() {
        cata::lua_platform::clear_active_runtimes();
    } );

    sol::state owner_lua;
    sol::table owner_ccb = owner_lua.create_table();
    const std::shared_ptr<cata::lua_platform::runtime> owner_runtime =
        cata::lua_platform::make_runtime(
            "dialogue_topic_owner", 81, owner_lua );
    cata::lua_platform::install_runtime_api(
        owner_runtime, owner_lua, owner_ccb );

    const sol::table dialogue_api = owner_ccb["dialogue"];
    const sol::protected_function register_topic =
        dialogue_api["register_topic"];
    sol::table descriptor = owner_lua.create_table();
    descriptor["id"] = "TALK_CCB_DECLARATIVE_OWNER";
    descriptor["dynamic_line"] = "Registered Platform topic";
    descriptor["responses"] = owner_lua.create_table();
    const sol::protected_function_result declarative_registration =
        register_topic( descriptor );
    REQUIRE( declarative_registration.valid() );

    const sol::table runtime_api = owner_ccb["runtime"];
    owner_lua.set_function( "ccb_test_dialogue_handler", []() {} );
    const sol::protected_function register_handler = runtime_api["handler"];
    const sol::object handler_callback =
        owner_lua["ccb_test_dialogue_handler"];
    const sol::protected_function_result handler_registration =
        register_handler(
            "ccb_test_dialogue_handler", handler_callback );
    REQUIRE( handler_registration.valid() );
    const sol::protected_function register_handler_topic =
        runtime_api["dialogue_topic"];
    const sol::protected_function_result handler_topic_registration =
        register_handler_topic(
            "TALK_CCB_HANDLER_OWNER", "ccb_test_dialogue_handler" );
    REQUIRE( handler_topic_registration.valid() );

    cata::lua_platform::set_active_runtimes( { owner_runtime } );
    const cata::lua_platform::game_handle_runtime owner_identity =
        cata::lua_platform::detail::runtime_handle_identity( owner_runtime );
    const std::size_t world_generation =
        cata::lua_platform::runtime_world_generation();
    REQUIRE( cata::lua_platform::detail::runtime_has_dialogue_topic(
                 "TALK_CCB_DECLARATIVE_OWNER", owner_identity,
                 world_generation ) );
    REQUIRE( cata::lua_platform::detail::runtime_has_dialogue_topic(
                 "TALK_CCB_HANDLER_OWNER", owner_identity,
                 world_generation ) );
    CHECK_FALSE( cata::lua_platform::detail::runtime_has_dialogue_topic(
                     "TALK_CCB_UNKNOWN_OWNER", owner_identity,
                     world_generation ) );
    CHECK_FALSE( cata::lua_platform::detail::runtime_has_dialogue_topic(
                     "TALK_CCB_DECLARATIVE_OWNER", owner_identity,
                     world_generation + 1 ) );

    platform_registered_dialogue_call_fixture owner_call(
        owner_identity, world_generation, 1281 );
    const sol::protected_function owner_open = owner_call.open_dialogue();
    for( const std::string &topic : {
             std::string( "TALK_CCB_DECLARATIVE_OWNER" ),
             std::string( "TALK_CCB_HANDLER_OWNER" )
         } ) {
        const sol::protected_function_result result = owner_open(
                    owner_call.target_handle, owner_call.speaker_handle, topic );
        REQUIRE( result.valid() );
        const sol::table envelope = result.get<sol::table>();
        REQUIRE( envelope["ok"].get<bool>() );
        const sol::table value = envelope["value"].get<sol::table>();
        CHECK( value["status"].get<std::string>() == "rejected" );
        CHECK_FALSE( value["completed"].get<bool>() );
    }

    const std::vector<std::string> native_topics = get_all_talk_topic_ids();
    REQUIRE_FALSE( native_topics.empty() );
    const sol::protected_function_result native_result = owner_open(
                owner_call.target_handle, owner_call.speaker_handle,
                native_topics.front() );
    REQUIRE( native_result.valid() );
    REQUIRE( native_result.get<sol::table>()["ok"].get<bool>() );

    const sol::protected_function_result unknown_result = owner_open(
                owner_call.target_handle, owner_call.speaker_handle,
                "TALK_CCB_UNKNOWN_OWNER" );
    CHECK_FALSE( unknown_result.valid() );

    sol::state foreign_lua;
    const std::shared_ptr<cata::lua_platform::runtime> foreign_runtime =
        cata::lua_platform::make_runtime(
            "dialogue_topic_foreign", 81, foreign_lua );
    cata::lua_platform::set_active_runtimes( {
        owner_runtime, foreign_runtime
    } );
    const cata::lua_platform::game_handle_runtime foreign_identity =
        cata::lua_platform::detail::runtime_handle_identity( foreign_runtime );
    CHECK_FALSE( cata::lua_platform::detail::runtime_has_dialogue_topic(
                     "TALK_CCB_DECLARATIVE_OWNER", foreign_identity,
                     world_generation ) );
    platform_registered_dialogue_call_fixture foreign_call(
        foreign_identity, world_generation, 1283 );
    const sol::protected_function_result foreign_result =
        foreign_call.open_dialogue()(
            foreign_call.target_handle, foreign_call.speaker_handle,
            "TALK_CCB_DECLARATIVE_OWNER" );
    CHECK_FALSE( foreign_result.valid() );

    cata::lua_platform::set_active_runtimes( { foreign_runtime } );
    CHECK_FALSE( cata::lua_platform::detail::runtime_has_dialogue_topic(
                     "TALK_CCB_DECLARATIVE_OWNER", owner_identity,
                     world_generation ) );
    const sol::protected_function_result stale_runtime_result = owner_open(
                owner_call.target_handle, owner_call.speaker_handle,
                "TALK_CCB_DECLARATIVE_OWNER" );
    CHECK_FALSE( stale_runtime_result.valid() );
}

TEST_CASE( "lua_platform_open_dialogue_rejection_is_not_completion",
           "[lua][platform][npc][dialogue]" )
{
    const std::vector<std::string> topics = get_all_talk_topic_ids();
    REQUIRE_FALSE( topics.empty() );
    platform_npc_dialogue_fixture fixture;
    fixture.target.set_attitude( NPCATT_KILL );

    const sol::protected_function_result result = fixture.open_dialogue()(
                fixture.target_handle, fixture.speaker_handle, topics.front() );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE( envelope["ok"].get<bool>() );
    const sol::table value = envelope["value"].get<sol::table>();
    CHECK( value["status"].get<std::string>() == "rejected" );
    CHECK_FALSE( value["started"].get<bool>() );
    CHECK_FALSE( value["completed"].get<bool>() );
    CHECK_FALSE( value["session"].valid() );
}

TEST_CASE( "lua_platform_open_dialogue_rejects_stale_participants_and_generations",
           "[lua][platform][npc][dialogue]" )
{
    const std::vector<std::string> topics = get_all_talk_topic_ids();
    REQUIRE_FALSE( topics.empty() );
    const std::string topic = topics.front();

    SECTION( "NPC native identity" ) {
        platform_npc_dialogue_fixture fixture;
        fixture.target.setID( character_id( 1275 ), true );
        const sol::protected_function_result result = fixture.open_dialogue()(
                    fixture.target_handle, fixture.speaker_handle, topic );
        REQUIRE( result.valid() );
        const sol::table envelope = result.get<sol::table>();
        CHECK_FALSE( envelope["ok"].get<bool>() );
        CHECK( envelope["error"].get<sol::table>()["code"].get<std::string>() ==
               "stale_identity" );
    }

    SECTION( "avatar native identity" ) {
        platform_npc_dialogue_fixture fixture;
        fixture.speaker.setID( character_id( 1276 ), true );
        const sol::protected_function_result result = fixture.open_dialogue()(
                    fixture.target_handle, fixture.speaker_handle, topic );
        REQUIRE( result.valid() );
        const sol::table envelope = result.get<sol::table>();
        CHECK_FALSE( envelope["ok"].get<bool>() );
        CHECK( envelope["error"].get<sol::table>()["code"].get<std::string>() ==
               "stale_identity" );
    }

    SECTION( "runtime owner" ) {
        platform_npc_dialogue_fixture fixture;
        fixture.active_runtime = fixture.other_runtime;
        const sol::protected_function_result result = fixture.open_dialogue()(
                    fixture.target_handle, fixture.speaker_handle, topic );
        REQUIRE( result.valid() );
        const sol::table envelope = result.get<sol::table>();
        CHECK_FALSE( envelope["ok"].get<bool>() );
        CHECK( envelope["error"].get<sol::table>()["code"].get<std::string>() ==
               "stale_runtime" );
    }

    SECTION( "runtime generation" ) {
        platform_npc_dialogue_fixture fixture;
        fixture.active_runtime = fixture.newer_runtime;
        const sol::protected_function_result result = fixture.open_dialogue()(
                    fixture.target_handle, fixture.speaker_handle, topic );
        REQUIRE( result.valid() );
        const sol::table envelope = result.get<sol::table>();
        CHECK_FALSE( envelope["ok"].get<bool>() );
        CHECK( envelope["error"].get<sol::table>()["code"].get<std::string>() ==
               "stale_runtime" );
    }

    SECTION( "world generation" ) {
        platform_npc_dialogue_fixture fixture;
        ++fixture.active_world;
        const sol::protected_function_result result = fixture.open_dialogue()(
                    fixture.target_handle, fixture.speaker_handle, topic );
        REQUIRE( result.valid() );
        const sol::table envelope = result.get<sol::table>();
        CHECK_FALSE( envelope["ok"].get<bool>() );
        CHECK( envelope["error"].get<sol::table>()["code"].get<std::string>() ==
               "stale_world" );
    }
}

TEST_CASE( "lua_platform_dialogue_sessions_invalidate_topics_and_participants",
           "[lua][platform]" )
{
    monster participant{ mtype_id( "mon_zombie" ) };
    participant.set_hp( 1 );
    dialogue conversation(
        std::make_unique<talker_monster>( &participant ),
        std::make_unique<talker_topic>() );
    const auto runtime_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( runtime_owner, 1 );
    const std::size_t world_generation = 1;

    const cata::lua_platform::dialogue::dialogue_session_ptr session =
        cata::lua_platform::dialogue::begin_session(
            conversation, runtime, world_generation );
    const cata::lua_platform::dialogue::dialogue_session_ptr topic_session =
        cata::lua_platform::dialogue::session_for(
            conversation, "TALK_ONE", runtime, world_generation );
    REQUIRE( topic_session == session );
    CHECK( topic_session->active_for( "TALK_ONE" ) );
    CHECK( topic_session->speaker_snapshot().present );
    CHECK( topic_session->speaker_snapshot().entity );
    CHECK( topic_session->speaker_snapshot().kind == "monster" );

    const cata::lua_platform::dialogue::dialogue_session_ptr replacement_session =
        cata::lua_platform::dialogue::session_for(
            conversation, "TALK_TWO", runtime, world_generation );
    REQUIRE( replacement_session != topic_session );
    CHECK( replacement_session->generation() != topic_session->generation() );
    CHECK_FALSE( topic_session->active_for( "TALK_ONE" ) );
    CHECK_FALSE( topic_session->active() );
    CHECK( replacement_session->active_for( "TALK_TWO" ) );

    participant.set_hp( 0 );
    CHECK_FALSE( replacement_session->active_for( "TALK_TWO" ) );

    cata::lua_platform::dialogue::end_session( conversation );
    CHECK_FALSE( topic_session->active() );
}

TEST_CASE( "lua_platform_dialogue_response_callbacks_reject_stale_topics",
           "[lua][platform][dialogue]" )
{
    cata::lua_platform::dialogue::clear_response_callbacks();
    monster participant{ mtype_id( "mon_zombie" ) };
    participant.set_hp( 1 );
    dialogue conversation(
        std::make_unique<talker_monster>( &participant ),
        std::make_unique<talker_topic>() );
    const auto runtime_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( runtime_owner, 1 );
    const std::size_t world_generation = 1;
    cata::lua_platform::dialogue::begin_session(
        conversation, runtime, world_generation );
    const cata::lua_platform::dialogue::dialogue_session_ptr first_session =
        cata::lua_platform::dialogue::session_for(
            conversation, "TALK_ONE", runtime, world_generation );
    std::size_t callback_calls = 0;
    const std::uint64_t replaced_callback =
        cata::lua_platform::dialogue::register_response_callback(
            cata::lua_platform::dialogue::response_callback_origin::platform,
            [&]( dialogue &, const talk_topic &, bool ) {
        ++callback_calls;
        return talk_topic( "CALLBACK_RAN" );
    }, first_session, "TALK_ONE" );

    const cata::lua_platform::dialogue::dialogue_session_ptr second_session =
        cata::lua_platform::dialogue::session_for(
            conversation, "TALK_TWO", runtime, world_generation );
    const talk_topic fallback( "FALLBACK" );
    const talk_topic after_topic_replacement =
        cata::lua_platform::dialogue::apply_response_callback(
            conversation, replaced_callback, fallback, true );
    CHECK( after_topic_replacement.id == fallback.id );
    CHECK( callback_calls == 0 );
    CHECK( second_session->active_for( "TALK_TWO" ) );

    const std::uint64_t ended_callback =
        cata::lua_platform::dialogue::register_response_callback(
            cata::lua_platform::dialogue::response_callback_origin::platform,
            [&]( dialogue &, const talk_topic &, bool ) {
        ++callback_calls;
        return talk_topic( "CALLBACK_RAN" );
    }, second_session, "TALK_TWO" );
    cata::lua_platform::dialogue::end_session( conversation );
    const talk_topic after_dialogue_end =
        cata::lua_platform::dialogue::apply_response_callback(
            conversation, ended_callback, fallback, true );
    CHECK( after_dialogue_end.id == fallback.id );
    CHECK( callback_calls == 0 );
    cata::lua_platform::dialogue::clear_response_callbacks();
}

TEST_CASE( "lua_platform_dialogue_participants_keep_exact_npc_identity",
           "[lua][platform][dialogue][npc]" )
{
    npc speaker;
    speaker.normalize();
    speaker.setID( character_id( 1210 ), true );
    npc interlocutor;
    interlocutor.normalize();
    interlocutor.setID( character_id( 1211 ), true );
    dialogue conversation(
        std::make_unique<talker_npc>( &speaker ),
        std::make_unique<talker_npc>( &interlocutor ) );
    const auto runtime_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( runtime_owner, 1 );
    const std::size_t world_generation = 1;
    const cata::lua_platform::dialogue::dialogue_session_ptr session =
        cata::lua_platform::dialogue::begin_session(
            conversation, runtime, world_generation );

    REQUIRE( session->speaker_snapshot().entity );
    REQUIRE( session->interlocutor_snapshot().entity );
    CHECK( session->speaker_snapshot().kind == "npc" );
    CHECK( session->interlocutor_snapshot().kind == "npc" );
    REQUIRE( session->speaker_snapshot().stable_id );
    REQUIRE( session->interlocutor_snapshot().stable_id );
    CHECK( *session->speaker_snapshot().stable_id == 1210 );
    CHECK( *session->interlocutor_snapshot().stable_id == 1211 );
    CHECK( session->participants_live() );

    cata::lua_platform::dialogue::end_session( conversation );
    CHECK_FALSE( session->participants_live() );
}

TEST_CASE( "lua_platform_dialogue_detached_participants_are_snapshots",
           "[lua][platform]" )
{
    dialogue conversation(
        std::make_unique<talker_topic>(), std::make_unique<talker_topic>() );
    const auto runtime_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( runtime_owner, 1 );
    const std::size_t world_generation = 1;
    const cata::lua_platform::dialogue::dialogue_session_ptr session =
        cata::lua_platform::dialogue::begin_session(
            conversation, runtime, world_generation );

    CHECK( session->speaker_snapshot().present );
    CHECK_FALSE( session->speaker_snapshot().entity );
    CHECK( session->speaker_snapshot().kind == "topic" );
    CHECK( session->participants_live() );

    cata::lua_platform::dialogue::end_session( conversation );
    CHECK_FALSE( session->participants_live() );
}

TEST_CASE( "lua_platform_dialogue_sessions_reject_stale_identity_without_dereference",
           "[lua][platform][dialogue]" )
{
    monster participant{ mtype_id( "mon_zombie" ) };
    participant.set_hp( 1 );
    dialogue conversation(
        std::make_unique<talker_monster>( &participant ),
        std::make_unique<talker_topic>() );
    const auto runtime_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const auto foreign_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( runtime_owner, 7 );
    const cata::lua_platform::game_handle_runtime newer_runtime( runtime_owner, 8 );
    const cata::lua_platform::game_handle_runtime foreign_runtime( foreign_owner, 7 );
    const std::size_t world_generation = 4;
    const std::size_t newer_world_generation = 5;
    const cata::lua_platform::dialogue::dialogue_session_ptr session =
        cata::lua_platform::dialogue::begin_session(
            conversation, runtime, world_generation );
    const cata::lua_platform::dialogue::dialogue_session_ptr topic_session =
        cata::lua_platform::dialogue::session_for(
            conversation, "TALK_ONE", runtime, world_generation );
    REQUIRE( topic_session == session );
    CHECK( session->active_for( "TALK_ONE", runtime, world_generation,
                                &conversation ) );

    const std::optional<cata::lua_platform::game_handle_error> foreign_error =
        session->validation_error( &conversation, foreign_runtime, world_generation );
    REQUIRE( foreign_error );
    CHECK( foreign_error->code == "stale_runtime" );
    const std::optional<cata::lua_platform::game_handle_error> generation_error =
        session->validation_error( &conversation, newer_runtime, world_generation );
    REQUIRE( generation_error );
    CHECK( generation_error->code == "stale_runtime" );
    const std::optional<cata::lua_platform::game_handle_error> world_error =
        session->validation_error( &conversation, runtime, newer_world_generation );
    REQUIRE( world_error );
    CHECK( world_error->code == "stale_world" );

    dialogue different_conversation(
        std::make_unique<talker_topic>(), std::make_unique<talker_topic>() );
    const std::optional<cata::lua_platform::game_handle_error> native_error =
        session->validation_error( &different_conversation, runtime, world_generation );
    REQUIRE( native_error );
    CHECK( native_error->code == "destroyed" );

    using dialogue_context = cata::lua_platform::dialogue::context;
    dialogue_context context( nullptr, conversation, "TALK_ONE", false,
                              "dialogue context is stale", {}, session,
                              runtime, world_generation );
    CHECK( context.valid() );
    CHECK_FALSE( context.validation_error() );

    dialogue_context foreign_context( nullptr, conversation, "TALK_ONE", false,
                                      "dialogue context is stale", {}, session,
                                      foreign_runtime, world_generation );
    CHECK_FALSE( foreign_context.valid() );
    REQUIRE( foreign_context.validation_error() );
    CHECK( foreign_context.validation_error()->code == "stale_runtime" );

    dialogue_context wrong_world_context( nullptr, conversation, "TALK_ONE", false,
                                          "dialogue context is stale", {}, session,
                                          runtime, newer_world_generation );
    CHECK_FALSE( wrong_world_context.valid() );
    REQUIRE( wrong_world_context.validation_error() );
    CHECK( wrong_world_context.validation_error()->code == "stale_world" );

    dialogue_context wrong_native_context( nullptr, different_conversation, "TALK_ONE",
                                           false, "dialogue context is stale", {}, session,
                                           runtime, world_generation );
    CHECK_FALSE( wrong_native_context.valid() );
    REQUIRE( wrong_native_context.validation_error() );
    CHECK( wrong_native_context.validation_error()->code == "destroyed" );

    runtime_owner->retire();
    CHECK_FALSE( context.valid() );
    REQUIRE( context.validation_error() );
    CHECK( context.validation_error()->code == "stale_runtime" );
}

TEST_CASE( "lua_platform_dialogue_session_scope_and_teardown_retirement",
           "[lua][platform][dialogue]" )
{
    const auto first_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const auto second_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime first_runtime( first_owner, 11 );
    const cata::lua_platform::game_handle_runtime second_runtime( second_owner, 11 );
    const std::size_t world_generation = 9;
    cata::lua_platform::dialogue::dialogue_session_ptr stale_after_scope;
    std::unique_ptr<cata::lua_platform::dialogue::context> stale_context;

    {
        dialogue conversation(
            std::make_unique<talker_topic>(), std::make_unique<talker_topic>() );
        stale_after_scope = cata::lua_platform::dialogue::begin_session(
                                conversation, first_runtime, world_generation );
        const cata::lua_platform::dialogue::dialogue_session_ptr second_session =
            cata::lua_platform::dialogue::session_for(
                conversation, "TALK_ONE", second_runtime, world_generation );
        REQUIRE( stale_after_scope != second_session );
        CHECK( stale_after_scope->active() );
        CHECK( second_session->active() );

        stale_context = std::make_unique<cata::lua_platform::dialogue::context>(
                             nullptr, conversation, "TALK_ONE", false,
                             "dialogue context is stale",
                             cata::lua_platform::dialogue::context::actor_converter{}, second_session,
                             second_runtime, world_generation );
        CHECK( stale_context->valid() );

        cata::lua_platform::dialogue::retire_sessions_for_runtime( first_runtime );
        CHECK_FALSE( stale_after_scope->active() );
        CHECK( second_session->active() );

        cata::lua_platform::dialogue::retire_sessions_for_world( world_generation );
        CHECK_FALSE( second_session->active() );
        CHECK_FALSE( stale_context->valid() );
        REQUIRE( stale_context->validation_error() );
        CHECK( stale_context->validation_error()->code == "destroyed" );
    }

    REQUIRE( stale_after_scope );
    CHECK_FALSE( stale_after_scope->active() );
    CHECK_FALSE( stale_context->valid() );
    REQUIRE( stale_context->validation_error() );
    CHECK( stale_context->validation_error()->code == "destroyed" );
}

TEST_CASE( "lua_platform_npc_identity_generation_bump_retires_dialogue_sessions",
           "[lua][platform][dialogue][npc]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 12 );
    const std::size_t previous_world_generation =
        cata::lua_platform::runtime_world_generation();
    dialogue conversation(
        std::make_unique<talker_topic>(), std::make_unique<talker_topic>() );
    cata::lua_platform::dialogue::dialogue_session_ptr session =
        cata::lua_platform::dialogue::begin_session(
            conversation, runtime, previous_world_generation );
    session = cata::lua_platform::dialogue::session_for(
                  conversation, "TALK_IDENTITY_BUMP", runtime,
                  previous_world_generation );
    cata::lua_platform::dialogue::context context(
        nullptr, conversation, "TALK_IDENTITY_BUMP", false,
        "dialogue context is stale", {}, session, runtime,
        previous_world_generation );
    REQUIRE( session );
    CHECK( context.valid() );

    cata::lua_platform::runtime_npc_identity_changed();

    CHECK( cata::lua_platform::runtime_world_generation() !=
           previous_world_generation );
    CHECK_FALSE( session->active() );
    CHECK_FALSE( context.valid() );
    REQUIRE( context.validation_error() );
    CHECK( context.validation_error()->code == "destroyed" );
}

TEST_CASE( "lua_platform_dialogue_move_retires_source_and_target_sessions",
           "[lua][platform][dialogue]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 13 );
    const std::size_t world_generation = 31;

    SECTION( "move construction" ) {
        dialogue source(
            std::make_unique<talker_topic>(), std::make_unique<talker_topic>() );
        source.done = true;
        source.topic_stack.emplace_back( "TALK_MOVE_SOURCE" );
        source.responses.emplace_back();
        source.response_condition_exists.push_back( true );
        source.response_condition_eval.push_back( false );
        source.reason = "move source";
        source.by_radio = true;
        source.debug_conditionals = false;
        source.debug_effects = false;
        source.debug_ignore_conditionals = true;
        cata::lua_platform::dialogue::dialogue_session_ptr source_session =
            cata::lua_platform::dialogue::begin_session(
                source, runtime, world_generation );
        source_session = cata::lua_platform::dialogue::session_for(
                             source, "TALK_MOVE_SOURCE", runtime, world_generation );
        cata::lua_platform::dialogue::context source_context(
            nullptr, source, "TALK_MOVE_SOURCE", false,
            "dialogue context is stale", {}, source_session,
            runtime, world_generation );
        REQUIRE( source_context.valid() );

        dialogue moved( std::move( source ) );

        CHECK_FALSE( source_session->active() );
        CHECK_FALSE( source_context.valid() );
        REQUIRE( source_context.validation_error() );
        CHECK( source_context.validation_error()->code == "destroyed" );
        CHECK( moved.done );
        REQUIRE( moved.topic_stack.size() == 1 );
        CHECK( moved.topic_stack.front().id == "TALK_MOVE_SOURCE" );
        CHECK( moved.responses.size() == 1 );
        CHECK( moved.response_condition_exists == std::vector<bool> { true } );
        CHECK( moved.response_condition_eval == std::vector<bool> { false } );
        CHECK( moved.reason == "move source" );
        CHECK( moved.by_radio );
        CHECK_FALSE( moved.debug_conditionals );
        CHECK_FALSE( moved.debug_effects );
        CHECK( moved.debug_ignore_conditionals );
        CHECK( moved.has_actor( false ) );
        CHECK( moved.has_actor( true ) );

        cata::lua_platform::dialogue::dialogue_session_ptr moved_session =
            cata::lua_platform::dialogue::begin_session(
                moved, runtime, world_generation );
        moved_session = cata::lua_platform::dialogue::session_for(
                            moved, "TALK_MOVE_SOURCE", runtime, world_generation );
        CHECK( moved_session->active_for(
                   "TALK_MOVE_SOURCE", runtime, world_generation, &moved ) );
    }

    SECTION( "move assignment" ) {
        dialogue source(
            std::make_unique<talker_topic>(), std::make_unique<talker_topic>() );
        source.topic_stack.emplace_back( "TALK_MOVE_ASSIGN" );
        source.reason = "assigned source";
        dialogue target(
            std::make_unique<talker_topic>(), std::make_unique<talker_topic>() );

        cata::lua_platform::dialogue::dialogue_session_ptr source_session =
            cata::lua_platform::dialogue::begin_session(
                source, runtime, world_generation );
        source_session = cata::lua_platform::dialogue::session_for(
                             source, "TALK_MOVE_ASSIGN", runtime, world_generation );
        cata::lua_platform::dialogue::context source_context(
            nullptr, source, "TALK_MOVE_ASSIGN", false,
            "dialogue context is stale", {}, source_session,
            runtime, world_generation );
        cata::lua_platform::dialogue::dialogue_session_ptr target_session =
            cata::lua_platform::dialogue::begin_session(
                target, runtime, world_generation );
        target_session = cata::lua_platform::dialogue::session_for(
                             target, "TALK_MOVE_TARGET", runtime, world_generation );
        cata::lua_platform::dialogue::context target_context(
            nullptr, target, "TALK_MOVE_TARGET", false,
            "dialogue context is stale", {}, target_session,
            runtime, world_generation );
        REQUIRE( source_context.valid() );
        REQUIRE( target_context.valid() );

        target = std::move( source );

        CHECK_FALSE( source_session->active() );
        CHECK_FALSE( target_session->active() );
        CHECK_FALSE( source_context.valid() );
        CHECK_FALSE( target_context.valid() );
        REQUIRE( source_context.validation_error() );
        REQUIRE( target_context.validation_error() );
        CHECK( source_context.validation_error()->code == "destroyed" );
        CHECK( target_context.validation_error()->code == "destroyed" );
        REQUIRE( target.topic_stack.size() == 1 );
        CHECK( target.topic_stack.front().id == "TALK_MOVE_ASSIGN" );
        CHECK( target.reason == "assigned source" );
        CHECK( target.has_actor( false ) );
        CHECK( target.has_actor( true ) );

        cata::lua_platform::dialogue::dialogue_session_ptr moved_session =
            cata::lua_platform::dialogue::begin_session(
                target, runtime, world_generation );
        moved_session = cata::lua_platform::dialogue::session_for(
                            target, "TALK_MOVE_ASSIGN", runtime, world_generation );
        CHECK( moved_session->active_for(
                   "TALK_MOVE_ASSIGN", runtime, world_generation, &target ) );
    }
}

#endif // CATA_ENABLE_LUA_PLATFORM
