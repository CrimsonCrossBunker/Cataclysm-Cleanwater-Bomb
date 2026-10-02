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

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
    #include "avatar.h"
    #include "cata_scope_helpers.h"
    #include "character_id.h"
    #include "lua_platform_bindings_values.h"
    #include "lua_platform_handle.h"
    #include "lua_platform_mutations.h"
    #include "lua_platform_sol.h"
#endif

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
        finalize_conditions();
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

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
TEST_CASE( "lua_platform_named_predicate_uses_current_dialogue_alpha",
           "[lua][platform][named_predicates][semantic]" )
{
    namespace platform = cata::lua_platform;
    const trait_id quick( "QUICK" );

    avatar native_original_alpha;
    native_original_alpha.normalize();
    npc native_child_alpha;
    native_child_alpha.normalize();
    native_child_alpha.setID( character_id( 7402 ), true );
    native_child_alpha.set_mutation( quick );
    dialogue native_original( get_talker_for( native_original_alpha ), nullptr );

    talk_effect_t store_native_predicate;
    store_native_predicate.parse_sub_effect( json_loader::from_string(
                R"({"set_condition":"alpha_trait","condition":{"u_has_trait":"QUICK"}})"
            ).get_object(), "named_predicate_platform_comparison" );
    for( const talk_effect_fun_t &operation : store_native_predicate.effects ) {
        operation( native_original );
    }
    const conditional_t read_native_predicate( json_loader::from_string(
                R"({"get_condition":"alpha_trait"})"
            ).get_object() );

    sol::state lua;
    lua.open_libraries( sol::lib::base );
    sol::table services = lua.create_table();
    const platform::game_handle_runtime_owner_ptr owner =
        platform::make_game_handle_runtime_owner();
    const platform::game_handle_runtime runtime{ owner, 1 };
    platform::install_value_type_api( lua, services, []() {} );
    platform::install_game_handle_api( lua, services, [runtime]() {
        return runtime;
    }, []() {
        return 1;
    }, []() {} );
    platform::install_mutation_api( services, [runtime]() {
        return runtime;
    }, []() {
        return 1;
    }, []() {}, []() {} );

    avatar platform_original_alpha;
    platform_original_alpha.normalize();
    platform_original_alpha.setID( character_id( 7401 ), true );
    platform::register_npc_handle_identity( native_child_alpha );
    const on_out_of_scope cleanup_npc_handle( [&native_child_alpha]() {
        platform::retire_npc_handle_identity( native_child_alpha );
    } );
    const platform::game_handle original_alpha_handle =
        platform::game_handle::from_creature(
            platform_original_alpha,
    { "avatar", platform_original_alpha.getID().get_value(), 0, 0, 0, {} },
    runtime, 1 );
    const platform::game_handle child_alpha_handle =
        platform::game_handle::from_creature(
            native_child_alpha,
    { "npc", native_child_alpha.getID().get_value(), 0, 0, 0, {} },
    runtime, 1 );
    lua["services"] = services;
    const sol::protected_function_result helpers = lua.safe_script( R"(
        local function service_value(result)
            assert(result.ok)
            return result.value
        end
        store_named = function(context)
            context.conditions = context.conditions or {}
            context.conditions["alpha_trait"] = function(context, actor, stored_condition_beta)
                if actor == nil or actor.kind ~= "creature" or
                    (actor.subtype ~= "avatar" and actor.subtype ~= "character" and
                    actor.subtype ~= "npc") then return false end
                return service_value(services.mutations.has_id_text(actor, "QUICK"))
            end
        end
        read_named = function(context, actor, beta)
            local stored = context.conditions and context.conditions["alpha_trait"]
            return stored ~= nil and stored(context, actor, beta) or false
        end
        copy_conditions = function(context)
            local child = { conditions = {} }
            for name, predicate in pairs(context.conditions or {}) do
                child.conditions[name] = predicate
            end
            return child
        end
    )", sol::script_pass_on_error );
    if( !helpers.valid() ) {
        const sol::error error = helpers;
        INFO( error.what() );
    }
    REQUIRE( helpers.valid() );

    sol::table original_context = lua.create_table();
    sol::protected_function store_named = lua["store_named"];
    sol::protected_function_result store_call = store_named( original_context );
    REQUIRE( store_call.valid() );
    sol::protected_function read_named = lua["read_named"];
    const bool native_original_result = read_native_predicate( native_original );
    const sol::protected_function_result platform_original_call = read_named(
            original_context, original_alpha_handle );
    REQUIRE( platform_original_call.valid() );
    CHECK_FALSE( native_original_result );
    CHECK( platform_original_call.get<bool>() == native_original_result );

    dialogue native_child( get_talker_for( native_child_alpha ), nullptr,
                           native_original.get_conditionals(),
                           native_original.get_context() );
    const sol::protected_function copy_conditions = lua["copy_conditions"];
    const sol::protected_function_result child_context_call =
        copy_conditions( original_context );
    REQUIRE( child_context_call.valid() );
    const sol::table child_context = child_context_call;
    const bool native_child_result = read_native_predicate( native_child );
    const sol::protected_function_result platform_child_call = read_named(
            child_context, child_alpha_handle );
    REQUIRE( platform_child_call.valid() );
    CHECK( native_child_result );
    CHECK( platform_child_call.get<bool>() == native_child_result );
}
#endif
