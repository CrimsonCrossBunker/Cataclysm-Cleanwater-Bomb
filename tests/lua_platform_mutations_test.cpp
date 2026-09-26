#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <algorithm>
#include <cstddef>
#include <functional>
#include <initializer_list>
#include <memory>
#include <set>
#include <stdexcept>
#include <string>
#include <vector>

#include "avatar.h"
#include "cata_catch.h"
#include "character.h"
#include "character_id.h"
#include "condition.h"
#include "dialogue.h"
#include "dialogue_helpers.h"
#include "flexbuffer_json.h"
#include "json_loader.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"
#include "lua_platform_mutations.h"
#include "lua_platform_sol.h"
#include "lua_platform_variables.h"
#include "mutation.h"
#include "npc.h"
#include "options_helpers.h"
#include "rng.h"
#include "type_id.h"

static const trait_id trait_FELINE_EARS( "FELINE_EARS" );
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
        cata::lua_platform::install_variable_api(
        services, [this]() {
            return runtime;
        }, [this]() {
            return world;
        }, []() {}, [this]() {
            if( !writable ) {
                throw std::runtime_error( "test: variable write outside write phase" );
            }
        }, []() {
            return true;
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

    void legacy_effect( const std::string &source, const bool alpha_is_npc = false,
                        const std::string &context_key = {}, const std::string &context_value = {} ) {
        Character &alpha = alpha_is_npc ? static_cast<Character &>( other ) :
                           static_cast<Character &>( player );
        Character &beta = alpha_is_npc ? static_cast<Character &>( player ) :
                          static_cast<Character &>( other );
        dialogue context( get_talker_for( alpha ), get_talker_for( beta ) );
        if( !context_key.empty() ) {
            context.set_value( context_key, context_value );
        }
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

TEST_CASE( "lua_platform_mutations_query_variable_owners_and_list_boundaries",
           "[lua][platform][mutations][semantic]" )
{
    mutation_fixture fixture;
    fixture.player.set_mutation( trait_QUICK );
    fixture.other.set_mutation( trait_FELINE_EARS );
    fixture.player.set_value( "trait", "QUICK" );
    fixture.other.set_value( "trait", "FELINE_EARS" );
    dialogue context( get_talker_for( fixture.player ), get_talker_for( fixture.other ) );
    context.set_value( "trait", "FELINE_EARS" );
    const bool npc_target = GENERATE( false, true );
    const std::string prefix = npc_target ? "npc_" : "u_";
    for( const std::string scope : {
             "u_val", "npc_val", "context_val"
         } ) {
        const std::string id = scope == "u_val" ? "QUICK" : "FELINE_EARS";
        CAPTURE( npc_target, scope );
        const std::string source = R"({")" + prefix + R"(has_trait":{")" + scope + R"(":"trait"}})";
        const conditional_t legacy( json_loader::from_string( source ).get_object() );
        CHECK( legacy( context ) == fixture.query( "has", npc_target, id ) );
        CHECK( legacy( context ) == ( npc_target == ( scope != "u_val" ) ) );
    }
    CHECK_FALSE( fixture.legacy_condition( R"({")" + prefix + R"(has_any_trait":[]})" ) );
    std::string list;
    for( int i = 0; i < 64; ++i ) {
        list += R"("QUICK",)";
    }
    list += R"("FELINE_EARS")";
    CHECK( fixture.legacy_condition( R"({")" + prefix + R"(has_any_trait":[)" + list + "]}" ) );
    CHECK( ( fixture.query( "has", npc_target, "QUICK" ) ||
             fixture.query( "has", npc_target, "FELINE_EARS" ) ) );
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

TEST_CASE( "lua_platform_mutation_erase_matches_native_base_trait_and_absence",
           "[lua][platform][mutations][semantic]" )
{
    mutation_fixture legacy( 2900 );
    mutation_fixture platform( 3000 );
    const bool npc_target = GENERATE( false, true );
    const bool base = GENERATE( false, true );
    Character &old_target = legacy.target( npc_target );
    Character &new_target = platform.target( npc_target );
    if( base ) {
        old_target.toggle_trait( trait_QUICK );
        new_target.toggle_trait( trait_QUICK );
    } else {
        old_target.set_mutation( trait_QUICK );
        new_target.set_mutation( trait_QUICK );
    }
    Character &legacy_untouched = legacy.target( !npc_target );
    Character &platform_untouched = platform.target( !npc_target );
    legacy_untouched.set_mutation( trait_QUICK );
    platform_untouched.set_mutation( trait_QUICK );
    const bool untouched_base = platform_untouched.has_base_trait( trait_QUICK );
    const std::string effect = std::string( R"({")" ) +
                               ( npc_target ? "npc_" : "u_" ) + R"(lose_trait":"QUICK"})";
    for( int attempt = 0; attempt < 2; ++attempt ) {
        legacy.legacy_effect( effect );
        const sol::protected_function_result call = platform.services["mutations"]["erase"](
                    platform.handle( npc_target ), cata::lua_platform::script_game_id( "mutation", "QUICK" ) );
        REQUIRE( call.valid() );
        REQUIRE( call.get<sol::table>()["ok"].get<bool>() );
        CHECK( old_target.has_trait( trait_QUICK ) == new_target.has_trait( trait_QUICK ) );
        CHECK( old_target.has_base_trait( trait_QUICK ) == new_target.has_base_trait( trait_QUICK ) );
        CHECK( new_target.has_base_trait( trait_QUICK ) == base );
        CHECK( legacy_untouched.has_trait( trait_QUICK ) );
        CHECK( platform_untouched.has_trait( trait_QUICK ) );
        CHECK( legacy_untouched.has_trait( trait_QUICK ) == platform_untouched.has_trait( trait_QUICK ) );
        CHECK( legacy_untouched.has_base_trait( trait_QUICK ) == platform_untouched.has_base_trait(
                   trait_QUICK ) );
        CHECK( platform_untouched.has_base_trait( trait_QUICK ) == untouched_base );
    }
}

TEST_CASE( "lua_platform_mutation_erase_matches_dynamic_u_val_effect",
           "[lua][platform][mutations][semantic]" )
{
    mutation_fixture legacy( 3500 );
    mutation_fixture platform( 3600 );
    const std::string key = "chronomancer_menu_learn_id";
    const std::string effect =
        R"({"u_lose_trait":{"u_val":"chronomancer_menu_learn_id"}})";
    legacy.other.set_mutation( trait_QUICK );
    platform.other.set_mutation( trait_QUICK );
    legacy.other.set_value( key, trait_QUICK.str() );
    platform.other.set_value( key, trait_QUICK.str() );
    legacy.player.set_mutation( trait_QUICK );
    platform.player.set_mutation( trait_QUICK );

    // This is the live Xedra_Evolved u_val shape; place the NPC in the alpha
    // position to verify that u_ selects the talker, not a fixed avatar type.
    legacy.legacy_effect( effect, true );

    sol::protected_function resolve = platform.services["variables"]["resolve"];
    const sol::table context = platform.lua.create_table();
    sol::protected_function_result resolved = resolve( context, platform.handle( true ),
            "u", key );
    REQUIRE( resolved.valid() );
    sol::table resolved_result = resolved;
    REQUIRE( resolved_result["ok"].get<bool>() );
    REQUIRE( resolved_result["value"]["exists"].get<bool>() );
    const std::string id = resolved_result["value"]["value"].get<std::string>();
    const sol::protected_function_result call = platform.services["mutations"]["erase"](
                platform.handle( true ), cata::lua_platform::script_game_id( "mutation", id ) );
    REQUIRE( call.valid() );
    REQUIRE( call.get<sol::table>()["ok"].get<bool>() );
    CHECK_FALSE( legacy.other.has_trait( trait_QUICK ) );
    CHECK_FALSE( platform.other.has_trait( trait_QUICK ) );
    CHECK( legacy.player.has_trait( trait_QUICK ) );
    CHECK( platform.player.has_trait( trait_QUICK ) );
}

TEST_CASE( "lua_platform_mutation_replace_matches_legacy_context_values_for_alpha_npc",
           "[lua][platform][mutations][semantic]" )
{
    mutation_fixture legacy( 3300 );
    mutation_fixture platform( 3400 );
    const trait_id hair( "artificial_hair_buzzcut" );
    REQUIRE( hair.is_valid() );
    const mutation_variant *red_variant = hair->variant( "red" );
    const mutation_variant *black_variant = hair->variant( "black" );
    const mutation_variant *white_variant = hair->variant( "white" );
    REQUIRE( red_variant != nullptr );
    REQUIRE( black_variant != nullptr );
    REQUIRE( white_variant != nullptr );
    const cata::lua_platform::game_handle alpha_npc = platform.handle( true );

    SECTION( "dynamic_trait_id_and_static_variant" ) {
        const std::string source =
            R"({"u_add_trait":{"context_val":"trait_id"},"variant":"red"})";
        legacy.legacy_effect( source, true, "trait_id", hair.str() );

        sol::table context = platform.lua.create_table();
        context["trait_id"] = hair.str();
        sol::protected_function resolve = platform.services["variables"]["resolve"];
        sol::protected_function_result resolved = resolve( context, sol::nil, "context", "trait_id" );
        REQUIRE( resolved.valid() );
        sol::table resolved_result = resolved;
        REQUIRE( resolved_result["ok"].get<bool>() );
        REQUIRE( resolved_result["value"]["exists"].get<bool>() );
        const std::string id = resolved_result["value"]["value"].get<std::string>();
        sol::protected_function replace = platform.services["mutations"]["replace"];
        sol::protected_function_result call = replace( alpha_npc,
                                              cata::lua_platform::script_game_id( "mutation", id ), "red" );
        REQUIRE( call.valid() );
        REQUIRE( call.get<sol::table>()["ok"].get<bool>() );
        CHECK( legacy.other.has_trait( hair ) == platform.other.has_trait( hair ) );
        CHECK( legacy.other.get_mutations_variants() == platform.other.get_mutations_variants() );
        CHECK( legacy.other.has_trait( hair ) );
        REQUIRE( legacy.other.get_mutations_variants().size() == 1 );
        REQUIRE( platform.other.get_mutations_variants().size() == 1 );
        CHECK( legacy.other.get_mutations_variants().front().variant == "red" );
        CHECK( platform.other.get_mutations_variants().front().variant == "red" );
        CHECK_FALSE( platform.player.has_trait( hair ) );
    }

    SECTION( "bionic_color_id_context_variant" ) {
        legacy.other.set_mutation( hair, black_variant );
        platform.other.set_mutation( hair, black_variant );
        const std::string source =
            R"({"u_add_trait":"artificial_hair_buzzcut","variant":{"context_val":"color_id"}})";
        legacy.legacy_effect( source, true, "color_id", "white" );

        sol::table context = platform.lua.create_table();
        context["color_id"] = "white";
        sol::protected_function resolve = platform.services["variables"]["resolve"];
        sol::protected_function_result resolved = resolve( context, sol::nil, "context", "color_id" );
        REQUIRE( resolved.valid() );
        sol::table resolved_result = resolved;
        REQUIRE( resolved_result["ok"].get<bool>() );
        REQUIRE( resolved_result["value"]["exists"].get<bool>() );
        const std::string variant = resolved_result["value"]["value"].get<std::string>();
        CHECK( variant == white_variant->id );
        sol::protected_function replace = platform.services["mutations"]["replace"];
        sol::protected_function_result call = replace( alpha_npc,
                                              cata::lua_platform::script_game_id( "mutation", hair.str() ), variant );
        REQUIRE( call.valid() );
        REQUIRE( call.get<sol::table>()["ok"].get<bool>() );
        CHECK( legacy.other.get_mutations_variants() == platform.other.get_mutations_variants() );
        REQUIRE( platform.other.get_mutations_variants().size() == 1 );
        CHECK( platform.other.get_mutations_variants().front().trait == hair );
        CHECK( platform.other.get_mutations_variants().front().variant == "white" );
        CHECK_FALSE( platform.player.has_trait( hair ) );
    }
}

TEST_CASE( "lua_platform_mutation_replace_matches_native_conflicts_and_repeat",
           "[lua][platform][mutations][semantic]" )
{
    mutation_fixture legacy( 3100 );
    mutation_fixture platform( 3200 );
    const bool npc_target = GENERATE( false, true );
    Character &old_target = legacy.target( npc_target );
    Character &new_target = platform.target( npc_target );
    for( Character *target : {
             &old_target, &new_target
         } ) {
        target->toggle_trait( trait_VULNERABLECHILL );
        target->set_mutation( trait_QUICK );
    }
    platform.target( !npc_target ).set_mutation( trait_VULNERABLECHILL );
    const std::string effect = std::string( R"({")" ) + ( npc_target ? "npc_" : "u_" ) +
                               R"(add_trait":"STRONGER_VULNERABLEWARM","variant":"unknown"})";
    for( int attempt = 0; attempt < 2; ++attempt ) {
        legacy.legacy_effect( effect );
        const sol::protected_function_result call = platform.services["mutations"]["replace"](
                    platform.handle( npc_target ),
                    cata::lua_platform::script_game_id( "mutation", "STRONGER_VULNERABLEWARM" ), "unknown" );
        REQUIRE( call.valid() );
        REQUIRE( call.get<sol::table>()["ok"].get<bool>() );
        CHECK( old_target.get_mutations() == new_target.get_mutations() );
        CHECK( old_target.has_base_trait( trait_VULNERABLECHILL ) ==
               new_target.has_base_trait( trait_VULNERABLECHILL ) );
        CHECK( new_target.has_trait( trait_QUICK ) );
        CHECK_FALSE( new_target.has_trait( trait_VULNERABLECHILL ) );
        CHECK( platform.target( !npc_target ).has_trait( trait_VULNERABLECHILL ) );
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
    const bool retrigger = GENERATE( false, true );
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
                                              cata::lua_platform::script_game_id( "mutation", "SNAIL_TRAIL" ), true, retrigger );
        REQUIRE( call.valid() );
        REQUIRE( call.get<sol::table>()["ok"].get<bool>() );
    }
    CHECK( old_target.has_active_mutation( trait_SNAIL_TRAIL ) );
    CHECK( new_target.has_active_mutation( trait_SNAIL_TRAIL ) );
    CHECK( new_target.get_thirst() > 0 );
    if( retrigger ) {
        CHECK( old_target.get_thirst() == new_target.get_thirst() );
    } else {
        CHECK( old_target.get_thirst() > new_target.get_thirst() );
    }
}

