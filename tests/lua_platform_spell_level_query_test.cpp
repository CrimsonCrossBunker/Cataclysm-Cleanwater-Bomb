#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <pimpl.h>
#include <cstddef>
#include <functional>
#include <initializer_list>
#include <memory>
#include <string>
#include <vector>

#include "avatar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character_id.h"
#include "dialogue.h"
#include "lua_platform_handle.h"
#include "lua_platform_runtime.h"
#include "lua_platform_runtime_internal.h"
#include "lua_platform_sol.h"
#include "magic.h"
#include "math_parser.h"
#include "npc.h"
#include "type_id.h"

static const spell_id spell_test_spell_pew( "test_spell_pew" );

TEST_CASE( "lua_platform_spell_level_query_matches_native_math_scope",
           "[lua][platform][spells][math][semantic]" )
{
    namespace platform = cata::lua_platform;
    platform::clear_active_runtimes();

    avatar alpha;
    npc beta;
    alpha.normalize();
    beta.normalize();
    alpha.setID( character_id( 6411 ), true );
    beta.setID( character_id( 6412 ), true );
    platform::register_npc_handle_identity( beta );
    const on_out_of_scope retire_beta( [&]() {
        platform::retire_npc_handle_identity( beta );
    } );

    REQUIRE( spell_test_spell_pew.is_valid() );
    alpha.magic->learn_spell( spell_test_spell_pew, alpha, true );
    alpha.magic->set_spell_level( spell_test_spell_pew, 4, &alpha );
    beta.magic->learn_spell( spell_test_spell_pew, beta, true );
    beta.magic->set_spell_level( spell_test_spell_pew, 2, &beta );

    dialogue native_pair( get_talker_for( alpha ), get_talker_for( beta ) );
    math_exp alpha_level;
    math_exp beta_level;
    math_exp unregistered_level;
    math_exp highest_level;
    REQUIRE( alpha_level.parse( "u_spell_level('test_spell_pew')", true ) );
    REQUIRE( beta_level.parse( "n_spell_level('test_spell_pew')", true ) );
    REQUIRE( unregistered_level.parse( "u_spell_level('delay_spell')", true ) );
    REQUIRE( highest_level.parse( "u_spell_level('null')", true ) );
    CHECK( alpha_level.eval( native_pair ) == 4.0 );
    CHECK( beta_level.eval( native_pair ) == 2.0 );
    CHECK( unregistered_level.eval( native_pair ) == -1.0 );
    CHECK( highest_level.eval( native_pair ) == 4.0 );

    const std::string empty_id;
    const std::string nul_id( "delay\0spell", 11 );
    const std::string long_id( 8193, 'x' );
    for( const std::string *raw_id : {
             &empty_id, &nul_id, &long_id
         } ) {
        const std::string source = "u_spell_level('" + *raw_id + "')";
        math_exp native_raw_id;
        REQUIRE( native_raw_id.parse( source, true ) );
        CHECK( native_raw_id.eval( native_pair ) == -1.0 );
    }

    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::table, sol::lib::string );
    sol::table ccb = lua.create_table();
    const std::shared_ptr<platform::runtime> owner = platform::make_runtime(
                "spell_level_query_semantics", 6413, lua );
    platform::install_runtime_api( owner, lua, ccb );
    platform::set_active_runtimes( { owner } );
    const on_out_of_scope clear_runtimes( []() {
        platform::clear_active_runtimes();
    } );
    owner->world_is_ready = true;

    const std::size_t world_generation = platform::detail::runtime_world_generation_storage();
    lua["ccb"] = ccb;
    lua["empty_id"] = empty_id;
    lua["nul_id"] = nul_id;
    lua["long_id"] = long_id;
    lua["alpha_owner"] = platform::game_handle::from_creature(
                             alpha, { "avatar", 6411, 0, 0, 0, {} },
                             owner->handle_runtime(), world_generation );
    lua["beta_owner"] = platform::game_handle::from_creature(
                            beta, { "npc", 6412, 0, 0, 0, {} },
                            owner->handle_runtime(), world_generation );

    platform::detail::callback_scope active_callback( *owner );
    const sol::protected_function_result result = lua.safe_script( R"(
        local alpha_known = ccb.services.spells.effective_level(
            alpha_owner, "test_spell_pew")
        local beta_known = ccb.services.spells.effective_level(
            beta_owner, "test_spell_pew")
        local alpha_unregistered = ccb.services.spells.effective_level(
            alpha_owner, "delay_spell")
        local alpha_highest = ccb.services.spells.effective_level(
            alpha_owner, "null")
        local alpha_empty = ccb.services.spells.effective_level(alpha_owner, empty_id)
        local alpha_nul = ccb.services.spells.effective_level(alpha_owner, nul_id)
        local alpha_long = ccb.services.spells.effective_level(alpha_owner, long_id)
        assert(alpha_known.ok and alpha_known.value == 4)
        assert(beta_known.ok and beta_known.value == 2)
        assert(alpha_unregistered.ok and alpha_unregistered.value == -1)
        assert(alpha_highest.ok and alpha_highest.value == 4)
        assert(alpha_empty.ok and alpha_empty.value == -1)
        assert(alpha_nul.ok and alpha_nul.value == -1)
        assert(alpha_long.ok and alpha_long.value == -1)
    )", sol::script_pass_on_error );
    if( !result.valid() ) {
        const sol::error error = result;
        INFO( error.what() );
    }
    REQUIRE( result.valid() );
}

#endif // CATA_ENABLE_LUA_PLATFORM
