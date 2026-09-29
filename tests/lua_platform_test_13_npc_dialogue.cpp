#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"
#include "lua_platform_dialogue.h"
#include "condition.h"
#include "avatar.h"
#include "calendar.h"
#include "dialogue.h"
#include "faction.h"
#include "item.h"
#include "json_loader.h"
#include "mission.h"
#include "map.h"
#include "npctalk.h"
#include "talker.h"
#include "talker_avatar.h"
#include "translation.h"
#include "type_id.h"

class platform_item_offer_test_talker : public talker_npc
{
    public:
        platform_item_offer_test_talker( npc *const subject,
                                         std::vector<std::string> results ) :
            talker_npc( subject ), subject_( subject ), results_( std::move( results ) ) {}

        std::string give_item_to( const bool use_item ) override {
            use_item_calls.push_back( use_item );
            trust_before_call.push_back( subject_->op_of_u.trust );
            return results_.at( use_item_calls.size() - 1 );
        }

        std::vector<bool> use_item_calls;
        std::vector<int> trust_before_call;

    private:
        npc *subject_;
        std::vector<std::string> results_;
};

class platform_dialogue_silent_npc_talker : public talker_npc
{
    public:
        explicit platform_dialogue_silent_npc_talker( npc *const subject ) :
            talker_npc( subject ) {}

        std::string disp_name() const override {
            return {};
        }
};

class platform_dialogue_reject_pet_purchase_talker : public talker_avatar
{
    public:
        explicit platform_dialogue_reject_pet_purchase_talker( avatar *subject ) :
            talker_avatar( subject ) {}

        bool buy_monster( talker &seller, const mtype_id &, int, int, bool,
                          const translation & ) override {
            ++purchase_calls;
            sold_pet_was_present_before_purchase = seller.has_effect(
                    efftype_id( "sold_pet" ), bodypart_str_id::NULL_ID() );
            return false;
        }

        int purchase_calls = 0;
        bool sold_pet_was_present_before_purchase = false;
};

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

TEST_CASE( "lua_platform_dialogue_response_action_registry_rejects_stale_sessions",
           "[lua][platform][dialogue]" )
{
    cata::lua_platform::dialogue::clear_response_callbacks();
    npc speaker;
    speaker.normalize();
    speaker.setID( character_id( 1220 ), true );
    npc interlocutor;
    interlocutor.normalize();
    interlocutor.setID( character_id( 1221 ), true );
    dialogue conversation(
        std::make_unique<talker_npc>( &speaker ),
        std::make_unique<talker_npc>( &interlocutor ) );
    const auto runtime_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( runtime_owner, 1 );
    constexpr std::size_t world_generation = 1;
    cata::lua_platform::dialogue::begin_session(
        conversation, runtime, world_generation );
    const cata::lua_platform::dialogue::dialogue_session_ptr first_session =
        cata::lua_platform::dialogue::session_for(
            conversation, "TALK_ACTION_ONE", runtime, world_generation );
    int callback_calls = 0;
    const std::uint64_t stale_action =
        cata::lua_platform::dialogue::register_response_action_callback(
            cata::lua_platform::dialogue::response_callback_origin::platform,
            [&callback_calls]( dialogue &, bool ) {
        ++callback_calls;
    }, first_session, "TALK_ACTION_ONE" );

    cata::lua_platform::dialogue::session_for(
        conversation, "TALK_ACTION_TWO", runtime, world_generation );
    cata::lua_platform::dialogue::apply_response_action_callback(
        conversation, stale_action, true );
    CHECK( callback_calls == 0 );

    const cata::lua_platform::dialogue::dialogue_session_ptr current_session =
        cata::lua_platform::dialogue::session_for(
            conversation, "TALK_ACTION_TWO", runtime, world_generation );
    const std::uint64_t retired_action =
        cata::lua_platform::dialogue::register_response_action_callback(
            cata::lua_platform::dialogue::response_callback_origin::platform,
            [&callback_calls]( dialogue &, bool ) {
        ++callback_calls;
    }, current_session, "TALK_ACTION_TWO" );
    cata::lua_platform::dialogue::retire_sessions_for_world( world_generation );
    cata::lua_platform::dialogue::apply_response_action_callback(
        conversation, retired_action, true );
    CHECK( callback_calls == 0 );

    cata::lua_platform::dialogue::begin_session(
        conversation, runtime, world_generation );
    const cata::lua_platform::dialogue::dialogue_session_ptr replacement_session =
        cata::lua_platform::dialogue::session_for(
            conversation, "TALK_ACTION_TWO", runtime, world_generation );
    const std::uint64_t cleared_action =
        cata::lua_platform::dialogue::register_response_action_callback(
            cata::lua_platform::dialogue::response_callback_origin::platform,
            [&callback_calls]( dialogue &, bool ) {
        ++callback_calls;
    }, replacement_session, "TALK_ACTION_TWO" );
    cata::lua_platform::dialogue::clear_response_callbacks(
        cata::lua_platform::dialogue::response_callback_origin::platform );
    cata::lua_platform::dialogue::apply_response_action_callback(
        conversation, cleared_action, false );
    CHECK( callback_calls == 0 );
    cata::lua_platform::dialogue::end_session( conversation );
}

TEST_CASE( "lua_platform_declarative_response_action_runs_before_opinion_and_on_select",
           "[lua][platform][dialogue][runtime]" )
{
    cata::lua_platform::clear_active_runtimes();
    sol::state owner_lua;
    sol::table ccb = owner_lua.create_table();
    const std::shared_ptr<cata::lua_platform::runtime> owner_runtime =
        cata::lua_platform::make_runtime( "dialogue_action_stage", 83, owner_lua );
    on_out_of_scope cleanup( []() {
        cata::lua_platform::clear_active_runtimes();
    } );
    cata::lua_platform::install_runtime_api( owner_runtime, owner_lua, ccb );

    npc speaker;
    speaker.normalize();
    speaker.setID( character_id( 1222 ), true );
    npc interlocutor;
    interlocutor.normalize();
    interlocutor.setID( character_id( 1223 ), true );
    interlocutor.op_of_u.anger = interlocutor.hostile_anger_level() - 1;
    CHECK_FALSE( interlocutor.turned_hostile() );
    owner_lua.set_function( "native_interlocutor_trust", [&interlocutor]() {
        return interlocutor.op_of_u.trust;
    } );
    owner_lua.set_function( "native_interlocutor_hostile", [&interlocutor]() {
        return interlocutor.turned_hostile();
    } );
    owner_lua.script( R"(
        action_events = {}
        function action_stage_callback(context, trial_success)
            action_events[#action_events + 1] = {
                trial_success = trial_success,
                topic = context:topic(),
                trust = native_interlocutor_trust(),
                hostile = native_interlocutor_hostile(),
                valid = context:valid()
            }
            action_context = context
            return "TALK_ACTION_RETURN_MUST_BE_IGNORED"
        end
        function select_stage_callback(context, trial_success, fallback_topic)
            select_stage_trust = native_interlocutor_trust()
            select_stage_hostile = native_interlocutor_hostile()
            return "TALK_SELECTED_AFTER_ACTION"
        end
        function action_context_is_valid()
            return action_context:valid()
        end
        function error_action_stage_callback(context)
            failing_action_context = context
            error("expected action-stage callback failure")
        end
        function failing_action_context_is_valid()
            return failing_action_context:valid()
        end
    )" );

    sol::table response_one = owner_lua.create_table();
    response_one["text"] = "Run successful action";
    response_one["on_action"] = owner_lua["action_stage_callback"];
    response_one["on_select"] = owner_lua["select_stage_callback"];
    sol::table success_opinion = owner_lua.create_table();
    success_opinion["trust"] = 7;
    success_opinion["anger"] = 2;
    response_one["success_opinion"] = success_opinion;
    sol::table response_two = owner_lua.create_table();
    response_two["text"] = "Run failed action";
    response_two["on_action"] = owner_lua["action_stage_callback"];
    sol::table response_three = owner_lua.create_table();
    response_three["text"] = "Run a failing action callback";
    response_three["on_action"] = owner_lua["error_action_stage_callback"];
    sol::table response_four = owner_lua.create_table();
    response_four["text"] = "Run action before runtime shutdown";
    response_four["on_action"] = owner_lua["action_stage_callback"];
    sol::table responses = owner_lua.create_table();
    responses[1] = response_one;
    responses[2] = response_two;
    responses[3] = response_three;
    responses[4] = response_four;
    sol::table topic = owner_lua.create_table();
    topic["id"] = "TALK_CCB_ACTION_STAGE";
    topic["dynamic_line"] = "Action stage test";
    topic["responses"] = responses;
    const sol::table dialogue_api = ccb["dialogue"];
    const sol::protected_function register_topic = dialogue_api["register_topic"];
    const sol::protected_function_result registered =
        register_topic( topic );
    REQUIRE( registered.valid() );

    cata::lua_platform::set_active_runtimes( { owner_runtime } );
    cata::lua_platform::runtime_world_ready( true );
    dialogue conversation(
        std::make_unique<talker_npc>( &speaker ),
        std::make_unique<talker_npc>( &interlocutor ) );
    const cata::lua_platform::game_handle_runtime runtime_identity =
        cata::lua_platform::detail::runtime_handle_identity( owner_runtime );
    const std::size_t world_generation =
        cata::lua_platform::runtime_world_generation();
    cata::lua_platform::dialogue::begin_session(
        conversation, runtime_identity, world_generation );
    conversation.gen_responses( talk_topic( "TALK_CCB_ACTION_STAGE" ) );
    REQUIRE( conversation.responses.size() == 4 );

    talk_response &success_response = conversation.responses[0];
    REQUIRE( success_response.lua_response_id.has_value() );
    CHECK( success_response.success.opinion.trust == 7 );
    CHECK( success_response.success.opinion.anger == 2 );

    talk_response &failure_response = conversation.responses[1];
    CHECK_FALSE( failure_response.lua_response_id.has_value() );
    const talk_topic failure_topic = failure_response.failure.apply( conversation );
    CHECK( failure_topic.id == "TALK_NONE" );

    talk_response &failing_response = conversation.responses[2];
    CHECK_FALSE( failing_response.lua_response_id.has_value() );
    const talk_topic failure_callback_topic = failing_response.failure.apply( conversation );
    CHECK( failure_callback_topic.id == "TALK_NONE" );

    const talk_topic native_success_topic = success_response.success.apply( conversation );
    CHECK( native_success_topic.id == "TALK_DONE" );
    CHECK( interlocutor.op_of_u.trust == 7 );
    CHECK( interlocutor.turned_hostile() );
    const talk_topic selected_topic =
        cata::lua_platform::dialogue::apply_response_callback(
            conversation, *success_response.lua_response_id,
            native_success_topic, true );
    CHECK( selected_topic.id == "TALK_SELECTED_AFTER_ACTION" );
    const talk_topic duplicate_branch_topic = success_response.failure.apply( conversation );
    CHECK( duplicate_branch_topic.id == "TALK_DONE" );

    talk_response &runtime_response = conversation.responses[3];
    CHECK_FALSE( runtime_response.lua_response_id.has_value() );
    cata::lua_platform::clear_active_runtimes();
    const talk_topic after_runtime_shutdown = runtime_response.success.apply( conversation );
    CHECK( after_runtime_shutdown.id == "TALK_DONE" );

    const sol::table action_events = owner_lua["action_events"];
    REQUIRE( action_events.size() == 2 );
    const sol::table failure_event = action_events.get<sol::table>( 1 );
    CHECK_FALSE( failure_event["trial_success"].get<bool>() );
    CHECK( failure_event["topic"].get<std::string>() == "TALK_CCB_ACTION_STAGE" );
    CHECK( failure_event["trust"].get<int>() == 0 );
    CHECK_FALSE( failure_event["hostile"].get<bool>() );
    CHECK( failure_event["valid"].get<bool>() );
    const sol::table success_event = action_events.get<sol::table>( 2 );
    CHECK( success_event["trial_success"].get<bool>() );
    CHECK( success_event["topic"].get<std::string>() == "TALK_CCB_ACTION_STAGE" );
    CHECK( success_event["trust"].get<int>() == 0 );
    CHECK_FALSE( success_event["hostile"].get<bool>() );
    CHECK( success_event["valid"].get<bool>() );
    CHECK( owner_lua["select_stage_trust"].get<int>() == 7 );
    CHECK( owner_lua["select_stage_hostile"].get<bool>() );
    const sol::protected_function context_valid = owner_lua["action_context_is_valid"];
    const sol::protected_function_result stale_context = context_valid();
    REQUIRE( stale_context.valid() );
    CHECK_FALSE( stale_context.get<bool>() );
    const sol::protected_function failing_context_valid =
        owner_lua["failing_action_context_is_valid"];
    const sol::protected_function_result invalidated_failure_context =
        failing_context_valid();
    REQUIRE( invalidated_failure_context.valid() );
    CHECK_FALSE( invalidated_failure_context.get<bool>() );
    cata::lua_platform::dialogue::end_session( conversation );
}

