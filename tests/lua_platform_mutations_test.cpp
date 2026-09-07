#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include "dialogue_helpers.h"
#include "flexbuffer_json.h"
#include "lua_platform_sol.h"
#include <functional>
#include <initializer_list>
#include <memory>
#include <vector>

#include <cstddef>
#include <set>
#include <stdexcept>
#include <string>

#include "avatar.h"
#include "cata_catch.h"
#include "character.h"
#include "character_id.h"
#include "condition.h"
#include "dialogue.h"
#include "json_loader.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"
#include "lua_platform_mutations.h"
#include "npc.h"
#include "options_helpers.h"
#include "rng.h"
#include "talker.h"
#include "type_id.h"

static const trait_id trait_QUICK( "QUICK" );
static const trait_id trait_SNAIL_TRAIL( "SNAIL_TRAIL" );
static const trait_id trait_STRONGER_VULNERABLEWARM( "STRONGER_VULNERABLEWARM" );
static const trait_id trait_VULNERABLECHILL( "VULNERABLECHILL" );
static const trait_id trait_VULNERABLEWARM( "VULNERABLEWARM" );

namespace
{
struct mutation_fixture {
    explicit mutation_fixture( const int first_id = 1800 ) {
        player.normalize();
        player.setID( character_id( first_id + 1 ), true );
        other.normalize();
        other.setID( character_id( first_id + 2 ), true );
        cata::lua_platform::register_npc_handle_identity( other );
        cata::lua_platform::install_value_type_api( lua, services, []() {} );
        cata::lua_platform::install_game_handle_api(
        lua, services, [this]() {
            return runtime;
        },
        [this]() {
            return world;
        }, []() {} );
        cata::lua_platform::install_mutation_api(
        services, [this]() {
            return runtime;
        }, [this]() {
            return world;
        },
        []() {}, [this]() {
            if( !writable ) {
                throw std::runtime_error( "test: mutation outside write phase" );
            }
        } );
    }

    ~mutation_fixture() {
        cata::lua_platform::retire_npc_handle_identity( other );
    }

    cata::lua_platform::game_handle handle( const bool npc_target ) {
        Character &target = npc_target ? static_cast<Character &>( other ) : player;
        return cata::lua_platform::game_handle::from_creature(
                   target, { npc_target ? "npc" : "avatar", target.getID().get_value(), 0, 0, 0, {} },
                   runtime, world );
    }

    sol::protected_function remove_type() {
        return services["mutations"]["remove_type"];
    }

    Character &target( const bool npc_target ) {
        return npc_target ? static_cast<Character &>( other ) : player;
    }

    bool legacy_condition( const std::string &source ) {
        dialogue context( get_talker_for( player ), get_talker_for( other ) );
        const conditional_t condition( json_loader::from_string( source ).get_object() );
        return condition( context );
    }

    void legacy_effect( const std::string &source ) {
        dialogue context( get_talker_for( player ), get_talker_for( other ) );
        talk_effect_t effect;
        effect.parse_sub_effect( json_loader::from_string( source ).get_object(), "mutation_acceptance" );
        for( const talk_effect_fun_t &operation : effect.effects ) {
            operation( context );
        }
    }

    bool query( const std::string &method, const bool npc_target, const std::string &trait ) {
        sol::protected_function function = services["mutations"][method];
        sol::protected_function_result call = function( handle( npc_target ),
            cata::lua_platform::script_game_id( "mutation", trait ) );
        REQUIRE( call.valid() );
        sol::table result = call;
        REQUIRE( result["ok"].get<bool>() );
        return result["value"].get<bool>();
    }

    cata::lua_platform::game_handle_runtime_owner_ptr owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    cata::lua_platform::game_handle_runtime runtime{ owner, 1 };
    std::size_t world = 1;
    bool writable = true;
    avatar player;
    npc other;
    sol::state lua;
    sol::table services = lua.create_table();
};
} // namespace

