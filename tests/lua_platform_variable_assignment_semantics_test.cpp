#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <string_view>

#include "flexbuffer_json.h"
#include <cstddef>
#include <functional>
#include <limits>
#include <memory>
#include <string>
#include <utility>
#include <vector>

#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character_id.h"
#include "dialogue.h"
#include "debug.h"
#include "dialogue_helpers.h"
#include "event.h"
#include "event_bus.h"
#include "event_subscriber.h"
#include "global_vars.h"
#include "json_loader.h"
#include "lua_platform_handle.h"
#include "lua_platform_runtime.h"
#include "lua_platform_runtime_internal.h"
#include "lua_platform_sol.h"
#include "math_parser_diag_value.h"
#include "npc.h"
#include "rng.h"

namespace
{

struct variable_changed_observer : event_subscriber {
    using event_subscriber::notify;

    void notify( const cata::event &event ) override {
        if( event.type() == event_type::u_var_changed ) {
            changes.emplace_back( event.get<std::string>( "var" ),
                                  event.get<std::string>( "value" ) );
        }
    }

    std::vector<std::pair<std::string, std::string>> changes;
};

void apply_talk_effect( dialogue &context, const std::string &json,
                        const std::string &name, const bool expect_shadowed_value = false )
{
    talk_effect_t effect;
    if( expect_shadowed_value ) {
        const std::string diagnostic = capture_debugmsg_during( [&]() {
            effect.parse_sub_effect( json_loader::from_string( json ).get_object(), name );
        } );
        CHECK( diagnostic.find( "Invalid or misplaced field name \"value\"" ) !=
               std::string::npos );
    } else {
        effect.parse_sub_effect( json_loader::from_string( json ).get_object(), name );
    }
    for( const talk_effect_fun_t &entry : effect.effects ) {
        entry( context );
    }
}

} // namespace