TEST_CASE( "lua_platform_dialogue_item_grant_matches_native_talk_effect",
           "[lua][platform][dialogue][items][semantic]" )
{
    cata::lua_platform::clear_active_runtimes();
    clear_map_without_vision();
    on_out_of_scope cleanup( []() {
        cata::lua_platform::clear_active_runtimes();
        clear_map_without_vision();
    } );

    map &here = get_map();
    avatar native_speaker;
    native_speaker.normalize();
    native_speaker.setID( character_id( 1550 ), true );
    native_speaker.setpos( here, tripoint_bub_ms( 60, 60, 0 ) );
    avatar platform_speaker;
    platform_speaker.normalize();
    platform_speaker.setID( character_id( 1551 ), true );
    platform_speaker.setpos( here, tripoint_bub_ms( 65, 60, 0 ) );
    npc native_interlocutor;
    native_interlocutor.normalize();
    native_interlocutor.setID( character_id( 1552 ), true );
    native_interlocutor.setpos( here, tripoint_bub_ms( 61, 60, 0 ) );
    npc platform_interlocutor;
    platform_interlocutor.normalize();
    platform_interlocutor.setID( character_id( 1553 ), true );
    platform_interlocutor.setpos( here, tripoint_bub_ms( 66, 60, 0 ) );
    cata::lua_platform::register_npc_handle_identity( native_interlocutor );
    cata::lua_platform::register_npc_handle_identity( platform_interlocutor );
    on_out_of_scope retire_npc_identities( [&]() {
        cata::lua_platform::retire_npc_handle_identity( native_interlocutor );
        cata::lua_platform::retire_npc_handle_identity( platform_interlocutor );
    } );

    constexpr std::string_view topic_id = "TALK_CCB_ITEM_GRANT";
    constexpr std::string_view item_id = "bottle_plastic";
    const itype_id native_item_type( std::string( item_id ) );
    REQUIRE( native_item_type.is_valid() );
    REQUIRE_FALSE( item::count_by_charges( native_item_type ) );

    dialogue native_conversation(
        get_talker_for( native_speaker ),
        std::make_unique<platform_dialogue_silent_npc_talker>(
            &native_interlocutor ) );
    talk_effect_t native_effect;
    native_effect.parse_sub_effect(
        json_loader::from_string(
            R"({"u_spawn_item":"bottle_plastic"})" ).get_object(),
        "dialogue_item_grant_semantic_test" );
    for( const talk_effect_fun_t &operation : native_effect.effects ) {
        operation( native_conversation );
    }

    sol::state owner_lua;
    sol::table ccb = owner_lua.create_table();
    const std::shared_ptr<cata::lua_platform::runtime> owner_runtime =
        cata::lua_platform::make_runtime( "dialogue_item_grant", 92, owner_lua );
    cata::lua_platform::install_runtime_api( owner_runtime, owner_lua, ccb );
    owner_lua["ccb"] = ccb;
    owner_lua.script( R"(
        local services = ccb.services
        function grant_native_item(context, trial_success)
            if not trial_success or not context:valid() then return end
            saved_item_grant_context = context
            context:grant_item_to_speaker(services.types.id("item", "bottle_plastic"))
        end
        function item_grant_context_is_valid()
            return saved_item_grant_context:valid()
        end
        function reuse_item_grant_context()
            saved_item_grant_context:grant_item_to_speaker(
                services.types.id("item", "bottle_plastic"))
        end
    )" );
    sol::table response = owner_lua.create_table();
    response["text"] = "Receive a plastic bottle";
    response["on_action"] = owner_lua["grant_native_item"];
    sol::table responses = owner_lua.create_table();
    responses[1] = response;
    sol::table descriptor = owner_lua.create_table();
    descriptor["id"] = std::string( topic_id );
    descriptor["dynamic_line"] = "Item grant semantic test";
    descriptor["responses"] = responses;
    const sol::protected_function_result registration =
        ccb["dialogue"]["register_topic"]( descriptor );
    REQUIRE( registration.valid() );

    cata::lua_platform::set_active_runtimes( { owner_runtime } );
    cata::lua_platform::runtime_world_ready( true );
    const cata::lua_platform::game_handle_runtime runtime_identity =
        cata::lua_platform::detail::runtime_handle_identity( owner_runtime );
    const std::size_t world_generation =
        cata::lua_platform::runtime_world_generation();
    dialogue platform_conversation(
        get_talker_for( platform_speaker ),
        std::make_unique<platform_dialogue_silent_npc_talker>(
            &platform_interlocutor ) );
    const cata::lua_platform::dialogue::dialogue_session_ptr session =
        cata::lua_platform::dialogue::begin_session(
            platform_conversation, runtime_identity, world_generation );
    platform_conversation.gen_responses( talk_topic( std::string( topic_id ) ) );
    REQUIRE( platform_conversation.responses.size() == 1 );

    cata::lua_platform::dialogue::context outside_action(
        owner_lua.lua_state(), platform_conversation, std::string( topic_id ), true,
        "dialogue context is stale", {}, session, runtime_identity,
        world_generation );
    CHECK_THROWS( outside_action.grant_item_to_speaker(
                      cata::lua_platform::script_game_id(
                          "item", std::string( item_id ) ) ) );
    CHECK_FALSE( platform_speaker.has_amount( native_item_type, 1 ) );

    platform_conversation.responses.front().success.apply( platform_conversation );
    CHECK( native_speaker.has_amount( native_item_type, 1 ) );
    CHECK( platform_speaker.has_amount( native_item_type, 1 ) );
    CHECK_FALSE( native_interlocutor.has_amount( native_item_type, 1 ) );
    CHECK_FALSE( platform_interlocutor.has_amount( native_item_type, 1 ) );
    const sol::protected_function context_valid =
        owner_lua["item_grant_context_is_valid"];
    const sol::protected_function_result stale_context = context_valid();
    REQUIRE( stale_context.valid() );
    CHECK_FALSE( stale_context.get<bool>() );
    const sol::protected_function reuse_context =
        owner_lua["reuse_item_grant_context"];
    const sol::protected_function_result rejected_reuse = reuse_context();
    CHECK_FALSE( rejected_reuse.valid() );
    cata::lua_platform::dialogue::end_session( platform_conversation );
}