TEST_CASE( "lua_platform_mutations_remove_type_targets_exact_character",
           "[lua][platform][mutations]" )
{
    mutation_fixture fixture;
    const bool npc_target = GENERATE( false, true );
    const cata::lua_platform::game_handle target_handle = fixture.handle( npc_target );
    Character &target = npc_target ? static_cast<Character &>( fixture.other ) : fixture.player;
    Character &untouched = npc_target ? static_cast<Character &>( fixture.player ) : fixture.other;
    const trait_id &cold = trait_VULNERABLECHILL;
    const trait_id &heat = trait_STRONGER_VULNERABLEWARM;
    const trait_id &keep = trait_QUICK;
    target.set_mutation( cold );
    target.set_mutation( heat );
    target.set_mutation( keep );
    untouched.set_mutation( cold );
    REQUIRE( target.has_trait( cold ) );
    REQUIRE( target.has_trait( heat ) );

    sol::protected_function_result call = fixture.remove_type()( target_handle,
        "ACCLIMATIZATION" );
    REQUIRE( call.valid() );
    sol::table result = call;
    REQUIRE( result["ok"].get<bool>() );
    sol::table value = result["value"];
    CHECK( value["type"].get<std::string>() == "ACCLIMATIZATION" );
    CHECK( value["removed_count"].get<int>() == 2 );
    sol::table removed = value["removed"];
    std::set<std::string> ids;
    for( const auto &entry : removed ) {
        const cata::lua_platform::script_game_id id = entry.second.as<cata::lua_platform::script_game_id>();
        CHECK( id.kind() == "mutation" );
        ids.insert( id.value() );
    }
    CHECK( ids == std::set<std::string> { cold.str(), heat.str() } );
    CHECK_FALSE( target.has_trait( cold ) );
    CHECK_FALSE( target.has_trait( heat ) );
    CHECK_FALSE( target.has_trait( trait_VULNERABLEWARM ) );
    CHECK( target.has_trait( keep ) );
    CHECK( untouched.has_trait( cold ) );

    // Repeating a removal and requesting an unknown type both succeed unchanged.
    for( const char *type : {
             "ACCLIMATIZATION", "test_unknown_mutation_type"
         } ) {
        sol::protected_function_result again = fixture.remove_type()( target_handle, type );
        REQUIRE( again.valid() );
        sol::table unchanged = again;
        REQUIRE( unchanged["ok"].get<bool>() );
        CHECK( unchanged["value"]["removed_count"].get<int>() == 0 );
        CHECK( unchanged["value"]["removed"].get<sol::table>().size() == 0 );
        CHECK( target.has_trait( keep ) );
    }
}

TEST_CASE( "lua_platform_mutations_remove_type_rejects_invalid_inputs_before_mutating",
           "[lua][platform][mutations]" )
{
    mutation_fixture fixture;
    const trait_id &cold = trait_VULNERABLECHILL;
    fixture.player.set_mutation( cold );
    const cata::lua_platform::game_handle handle = fixture.handle( false );

    SECTION( "invalid_type" ) {
        for( const std::string &type : {
                 std::string(), std::string( 257, 'x' ),
                 std::string( "ACCLIMATIZATION\0ignored", 23 )
             } ) {
            sol::protected_function_result call = fixture.remove_type()( handle, type );
            CHECK_FALSE( call.valid() );
            CHECK( fixture.player.has_trait( cold ) );
        }
    }
    SECTION( "wrong_phase" ) {
        fixture.writable = false;
        sol::protected_function_result call = fixture.remove_type()( handle, "ACCLIMATIZATION" );
        CHECK_FALSE( call.valid() );
    }
    SECTION( "stale_world" ) {
        ++fixture.world;
        sol::protected_function_result call = fixture.remove_type()( handle, "ACCLIMATIZATION" );
        REQUIRE( call.valid() );
        sol::table result = call;
        CHECK_FALSE( result["ok"].get<bool>() );
        CHECK( result["error"]["code"].get<std::string>() == "stale_world" );
    }
    SECTION( "retired_runtime" ) {
        fixture.owner->retire();
        sol::protected_function_result call = fixture.remove_type()( handle, "ACCLIMATIZATION" );
        REQUIRE( call.valid() );
        sol::table result = call;
        CHECK_FALSE( result["ok"].get<bool>() );
        CHECK( result["error"]["code"].get<std::string>() == "stale_runtime" );
    }
    CHECK( fixture.player.has_trait( cold ) );
}


