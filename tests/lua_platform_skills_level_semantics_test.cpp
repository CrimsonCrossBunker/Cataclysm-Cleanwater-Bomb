#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <memory>
#include <string>
#include <utility>
#include <vector>

#include "avatar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character_id.h"
#include "debug.h"
#include "dialogue.h"
#include "lua_platform_handle.h"
#include "lua_platform_runtime.h"
#include "lua_platform_runtime_internal.h"
#include "lua_platform_sol.h"
#include "math_parser.h"
#include "npc.h"
#include "skill.h"

TEST_CASE( "lua_platform_skills_level_matches_raw_character_and_talker_skill_values",
           "[lua][platform][skills][semantic]" )
{
    namespace platform = cata::lua_platform;
    platform::clear_active_runtimes();

    avatar alpha;
    npc beta;
    alpha.normalize();
    beta.normalize();
    alpha.setID( character_id( 7111 ), true );
    beta.setID( character_id( 7112 ), true );
    platform::register_npc_handle_identity( beta );
    const on_out_of_scope retire_beta( [&]() {
        platform::retire_npc_handle_identity( beta );
    } );

    const skill_id speech( "speech" );
    alpha.set_skill_level( speech, 4 );
    alpha.get_skill_level_object( speech ).set_exercise( 35 );
    beta.set_skill_level( speech, 8 );
    beta.get_skill_level_object( speech ).set_exercise( 75 );
    const float alpha_speech = alpha.get_skill_level( speech );
    const float beta_speech = beta.get_skill_level( speech );

    sol::state lua;
    sol::table ccb = lua.create_table();
    const std::shared_ptr<platform::runtime> owner = platform::make_runtime(
                "skills_level_semantics", 7113, lua );
    platform::install_runtime_api( owner, lua, ccb );
    platform::set_active_runtimes( { owner } );
    const on_out_of_scope clear_runtimes( []() {
        platform::clear_active_runtimes();
    } );
    owner->world_is_ready = true;

    const std::size_t world_generation = platform::runtime_world_generation();
    const platform::game_handle alpha_handle = platform::game_handle::from_creature(
                alpha, { "avatar", 7111, 0, 0, 0, {} },
                owner->handle_runtime(), world_generation );
    const platform::game_handle beta_handle = platform::game_handle::from_creature(
                beta, { "npc", 7112, 0, 0, 0, {} },
                owner->handle_runtime(), world_generation );
    const sol::protected_function level_api =
        ccb["services"]["skills"]["level"];
    const auto invoke_level = [&]( const platform::game_handle &handle,
                                   const std::string &id ) {
        platform::detail::callback_scope active_callback( *owner );
        const sol::protected_function_result result = level_api( handle, id );
        if( !result.valid() ) {
            const sol::error error = result;
            INFO( error.what() );
            FAIL( "services.skills.level call failed" );
        }
        return result.get<sol::table>();
    };
    const auto query_level = [&]( const platform::game_handle &handle,
                                  const std::string &id ) {
        const sol::table result = invoke_level( handle, id );
        REQUIRE( result["ok"].get<bool>() );
        return result["value"].get<float>();
    };

    SECTION( "registered IDs resolve the exact Character and retain fractions" ) {
        CHECK( alpha_speech > 4.0f );
        CHECK( alpha_speech < 5.0f );
        CHECK( beta_speech > 8.0f );
        CHECK( beta_speech < 9.0f );
        CHECK( query_level( alpha_handle, "speech" ) == alpha_speech );
        CHECK( query_level( beta_handle, "speech" ) == beta_speech );

        dialogue native_pair( get_talker_for( alpha ), get_talker_for( beta ) );
        math_exp alpha_expression;
        math_exp beta_expression;
        REQUIRE( alpha_expression.parse( "u_skill('speech')" ) );
        REQUIRE( beta_expression.parse( "n_skill('speech')" ) );
        CHECK( alpha_expression.eval( native_pair ) ==
               static_cast<int>( alpha_speech ) );
        CHECK( beta_expression.eval( native_pair ) ==
               static_cast<int>( beta_speech ) );
    }

    SECTION( "unknown IDs keep native raw lookup behavior" ) {
        const std::string unknown_id = "ccb_skill_level_unregistered_20261002";
        const skill_id native_unknown( unknown_id );
        REQUIRE_FALSE( native_unknown.is_valid() );
        const float alpha_unknown = alpha.get_skill_level( native_unknown );
        const float beta_unknown = beta.get_skill_level( native_unknown );
        float queried_alpha = 0.0f;
        float queried_beta = 0.0f;
        const std::string diagnostics = capture_debugmsg_during( [&]() {
            queried_alpha = query_level( alpha_handle, unknown_id );
            queried_beta = query_level( beta_handle, unknown_id );
        } );
        CHECK( queried_alpha == alpha_unknown );
        CHECK( queried_beta == beta_unknown );
        CHECK( diagnostics.empty() );

        dialogue native_pair( get_talker_for( alpha ), get_talker_for( beta ) );
        math_exp alpha_expression;
        math_exp beta_expression;
        REQUIRE( alpha_expression.parse( "u_skill('ccb_skill_level_unregistered_20261002')" ) );
        REQUIRE( beta_expression.parse( "n_skill('ccb_skill_level_unregistered_20261002')" ) );
        double projected_alpha = 0.0;
        double projected_beta = 0.0;
        const std::string math_diagnostics = capture_debugmsg_during( [&]() {
            projected_alpha = alpha_expression.eval( native_pair );
            projected_beta = beta_expression.eval( native_pair );
        } );
        CHECK( projected_alpha == static_cast<int>( alpha_unknown ) );
        CHECK( projected_beta == static_cast<int>( beta_unknown ) );
        CHECK( math_diagnostics.empty() );
    }

    SECTION( "empty, embedded-NUL, and long text reach native ID lookup" ) {
        const std::vector<std::string> raw_ids = {
            std::string(),
            std::string( "ccb\0skill", 9 ),
            std::string( 8193, 'x' )
        };
        for( const std::string &raw_id : raw_ids ) {
            CAPTURE( raw_id.size() );
            CHECK( query_level( alpha_handle, raw_id ) ==
                   alpha.get_skill_level( skill_id( raw_id ) ) );
        }
    }

    SECTION( "stale world-generation handles return an error" ) {
        const platform::game_handle stale = platform::game_handle::from_creature(
                alpha, { "avatar", 7111, 0, 0, 0, {} },
                owner->handle_runtime(), world_generation + 1 );
        const sol::table result = invoke_level( stale, "speech" );
        CHECK_FALSE( result["ok"].get<bool>() );
    }
}

#endif // CATA_ENABLE_LUA_PLATFORM