TEST_CASE( "lua_platform_dialogue_purchase_pet_matches_native_talk_effect",
           "[lua][platform][dialogue][pets][semantic]" )
{
    cata::lua_platform::clear_active_runtimes();
    clear_map_without_vision();
    on_out_of_scope cleanup( []() {
        cata::lua_platform::clear_active_runtimes();
        g->clear_zombies();
        clear_map_without_vision();
    } );

    map &here = get_map();
    avatar native_buyer;
    native_buyer.normalize();
    native_buyer.setID( character_id( 1570 ), true );
    native_buyer.setpos( here, tripoint_bub_ms( 60, 60, 0 ) );
    npc native_seller;
    native_seller.normalize();
    native_seller.setID( character_id( 1571 ), true );
    native_seller.setpos( here, tripoint_bub_ms( 61, 60, 0 ) );
    avatar platform_buyer;
    platform_buyer.normalize();
    platform_buyer.setID( character_id( 1572 ), true );
    platform_buyer.setpos( here, tripoint_bub_ms( 60, 60, 0 ) );
    npc platform_seller;
    platform_seller.normalize();
    platform_seller.setID( character_id( 1573 ), true );
    platform_seller.setpos( here, tripoint_bub_ms( 61, 60, 0 ) );
    cata::lua_platform::register_npc_handle_identity( platform_seller );
    on_out_of_scope retire_platform_seller( [&]() {
        cata::lua_platform::retire_npc_handle_identity( platform_seller );
    } );

    const mtype_id dog_type( "mon_dog" );
    const efftype_id pet_effect( "pet" );
    const efftype_id pacified_effect( "pacified" );
    const efftype_id sold_pet_effect( "sold_pet" );
    REQUIRE( dog_type.is_valid() );
    REQUIRE( pet_effect.is_valid() );
    REQUIRE( pacified_effect.is_valid() );
    REQUIRE( sold_pet_effect.is_valid() );
    native_seller.op_of_u.owed = 5000;
    platform_seller.op_of_u.owed = 5000;

    dialogue native_conversation(
        get_talker_for( native_buyer ), get_talker_for( native_seller ) );
    const conditional_t native_can_buy( json_loader::from_string(
            R"({"not":{"npc_has_effect":"sold_pet"}})" ).get_object() );
    CHECK( native_can_buy( native_conversation ) );
    talk_effect_t native_purchase;
    native_purchase.parse_sub_effect(
        json_loader::from_string(
            R"({"u_buy_monster":"mon_dog","cost":5000,"pacified":true})" ).get_object(),
        "dialogue_pet_purchase_semantic_test" );
    native_purchase.parse_sub_effect(
        json_loader::from_string(
            R"({"npc_add_effect":"sold_pet","duration":"24 hours"})" ).get_object(),
        "dialogue_pet_purchase_semantic_test" );
    rng_set_engine_seed( 58163 );
    native_purchase.apply( native_conversation );

    std::vector<monster *> native_pets;
    for( monster &entry : g->all_monsters() ) {
        if( entry.type->id == dog_type ) {
            native_pets.push_back( &entry );
        }
    }
    REQUIRE( native_pets.size() == 1 );
    const tripoint_bub_ms expected_position = native_pets.front()->pos_bub();
    const int expected_friendly = native_pets.front()->friendly;
    const bool expected_pet_permanent =
        native_pets.front()->get_effect( pet_effect ).is_permanent();
    const bool expected_pacified_permanent =
        native_pets.front()->get_effect( pacified_effect ).is_permanent();
    CHECK( native_pets.front()->friendly == -1 );
    CHECK( native_pets.front()->has_effect( pet_effect ) );
    CHECK( native_pets.front()->get_effect( pet_effect ).is_permanent() );
    CHECK( native_pets.front()->has_effect( pacified_effect ) );
    CHECK( native_pets.front()->get_effect( pacified_effect ).is_permanent() );
    CHECK( native_pets.front()->unique_name.empty() );
    CHECK( native_seller.op_of_u.owed == 0 );
    CHECK( native_seller.has_effect( sold_pet_effect ) );
    CHECK( native_seller.get_effect_dur( sold_pet_effect ) == 24_hours );
    CHECK_FALSE( native_can_buy( native_conversation ) );

    g->clear_zombies();
    sol::state owner_lua;
    sol::table ccb = owner_lua.create_table();
    const std::shared_ptr<cata::lua_platform::runtime> owner_runtime =
        cata::lua_platform::make_runtime( "dialogue_pet_purchase", 93, owner_lua );
    cata::lua_platform::install_runtime_api( owner_runtime, owner_lua, ccb );
    owner_lua["ccb"] = ccb;
    owner_lua.script( R"(
        local services = ccb.services
        function can_buy_pet(context)
            return not context:has_interlocutor_effect(
                services.types.id("effect", "sold_pet"))
        end
        function purchase_pet_action(context, trial_success)
            if not trial_success or not context:valid() then return end
            purchase_result = context:purchase_pet(
                services.types.id("monster", "mon_dog"),
                { cost = 5000, pacified = true })
            local marked = services.effects.add(
                context:interlocutor(),
                services.types.id("effect", "sold_pet"),
                services.time.duration(86400, "turn"))
            if not marked.ok then error(marked.error.code) end
        end
    )" );
    sol::table response = owner_lua.create_table();
    response["text"] = "I'll have a dog.";
    response["condition"] = owner_lua["can_buy_pet"];
    response["on_action"] = owner_lua["purchase_pet_action"];
    sol::table responses = owner_lua.create_table();
    responses[1] = response;
    sol::table descriptor = owner_lua.create_table();
    descriptor["id"] = "TALK_CCB_PET_PURCHASE";
    descriptor["dynamic_line"] = "Choose a shelter pet.";
    descriptor["responses"] = responses;
    const sol::protected_function_result registration =
        ccb["dialogue"]["register_topic"]( descriptor );
    REQUIRE( registration.valid() );

    cata::lua_platform::set_active_runtimes( { owner_runtime } );
    cata::lua_platform::runtime_world_ready( true );
    const cata::lua_platform::game_handle_runtime runtime_identity =
        cata::lua_platform::detail::runtime_handle_identity( owner_runtime );
    const std::size_t world_generation =
        cata::lua_platform::runtime_world_generation();
    dialogue platform_conversation(
        get_talker_for( platform_buyer ),
        std::make_unique<platform_dialogue_silent_npc_talker>( &platform_seller ) );
    const cata::lua_platform::dialogue::dialogue_session_ptr session =
        cata::lua_platform::dialogue::begin_session(
            platform_conversation, runtime_identity, world_generation );
    platform_conversation.gen_responses(
        talk_topic( "TALK_CCB_PET_PURCHASE" ) );
    REQUIRE( platform_conversation.responses.size() == 1 );
    REQUIRE( platform_conversation.response_condition_eval.size() == 1 );
    CHECK( platform_conversation.response_condition_eval.front() );

    rng_set_engine_seed( 58163 );
    platform_conversation.responses.front().success.apply( platform_conversation );
    REQUIRE( owner_lua["purchase_result"].valid() );
    CHECK( owner_lua["purchase_result"].get<bool>() );
    CHECK( platform_seller.op_of_u.owed == 0 );
    CHECK( platform_seller.has_effect( sold_pet_effect ) );
    CHECK( platform_seller.get_effect_dur( sold_pet_effect ) == 24_hours );

    std::vector<monster *> platform_pets;
    for( monster &entry : g->all_monsters() ) {
        if( entry.type->id == dog_type ) {
            platform_pets.push_back( &entry );
        }
    }
    REQUIRE( platform_pets.size() == 1 );
    CHECK( platform_pets.front()->pos_bub() == expected_position );
    CHECK( platform_pets.front()->friendly == expected_friendly );
    CHECK( platform_pets.front()->has_effect( pet_effect ) );
    CHECK( platform_pets.front()->get_effect( pet_effect ).is_permanent() ==
           expected_pet_permanent );
    CHECK( platform_pets.front()->has_effect( pacified_effect ) );
    CHECK( platform_pets.front()->get_effect( pacified_effect ).is_permanent() ==
           expected_pacified_permanent );
    CHECK( platform_pets.front()->unique_name.empty() );
    cata::lua_platform::dialogue::end_session( platform_conversation );
}

TEST_CASE( "lua_platform_dialogue_pet_purchase_false_result_keeps_native_effect_tail",
           "[lua][platform][dialogue][pets][semantic]" )
{
    clear_map_without_vision();
    on_out_of_scope cleanup( []() {
        g->clear_zombies();
        clear_map_without_vision();
    } );
    map &here = get_map();
    avatar buyer;
    buyer.normalize();
    buyer.setID( character_id( 1574 ), true );
    buyer.setpos( here, tripoint_bub_ms( 60, 60, 0 ) );
    npc seller;
    seller.normalize();
    seller.setID( character_id( 1575 ), true );
    seller.setpos( here, tripoint_bub_ms( 61, 60, 0 ) );

    auto rejecting_buyer = std::make_unique<platform_dialogue_reject_pet_purchase_talker>(
                               &buyer );
    platform_dialogue_reject_pet_purchase_talker *const buyer_talker =
        rejecting_buyer.get();
    dialogue conversation(
        std::move( rejecting_buyer ), get_talker_for( seller ) );
    talk_effect_t ordered_effects;
    ordered_effects.parse_sub_effect(
        json_loader::from_string(
            R"({"u_buy_monster":"mon_dog","cost":5000,"pacified":true})" ).get_object(),
        "dialogue_pet_purchase_failure_tail_test" );
    ordered_effects.parse_sub_effect(
        json_loader::from_string(
            R"({"npc_add_effect":"sold_pet","duration":"24 hours"})" ).get_object(),
        "dialogue_pet_purchase_failure_tail_test" );
    ordered_effects.apply( conversation );

    CHECK( buyer_talker->purchase_calls == 1 );
    CHECK_FALSE( buyer_talker->sold_pet_was_present_before_purchase );
    CHECK( seller.has_effect( efftype_id( "sold_pet" ) ) );
    CHECK( seller.get_effect_dur( efftype_id( "sold_pet" ) ) == 24_hours );
}