TEST_CASE( "lua_platform_mutations_character_queries_match_legacy_conditions",
           "[lua][platform][mutations][semantic]" )
{
    mutation_fixture fixture;
    const bool npc_target = GENERATE( false, true );
    const std::string prefix = npc_target ? "npc_" : "u_";
    Character &target = fixture.target( npc_target );
    // Missing, single and multiple traits; evaluate native conditions against
    // the same live actor as each Lua query rather than assuming their result.
    for( const std::string added : {
             "", "QUICK", "FELINE_EARS"
         } ) {
        if( !added.empty() ) {
            target.set_mutation( trait_id( added ) );
        }
        CAPTURE( npc_target, added );
        const bool lua_has = fixture.query( "has", npc_target, "QUICK" );
        CHECK( lua_has == fixture.legacy_condition( R"({")" + prefix + R"(has_trait":"QUICK"})" ) );
        const bool any = fixture.query( "has", npc_target, "QUICK" ) ||
                         fixture.query( "has", npc_target, "FELINE_EARS" );
        CHECK( any == fixture.legacy_condition(
                   R"({")" + prefix + R"(has_any_trait":["QUICK","FELINE_EARS"]})" ) );
        for( const char *trait : {
                 "QUICK", "FELINE_EARS"
             } ) {
            sol::protected_function visible = fixture.services["mutations"]["is_visible_to"];
            const cata::lua_platform::game_handle subject = fixture.handle( npc_target );
            const cata::lua_platform::game_handle observer = fixture.handle( !npc_target );
            sol::protected_function_result call = visible( subject, observer,
                cata::lua_platform::script_game_id( "mutation", trait ) );
            REQUIRE( call.valid() );
            sol::table result = call;
            REQUIRE( result["ok"].get<bool>() );
            CHECK( result["value"].get<bool>() == fixture.legacy_condition(
                       R"({")" + prefix + R"(has_visible_trait":")" + trait + R"("})" ) );
        }
    }
    target.set_mutation( trait_VULNERABLECHILL );
    fixture.target( !npc_target ).set_mutation( trait_VULNERABLECHILL );
    for( const bool purifiable : {
             false, true
         } ) {
        fixture.legacy_effect( R"({")" + prefix +
                               R"(set_trait_purifiability":"VULNERABLECHILL","purifiable":)" +
                               ( purifiable ? "true}" : "false}" ) );
        CHECK( fixture.query( "is_purifiable", npc_target, "VULNERABLECHILL" ) == purifiable );
        const bool lua_purifiable = fixture.query( "is_purifiable", npc_target, "VULNERABLECHILL" );
        CHECK( lua_purifiable == fixture.legacy_condition( R"({")" + prefix +
                R"(is_trait_purifiable":"VULNERABLECHILL"})" ) );
        CHECK( fixture.query( "is_purifiable", !npc_target, "VULNERABLECHILL" ) );
    }
}

TEST_CASE( "lua_platform_mutations_legacy_writes_require_semantic_choice",
           "[lua][platform][mutations][semantic]" )
{
    mutation_fixture legacy( 1900 );
    mutation_fixture platform( 2000 );
    const bool npc_target = GENERATE( false, true );
    const std::string prefix = npc_target ? "npc_" : "u_";
    Character &old_target = legacy.target( npc_target );
    Character &new_target = platform.target( npc_target );
    SECTION( "same_type_conflict_is_not_a_direct_grant" ) {
        old_target.set_mutation( trait_VULNERABLECHILL );
        new_target.set_mutation( trait_VULNERABLECHILL );
        legacy.legacy_effect( R"({")" + prefix + R"(add_trait":"STRONGER_VULNERABLEWARM"})" );
        sol::protected_function grant = platform.services["mutations"]["grant"];
        sol::protected_function_result call = grant( platform.handle( npc_target ),
            cata::lua_platform::script_game_id( "mutation", "STRONGER_VULNERABLEWARM" ) );
        REQUIRE( call.valid() );
        REQUIRE( call.get<sol::table>()["ok"].get<bool>() );
        CHECK_FALSE( old_target.has_trait( trait_VULNERABLECHILL ) );
        CHECK( new_target.has_trait( trait_VULNERABLECHILL ) );
        CHECK( old_target.has_trait( trait_STRONGER_VULNERABLEWARM ) );
        CHECK( new_target.has_trait( trait_STRONGER_VULNERABLEWARM ) );
    }
    SECTION( "base_trait_bookkeeping_differs_on_removal" ) {
        old_target.toggle_trait( trait_QUICK );
        new_target.toggle_trait( trait_QUICK );
        legacy.legacy_effect( R"({")" + prefix + R"(lose_trait":"QUICK"})" );
        sol::protected_function remove = platform.services["mutations"]["remove"];
        sol::protected_function_result call = remove( platform.handle( npc_target ),
            cata::lua_platform::script_game_id( "mutation", "QUICK" ) );
        REQUIRE( call.valid() );
        REQUIRE( call.get<sol::table>()["ok"].get<bool>() );
        CHECK_FALSE( old_target.has_trait( trait_QUICK ) );
        CHECK_FALSE( new_target.has_trait( trait_QUICK ) );
        CHECK( old_target.has_base_trait( trait_QUICK ) );
        CHECK_FALSE( new_target.has_base_trait( trait_QUICK ) );
    }
}

