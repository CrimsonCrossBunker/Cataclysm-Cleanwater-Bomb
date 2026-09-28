#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <cstddef>
#include <memory>
#include <string>

#include "avatar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character_id.h"
#include "condition.h"
#include "dialogue.h"
#include "json_loader.h"
#include "lua_platform_handle.h"
#include "lua_platform_runtime.h"
#include "lua_platform_runtime_internal.h"
#include "lua_platform_sol.h"
#include "math_parser_diag_value.h"
#include "npc.h"
#include "npctalk.h"

namespace
{

void apply_native_math_effect( dialogue &context, const std::string &json,
                               const std::string &name )
{
    talk_effect_t effect;
    effect.parse_sub_effect( json_loader::from_string( json ).get_object(), name );
    for( const talk_effect_fun_t &entry : effect.effects ) {
        entry( context );
    }
}

} // namespace

TEST_CASE( "lua_platform_gameplay_math_keeps_native_scope_and_operation_modes",
           "[lua][platform][gameplay][math][semantic]" )
{
    namespace platform = cata::lua_platform;
    platform::clear_active_runtimes();

    avatar alpha;
    npc beta;
    alpha.normalize();
    beta.normalize();
    alpha.setID( character_id( 6311 ), true );
    beta.setID( character_id( 6312 ), true );
    platform::register_npc_handle_identity( beta );
    const on_out_of_scope retire_beta( [&]() {
        platform::retire_npc_handle_identity( beta );
    } );
    alpha.set_value( "math_alpha_source", 7.0 );
    beta.set_value( "math_beta_source", 13.0 );
    beta.set_value( "math_missing_beta_target", 3.0 );
    alpha.set_value( "math_missing_beta_target", 5.0 );

    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::table, sol::lib::string );
    sol::table ccb = lua.create_table();
    const std::shared_ptr<platform::runtime> owner = platform::make_runtime(
                "gameplay_math_semantics", 6313, lua );
    platform::install_runtime_api( owner, lua, ccb );
    platform::set_active_runtimes( { owner } );
    const on_out_of_scope clear_runtimes( []() {
        platform::clear_active_runtimes();
    } );
    owner->world_is_ready = true;

    const std::size_t world_generation = platform::detail::runtime_world_generation_storage();
    lua["ccb"] = ccb;
    lua["alpha_owner"] = platform::game_handle::from_creature(
                             alpha, { "avatar", 6311, 0, 0, 0, {} },
                             owner->handle_runtime(), world_generation );
    lua["beta_owner"] = platform::game_handle::from_creature(
                            beta, { "npc", 6312, 0, 0, 0, {} },
                            owner->handle_runtime(), world_generation );
    const auto run_platform_call = [&]( const std::string &script ) {
        platform::detail::callback_scope active_callback( *owner );
        const sol::protected_function_result result = lua.safe_script(
                    script, sol::script_pass_on_error );
        if( !result.valid() ) {
            const sol::error error = result;
            INFO( error.what() );
        }
        REQUIRE( result.valid() );
    };

    SECTION( "evaluate and apply use exact alpha and beta scopes" ) {
        dialogue native_pair( get_talker_for( alpha ), get_talker_for( beta ) );
        apply_native_math_effect(
            native_pair,
            R"({"math":["n_math_native_result = u_math_alpha_source + n_math_beta_source"]})",
            "lua_platform_native_math_pair" );
        REQUIRE( beta.maybe_get_value( "math_native_result" ) != nullptr );
        CHECK( beta.get_value( "math_native_result" ).dbl() == 20.0 );

        run_platform_call( R"(
            local result = ccb.services.gameplay.math.evaluate(
                "u_math_alpha_source + n_math_beta_source",
                alpha_owner, {}, beta_owner)
            assert(result.ok and result.value == 20)
            local legacy_call = ccb.services.gameplay.math.evaluate(
                "u_math_alpha_source", alpha_owner, {})
            assert(legacy_call.ok and legacy_call.value == 7)
            local legacy_apply = ccb.services.gameplay.math.apply(
                "u_math_legacy_result = 8", alpha_owner, {})
            assert(legacy_apply.ok and legacy_apply.value == 0)

            local applied = ccb.services.gameplay.math.apply(
                "n_math_beta_result = u_math_alpha_source + n_math_beta_source",
                alpha_owner, {}, beta_owner)
            assert(applied.ok and applied.value == 0)
        )" );
        CHECK( alpha.get_value( "math_legacy_result" ).dbl() == 8.0 );
        REQUIRE( beta.maybe_get_value( "math_beta_result" ) != nullptr );
        CHECK( beta.get_value( "math_beta_result" ).dbl() == 20.0 );
        CHECK( alpha.maybe_get_value( "math_beta_result" ) == nullptr );
    }

    SECTION( "same handle can occupy both native dialogue roles" ) {
        alpha.set_value( "math_same_target", 0.0 );
        dialogue native_self( get_talker_for( alpha ), get_talker_for( alpha ) );
        apply_native_math_effect(
            native_self,
            R"({"math":["n_math_native_same_target = u_math_alpha_source + 1"]})",
            "lua_platform_native_math_same_actor" );
        CHECK( alpha.get_value( "math_native_same_target" ).dbl() == 8.0 );
        run_platform_call( R"(
            local applied = ccb.services.gameplay.math.apply(
                "n_math_same_target = u_math_alpha_source + 1",
                alpha_owner, {}, alpha_owner)
            assert(applied.ok and applied.value == 0)
        )" );
        CHECK( alpha.get_value( "math_same_target" ).dbl() == 8.0 );
        CHECK( beta.maybe_get_value( "math_same_target" ) == nullptr );
    }

    SECTION( "missing beta preserves native alpha fallback for n_ writes" ) {
        dialogue native_without_beta( get_talker_for( alpha ), nullptr );
        const std::string native_warning = capture_debugmsg_during( [&]() {
            apply_native_math_effect(
                native_without_beta,
                R"({"math":["n_math_missing_beta_target = 99"]})",
                "lua_platform_native_math_missing_beta" );
        } );
        CHECK( native_warning.find( "invalid beta talker" ) != std::string::npos );
        CHECK( alpha.get_value( "math_missing_beta_target" ).dbl() == 99.0 );
        CHECK( beta.get_value( "math_missing_beta_target" ).dbl() == 3.0 );

        const std::string platform_warning = capture_debugmsg_during( [&]() {
            run_platform_call( R"(
                local applied = ccb.services.gameplay.math.apply(
                    "n_math_platform_missing_beta_target = 99", alpha_owner)
                assert(applied.ok and applied.value == 0)
            )" );
        } );
        CHECK( platform_warning.find( "invalid beta talker" ) != std::string::npos );
        CHECK( beta.get_value( "math_missing_beta_target" ).dbl() == 3.0 );
        REQUIRE( alpha.maybe_get_value( "math_platform_missing_beta_target" ) != nullptr );
        CHECK( alpha.get_value( "math_platform_missing_beta_target" ).dbl() == 99.0 );
        CHECK( beta.maybe_get_value( "math_platform_missing_beta_target" ) == nullptr );
    }

    SECTION( "evaluate rejects assignments and apply rejects comparisons" ) {
        run_platform_call( R"(
            local evaluate_ok = pcall(function()
                ccb.services.gameplay.math.evaluate(
                    "u_math_alpha_source = 99", alpha_owner)
            end)
            assert(not evaluate_ok)

            local apply_ok = pcall(function()
                ccb.services.gameplay.math.apply("1 == 1", alpha_owner)
            end)
            assert(not apply_ok)
        )" );
        CHECK( alpha.get_value( "math_alpha_source" ).dbl() == 7.0 );
    }

    SECTION( "detached context assignments are not written back" ) {
        dialogue native_context( get_talker_for( alpha ), nullptr );
        native_context.set_value( "math_context_value", 5.0 );
        native_context.set_value( "indirect_target", "_math_context_value" );
        apply_native_math_effect(
            native_context, R"({"math":["_math_context_value = 42"]})",
            "lua_platform_native_math_context_write" );
        CHECK( native_context.get_value( "math_context_value" ).dbl() == 42.0 );
        apply_native_math_effect(
            native_context, R"({"math":["v_indirect_target = 43"]})",
            "lua_platform_native_math_indirect_context_write" );
        CHECK( native_context.get_value( "math_context_value" ).dbl() == 43.0 );

        run_platform_call( R"(
            local context = { math_context_value = 5, indirect_target = "_math_context_value" }
            local direct = ccb.services.gameplay.math.apply(
                "_math_context_value = 42", alpha_owner, context, beta_owner)
            local indirect = ccb.services.gameplay.math.apply(
                "v_indirect_target = 43", alpha_owner, context, beta_owner)
            assert(direct.ok and indirect.ok)
            assert(context.math_context_value == 5)
        )" );
    }
}