TEST_CASE( "lua_platform_dialogue_pet_purchase_keeps_partial_placement_success",
           "[lua][platform][dialogue][pets][semantic]" )
{
    clear_map_without_vision();
    g->clear_zombies();
    on_out_of_scope cleanup( []() {
        g->clear_zombies();
        clear_map_without_vision();
    } );
    map &here = get_map();
    const tripoint_bub_ms center( 60, 60, 0 );
    const tripoint_bub_ms only_open = center + tripoint_rel_ms( 1, 0, 0 );
    const ter_str_id wall( "t_wall" );
    const ter_str_id floor( "t_floor" );
    REQUIRE( wall.is_valid() );
    REQUIRE( floor.is_valid() );
    for( int x = center.x() - 3; x <= center.x() + 3; ++x ) {
        for( int y = center.y() - 3; y <= center.y() + 3; ++y ) {
            here.ter_set( tripoint_bub_ms( x, y, center.z() ), wall );
        }
    }
    here.ter_set( only_open, floor );
    avatar buyer;
    buyer.normalize();
    buyer.setpos( here, center );
    npc seller;
    seller.normalize();
    talker_avatar native_buyer( &buyer );
    talker_npc native_seller( &seller );

    const bool result = native_buyer.buy_monster(
                            native_seller, mtype_id( "mon_dog" ), 0, 2, true,
                            no_translation( "" ) );
    CHECK( result );
    std::vector<monster *> placed;
    for( monster &entry : g->all_monsters() ) {
        placed.push_back( &entry );
    }
    REQUIRE( placed.size() == 1 );
    CHECK( placed.front()->type->id == mtype_id( "mon_dog" ) );
    CHECK( placed.front()->friendly == -1 );
    CHECK( placed.front()->has_effect( efftype_id( "pet" ) ) );
    CHECK( placed.front()->has_effect( efftype_id( "pacified" ) ) );
    CHECK( placed.front()->unique_name.empty() );
}

TEST_CASE( "lua_platform_dialogue_effect_condition_uses_native_reason_body_part",
           "[lua][platform][dialogue][effects][semantic]" )
{
    cata::lua_platform::clear_active_runtimes();
    clear_map_without_vision();
    on_out_of_scope cleanup( []() {
        cata::lua_platform::clear_active_runtimes();
        clear_map_without_vision();
    } );
    map &here = get_map();
    avatar buyer;
    buyer.normalize();
    buyer.setID( character_id( 1576 ), true );
    buyer.setpos( here, tripoint_bub_ms( 60, 60, 0 ) );
    npc seller;
    seller.normalize();
    seller.setID( character_id( 1577 ), true );
    seller.setpos( here, tripoint_bub_ms( 61, 60, 0 ) );
    seller.add_effect( efftype_id( "bleed" ), 10_turns,
                       bodypart_id( "arm_l" ), false, 1 );
    cata::lua_platform::register_npc_handle_identity( seller );
    on_out_of_scope retire_seller_identity( [&]() {
        cata::lua_platform::retire_npc_handle_identity( seller );
    } );

    sol::state lua;
    const std::shared_ptr<cata::lua_platform::runtime> owner_runtime =
        cata::lua_platform::make_runtime( "dialogue_effect_condition", 94, lua );
    cata::lua_platform::set_active_runtimes( { owner_runtime } );
    cata::lua_platform::runtime_world_ready( true );
    const cata::lua_platform::game_handle_runtime runtime_identity =
        cata::lua_platform::detail::runtime_handle_identity( owner_runtime );
    const std::size_t world_generation =
        cata::lua_platform::runtime_world_generation();
    dialogue conversation( get_talker_for( buyer ), get_talker_for( seller ) );
    const cata::lua_platform::dialogue::dialogue_session_ptr session =
        cata::lua_platform::dialogue::begin_session(
            conversation, runtime_identity, world_generation );
    const cata::lua_platform::dialogue::dialogue_session_ptr topic_session =
        cata::lua_platform::dialogue::session_for(
            conversation, "TALK_CCB_EFFECT_CONDITION", runtime_identity,
            world_generation );
    REQUIRE( topic_session == session );
    cata::lua_platform::dialogue::context context(
        lua.lua_state(), conversation, "TALK_CCB_EFFECT_CONDITION", false,
        "dialogue context is stale", {}, topic_session, runtime_identity,
        world_generation );
    const conditional_t native_condition( json_loader::from_string(
            R"({"npc_has_effect":"bleed"})" ).get_object() );
    const cata::lua_platform::script_game_id bleed_id( "effect", "bleed" );
    for( const auto &[reason, expected] : std::vector<std::pair<std::string, bool>> {
             { "arm_l", true }, { "leg_l", false },
             { "unknown_dialogue_reason", false }, { "", false }
         } ) {
        conversation.reason = reason;
        CHECK( native_condition( conversation ) == expected );
        CHECK( context.has_interlocutor_effect( bleed_id ) == expected );
    }
    cata::lua_platform::dialogue::end_session( conversation );
}

TEST_CASE( "lua_platform_dialogue_pet_purchase_requires_interlocutor",
           "[lua][platform][dialogue][pets][contract]" )
{
    cata::lua_platform::clear_active_runtimes();
    on_out_of_scope cleanup( []() {
        cata::lua_platform::clear_active_runtimes();
    } );
    sol::state lua;
    const std::shared_ptr<cata::lua_platform::runtime> owner_runtime =
        cata::lua_platform::make_runtime( "dialogue_pet_purchase_no_beta", 95, lua );
    cata::lua_platform::set_active_runtimes( { owner_runtime } );
    cata::lua_platform::runtime_world_ready( true );
    const cata::lua_platform::game_handle_runtime runtime_identity =
        cata::lua_platform::detail::runtime_handle_identity( owner_runtime );
    const std::size_t world_generation =
        cata::lua_platform::runtime_world_generation();
    dialogue no_interlocutor(
        std::make_unique<talker_topic>(), std::unique_ptr<talker>() );
    const cata::lua_platform::dialogue::dialogue_session_ptr session =
        cata::lua_platform::dialogue::begin_session(
            no_interlocutor, runtime_identity, world_generation );
    const cata::lua_platform::dialogue::dialogue_session_ptr topic_session =
        cata::lua_platform::dialogue::session_for(
            no_interlocutor, "TALK_CCB_NO_INTERLOCUTOR", runtime_identity,
            world_generation );
    cata::lua_platform::dialogue::context action_context(
        lua.lua_state(), no_interlocutor, "TALK_CCB_NO_INTERLOCUTOR", true,
        "dialogue context is stale", {}, topic_session, runtime_identity,
        world_generation, true );
    sol::optional<sol::table> no_options;
    CHECK( action_context.valid() );
    CHECK_FALSE( no_interlocutor.has_beta );
    CHECK_THROWS( action_context.purchase_pet(
                      cata::lua_platform::script_game_id( "monster", "mon_dog" ),
                      no_options ) );
    cata::lua_platform::dialogue::end_session( no_interlocutor );
}

TEST_CASE( "lua_platform_dialogue_clear_mission_matches_native_talk_effect",
           "[lua][platform][dialogue][missions][semantic]" )
{
    cata::lua_platform::clear_active_runtimes();
    mission::clear_all();
    struct mission_cleanup {
        ~mission_cleanup() {
            cata::lua_platform::clear_active_runtimes();
            mission::clear_all();
        }
    } cleanup;

    avatar native_speaker;
    native_speaker.normalize();
    native_speaker.setID( character_id( 1560 ), true );
    avatar platform_speaker;
    platform_speaker.normalize();
    platform_speaker.setID( character_id( 1561 ), true );
    npc native_interlocutor;
    native_interlocutor.normalize();
    native_interlocutor.setID( character_id( 1562 ), true );
    npc platform_interlocutor;
    platform_interlocutor.normalize();
    platform_interlocutor.setID( character_id( 1563 ), true );
    cata::lua_platform::register_npc_handle_identity( native_interlocutor );
    cata::lua_platform::register_npc_handle_identity( platform_interlocutor );
    on_out_of_scope retire_npc_identities( [&]() {
        cata::lua_platform::retire_npc_handle_identity( native_interlocutor );
        cata::lua_platform::retire_npc_handle_identity( platform_interlocutor );
    } );

    const mission_type_id test_mission( "TEST_MISSION_GOAL_CONDITION1" );
    mission *const native_first = mission::reserve_new(
                                      test_mission, native_interlocutor.getID() );
    mission *const native_selected = mission::reserve_new(
                                         test_mission, native_interlocutor.getID() );
    mission *const platform_first = mission::reserve_new(
                                        test_mission, platform_interlocutor.getID() );
    mission *const platform_selected = mission::reserve_new(
                                           test_mission, platform_interlocutor.getID() );
    REQUIRE( native_first != nullptr );
    REQUIRE( native_selected != nullptr );
    REQUIRE( platform_first != nullptr );
    REQUIRE( platform_selected != nullptr );
    native_first->set_assigned_player_id( native_speaker.getID() );
    native_selected->set_assigned_player_id( native_speaker.getID() );
    platform_first->set_assigned_player_id( platform_speaker.getID() );
    platform_selected->set_assigned_player_id( platform_speaker.getID() );
    CHECK_FALSE( native_selected->has_follow_up() );
    CHECK_FALSE( platform_selected->has_follow_up() );
    native_interlocutor.chatbin.missions_assigned = { native_first, native_selected };
    native_interlocutor.chatbin.mission_selected = native_selected;
    platform_interlocutor.chatbin.missions_assigned = {
        platform_first, platform_selected
    };
    platform_interlocutor.chatbin.mission_selected = platform_selected;

    dialogue native_conversation(
        get_talker_for( native_speaker ), get_talker_for( native_interlocutor ) );
    const JsonValue native_effect_json = json_loader::from_string(
            R"({"effect":"clear_mission"})" );
    talk_effect_t native_effect(
        native_effect_json.get_object(), "effect", "dialogue_clear_mission_test" );
    native_effect.apply( native_conversation );

    sol::state owner_lua;
    sol::table ccb = owner_lua.create_table();
    const std::shared_ptr<cata::lua_platform::runtime> owner_runtime =
        cata::lua_platform::make_runtime( "dialogue_clear_mission", 93, owner_lua );
    cata::lua_platform::install_runtime_api( owner_runtime, owner_lua, ccb );
    owner_lua["ccb"] = ccb;
    owner_lua.script( R"(
        function clear_native_selected_mission(context, trial_success)
            if not trial_success or not context:valid() then return end
            saved_clear_mission_context = context
            context:clear_selected_mission()
        end
        function clear_mission_context_is_valid()
            return saved_clear_mission_context:valid()
        end
        function reuse_clear_mission_context()
            saved_clear_mission_context:clear_selected_mission()
        end
    )" );
    sol::table response = owner_lua.create_table();
    response["text"] = "Clear selected mission";
    response["on_action"] = owner_lua["clear_native_selected_mission"];
    sol::table responses = owner_lua.create_table();
    responses[1] = response;
    sol::table descriptor = owner_lua.create_table();
    descriptor["id"] = "TALK_CCB_CLEAR_MISSION";
    descriptor["dynamic_line"] = "Clear mission semantic test";
    descriptor["responses"] = responses;
    const sol::protected_function_result registration =
        ccb["dialogue"]["register_topic"]( descriptor );
    REQUIRE( registration.valid() );

    cata::lua_platform::set_active_runtimes( { owner_runtime } );
    cata::lua_platform::runtime_world_ready( true );
    const cata::lua_platform::game_handle_runtime runtime_identity =
        cata::lua_platform::detail::runtime_handle_identity( owner_runtime );
    const std::size_t world_generation =
        cata::lua_platform::runtime_world_generation();
    dialogue platform_conversation(
        get_talker_for( platform_speaker ), get_talker_for( platform_interlocutor ) );
    const cata::lua_platform::dialogue::dialogue_session_ptr session =
        cata::lua_platform::dialogue::begin_session(
            platform_conversation, runtime_identity, world_generation );
    platform_conversation.gen_responses( talk_topic( "TALK_CCB_CLEAR_MISSION" ) );
    REQUIRE( platform_conversation.responses.size() == 1 );

    cata::lua_platform::dialogue::context outside_action(
        owner_lua.lua_state(), platform_conversation, "TALK_CCB_CLEAR_MISSION", true,
        "dialogue context is stale", {}, session, runtime_identity,
        world_generation );
    CHECK_THROWS( outside_action.clear_selected_mission() );
    CHECK( platform_interlocutor.chatbin.mission_selected == platform_selected );
    platform_conversation.responses.front().success.apply( platform_conversation );

    CHECK( native_interlocutor.chatbin.missions_assigned ==
           std::vector<mission *>( { native_first } ) );
    CHECK( native_interlocutor.chatbin.mission_selected == native_first );
    CHECK( platform_interlocutor.chatbin.missions_assigned ==
           std::vector<mission *>( { platform_first } ) );
    CHECK( platform_interlocutor.chatbin.mission_selected == platform_first );
    CHECK( native_interlocutor.chatbin.missions.empty() );
    CHECK( platform_interlocutor.chatbin.missions.empty() );
    const sol::protected_function context_valid =
        owner_lua["clear_mission_context_is_valid"];
    const sol::protected_function_result stale_context = context_valid();
    REQUIRE( stale_context.valid() );
    CHECK_FALSE( stale_context.get<bool>() );
    const sol::protected_function reuse_context =
        owner_lua["reuse_clear_mission_context"];
    CHECK_FALSE( reuse_context().valid() );
    cata::lua_platform::dialogue::end_session( platform_conversation );
}