TEST_CASE( "lua_platform_mutations_bulk_removal_matches_legacy_effects",
           "[lua][platform][mutations][semantic]" )
{
    mutation_fixture legacy( 2100 );
    mutation_fixture platform( 2200 );
    const bool npc_target = GENERATE( false, true );
    const bool by_type = GENERATE( false, true );
    const std::string prefix = npc_target ? "npc_" : "u_";
    Character &old_target = legacy.target( npc_target );
    Character &new_target = platform.target( npc_target );
    for( const char *id : {
             "QUICK", "RUMINANT", "VULNERABLECHILL", "STRONGER_VULNERABLEWARM"
         } ) {
        old_target.set_mutation( trait_id( id ) );
        new_target.set_mutation( trait_id( id ) );
        platform.target( !npc_target ).set_mutation( trait_id( id ) );
    }
    const auto untouched = platform.target( !npc_target ).get_mutations();
    for( int attempt = 0; attempt < 2; ++attempt ) {
        legacy.legacy_effect( R"({")" + prefix + ( by_type ? "lose_mutation_type" : "lose_category" ) +
                              R"(":")" + ( by_type ? "ACCLIMATIZATION" : "CATTLE" ) + R"("})" );
        sol::protected_function function = platform.services["mutations"][by_type ? "remove_type" :
            "remove_category"];
        sol::protected_function_result call = by_type ?
                                              function( platform.handle( npc_target ), "ACCLIMATIZATION" ) :
                                              function( platform.handle( npc_target ), cata::lua_platform::script_game_id( "mutation_category",
                                                  "CATTLE" ) );
        REQUIRE( call.valid() );
        sol::table result = call;
        REQUIRE( result["ok"].get<bool>() );
        const auto expected = old_target.get_mutations();
        const auto actual = new_target.get_mutations();
        CHECK( std::set<trait_id>( actual.begin(), actual.end() ) ==
               std::set<trait_id>( expected.begin(), expected.end() ) );
        CHECK( result["value"]["removed_count"].get<int>() == ( attempt == 1 ? 0 : by_type ? 2 : 1 ) );
        CHECK( new_target.has_trait( trait_QUICK ) );
        CHECK( platform.target( !npc_target ).get_mutations() == untouched );
    }
}

TEST_CASE( "lua_platform_mutations_purifiability_write_matches_legacy_effect",
           "[lua][platform][mutations][semantic]" )
{
    mutation_fixture legacy( 2700 );
    mutation_fixture platform( 2800 );
    const bool npc_target = GENERATE( false, true );
    const bool present = GENERATE( false, true );
    const std::string prefix = npc_target ? "npc_" : "u_";
    const trait_id &trait = trait_VULNERABLECHILL;
    if( present ) {
        legacy.target( npc_target ).set_mutation( trait );
        platform.target( npc_target ).set_mutation( trait );
    }
    platform.target( !npc_target ).set_mutation( trait );
    sol::protected_function set = platform.services["mutations"]["set_purifiable"];
    for( const bool desired : {
             false, false, true, true
         } ) {
        const bool before = platform.target( npc_target ).purifiable( trait );
        legacy.legacy_effect( R"({")" + prefix +
                              R"(set_trait_purifiability":"VULNERABLECHILL","purifiable":)" +
                              ( desired ? "true}" : "false}" ) );
        sol::protected_function_result call = set( platform.handle( npc_target ),
            cata::lua_platform::script_game_id( "mutation", trait.str() ), desired );
        REQUIRE( call.valid() );
        sol::table result = call;
        REQUIRE( result["ok"].get<bool>() );
        const bool after = platform.target( npc_target ).purifiable( trait );
        CHECK( after == legacy.target( npc_target ).purifiable( trait ) );
        CHECK( result["value"]["before"].get<bool>() == before );
        CHECK( result["value"]["after"].get<bool>() == after );
        CHECK( result["value"]["changed"].get<bool>() == ( before != after ) );
        CHECK( result["value"]["present"].get<bool>() == present );
        CHECK( platform.target( !npc_target ).purifiable( trait ) );
    }
}