TEST_CASE( "lua_platform_variable_assignment_matches_literal_legacy_effects",
           "[lua][platform][semantic][variables]" )
{
    namespace platform = cata::lua_platform;
    platform::clear_active_runtimes();

    // Platform randomness uses a runtime-local stream.  This batch checks
    // values and events without requiring parity with the legacy global RNG.
    const cata_default_random_engine saved_rng = rng_get_engine(); // NOLINT(cata-determinism)
    const on_out_of_scope restore_rng( [&saved_rng]() {
        rng_get_engine() = saved_rng;
    } );

    avatar player;
    npc partner;
    player.normalize();
    partner.normalize();
    player.setID( character_id( 9051 ), true );
    partner.setID( character_id( 9052 ), true );
    platform::register_npc_handle_identity( partner );
    struct identity_cleanup {
        npc &value;
        ~identity_cleanup() {
            platform::retire_npc_handle_identity( value );
        }
    } cleanup{ partner };

    dialogue context( get_talker_for( player ), get_talker_for( partner ) );
    // These are literal storage keys even though their text resembles the
    // legacy u_val/context_val variable-reference prefixes.
    const std::string u_key = "u_val";
    const std::string npc_key = "context_val";
    const std::string assignment_value = "assignment-ready";

    variable_changed_observer observer;
    get_event_bus().subscribe( &observer );

    // Legacy u_add_var stores on the avatar and emits the two string payload
    // fields.  Its literal-value path still calls global rng(0, 0); restore
    // that engine so this native behavior check stays isolated.
    apply_talk_effect( context,
                       R"({"u_add_var":"u_val","value":"assignment-ready"})",
                       "lua_platform_u_add_var_semantics" );
    REQUIRE( player.maybe_get_value( u_key ) != nullptr );
    CHECK( player.get_value( u_key ).str() == assignment_value );
    CHECK( partner.maybe_get_value( u_key ) == nullptr );
    REQUIRE( observer.changes.size() == 1 );
    CHECK( observer.changes.back().first == u_key );
    CHECK( observer.changes.back().second == assignment_value );

    apply_talk_effect( context,
                       R"({"npc_add_var":"context_val","value":"assignment-ready"})",
                       "lua_platform_npc_add_var_semantics" );
    REQUIRE( partner.maybe_get_value( npc_key ) != nullptr );
    CHECK( partner.get_value( npc_key ).str() == assignment_value );
    CHECK( player.maybe_get_value( npc_key ) == nullptr );
    REQUIRE( observer.changes.size() == 2 );
    CHECK( observer.changes.back().first == npc_key );
    CHECK( observer.changes.back().second == assignment_value );

    const std::string priority_key = "variable_assignment_priority";
    const std::string fallback_key = "variable_assignment_fallback";
    const std::string time_override_key = "variable_assignment_time_override";
    const std::string time_empty_candidates_key =
        "variable_assignment_time_empty_candidates";
    apply_talk_effect( context,
                       R"({
                           "u_add_var":"variable_assignment_priority",
                           "value":17,
                           "possible_values":["candidate-a","candidate-b"]
                       })",
                       "lua_platform_u_add_var_possible_values_priority", true );
    REQUIRE( player.maybe_get_value( priority_key ) != nullptr );
    const std::string native_choice = player.get_value( priority_key ).str();
    CHECK( native_choice != "17" );
    CHECK( ( native_choice == "candidate-a" || native_choice == "candidate-b" ) );
    REQUIRE( observer.changes.size() == 3 );
    CHECK( observer.changes.back().first == priority_key );
    CHECK( observer.changes.back().second == native_choice );

    apply_talk_effect( context,
                       R"({
                           "npc_add_var":"variable_assignment_fallback",
                           "value":"fallback-ready",
                           "possible_values":[]
                       })",
                       "lua_platform_npc_add_var_empty_candidates_fallback" );
    REQUIRE( partner.maybe_get_value( fallback_key ) != nullptr );
    CHECK( partner.get_value( fallback_key ).str() == "fallback-ready" );
    REQUIRE( observer.changes.size() == 4 );
    CHECK( observer.changes.back().first == fallback_key );
    CHECK( observer.changes.back().second == "fallback-ready" );

    // The native parser reads possible_values first, but a true time flag
    // overrides both it and value; the wrong-typed value is never read.
    const std::string time_override_value =
        std::to_string( to_turn<int>( calendar::turn ) );
    const std::string ignored_time_candidate( 1025, 'x' );
    const std::string time_override_effect =
        R"({"u_add_var":"variable_assignment_time_override","time":true,"value":17,"possible_values":[")" +
        ignored_time_candidate + R"("]})";
    apply_talk_effect( context, time_override_effect,
                       "lua_platform_u_add_var_time_priority", true );
    REQUIRE( player.maybe_get_value( time_override_key ) != nullptr );
    CHECK( player.get_value( time_override_key ).str() == time_override_value );
    CHECK( observer.changes.size() == 4 );
    apply_talk_effect( context,
                       R"({
                           "u_add_var":"variable_assignment_time_empty_candidates",
                           "time":true,
                           "value":17,
                           "possible_values":[]
                       })",
                       "lua_platform_u_add_var_time_with_empty_candidates", true );
    REQUIRE( player.maybe_get_value( time_empty_candidates_key ) != nullptr );
    CHECK( player.get_value( time_empty_candidates_key ).str() == time_override_value );
    CHECK( observer.changes.size() == 4 );

    CHECK_THROWS( apply_talk_effect( context,
                                     R"({"u_add_var":"bad_time","time":"true","value":"x"})",
                                     "lua_platform_u_add_var_bad_time_type" ) );
    CHECK_THROWS( apply_talk_effect( context,
                                     R"({"u_add_var":"bad_candidates","possible_values":"left","value":"x"})",
                                     "lua_platform_u_add_var_bad_candidates_type" ) );
    CHECK_THROWS( apply_talk_effect( context,
                                     R"({"u_add_var":"bad_candidate","possible_values":["left",7]})",
                                     "lua_platform_u_add_var_bad_candidate_type" ) );
    CHECK_THROWS( apply_talk_effect( context,
                                     R"({
                                         "u_add_var":"bad_ignored_candidate",
                                         "time":true,
                                         "possible_values":["left",7]
                                     })",
                                     "lua_platform_u_add_var_bad_ignored_candidate_type" ) );
    CHECK_THROWS( apply_talk_effect( context,
                                     R"({"u_add_var":"missing_fallback","possible_values":[]})",
                                     "lua_platform_u_add_var_missing_fallback" ) );
    CHECK_THROWS( apply_talk_effect( context,
                                     R"({"u_add_var":"bad_fallback","possible_values":[],"value":7})",
                                     "lua_platform_u_add_var_bad_fallback_type" ) );

    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::table, sol::lib::string );
    sol::table ccb = lua.create_table();
    const std::shared_ptr<platform::runtime> owner = platform::make_runtime(
                "lua_variable_assignment_semantics", 9053, lua );
    platform::install_runtime_api( owner, lua, ccb );
    platform::set_active_runtimes( { owner } );
    const on_out_of_scope clear_runtimes( []() {
        platform::clear_active_runtimes();
    } );
    owner->world_is_ready = true;

    const std::size_t world_generation = platform::detail::runtime_world_generation_storage();
    lua["ccb"] = ccb;
    lua["player_owner"] = platform::game_handle::from_creature(
                              player, { "avatar", 9051, 0, 0, 0, {} },
                              owner->handle_runtime(), world_generation );
    lua["partner_owner"] = platform::game_handle::from_creature(
                               partner, { "npc", 9052, 0, 0, 0, {} },
                               owner->handle_runtime(), world_generation );

    const auto run_platform_write = [&lua]( const std::string_view script ) {
        const sol::protected_function_result result = lua.safe_script(
                    script, sol::script_pass_on_error );
        if( !result.valid() ) {
            const sol::error error = result;
            INFO( error.what() );
            REQUIRE( result.valid() );
        }
    };

    const time_point original_turn = calendar::turn;
    const on_out_of_scope restore_turn( [original_turn]() {
        calendar::turn = original_turn;
    } );
    const auto check_native_int_turn = [&]( const int turns ) {
        calendar::turn = time_point::from_turn( turns );
        lua["expected_native_int_turn"] = turns;
        platform::detail::callback_scope active_callback( *owner );
        run_platform_write( R"(
            assert(ccb.services.turn_native_int() == expected_native_int_turn)
        )" );
    };
    check_native_int_turn( to_turn<int>( original_turn ) );
    check_native_int_turn( 0 );
    check_native_int_turn( std::numeric_limits<int>::max() );
    check_native_int_turn( std::numeric_limits<int>::min() );
    calendar::turn = original_turn;

    const std::string copy_npc_source = "lua_semantic_copy_npc_source";
    const std::string copy_u_source = "lua_semantic_copy_u_source";
    const std::string copy_u_target = "lua_semantic_copy_u_target";
    const std::string copy_npc_target = "lua_semantic_copy_npc_target";
    const std::string copy_missing_native = "lua_semantic_copy_missing_native";
    const std::string copy_missing_platform = "lua_semantic_copy_missing_platform";
    diag_value copy_value;
    copy_value._deserialize(
        json_loader::from_string( R"([null,[1,null,"tail"],{"tripoint":[1,2,3]}])" ),
        false );
    player.set_value( copy_u_source, copy_value );
    partner.set_value( copy_npc_source, copy_value );
    const std::size_t events_before_copy = observer.changes.size();

    apply_talk_effect( context,
                       R"({
                           "copy_var":{"npc_val":"lua_semantic_copy_npc_source"},
                           "target_var":{"u_val":"lua_semantic_copy_u_target"}
                       })",
                       "lua_platform_copy_var_npc_to_u" );
    CHECK( player.get_value( copy_u_target ) == copy_value );
    CHECK( observer.changes.size() == events_before_copy );
    {
        platform::detail::callback_scope active_callback( *owner );
        run_platform_write( R"(
            local result = ccb.services.variables.copy(
                partner_owner, "lua_semantic_copy_npc_source",
                player_owner, "lua_semantic_copy_u_target")
            assert(result.ok and result.value.source_exists and
                result.value.destination_existed)
        )" );
    }
    CHECK( player.get_value( copy_u_target ) == copy_value );
    CHECK( observer.changes.size() == events_before_copy );

    apply_talk_effect( context,
                       R"({
                           "copy_var":{"u_val":"lua_semantic_copy_u_source"},
                           "target_var":{"npc_val":"lua_semantic_copy_npc_target"}
                       })",
                       "lua_platform_copy_var_u_to_npc" );
    CHECK( partner.get_value( copy_npc_target ) == copy_value );
    {
        platform::detail::callback_scope active_callback( *owner );
        run_platform_write( R"(
            local result = ccb.services.variables.copy(
                player_owner, "lua_semantic_copy_u_source",
                partner_owner, "lua_semantic_copy_npc_target")
            assert(result.ok and result.value.source_exists and
                result.value.destination_existed)
        )" );
    }
    CHECK( partner.get_value( copy_npc_target ) == copy_value );
    CHECK( observer.changes.size() == events_before_copy );

    apply_talk_effect( context,
                       R"({
                           "copy_var":{"u_val":"lua_semantic_copy_source_missing"},
                           "target_var":{"npc_val":"lua_semantic_copy_missing_native"}
                       })",
                       "lua_platform_copy_var_missing_source" );
    REQUIRE( partner.maybe_get_value( copy_missing_native ) != nullptr );
    CHECK( partner.get_value( copy_missing_native ).is_empty() );
    partner.remove_value( copy_missing_platform );
    {
        platform::detail::callback_scope active_callback( *owner );
        run_platform_write( R"(
            local result = ccb.services.variables.copy(
                player_owner, "lua_semantic_copy_source_missing",
                partner_owner, "lua_semantic_copy_missing_platform")
            assert(result.ok and not result.value.source_exists and
                not result.value.destination_existed)
        )" );
    }
    REQUIRE( partner.maybe_get_value( copy_missing_platform ) != nullptr );
    CHECK( partner.get_value( copy_missing_platform ).is_empty() );
    CHECK( observer.changes.size() == events_before_copy );

    const std::string empty_global_key;
    const diag_value *old_empty_global = get_globals().maybe_get_global_value( empty_global_key );
    const bool empty_global_existed = old_empty_global != nullptr;
    const diag_value old_empty_global_value = empty_global_existed ?
            *old_empty_global : diag_value{};
    const on_out_of_scope restore_empty_global(
    [empty_global_existed, old_empty_global_value]() {
        if( empty_global_existed ) {
            get_globals().set_global_value( "", old_empty_global_value );
        } else {
            get_globals().remove_global_value( "" );
        }
    } );
    get_globals().set_global_value( empty_global_key, copy_value );
    apply_talk_effect( context,
                       R"({"copy_var":{"global_val":""},"target_var":{"global_val":""}})",
                       "lua_platform_copy_var_global_empty_key_self_copy" );
    CHECK( get_globals().get_global_value( empty_global_key ) == copy_value );
    {
        platform::detail::callback_scope active_callback( *owner );
        run_platform_write( R"(
            local result = ccb.services.variables.copy(nil, "", nil, "")
            assert(result.ok and result.value.source_exists and
                result.value.destination_existed)
        )" );
    }
    CHECK( get_globals().get_global_value( empty_global_key ) == copy_value );
    CHECK( observer.changes.size() == events_before_copy );

    const std::string empty_string_global_key = "lua_platform_set_string_empty";
    const diag_value *old_string_global =
        get_globals().maybe_get_global_value( empty_string_global_key );
    const bool string_global_existed = old_string_global != nullptr;
    const diag_value old_string_global_value = string_global_existed ?
            *old_string_global : diag_value{};
    const on_out_of_scope restore_string_global(
    [empty_string_global_key, string_global_existed, old_string_global_value]() {
        if( string_global_existed ) {
            get_globals().set_global_value( empty_string_global_key, old_string_global_value );
        } else {
            get_globals().remove_global_value( empty_string_global_key );
        }
    } );
    apply_talk_effect( context,
                       R"({"set_string_var":"","target_var":{"global_val":"lua_platform_set_string_empty"}})",
                       "lua_platform_set_string_empty_native" );
    REQUIRE( get_globals().maybe_get_global_value( empty_string_global_key ) != nullptr );
    CHECK( get_globals().get_global_value( empty_string_global_key ).is_str() );
    CHECK( get_globals().get_global_value( empty_string_global_key ).str().empty() );
    CHECK( observer.changes.size() == events_before_copy );
    {
        platform::detail::callback_scope active_callback( *owner );
        run_platform_write( R"(
            local result = ccb.services.variables.set_global(
                "lua_platform_set_string_empty", "")
            assert(result.ok and result.value.existed)
        )" );
    }
    REQUIRE( get_globals().maybe_get_global_value( empty_string_global_key ) != nullptr );
    CHECK( get_globals().get_global_value( empty_string_global_key ).is_str() );
    CHECK( get_globals().get_global_value( empty_string_global_key ).str().empty() );
    CHECK( observer.changes.size() == events_before_copy );

    player.remove_value( u_key );
    partner.remove_value( npc_key );
    CHECK( player.maybe_get_value( u_key ) == nullptr );
    CHECK( partner.maybe_get_value( npc_key ) == nullptr );
    {
        // Model an active Platform callback so the real write and native event
        // services enforce their normal callback-scoped mutation contract.
        platform::detail::callback_scope active_callback( *owner );
        run_platform_write( R"(
            local services = ccb.services
            local u_write = services.variables.set(player_owner,
                "u_val", "assignment-ready")
            assert(u_write.ok and not u_write.value.existed)
            assert(services.native_events.emit("u_var_changed",
                {"u_val", "assignment-ready"}))
            local npc_write = services.variables.set(partner_owner,
                "context_val", "assignment-ready")
            assert(npc_write.ok and not npc_write.value.existed)
            assert(services.native_events.emit("u_var_changed",
                {"context_val", "assignment-ready"}))
        )" );
    }
    CHECK( player.get_value( u_key ).str() == assignment_value );
    CHECK( partner.get_value( npc_key ).str() == assignment_value );
    REQUIRE( observer.changes.size() == 6 );
    CHECK( observer.changes[4].first == u_key );
    CHECK( observer.changes[4].second == assignment_value );
    CHECK( observer.changes[5].first == npc_key );
    CHECK( observer.changes[5].second == assignment_value );

    player.remove_value( priority_key );
    partner.remove_value( fallback_key );
    player.remove_value( time_override_key );
    CHECK( player.maybe_get_value( priority_key ) == nullptr );
    CHECK( partner.maybe_get_value( fallback_key ) == nullptr );
    CHECK( player.maybe_get_value( time_override_key ) == nullptr );
    lua["time_override_value"] = time_override_value;
    {
        platform::detail::callback_scope active_callback( *owner );
        run_platform_write( R"(
            local services = ccb.services
            local candidates = { "candidate-a", "candidate-b" }
            local selected = candidates[services.random.int(0, #candidates - 1) + 1]
            local choice_write = services.variables.set(
                player_owner, "variable_assignment_priority", selected)
            assert(choice_write.ok and not choice_write.value.existed)
            assert(services.native_events.emit("u_var_changed",
                { "variable_assignment_priority", selected }))
            local fallback_write = services.variables.set(
                partner_owner, "variable_assignment_fallback", "fallback-ready")
            assert(fallback_write.ok and not fallback_write.value.existed)
            assert(services.native_events.emit("u_var_changed",
                { "variable_assignment_fallback", "fallback-ready" }))
            local time_write = services.variables.set(player_owner,
                "variable_assignment_time_override", time_override_value)
            assert(time_write.ok and not time_write.value.existed)
        )" );
    }
    const std::string platform_choice = player.get_value( priority_key ).str();
    CHECK( ( platform_choice == "candidate-a" || platform_choice == "candidate-b" ) );
    CHECK( partner.get_value( fallback_key ).str() == "fallback-ready" );
    CHECK( player.get_value( time_override_key ).str() == time_override_value );
    REQUIRE( observer.changes.size() == 8 );
    CHECK( observer.changes[6].first == priority_key );
    CHECK( observer.changes[6].second == platform_choice );
    CHECK( observer.changes[7].first == fallback_key );
    CHECK( observer.changes[7].second == "fallback-ready" );

    // The native time branch stores the current turn but intentionally emits
    // no u_var_changed event.  A Platform assignment for the same value has
    // the same no-event behavior.
    const std::string time_key = "lua_semantic_time_assignment";
    const std::string time_value = std::to_string( to_turn<int>( calendar::turn ) );
    const std::size_t events_before_time = observer.changes.size();
    apply_talk_effect( context,
                       R"({
                           "u_add_var":"lua_semantic_time_assignment",
                           "time":true,
                           "value":17,
                           "possible_values":["ignored"]
                       })",
                       "lua_platform_u_add_var_time_semantics", true );
    CHECK( player.get_value( time_key ).str() == time_value );
    CHECK( observer.changes.size() == events_before_time );
    player.remove_value( time_key );
    CHECK( player.maybe_get_value( time_key ) == nullptr );
    lua["time_value"] = time_value;
    {
        platform::detail::callback_scope active_callback( *owner );
        run_platform_write( R"(
            local result = ccb.services.variables.set(player_owner,
                "lua_semantic_time_assignment", time_value)
            assert(result.ok and not result.value.existed)
        )" );
    }
    CHECK( player.get_value( time_key ).str() == time_value );
    CHECK( observer.changes.size() == events_before_time );

    const std::string npc_time_key = "lua_semantic_npc_time_assignment";
    apply_talk_effect( context,
                       R"({
                           "npc_add_var":"lua_semantic_npc_time_assignment",
                           "time":true,
                           "value":17,
                           "possible_values":["ignored"]
                       })",
                       "lua_platform_npc_add_var_time_semantics", true );
    CHECK( partner.get_value( npc_time_key ).str() == time_value );
    CHECK( observer.changes.size() == events_before_time );
    partner.remove_value( npc_time_key );
    lua["npc_time_key"] = npc_time_key;
    lua["time_value"] = time_value;
    {
        platform::detail::callback_scope active_callback( *owner );
        run_platform_write( R"(
            local turn_text = tostring(ccb.services.turn_native_int())
            assert(turn_text == time_value)
            local result = ccb.services.variables.set(
                partner_owner, npc_time_key, turn_text, {include_before = false})
            assert(result.ok and not result.value.existed)
        )" );
    }
    CHECK( partner.get_value( npc_time_key ).str() == time_value );
    CHECK( observer.changes.size() == events_before_time );

    // Legacy lose-var effects and Platform removal only erase the selected
    // actor's key; neither operation publishes u_var_changed.
    const std::size_t events_before_remove = observer.changes.size();
    apply_talk_effect( context,
                       R"({"u_lose_var":"u_val"})",
                       "lua_platform_u_lose_var_semantics" );
    CHECK( player.maybe_get_value( u_key ) == nullptr );
    CHECK( observer.changes.size() == events_before_remove );
    player.set_value( u_key, assignment_value );
    REQUIRE( player.maybe_get_value( u_key ) != nullptr );
    {
        platform::detail::callback_scope active_callback( *owner );
        run_platform_write( R"(
            local result = ccb.services.variables.remove(player_owner, "u_val")
            assert(result.ok and result.value.removed)
        )" );
    }
    CHECK( player.maybe_get_value( u_key ) == nullptr );
    CHECK( observer.changes.size() == events_before_remove );

    // This key is used by the real lumbermill dialogue cleanup in
    // data/json/npcs/lumbermill_employees/TALK_lumbermill_fabricate.json.
    // npc_lose_var must erase beta's value, leave alpha's same-named value,
    // and publish no u_var_changed event.
    const std::string npc_remove_key = "timer_fabricate_waiting";
    player.set_value( npc_remove_key, "alpha-kept" );
    partner.set_value( npc_remove_key, "beta-removed" );
    apply_talk_effect( context,
                       R"({"npc_lose_var":"timer_fabricate_waiting"})",
                       "lua_platform_npc_lose_var_semantics" );
    CHECK( partner.maybe_get_value( npc_remove_key ) == nullptr );
    REQUIRE( player.maybe_get_value( npc_remove_key ) != nullptr );
    CHECK( player.get_value( npc_remove_key ).str() == "alpha-kept" );
    CHECK( observer.changes.size() == events_before_remove );
    partner.set_value( npc_remove_key, "beta-removed" );
    REQUIRE( partner.maybe_get_value( npc_remove_key ) != nullptr );
    {
        platform::detail::callback_scope active_callback( *owner );
        run_platform_write( R"(
            local result = ccb.services.variables.remove(partner_owner, "timer_fabricate_waiting")
            assert(result.ok and result.value.removed)
        )" );
    }
    CHECK( partner.maybe_get_value( npc_remove_key ) == nullptr );
    CHECK( player.get_value( npc_remove_key ).str() == "alpha-kept" );
    CHECK( observer.changes.size() == events_before_remove );
}

#endif