TEST_CASE( "lua_platform_dialogue_mission_success_matches_native_talk_effect",
           "[lua][platform][dialogue][missions][semantic]" )
{
    cata::lua_platform::clear_active_runtimes();
    avatar &owner = get_avatar();
    owner.reset_all_missions();
    mission::clear_all();
    struct mission_success_cleanup {
        avatar &owner;
        ~mission_success_cleanup() {
            cata::lua_platform::clear_active_runtimes();
            owner.reset_all_missions();
            mission::clear_all();
        }
    } cleanup{ owner };

    npc native_interlocutor;
    native_interlocutor.normalize();
    native_interlocutor.setID( character_id( 1564 ), true );
    native_interlocutor.set_fac( faction_id( "tacoma_commune" ) );
    native_interlocutor.op_of_u.value = 4;
    native_interlocutor.op_of_u.anger = 2;
    npc platform_interlocutor;
    platform_interlocutor.normalize();
    platform_interlocutor.setID( character_id( 1565 ), true );
    platform_interlocutor.set_fac( faction_id( "tacoma_commune" ) );
    platform_interlocutor.op_of_u.value = 4;
    platform_interlocutor.op_of_u.anger = 2;
    cata::lua_platform::register_npc_handle_identity( native_interlocutor );
    cata::lua_platform::register_npc_handle_identity( platform_interlocutor );
    on_out_of_scope retire_npc_identities( [&]() {
        cata::lua_platform::retire_npc_handle_identity( native_interlocutor );
        cata::lua_platform::retire_npc_handle_identity( platform_interlocutor );
    } );

    faction *const shared_faction = native_interlocutor.get_faction();
    REQUIRE( shared_faction != nullptr );
    REQUIRE( platform_interlocutor.get_faction() == shared_faction );
    const mission_type_id test_mission( "TEST_MISSION_GENERIC_REWARD" );
    mission *const native_mission = mission::reserve_new(
                                        test_mission, native_interlocutor.getID() );
    mission *const platform_mission = mission::reserve_new(
                                          test_mission, platform_interlocutor.getID() );
    REQUIRE( native_mission != nullptr );
    REQUIRE( platform_mission != nullptr );
    native_mission->set_assigned_player_id( owner.getID() );
    platform_mission->set_assigned_player_id( owner.getID() );
    native_interlocutor.chatbin.missions_assigned = { native_mission };
    native_interlocutor.chatbin.mission_selected = native_mission;
    platform_interlocutor.chatbin.missions_assigned = { platform_mission };
    platform_interlocutor.chatbin.mission_selected = platform_mission;

    dialogue native_conversation(
        get_talker_for( owner ), get_talker_for( native_interlocutor ) );
    const JsonValue native_effect_json = json_loader::from_string(
            R"({"effect":"mission_success"})" );
    talk_effect_t native_effect(
        native_effect_json.get_object(), "effect", "dialogue_mission_success_test" );
    const int native_value_before = native_interlocutor.op_of_u.value;
    const int native_anger_before = native_interlocutor.op_of_u.anger;
    const int faction_likes_before = shared_faction->likes_u;
    const int faction_respects_before = shared_faction->respects_u;
    const int faction_trust_before = shared_faction->trusts_u;
    const int faction_power_before = shared_faction->power;
    on_out_of_scope restore_faction( [&]() {
        shared_faction->likes_u = faction_likes_before;
        shared_faction->respects_u = faction_respects_before;
        shared_faction->trusts_u = faction_trust_before;
        shared_faction->power = faction_power_before;
    } );
    native_effect.apply( native_conversation );
    CHECK( native_mission->is_complete( owner.getID() ) );
    const int native_value_delta =
        native_interlocutor.op_of_u.value - native_value_before;
    const int native_anger_delta =
        native_interlocutor.op_of_u.anger - native_anger_before;
    const int native_faction_likes_delta = shared_faction->likes_u - faction_likes_before;
    const int native_faction_respects_delta =
        shared_faction->respects_u - faction_respects_before;
    const int native_faction_trust_delta =
        shared_faction->trusts_u - faction_trust_before;
    const int native_faction_power_delta = shared_faction->power - faction_power_before;
    CHECK( native_value_delta > 0 );
    CHECK( native_anger_delta == -1 );
    CHECK( native_faction_likes_delta > 0 );
    CHECK( native_faction_respects_delta == native_faction_likes_delta );
    CHECK( native_faction_trust_delta == native_faction_likes_delta );
    CHECK( native_faction_power_delta == native_faction_likes_delta );

    sol::state owner_lua;
    sol::table ccb = owner_lua.create_table();
    const std::shared_ptr<cata::lua_platform::runtime> owner_runtime =
        cata::lua_platform::make_runtime( "dialogue_mission_success", 94, owner_lua );
    cata::lua_platform::install_runtime_api( owner_runtime, owner_lua, ccb );
    owner_lua["ccb"] = ccb;
    owner_lua.script( R"(
        function succeed_native_selected_mission(context, trial_success)
            if not trial_success or not context:valid() then return end
            saved_mission_success_context = context
            context:succeed_selected_mission()
        end
        function mission_success_context_is_valid()
            return saved_mission_success_context:valid()
        end
        function reuse_mission_success_context()
            saved_mission_success_context:succeed_selected_mission()
        end
    )" );
    sol::table response = owner_lua.create_table();
    response["text"] = "Mission complete";
    response["on_action"] = owner_lua["succeed_native_selected_mission"];
    sol::table responses = owner_lua.create_table();
    responses[1] = response;
    sol::table descriptor = owner_lua.create_table();
    descriptor["id"] = "TALK_CCB_MISSION_SUCCESS";
    descriptor["dynamic_line"] = "Mission success semantic test";
    descriptor["responses"] = responses;
    const sol::protected_function_result registration =
        ccb["dialogue"]["register_topic"]( descriptor );
    REQUIRE( registration.valid() );

    cata::lua_platform::set_active_runtimes( { owner_runtime } );
    cata::lua_platform::runtime_world_ready( true );
    const cata::lua_platform::game_handle_runtime runtime_identity =
        cata::lua_platform::detail::runtime_handle_identity( owner_runtime );
    const std::size_t world_generation =
        cata::lua_platform::runtime_world_generation();
    dialogue platform_conversation(
        get_talker_for( owner ), get_talker_for( platform_interlocutor ) );
    const cata::lua_platform::dialogue::dialogue_session_ptr session =
        cata::lua_platform::dialogue::begin_session(
            platform_conversation, runtime_identity, world_generation );
    platform_conversation.gen_responses( talk_topic( "TALK_CCB_MISSION_SUCCESS" ) );
    REQUIRE( platform_conversation.responses.size() == 1 );

    const int platform_value_before = platform_interlocutor.op_of_u.value;
    const int platform_anger_before = platform_interlocutor.op_of_u.anger;
    const int platform_likes_before = shared_faction->likes_u;
    const int platform_respects_before = shared_faction->respects_u;
    const int platform_trust_before = shared_faction->trusts_u;
    const int platform_power_before = shared_faction->power;
    cata::lua_platform::dialogue::context outside_action(
        owner_lua.lua_state(), platform_conversation,
        "TALK_CCB_MISSION_SUCCESS", true, "dialogue context is stale", {},
        session, runtime_identity, world_generation );
    CHECK_THROWS( outside_action.succeed_selected_mission() );
    CHECK_FALSE( platform_mission->is_complete( owner.getID() ) );
    CHECK( platform_interlocutor.op_of_u.value == platform_value_before );
    platform_conversation.responses.front().success.apply( platform_conversation );

    CHECK( platform_mission->is_complete( owner.getID() ) );
    CHECK( platform_interlocutor.op_of_u.value - platform_value_before ==
           native_value_delta );
    CHECK( platform_interlocutor.op_of_u.anger - platform_anger_before ==
           native_anger_delta );
    CHECK( shared_faction->likes_u - platform_likes_before ==
           native_faction_likes_delta );
    CHECK( shared_faction->respects_u - platform_respects_before ==
           native_faction_respects_delta );
    CHECK( shared_faction->trusts_u - platform_trust_before ==
           native_faction_trust_delta );
    CHECK( shared_faction->power - platform_power_before ==
           native_faction_power_delta );
    const sol::protected_function context_valid =
        owner_lua["mission_success_context_is_valid"];
    const sol::protected_function_result stale_context = context_valid();
    REQUIRE( stale_context.valid() );
    CHECK_FALSE( stale_context.get<bool>() );
    const sol::protected_function reuse_context =
        owner_lua["reuse_mission_success_context"];
    CHECK_FALSE( reuse_context().valid() );
    cata::lua_platform::dialogue::end_session( platform_conversation );
}

