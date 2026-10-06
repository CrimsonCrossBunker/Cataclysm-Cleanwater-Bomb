#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <math_parser_diag_value.h>
#include <functional>
#include <initializer_list>
#include <memory>
#include <string>
#include <unordered_map>
#include <utility>
#include <vector>

#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "condition.h"
#include "debug.h"
#include "dialogue.h"
#include "event.h"
#include "event_bus.h"
#include "event_subscriber.h"
#include "flexbuffer_json.h"
#include "global_vars.h"
#include "json_loader.h"
#include "lua_platform_runtime.h"
#include "lua_platform_runtime_internal.h"
#include "lua_platform_sol.h"
#include "talker.h"

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

} // namespace

TEST_CASE( "lua_platform_native_event_preserves_long_string_payloads",
           "[lua][platform][native_events][semantic]" )
{
    namespace platform = cata::lua_platform;
    platform::clear_active_runtimes();

    sol::state lua;
    lua.open_libraries( sol::lib::base );
    sol::table ccb = lua.create_table();
    const std::shared_ptr<platform::runtime> owner = platform::make_runtime(
                "native_event_string_payload", 5901, lua );
    const on_out_of_scope clear_runtimes( []() {
        platform::clear_active_runtimes();
    } );
    platform::install_runtime_api( owner, lua, ccb );
    platform::set_active_runtimes( { owner } );
    owner->world_is_ready = true;

    variable_changed_observer observer;
    get_event_bus().subscribe( &observer );

    std::string expected_key( 2048, 'k' );
    expected_key[31] = '\0';
    expected_key.back() = 'z';
    std::string expected_value( 4096, 'v' );
    expected_value[1537] = '\0';
    expected_value.back() = 'x';
    lua["ccb"] = ccb;
    lua["event_key"] = expected_key;
    lua["event_value"] = expected_value;

    {
        platform::detail::callback_scope active_callback( *owner );
        const sol::protected_function_result result = lua.safe_script(
                    R"(
                        assert(ccb.services.native_events.emit(
                            "u_var_changed", { event_key, event_value }))
                    )",
                    sol::script_pass_on_error );
        if( !result.valid() ) {
            const sol::error error = result;
            INFO( error.what() );
        }
        REQUIRE( result.valid() );
    }

    {
        platform::detail::callback_scope active_callback( *owner );
        const sol::protected_function_result result = lua.safe_script(
                    R"(
                        assert(ccb.services.native_events.emit(
                            "u_var_changed", { "number", 42.5 }))
                        assert(ccb.services.native_events.emit(
                            "u_var_changed", { "array", { "entry", 2 } }))
                        assert(ccb.services.native_events.emit(
                            "u_var_changed", { "boolean", true }))
                        assert(not ccb.services.native_events.emit(
                            "u_var_changed", { "wrong-arity" }))
                    )",
                    sol::script_pass_on_error );
        if( !result.valid() ) {
            const sol::error error = result;
            INFO( error.what() );
        }
        REQUIRE( result.valid() );
    }

    REQUIRE( observer.changes.size() == 4 );
    CHECK( observer.changes.front().first == expected_key );
    CHECK( observer.changes.front().second == expected_value );
    CHECK( observer.changes[1] == std::make_pair( std::string( "number" ),
            std::string( "42.5" ) ) );
    CHECK( observer.changes[2] == std::make_pair( std::string( "array" ),
            std::string( "[entry,2,]" ) ) );
    CHECK( observer.changes[3] == std::make_pair( std::string( "boolean" ),
            std::string( "1" ) ) );
}