TEST_CASE( "lua_platform_mutations_repeated_activation_is_not_set_active",
           "[lua][platform][mutations][semantic]" )
{
    mutation_fixture legacy( 2500 );
    mutation_fixture platform( 2600 );
    const bool npc_target = GENERATE( false, true );
    Character &old_target = legacy.target( npc_target );
    Character &new_target = platform.target( npc_target );
    old_target.set_mutation( trait_SNAIL_TRAIL );
    new_target.set_mutation( trait_SNAIL_TRAIL );
    old_target.set_thirst( 0 );
    new_target.set_thirst( 0 );
    old_target.set_stored_kcal( old_target.get_healthy_kcal() );
    new_target.set_stored_kcal( new_target.get_healthy_kcal() );
    const std::string source = std::string( R"({")" ) +
                               ( npc_target ? "npc_" : "u_" ) + R"(activate_trait":"SNAIL_TRAIL"})";
    sol::protected_function activate = platform.services["mutations"]["set_active"];
    // SNAIL_TRAIL has a 100-second charge period. Repeated native activation
    // advances that charge and eventually pays again; set_active is idempotent.
    for( int attempt = 0; attempt < 101; ++attempt ) {
        legacy.legacy_effect( source );
        sol::protected_function_result call = activate( platform.handle( npc_target ),
            cata::lua_platform::script_game_id( "mutation", "SNAIL_TRAIL" ), true );
        REQUIRE( call.valid() );
        REQUIRE( call.get<sol::table>()["ok"].get<bool>() );
    }
    CHECK( old_target.has_active_mutation( trait_SNAIL_TRAIL ) );
    CHECK( new_target.has_active_mutation( trait_SNAIL_TRAIL ) );
    CHECK( new_target.get_thirst() > 0 );
    CHECK( old_target.get_thirst() > new_target.get_thirst() );
}

TEST_CASE( "lua_platform_mutations_seeded_category_matches_legacy_effect",
           "[lua][platform][mutations][semantic]" )
{
    struct restore_rng {
        // Snapshot the shared engine to restore it after the seeded test.
        cata_default_random_engine saved = rng_get_engine(); // NOLINT(cata-determinism)
        ~restore_rng() {
            rng_get_engine() = saved;
        }
    } rng_scope;
    const override_option no_picker( "SHOW_MUTATION_SELECTOR", "false" );
    mutation_fixture legacy( 2300 );
    mutation_fixture platform( 2400 );
    const bool npc_target = GENERATE( false, true );
    const bool use_vitamins = GENERATE( false, true );
    const bool true_random = GENERATE( false, true );
    const std::string category = GENERATE( "CATTLE", "HUMAN" );
    const std::string prefix = npc_target ? "npc_" : "u_";
    Character &old_target = legacy.target( npc_target );
    Character &new_target = platform.target( npc_target );
    const auto before = new_target.get_mutations();
    const auto untouched = platform.target( !npc_target ).get_mutations();
    rng_set_engine_seed( 4242 );
    legacy.legacy_effect( R"({")" + prefix + R"(mutate_category":")" + category +
                          R"(","use_vitamins":)" + ( use_vitamins ? "true" : "false" ) +
                          R"(,"true_random":)" + ( true_random ? "true}" : "false}" ) );
    rng_set_engine_seed( 4242 );
    sol::protected_function function = platform.services["mutations"]["mutate_category"];
    sol::protected_function_result call = function( platform.handle( npc_target ),
        cata::lua_platform::script_game_id( "mutation_category", category ), use_vitamins, true_random );
    REQUIRE( call.valid() );
    sol::table result = call;
    REQUIRE( result["ok"].get<bool>() );
    const auto expected = old_target.get_mutations();
    const auto actual = new_target.get_mutations();
    CAPTURE( npc_target, category, use_vitamins, true_random );
    CHECK( std::set<trait_id>( actual.begin(), actual.end() ) ==
           std::set<trait_id>( expected.begin(), expected.end() ) );
    CHECK( result["value"]["before_count"].get<std::size_t>() == before.size() );
    CHECK( result["value"]["after_count"].get<std::size_t>() == actual.size() );
    CHECK( result["value"]["changed"].get<bool>() == ( actual != before ) );
    CHECK( platform.target( !npc_target ).get_mutations() == untouched );
    // At least this deterministic route must actually mutate: a no-op stub
    // must not pass just because the untargeted actor remained unchanged.
    if( category == "CATTLE" && !use_vitamins && true_random ) {
        CHECK_FALSE( actual.empty() );
    }
}

#endif