TEST_CASE( "lua_platform_math_condition_matches_native_concatenated_expression",
           "[lua][platform][gameplay][math][semantic]" )
{
    namespace platform = cata::lua_platform;
    platform::clear_active_runtimes();

    avatar alpha;
    npc beta;
    alpha.normalize();
    beta.normalize();
    alpha.setID( character_id( 6411 ), true );
    beta.setID( character_id( 6412 ), true );
    alpha.set_value( "math_condition_alpha", 7.0 );
    beta.set_value( "math_condition_beta", 13.0 );
    platform::register_npc_handle_identity( beta );
    const on_out_of_scope retire_beta( [&]() {
        platform::retire_npc_handle_identity( beta );
    } );

    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::table, sol::lib::string );
    sol::table ccb = lua.create_table();
    const std::shared_ptr<platform::runtime> owner = platform::make_runtime(
                "math_condition_semantics", 6413, lua );
    const on_out_of_scope clear_runtimes( []() {
        platform::clear_active_runtimes();
    } );
    platform::install_runtime_api( owner, lua, ccb );
    platform::set_active_runtimes( { owner } );
    owner->world_is_ready = true;

    const std::size_t world_generation = platform::detail::runtime_world_generation_storage();
    lua["ccb"] = ccb;
    lua["alpha_owner"] = platform::game_handle::from_creature(
                             alpha, { "avatar", 6411, 0, 0, 0, {} },
                             owner->handle_runtime(), world_generation );
    lua["beta_owner"] = platform::game_handle::from_creature(
                            beta, { "npc", 6412, 0, 0, 0, {} },
                            owner->handle_runtime(), world_generation );
    const std::string expression =
        "u_math_condition_alpha + n_math_condition_beta > 15";
    lua["math_condition_expression"] = expression;
    const sol::protected_function platform_condition = lua.load( R"(
        local result = ccb.services.gameplay.math.evaluate(
            math_condition_expression, alpha_owner, {}, beta_owner)
        assert(result.ok)
        return result.value ~= 0
    )" );

    const conditional_t native_condition( json_loader::from_string(
            R"({"math":["u_math_condition_alpha"," + ","n_math_condition_beta"," > ","15"]})"
        ).get_object() );
    finalize_conditions();
    dialogue native_dialogue( get_talker_for( alpha ), get_talker_for( beta ) );
    const bool native_result = native_condition( native_dialogue );

    bool platform_result = false;
    {
        platform::detail::callback_scope active_callback( *owner );
        const sol::protected_function_result result = platform_condition();
        if( !result.valid() ) {
            const sol::error error = result;
            INFO( error.what() );
        }
        REQUIRE( result.valid() );
        platform_result = result.get<bool>();
    }
    CHECK( native_result );
    CHECK( platform_result );
    CHECK( native_result == platform_result );
}

#endif // CATA_ENABLE_LUA_PLATFORM