TEST_CASE( "lua_platform_event_has_beta_matches_native_dialogue_presence",
           "[lua][platform][native_events][semantic]" )
{
    namespace platform = cata::lua_platform;
    platform::clear_active_runtimes();

    sol::state lua;
    lua.open_libraries( sol::lib::base );
    const std::shared_ptr<platform::runtime> owner = platform::make_runtime(
                "event_has_beta_presence", 5902, lua );
    const on_out_of_scope clear_runtimes( []() {
        platform::clear_active_runtimes();
    } );
    owner->world_is_ready = true;

    const sol::protected_function platform_has_beta = lua.load( R"(
        return context ~= nil and
            context.__ccb_event_beta_presence_proven == true and
            context.actors ~= nil and
            context.actors.interlocutor ~= nil
    )" );
    const conditional_t native_has_beta( "has_beta" );

    for( const bool has_beta : {
             false, true
         } ) {
        std::unique_ptr<talker> beta;
        if( has_beta ) {
            beta = std::make_unique<talker>();
        }
        dialogue native_dialogue( std::make_unique<talker>(), std::move( beta ) );
        const bool native_result = native_has_beta( native_dialogue );

        sol::table context = lua.create_table();
        context["__ccb_event_beta_presence_proven"] = true;
        sol::table actors = lua.create_table();
        if( has_beta ) {
            actors["interlocutor"] = platform::detail::platform_talker_to_lua(
                                         *owner, *native_dialogue.const_actor( true ) );
        }
        context["actors"] = actors;
        lua["context"] = context;

        const sol::protected_function_result platform_result = platform_has_beta();
        REQUIRE( platform_result.valid() );
        CHECK( platform_result.get<bool>() == native_result );
    }

    // Generated EOCs intentionally fail closed when they lack the direct-event
    // provenance marker, even if an unrelated caller supplied an interlocutor.
    sol::table unproven_context = lua.create_table();
    sol::table unproven_actors = lua.create_table();
    unproven_actors["interlocutor"] = lua.create_table();
    unproven_context["actors"] = unproven_actors;
    lua["context"] = unproven_context;
    const sol::protected_function_result unproven_result = platform_has_beta();
    REQUIRE( unproven_result.valid() );
    CHECK_FALSE( unproven_result.get<bool>() );
}

TEST_CASE( "lua_platform_expects_vars_matches_native_context_key_presence",
           "[lua][platform][conditions][semantic]" )
{
    global_variables::impl_t native_context;
    native_context.emplace( "false_value", diag_value( false ) );
    native_context.emplace( "zero_value", diag_value( 0 ) );
    native_context.emplace( "empty_value", diag_value( std::string() ) );
    native_context.emplace( "void_value", diag_value{} );
    dialogue native_dialogue( std::make_unique<talker>(), nullptr, {}, native_context );

    sol::state lua;
    lua.open_libraries( sol::lib::base );
    sol::table context = lua.create_table();
    sol::table data = lua.create_table();
    data["false_value"] = false;
    data["zero_value"] = 0;
    data["empty_value"] = "";
    // Platform's non-nil sentinel represents native empty/null values in
    // child contexts.  Presence, rather than truthiness, is what matters.
    data["void_value"] = lua.create_table();
    context["data"] = data;
    lua["context"] = context;
    const sol::protected_function_result evaluator = lua.safe_script( R"(
        return function(keys)
            for _, key in ipairs(keys) do
                if context.data[key] == nil then return false end
            end
            return true
        end
    )", sol::script_pass_on_error );
    REQUIRE( evaluator.valid() );
    const sol::protected_function platform_expects_vars = evaluator.get<sol::protected_function>();

    const auto compare = [&]( const std::string & json, const std::vector<std::string> &keys ) {
        const conditional_t native_condition(
            json_loader::from_string( json ).get_object() );
        sol::table required = lua.create_table();
        for( const std::string &key : keys ) {
            required.add( key );
        }
        const sol::protected_function_result platform_result = platform_expects_vars( required );
        REQUIRE( platform_result.valid() );
        CHECK( native_condition( native_dialogue ) == platform_result.get<bool>() );
    };

    compare( R"({"expects_vars":["false_value"]})", { "false_value" } );
    compare( R"({"expects_vars":["zero_value"]})", { "zero_value" } );
    compare( R"({"expects_vars":["empty_value"]})", { "empty_value" } );
    compare( R"({"expects_vars":["void_value"]})", { "void_value" } );
    compare( R"({"expects_vars":[]})", {} );

    const conditional_t missing_condition(
        json_loader::from_string( R"({"expects_vars":["missing"]})" ).get_object() );
    // The boolean result matches. Native additionally emits this diagnostic;
    // the Platform expression has no corresponding debug-message service.
    bool native_missing = true;
    const std::string native_diagnostic = capture_debugmsg_during( [&]() {
        native_missing = missing_condition( native_dialogue );
    } );
    sol::table missing = lua.create_table();
    missing.add( "missing" );
    const sol::protected_function_result platform_missing =
        platform_expects_vars( missing );
    REQUIRE( platform_missing.valid() );
    CHECK_FALSE( native_missing );
    CHECK_FALSE( platform_missing.get<bool>() );
    CHECK( native_diagnostic.find( "Missing required variables: missing" ) != std::string::npos );
}

#endif