TEST_CASE( "lua_platform_dialogue_mission_failure_sequence_matches_native_talk_effect",
           "[lua][platform][dialogue][missions][semantic]" )
{
    cata::lua_platform::clear_active_runtimes();
    avatar &owner = get_avatar();
    owner.reset_all_missions();
    mission::clear_all();
    struct mission_failure_cleanup {
        avatar &owner;
        ~mission_failure_cleanup() {
            cata::lua_platform::clear_active_runtimes();
            owner.reset_all_missions();
            mission::clear_all();
        }
    } cleanup{ owner };

    npc native_interlocutor;
    native_interlocutor.normalize();
    native_interlocutor.setID( character_id( 1570 ), true );
    native_interlocutor.op_of_u.trust = 3;
    native_interlocutor.op_of_u.value = 4;
    native_interlocutor.op_of_u.anger = 2;
    native_interlocutor.chatbin.first_topic = "TALK_BEFORE_FAILURE";
    npc platform_interlocutor;
    platform_interlocutor.normalize();
    platform_interlocutor.setID( character_id( 1571 ), true );
    platform_interlocutor.op_of_u.trust = 3;
    platform_interlocutor.op_of_u.value = 4;
    platform_interlocutor.op_of_u.anger = 2;
    platform_interlocutor.chatbin.first_topic = "TALK_BEFORE_FAILURE";
    cata::lua_platform::register_npc_handle_identity( native_interlocutor );
    cata::lua_platform::register_npc_handle_identity( platform_interlocutor );
    on_out_of_scope retire_npc_identities( [&]() {
        cata::lua_platform::retire_npc_handle_identity( native_interlocutor );
        cata::lua_platform::retire_npc_handle_identity( platform_interlocutor );
    } );

    const mission_type_id test_mission( "TEST_MISSION_GENERIC_REWARD" );
    mission *const native_mission = mission::reserve_new(
                                        test_mission, native_interlocutor.getID() );
    mission *const platform_mission = mission::reserve_new(
                                          test_mission, platform_interlocutor.getID() );
    REQUIRE( native_mission != nullptr );
    REQUIRE( platform_mission != nullptr );
    native_mission->set_assigned_player_id( owner.getID() );
    platform_mission->set_assigned_player_id( owner.getID() );
    native_interlocutor.chatbin.missions_assigned = { native_mission };
    native_interlocutor.chatbin.mission_selected = native_mission;
    platform_interlocutor.chatbin.missions_assigned = { platform_mission };
    platform_interlocutor.chatbin.mission_selected = platform_mission;

    dialogue native_conversation(
        get_talker_for( owner ), get_talker_for( native_interlocutor ) );
    const JsonValue native_failure_json = json_loader::from_string(
            R"({"effect":"mission_failure"})" );
    talk_effect_t native_failure(
        native_failure_json.get_object(), "effect", "dialogue_mission_failure_test" );
    native_failure.apply( native_conversation );
    CHECK( native_mission->has_failed() );
    CHECK( native_interlocutor.op_of_u.trust == 2 );
    CHECK( native_interlocutor.op_of_u.value == 3 );
    CHECK( native_interlocutor.op_of_u.anger == 3 );
    CHECK( native_interlocutor.chatbin.missions_assigned ==
           std::vector<mission *>( { native_mission } ) );
    CHECK( native_interlocutor.chatbin.mission_selected == native_mission );

    const JsonValue native_clear_json = json_loader::from_string(
            R"({"effect":"clear_mission"})" );
    talk_effect_t native_clear(
        native_clear_json.get_object(), "effect", "dialogue_mission_failure_test" );
    native_clear.apply( native_conversation );
    CHECK( native_interlocutor.chatbin.missions_assigned.empty() );
    CHECK( native_interlocutor.chatbin.mission_selected == nullptr );
    CHECK( native_interlocutor.chatbin.first_topic == "TALK_BEFORE_FAILURE" );

    const JsonValue native_end_json = json_loader::from_string(
            R"({"effect":"end_conversation"})" );
    talk_effect_t native_end(
        native_end_json.get_object(), "effect", "dialogue_mission_failure_test" );
    native_end.apply( native_conversation );
    CHECK( native_interlocutor.chatbin.first_topic == "TALK_DONE" );

    sol::state owner_lua;
    sol::table ccb = owner_lua.create_table();
    const std::shared_ptr<cata::lua_platform::runtime> owner_runtime =
        cata::lua_platform::make_runtime( "dialogue_mission_failure", 95, owner_lua );
    cata::lua_platform::install_runtime_api( owner_runtime, owner_lua, ccb );
    owner_lua["ccb"] = ccb;
    owner_lua.script( R"(
        function fail_clear_end_selected_mission(context, trial_success)
            if not trial_success or not context:valid() then return end
            saved_mission_failure_context = context
            context:fail_selected_mission()
            context:clear_selected_mission()
            context:end_interlocutor_conversation()
        end
        function mission_failure_context_is_valid()
            return saved_mission_failure_context:valid()
        end
        function reuse_mission_failure_context()
            saved_mission_failure_context:end_interlocutor_conversation()
        end
    )" );
    sol::table response = owner_lua.create_table();
    response["text"] = "I'm sorry";
    response["topic"] = "TALK_DONE";
    response["on_action"] = owner_lua["fail_clear_end_selected_mission"];
    sol::table responses = owner_lua.create_table();
    responses[1] = response;
    sol::table descriptor = owner_lua.create_table();
    descriptor["id"] = "TALK_CCB_MISSION_FAILURE";
    descriptor["dynamic_line"] = "Mission failure semantic test";
    descriptor["responses"] = responses;
    const sol::protected_function_result registration =
        ccb["dialogue"]["register_topic"]( descriptor );
    REQUIRE( registration.valid() );

    cata::lua_platform::set_active_runtimes( { owner_runtime } );
    cata::lua_platform::runtime_world_ready( true );
    const cata::lua_platform::game_handle_runtime runtime_identity =
        cata::lua_platform::detail::runtime_handle_identity( owner_runtime );
    const std::size_t world_generation =
        cata::lua_platform::runtime_world_generation();
    dialogue platform_conversation(
        get_talker_for( owner ), get_talker_for( platform_interlocutor ) );
    const cata::lua_platform::dialogue::dialogue_session_ptr session =
        cata::lua_platform::dialogue::begin_session(
            platform_conversation, runtime_identity, world_generation );
    platform_conversation.gen_responses( talk_topic( "TALK_CCB_MISSION_FAILURE" ) );
    REQUIRE( platform_conversation.responses.size() == 1 );
    CHECK( platform_interlocutor.chatbin.first_topic == "TALK_BEFORE_FAILURE" );

    cata::lua_platform::dialogue::context outside_action(
        owner_lua.lua_state(), platform_conversation, "TALK_CCB_MISSION_FAILURE", true,
        "dialogue context is stale", {}, session, runtime_identity,
        world_generation );
    CHECK_THROWS( outside_action.fail_selected_mission() );
    CHECK_FALSE( platform_mission->has_failed() );
    CHECK( platform_interlocutor.chatbin.mission_selected == platform_mission );
    platform_conversation.responses.front().success.apply( platform_conversation );

    CHECK( platform_mission->has_failed() );
    CHECK( platform_interlocutor.op_of_u.trust == 2 );
    CHECK( platform_interlocutor.op_of_u.value == 3 );
    CHECK( platform_interlocutor.op_of_u.anger == 3 );
    CHECK( platform_interlocutor.chatbin.missions_assigned.empty() );
    CHECK( platform_interlocutor.chatbin.mission_selected == nullptr );
    CHECK( platform_interlocutor.chatbin.first_topic == "TALK_DONE" );
    const sol::protected_function context_valid =
        owner_lua["mission_failure_context_is_valid"];
    const sol::protected_function_result stale_context = context_valid();
    REQUIRE( stale_context.valid() );
    CHECK_FALSE( stale_context.get<bool>() );
    const sol::protected_function reuse_context =
        owner_lua["reuse_mission_failure_context"];
    CHECK_FALSE( reuse_context().valid() );
    cata::lua_platform::dialogue::end_session( platform_conversation );
}