TEST_CASE( "lua_platform_mutation_action_matches_native_without_permanent_trait",
           "[lua][platform][mutations][semantic]" )
{
    mutation_fixture legacy( 2700 );
    mutation_fixture platform( 2800 );
    const bool npc_target = GENERATE( false, true );
    const bool active = GENERATE( false, true );
    const bool present = GENERATE( false, true );
    Character &old_target = legacy.target( npc_target );
    Character &new_target = platform.target( npc_target );
    if( present ) {
        old_target.set_mutation( trait_QUICK );
        new_target.set_mutation( trait_QUICK );
    }
    const std::string effect = std::string( R"({")" ) + ( npc_target ? "npc_" : "u_" ) +
                               ( active ? "activate_trait" : "deactivate_trait" ) + R"(":"QUICK"})";
    for( int attempt = 0; attempt < 2; ++attempt ) {
        legacy.legacy_effect( effect );
        const sol::protected_function_result call = platform.services["mutations"]["invoke_activation"](
                    platform.handle( npc_target ),
                    cata::lua_platform::script_game_id( "mutation", "QUICK" ), active );
        REQUIRE( call.valid() );
        REQUIRE( call.get<sol::table>()["ok"].get<bool>() );
        CHECK( old_target.has_active_mutation( trait_QUICK ) == new_target.has_active_mutation(
                   trait_QUICK ) );
        CHECK( old_target.has_permanent_trait( trait_QUICK ) == new_target.has_permanent_trait(
                   trait_QUICK ) );
    }
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

