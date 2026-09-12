#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <string>

#include "avatar.h"
#include "cata_catch.h"
#include "condition.h"
#include "dialogue.h"
#include "flexbuffer_json.h"
#include "json_loader.h"
#include "npc.h"

TEST_CASE( "lua_platform_string_comparison_native_short_circuit_contract",
           "[lua][platform][string_comparison][semantic]" )
{
    avatar player;
    npc partner;
    player.normalize();
    partner.normalize();
    player.set_value( "comparison", "alpha" );
    partner.set_value( "comparison", "alpha" );
    dialogue context( get_talker_for( player ), get_talker_for( partner ) );
    const auto evaluate = [&context]( const std::string & input ) {
        const conditional_t condition( json_loader::from_string( input ).get_object() );
        return condition( context );
    };
    // Evaluating the final mutator would request an invalid game option.
    // A decisive pair must prevent that evaluation entirely.
    CHECK( evaluate(
               R"({"compare_string":[{"u_val":"comparison"},{"npc_val":"comparison"},{"mutator":"game_option","option":"INVALID_UNREACHED_OPTION"}]})" ) );
    partner.set_value( "comparison", "beta" );
    CHECK_FALSE( evaluate(
                     R"({"compare_string_match_all":[{"u_val":"comparison"},{"npc_val":"comparison"},{"mutator":"game_option","option":"INVALID_UNREACHED_OPTION"}]})" ) );
    CHECK_FALSE( evaluate( R"({"compare_string":[]})" ) );
    CHECK_FALSE( evaluate( R"({"compare_string":["only"]})" ) );
    CHECK( evaluate( R"({"compare_string_match_all":["only"]})" ) );
    CHECK_FALSE( evaluate( R"({"compare_string":["a","b","c"]})" ) );
    CHECK( evaluate( R"({"compare_string_match_all":["a","a","a"]})" ) );
}

#endif