TEST_CASE( "lua_platform_dialogue_safe_space_query_matches_native_beta_condition",
           "[lua][platform][dialogue][runtime][semantic]" )
{
    cata::lua_platform::clear_active_runtimes();
    sol::state owner_lua;
    sol::table ccb = owner_lua.create_table();
    const std::shared_ptr<cata::lua_platform::runtime> owner_runtime =
        cata::lua_platform::make_runtime( "dialogue_safe_space", 84, owner_lua );
    const on_out_of_scope cleanup( []() {
        cata::lua_platform::clear_active_runtimes();
    } );
    cata::lua_platform::install_runtime_api( owner_runtime, owner_lua, ccb );
    owner_lua["services"] = ccb["services"];
    owner_lua.script( R"(
        observed_safe_space_context_valid = false
        observed_safe_space_beta_kind = ""
        observed_safe_space_beta_subtype = ""
        observed_safe_space_value = false
        function dialogue_safe_space_condition(context)
            if not context:valid() then return false end
            observed_safe_space_context_valid = true
            local beta = context:interlocutor()
            if beta == nil then return false end
            if beta.kind == "creature" and not beta:is_valid() then return false end
            observed_safe_space_beta_kind = beta.kind
            observed_safe_space_beta_subtype = beta.subtype or ""
            observed_safe_space_value = context:interlocutor_at_safe_space()
            return observed_safe_space_value
        end
    )" );

    sol::table response = owner_lua.create_table();
    response["text"] = "Only available in a safe space";
    response["condition"] = owner_lua["dialogue_safe_space_condition"];
    sol::table responses = owner_lua.create_table();
    responses[1] = response;
    sol::table descriptor = owner_lua.create_table();
    descriptor["id"] = "TALK_CCB_SAFE_SPACE_QUERY";
    descriptor["dynamic_line"] = "Safe-space beta query test";
    descriptor["responses"] = responses;
    const sol::table dialogue_api = ccb["dialogue"];
    const sol::protected_function register_topic = dialogue_api["register_topic"];
    const sol::protected_function_result registered =
        register_topic( descriptor );
    REQUIRE( registered.valid() );

    avatar speaker;
    speaker.normalize();
    speaker.setID( character_id( 1384 ), true );
    npc interlocutor;
    interlocutor.normalize();
    interlocutor.setID( character_id( 1385 ), true );
    cata::lua_platform::register_npc_handle_identity( interlocutor );
    const on_out_of_scope retire_interlocutor( [&]() {
        cata::lua_platform::retire_npc_handle_identity( interlocutor );
    } );

    cata::lua_platform::set_active_runtimes( { owner_runtime } );
    cata::lua_platform::runtime_world_ready( true );
    dialogue conversation( get_talker_for( speaker ), get_talker_for( interlocutor ) );
    const cata::lua_platform::game_handle_runtime runtime_identity =
        cata::lua_platform::detail::runtime_handle_identity( owner_runtime );
    const std::size_t world_generation =
        cata::lua_platform::runtime_world_generation();
    cata::lua_platform::dialogue::begin_session(
        conversation, runtime_identity, world_generation );
    conversation.gen_responses( talk_topic( "TALK_CCB_SAFE_SPACE_QUERY" ) );

    const bool native_safe_space =
        conditional_t( "at_safe_space" )( conversation );
    CHECK( conditional_t( "npc_at_safe_space" )( conversation ) == native_safe_space );
    CHECK( owner_lua["observed_safe_space_context_valid"].get<bool>() );
    CHECK( owner_lua["observed_safe_space_beta_kind"].get<std::string>() ==
           "creature" );
    CHECK( owner_lua["observed_safe_space_beta_subtype"].get<std::string>() ==
           "npc" );
    CHECK( owner_lua["observed_safe_space_value"].get<bool>() ==
           native_safe_space );
    CHECK( conversation.responses.size() == ( native_safe_space ? 1U : 0U ) );
    cata::lua_platform::dialogue::end_session( conversation );

    dialogue non_character_conversation(
        std::make_unique<talker_topic>(), std::make_unique<talker_topic>() );
    cata::lua_platform::dialogue::begin_session(
        non_character_conversation, runtime_identity, world_generation );
    non_character_conversation.gen_responses(
        talk_topic( "TALK_CCB_SAFE_SPACE_QUERY" ) );
    const bool native_non_character_safe_space =
        conditional_t( "at_safe_space" )( non_character_conversation );
    CHECK( owner_lua["observed_safe_space_beta_kind"].get<std::string>() !=
           "creature" );
    CHECK( owner_lua["observed_safe_space_beta_subtype"].get<std::string>().empty() );
    CHECK( owner_lua["observed_safe_space_value"].get<bool>() ==
           native_non_character_safe_space );
    CHECK( non_character_conversation.responses.size() ==
           ( native_non_character_safe_space ? 1U : 0U ) );
    cata::lua_platform::dialogue::end_session( non_character_conversation );
}

