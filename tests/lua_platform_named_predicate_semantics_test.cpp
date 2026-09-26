#include <string>

#include "avatar.h"
#include "cata_catch.h"
#include "condition.h"
#include "dialogue.h"
#include "dialogue_helpers.h"
#include "flexbuffer_json.h"
#include "json_loader.h"
#include "npc.h"
#include "type_id.h"

TEST_CASE( "lua_migration_native_named_predicate_accepts_empty_name",
           "[lua][platform][named_predicates][semantic]" )
{
    dialogue context;
    const conditional_t read( json_loader::from_string(
                                  R"({"get_condition":""})" ).get_object() );
    CHECK_FALSE( read( context ) );

    const auto assign = [&context]( const std::string & comparison ) {
        talk_effect_t effect;
        effect.parse_sub_effect( json_loader::from_string(
                                     R"({"set_condition":"","condition":{"math":[")" +
                                     comparison + R"("]}})" ).get_object(), "named_predicate_acceptance" );
        for( const talk_effect_fun_t &operation : effect.effects ) {
            operation( context );
        }
    };
    assign( "1 == 1" );
    CHECK( read( context ) );
    assign( "1 == 2" );
    CHECK_FALSE( read( context ) );
}

TEST_CASE( "lua_migration_native_named_predicate_uses_evaluating_beta",
           "[lua][platform][named_predicates][semantic]" )
{
    avatar alpha;
    alpha.normalize();
    npc original_beta;
    original_beta.normalize();
    npc new_beta;
    new_beta.normalize();
    const trait_id quick( "QUICK" );
    original_beta.unset_mutation( quick );
    new_beta.set_mutation( quick );
    dialogue original( get_talker_for( alpha ), get_talker_for( original_beta ) );
    talk_effect_t effect;
    effect.parse_sub_effect( json_loader::from_string(
                                 R"({"set_condition":"beta_test","condition":{"npc_has_trait":"QUICK"}})"
                             ).get_object(), "named_predicate_acceptance" );
    for( const talk_effect_fun_t &operation : effect.effects ) {
        operation( original );
    }
    const conditional_t read( json_loader::from_string(
                                  R"({"get_condition":"beta_test"})" ).get_object() );
    CHECK_FALSE( read( original ) );
    dialogue child( get_talker_for( alpha ), get_talker_for( new_beta ),
                    original.get_conditionals(), original.get_context() );
    CHECK( read( child ) );
    CHECK_FALSE( read( original ) );
}