TEST_CASE( "lua_platform_mutation_definitions_native_order", "[lua][mutations]" )
{
    mutation_fixture fixture;
    sol::protected_function definitions = fixture.services["mutations"]["definitions"];
    const auto &native = mutation_branch::get_all();
    REQUIRE( native.size() > 2 );
    sol::table options = fixture.lua.create_table();
    options["order"] = "native";
    options["offset"] = 1;
    options["limit"] = 2;
    sol::protected_function_result call = definitions( options );
    REQUIRE( call.valid() );
    sol::table page = call;
    sol::table items = page["items"];
    REQUIRE( items.size() == 2 );
    for( std::size_t index = 1; index <= 2; ++index ) {
        sol::table entry = items[index];
        CHECK( entry["id"].get<cata::lua_platform::script_game_id>().value() == native[index].id.str() );
    }
    std::vector<std::string> sorted_ids;
    for( const mutation_branch &definition : native ) {
        sorted_ids.push_back( definition.id.str() );
    }
    std::sort( sorted_ids.begin(), sorted_ids.end() );
    for( const bool explicit_order : {
             false, true
         } ) {
        options["order"] = sol::nil;
        if( explicit_order ) {
            options["order"] = "id";
        }
        sol::protected_function_result sorted_call = definitions( options );
        REQUIRE( sorted_call.valid() );
        sol::table sorted_page = sorted_call;
        sol::table sorted_items = sorted_page["items"];
        for( std::size_t index = 1; index <= 2; ++index ) {
            sol::table entry = sorted_items[index];
            CHECK( entry["id"].get<cata::lua_platform::script_game_id>().value() == sorted_ids[index] );
        }
    }
    options["order"] = "invalid";
    CHECK_FALSE( definitions( options ).valid() );
    options["order"] = 1;
    CHECK_FALSE( definitions( options ).valid() );
}

#endif