TEST_CASE( "lua_platform_dialogue_item_offer_delegates_native_reason_and_order",
           "[lua][platform][dialogue][npc]" )
{
    // Native f_npc_gets_item assigns the exact beta give_item_to result.  Inject
    // that virtual result here so acceptance, refusal, and cancellation are
    // deterministic without opening the real titled item menu.
    cata::lua_platform::clear_active_runtimes();
    on_out_of_scope cleanup( []() {
        cata::lua_platform::clear_active_runtimes();
    } );

    sol::state owner_lua;
    sol::table ccb = owner_lua.create_table();
    const std::shared_ptr<cata::lua_platform::runtime> owner_runtime =
        cata::lua_platform::make_runtime( "dialogue_item_offer", 91, owner_lua );
    cata::lua_platform::install_runtime_api( owner_runtime, owner_lua, ccb );
    owner_lua.script( R"(
        item_offer_events = {}
        function item_offer_action(context, trial_success)
            local call = #item_offer_events + 1
            local use_item = call == 2
            local result = context:offer_item_to_interlocutor(use_item)
            item_offer_events[call] = {
                use_item = use_item,
                result = result,
                reason = context:reason(),
                trial_success = trial_success
            }
        end
    )" );

    sol::table responses = owner_lua.create_table();
    for( int index = 1; index <= 3; ++index ) {
        sol::table response = owner_lua.create_table();
        response["text"] = "Offer item outcome " + std::to_string( index );
        response["on_action"] = owner_lua["item_offer_action"];
        responses[index] = response;
    }
    sol::table descriptor = owner_lua.create_table();
    descriptor["id"] = "TALK_CCB_ITEM_OFFER_TEST";
    descriptor["dynamic_line"] = "Item offer contract test";
    descriptor["responses"] = responses;
    const sol::table dialogue_api = ccb["dialogue"];
    const sol::protected_function register_topic = dialogue_api["register_topic"];
    const sol::protected_function_result registered =
        register_topic( descriptor );
    REQUIRE( registered.valid() );

    npc speaker;
    speaker.normalize();
    speaker.setID( character_id( 1331 ), true );
    npc interlocutor;
    interlocutor.normalize();
    interlocutor.setID( character_id( 1332 ), true );
    auto injected_interlocutor = std::make_unique<platform_item_offer_test_talker>(
                                     &interlocutor,
    std::vector<std::string> { "accepted", "refused", "cancelled" } );
    platform_item_offer_test_talker *const injected_interlocutor_ptr =
        injected_interlocutor.get();

    cata::lua_platform::set_active_runtimes( { owner_runtime } );
    cata::lua_platform::runtime_world_ready( true );
    dialogue conversation( std::make_unique<talker_npc>( &speaker ),
                           std::move( injected_interlocutor ) );
    const cata::lua_platform::game_handle_runtime runtime_identity =
        cata::lua_platform::detail::runtime_handle_identity( owner_runtime );
    const std::size_t world_generation =
        cata::lua_platform::runtime_world_generation();
    const cata::lua_platform::dialogue::dialogue_session_ptr session =
        cata::lua_platform::dialogue::begin_session(
            conversation, runtime_identity, world_generation );
    conversation.gen_responses( talk_topic( "TALK_CCB_ITEM_OFFER_TEST" ) );
    REQUIRE( conversation.responses.size() == 3 );

    const std::vector<std::string> expected_reasons = {
        "accepted", "refused", "cancelled"
    };
    for( std::size_t index = 0; index < conversation.responses.size(); ++index ) {
        talk_response &response = conversation.responses[index];
        response.success.opinion.trust = 1;
        const int trust_before_action = interlocutor.op_of_u.trust;
        response.success.apply( conversation );
        REQUIRE( injected_interlocutor_ptr->trust_before_call.size() >=
                 index + 1 );
        CHECK( injected_interlocutor_ptr->trust_before_call[index] ==
               trust_before_action );
        CHECK( conversation.reason == expected_reasons[index] );
    }

    REQUIRE( injected_interlocutor_ptr->use_item_calls.size() == 3 );
    CHECK_FALSE( injected_interlocutor_ptr->use_item_calls[0] );
    CHECK( injected_interlocutor_ptr->use_item_calls[1] );
    CHECK_FALSE( injected_interlocutor_ptr->use_item_calls[2] );
    const sol::table action_events = owner_lua["item_offer_events"];
    REQUIRE( action_events.size() == expected_reasons.size() );
    for( std::size_t index = 0; index < expected_reasons.size(); ++index ) {
        const sol::table event = action_events.get<sol::table>( index + 1 );
        CHECK( event["result"].get<std::string>() == expected_reasons[index] );
        CHECK( event["reason"].get<std::string>() == expected_reasons[index] );
        CHECK( event["trial_success"].get<bool>() );
    }

    using dialogue_context = cata::lua_platform::dialogue::context;
    dialogue_context outside_action(
        owner_lua.lua_state(), conversation, "TALK_CCB_ITEM_OFFER_TEST", true,
        "dialogue context is stale", {}, session, runtime_identity,
        world_generation );
    CHECK_THROWS( outside_action.offer_item_to_interlocutor( false ) );
    CHECK( injected_interlocutor_ptr->use_item_calls.size() == 3 );

    dialogue non_npc_beta( std::make_unique<talker_topic>(),
                           std::make_unique<talker_topic>() );
    auto non_npc_session = cata::lua_platform::dialogue::begin_session(
                               non_npc_beta, runtime_identity, world_generation );
    non_npc_session = cata::lua_platform::dialogue::session_for(
                          non_npc_beta, "TALK_CCB_ITEM_OFFER_TEST", runtime_identity,
                          world_generation );
    dialogue_context non_npc_context(
        owner_lua.lua_state(), non_npc_beta, "TALK_CCB_ITEM_OFFER_TEST", true,
        "dialogue context is stale", {}, non_npc_session, runtime_identity,
        world_generation, true );
    const std::string native_base_reason =
        non_npc_beta.actor( true )->give_item_to( false );
    CHECK( non_npc_context.offer_item_to_interlocutor( false ) == native_base_reason );
    CHECK( non_npc_beta.reason == native_base_reason );

    dialogue missing_beta( std::make_unique<talker_topic>(), nullptr );
    auto missing_beta_session =
        cata::lua_platform::dialogue::begin_session(
            missing_beta, runtime_identity, world_generation );
    missing_beta_session = cata::lua_platform::dialogue::session_for(
                               missing_beta, "TALK_CCB_ITEM_OFFER_TEST", runtime_identity,
                               world_generation );
    dialogue_context missing_beta_context(
        owner_lua.lua_state(), missing_beta, "TALK_CCB_ITEM_OFFER_TEST", true,
        "dialogue context is stale", {}, missing_beta_session, runtime_identity,
        world_generation, true );
    CHECK_THROWS( missing_beta_context.offer_item_to_interlocutor( false ) );
    cata::lua_platform::dialogue::end_session( non_npc_beta );
    cata::lua_platform::dialogue::end_session( missing_beta );
    cata::lua_platform::dialogue::end_session( conversation );
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

TEST_CASE( "lua_platform_dialogue_debug_shows_failed_switch_responses_like_native",
           "[lua][platform][dialogue][runtime][semantic]" )
{
    cata::lua_platform::clear_active_runtimes();
    struct dialogue_debug_cleanup {
        ~dialogue_debug_cleanup() {
            cata::lua_platform::clear_active_runtimes();
        }
    } cleanup;

    avatar speaker;
    speaker.normalize();
    speaker.setID( character_id( 1570 ), true );
    REQUIRE_FALSE( speaker.has_trait( trait_id( "SPIRITUAL" ) ) );
    const itype_id repeat_item_id( "test_rock" );
    speaker.i_add( item( repeat_item_id, calendar::turn ) );
    REQUIRE( speaker.has_amount( repeat_item_id, 1 ) );
    npc interlocutor;
    interlocutor.normalize();
    interlocutor.setID( character_id( 1571 ), true );

    const JsonValue false_switch_json = json_loader::from_string(
            R"({
              "text": "False switch",
              "condition": { "u_has_trait": "SPIRITUAL" },
              "switch": true
            })" );
    const JsonValue default_switch_json = json_loader::from_string(
            R"({
              "text": "Fallback",
              "switch": true,
              "default": true
            })" );
    const JsonValue repeat_json = json_loader::from_string(
            R"({
              "for_item": "test_rock",
              "response": { "text": "Repeat item", "switch": true }
            })" );
    const JsonValue false_repeat_json = json_loader::from_string(
            R"({
              "for_item": "test_rock",
              "response": {
                "text": "Hidden repeat",
                "condition": { "u_has_trait": "SPIRITUAL" },
                "show_always": true,
                "failure_explanation": "Unavailable"
              }
            })" );
    json_talk_response native_false_switch(
        false_switch_json.get_object(), "dialogue_debug_condition_test" );
    json_talk_response native_default_switch(
        default_switch_json.get_object(), "dialogue_debug_condition_test" );
    json_talk_repeat_response native_repeat(
        repeat_json.get_object(), "dialogue_debug_condition_test" );
    json_talk_repeat_response native_false_repeat(
        false_repeat_json.get_object(), "dialogue_debug_condition_test" );
    const auto generate_native = [&]( dialogue &conversation, bool &switch_done ) {
        switch_done = false;
        std::vector<bool> switch_claims;
        for( json_talk_response *const response : {
                 &native_false_switch, &native_default_switch
             } ) {
            const bool claims_switch = response->gen_responses( conversation, switch_done );
            switch_claims.push_back( claims_switch );
            if( claims_switch ) {
                switch_done = true;
            }
        }
        return switch_claims;
    };

    dialogue native_normal(
        get_talker_for( speaker ), get_talker_for( interlocutor ) );
    bool native_normal_switch_done = false;
    const std::vector<bool> native_normal_claims = generate_native(
                native_normal, native_normal_switch_done );
    REQUIRE( native_normal_claims.size() == 2 );
    CHECK_FALSE( native_normal_claims[0] );
    CHECK_FALSE( native_normal_claims[1] );
    CHECK_FALSE( native_normal_switch_done );
    CHECK( native_repeat.response.gen_repeat_response(
               native_normal, repeat_item_id, native_normal_switch_done ) );
    CHECK_FALSE( native_false_repeat.response.gen_repeat_response(
                     native_normal, repeat_item_id, native_normal_switch_done ) );
    REQUIRE( native_normal.responses.size() == 2 );
    CHECK( native_normal.responses[0].truetext.translated() == "Repeat item" );
    CHECK( native_normal.responses[1].truetext.translated() == "Fallback" );

    dialogue native_debug(
        get_talker_for( speaker ), get_talker_for( interlocutor ) );
    native_debug.debug_ignore_conditionals = true;
    bool native_debug_switch_done = false;
    const std::vector<bool> native_debug_claims = generate_native(
                native_debug, native_debug_switch_done );
    REQUIRE( native_debug_claims.size() == 2 );
    CHECK( native_debug_switch_done );
    CHECK_FALSE( native_repeat.response.gen_repeat_response(
                     native_debug, repeat_item_id, native_debug_switch_done ) );
    CHECK_FALSE( native_false_repeat.response.gen_repeat_response(
                     native_debug, repeat_item_id, native_debug_switch_done ) );
    REQUIRE( native_debug.responses.size() == 2 );
    CHECK( native_debug.responses[0].truetext.translated() == "False switch" );
    CHECK( native_debug.responses[1].truetext.translated() == "Fallback" );
    CHECK( native_debug.responses[0].ignore_conditionals );
    CHECK_FALSE( native_debug.responses[1].ignore_conditionals );
    CHECK( native_debug_claims[0] );
    CHECK_FALSE( native_debug_claims[1] );

    sol::state owner_lua;
    sol::table ccb = owner_lua.create_table();
    const std::shared_ptr<cata::lua_platform::runtime> owner_runtime =
        cata::lua_platform::make_runtime( "dialogue_debug_conditions", 96, owner_lua );
    cata::lua_platform::install_runtime_api( owner_runtime, owner_lua, ccb );
    owner_lua["ccb"] = ccb;
    sol::table false_switch = owner_lua.create_table();
    false_switch["text"] = "False switch";
    false_switch["condition"] = false;
    false_switch["switch"] = true;
    sol::table default_switch = owner_lua.create_table();
    default_switch["text"] = "Fallback";
    default_switch["switch"] = true;
    default_switch["default"] = true;
    sol::table responses = owner_lua.create_table();
    responses[1] = false_switch;
    responses[2] = default_switch;
    sol::table repeat_response = owner_lua.create_table();
    repeat_response["text"] = "Repeat item";
    repeat_response["switch"] = true;
    sol::table repeat_descriptor = owner_lua.create_table();
    repeat_descriptor["item"] = "test_rock";
    repeat_descriptor["response"] = repeat_response;
    sol::table repeat_responses = owner_lua.create_table();
    repeat_responses[1] = repeat_descriptor;
    sol::table false_repeat_response = owner_lua.create_table();
    false_repeat_response["text"] = "Hidden repeat";
    false_repeat_response["condition"] = false;
    false_repeat_response["show_always"] = true;
    false_repeat_response["failure_explanation"] = "Unavailable";
    sol::table false_repeat_descriptor = owner_lua.create_table();
    false_repeat_descriptor["item"] = "test_rock";
    false_repeat_descriptor["response"] = false_repeat_response;
    repeat_responses[2] = false_repeat_descriptor;
    sol::table descriptor = owner_lua.create_table();
    descriptor["id"] = "TALK_CCB_DEBUG_CONDITION";
    descriptor["dynamic_line"] = "Debug condition parity test";
    descriptor["responses"] = responses;
    descriptor["repeat_responses"] = repeat_responses;
    const sol::protected_function_result registration =
        ccb["dialogue"]["register_topic"]( descriptor );
    REQUIRE( registration.valid() );

    cata::lua_platform::set_active_runtimes( { owner_runtime } );
    cata::lua_platform::runtime_world_ready( true );
    const cata::lua_platform::game_handle_runtime runtime_identity =
        cata::lua_platform::detail::runtime_handle_identity( owner_runtime );
    const std::size_t world_generation =
        cata::lua_platform::runtime_world_generation();
    const auto generate_platform = [&]( dialogue &conversation ) {
        const cata::lua_platform::dialogue::dialogue_session_ptr session =
            cata::lua_platform::dialogue::begin_session(
                conversation, runtime_identity, world_generation );
        conversation.gen_responses( talk_topic( "TALK_CCB_DEBUG_CONDITION" ) );
        return session;
    };

    dialogue platform_normal(
        get_talker_for( speaker ), get_talker_for( interlocutor ) );
    const cata::lua_platform::dialogue::dialogue_session_ptr normal_session =
        generate_platform( platform_normal );
    REQUIRE( normal_session );
    REQUIRE( platform_normal.responses.size() == 2 );
    CHECK( platform_normal.responses[0].truetext.translated() == "Repeat item" );
    CHECK( platform_normal.responses[1].truetext.translated() == "Fallback" );
    CHECK( platform_normal.response_condition_eval == native_normal.response_condition_eval );
    cata::lua_platform::dialogue::end_session( platform_normal );

    dialogue platform_debug(
        get_talker_for( speaker ), get_talker_for( interlocutor ) );
    platform_debug.debug_ignore_conditionals = true;
    const cata::lua_platform::dialogue::dialogue_session_ptr debug_session =
        generate_platform( platform_debug );
    REQUIRE( debug_session );
    REQUIRE( platform_debug.responses.size() == 2 );
    CHECK( platform_debug.responses[0].truetext.translated() == "False switch" );
    CHECK( platform_debug.responses[1].truetext.translated() == "Fallback" );
    CHECK( platform_debug.responses[0].ignore_conditionals );
    CHECK_FALSE( platform_debug.responses[1].ignore_conditionals );
    CHECK( platform_debug.response_condition_eval == native_debug.response_condition_eval );
    cata::lua_platform::dialogue::end_session( platform_debug );
}

#endif // CATA_ENABLE_LUA_PLATFORM
