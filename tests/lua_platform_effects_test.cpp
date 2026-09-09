#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <cstddef>
#include <functional>
#include <initializer_list>
#include <stdexcept>
#include <string>
#include <vector>

#include "avatar.h"
#include "bodypart.h"
#include "calendar.h"
#include "cata_catch.h"
#include "character.h"
#include "character_id.h"
#include "condition.h"
#include "dialogue.h"
#include "dialogue_helpers.h"
#include "effect.h"
#include "flexbuffer_json.h"
#include "json_loader.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_effects.h"
#include "lua_platform_creatures.h"
#include "lua_platform_handle.h"
#include "lua_platform_sol.h"
#include "npc.h"
#include "rng.h"
#include "type_id.h"

static const efftype_id effect_bleed( "bleed" );

namespace
{
struct effect_fixture {
    explicit effect_fixture( const int first_id = 3100 ) {
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
        cata::lua_platform::install_effect_api(
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

    ~effect_fixture() {
        cata::lua_platform::retire_npc_handle_identity( other );
    }

    cata::lua_platform::game_handle handle( const bool npc_target ) {
        Character &target = npc_target ? static_cast<Character &>( other ) : player;
        return cata::lua_platform::game_handle::from_creature(
                   target, { npc_target ? "npc" : "avatar", target.getID().get_value(), 0, 0, 0, {} },
                   runtime, world );
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
        effect.parse_sub_effect( json_loader::from_string( source ).get_object(), "effect_acceptance" );
        finalize_conditions();
        for( const talk_effect_fun_t &operation : effect.effects ) {
            operation( context );
        }
    }

    bool query( const bool npc_target, const std::string &id,
                const std::string &part, const int intensity ) {
        sol::protected_function function = services["effects"]["has"];
        sol::protected_function_result call = function( handle( npc_target ),
            cata::lua_platform::script_game_id( "effect", id ),
            cata::lua_platform::script_game_id( "body_part", part ), intensity );
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

TEST_CASE( "lua_platform_effects_queries_match_legacy_for_exact_body_part",
           "[lua][platform][effects][semantic]" )
{
    effect_fixture fixture;
    const bool npc_target = GENERATE( false, true );
    const std::string part = GENERATE( std::string( "arm_l" ), std::string( "arm_r" ) );
    const int intensity = GENERATE( -1, 1, 2 );
    const std::string prefix = npc_target ? "npc_" : "u_";
    Character &target = fixture.target( npc_target );
    // The other actor has both effects so checking the wrong actor is observable.
    fixture.target( !npc_target ).add_effect( effect_bleed, 10_turns,
            body_part_arm_l.id(), false, 2, true );
    for( const bool present : {
             false, true
         } ) {
        if( present ) {
            target.add_effect( effect_bleed, 10_turns,
                               body_part_arm_l.id(), false, 1, true );
        }
        const std::string qualifiers = R"(, "bodypart": ")" + part +
                                       R"(", "intensity": )" + std::to_string( intensity ) + "}";
        const bool native = fixture.query( npc_target, "bleed", part, intensity );
        CHECK( native == fixture.legacy_condition(
                   std::string( R"({")" ).append( prefix ).append( R"(has_effect": "bleed")" ).append(
                       qualifiers ) ) );
        CHECK( ( native || fixture.query( npc_target, "poison", part, intensity ) ) ==
               fixture.legacy_condition( std::string( R"({")" ).append( prefix ).append(
                                             R"(has_any_effect": ["bleed", "poison"])" ).append( qualifiers ) ) );
        CHECK( native == ( present && part == "arm_l" && intensity <= 1 ) );
    }
}

TEST_CASE( "lua_platform_weighted_body_part_matches_native_anatomy",
           "[lua][platform][effects][semantic]" )
{
    struct restore_rng {
        cata_default_random_engine saved = rng_get_engine(); // NOLINT(cata-determinism)
        ~restore_rng() {
            rng_get_engine() = saved;
        }
    } rng_scope;
    effect_fixture fixture;
    cata::lua_platform::install_creature_api(
    fixture.services, [&]() {
        return fixture.runtime;
    },
    [&]() {
        return fixture.world;
    }, []() {}, []() {} );
    const bool npc_target = GENERATE( false, true );
    const bool main_parts_only = GENERATE( false, true );
    std::vector<std::string> expected;
    rng_set_engine_seed( 58163 );
    for( int i = 0; i < 128; ++i ) {
        expected.push_back( fixture.target( npc_target ).random_body_part( main_parts_only ).id().str() );
    }
    sol::protected_function pick = fixture.services["characters"]["random_body_part"];
    rng_set_engine_seed( 58163 );
    for( const std::string &part : expected ) {
        sol::protected_function_result call = pick( fixture.handle( npc_target ), main_parts_only );
        REQUIRE( call.valid() );
        sol::table result = call;
        REQUIRE( result["ok"].get<bool>() );
        const auto id = result["value"].get<cata::lua_platform::script_game_id>();
        CHECK( id.kind() == "body_part" );
        CHECK( id.value() == part );
    }
    const auto stale = fixture.handle( npc_target );
    ++fixture.world;
    sol::protected_function_result call = pick( stale );
    REQUIRE( call.valid() );
    sol::table result = call;
    CHECK_FALSE( result["ok"].get<bool>() );
}

TEST_CASE( "lua_platform_effect_snapshot_preserves_lazy_intensity_predicates",
           "[lua][platform][effects][semantic]" )
{
    effect_fixture fixture;
    const bool npc_target = GENERATE( false, true );
    const std::string prefix = npc_target ? "npc_" : "u_";
    int evaluations = 0;
    double threshold = 1;
    fixture.lua["effects"] = fixture.services["effects"];
    fixture.lua["actor"] = fixture.handle( npc_target );
    fixture.lua["effect_id"] = cata::lua_platform::script_game_id( "effect", "bleed" );
    fixture.lua["part_id"] = cata::lua_platform::script_game_id( "body_part", "arm_l" );
    fixture.lua.set_function( "threshold", [&]() {
        ++evaluations;
        return threshold;
    } );
    const sol::protected_function_result installed = fixture.lua.safe_script( R"(
query = function()
    local result = effects.get(actor, effect_id, part_id)
    if not result.ok then
        return false
    end
    return result.value.intensity >= threshold()
end
)", sol::script_pass_on_error );
    REQUIRE( installed.valid() );
    sol::protected_function query = fixture.lua["query"];
    sol::protected_function_result result = query();
    REQUIRE( result.valid() );
    CHECK_FALSE( result.get<bool>() );
    CHECK( evaluations == 0 );
    fixture.target( npc_target ).add_effect( effect_bleed, 10_turns,
            body_part_arm_l.id(), false, 1, true );
    for( const double minimum : {
             -1000001.0, 1.0, 1.5, 1000001.0
         } ) {
        threshold = minimum;
        const int before = evaluations;
        result = query();
        REQUIRE( result.valid() );
        CHECK( evaluations == before + 1 );
        const std::string source = R"({")" + prefix +
                                   R"(has_effect":"bleed","bodypart":"arm_l","intensity":)" +
                                   std::to_string( minimum ) + "}";
        CHECK( result.get<bool>() == fixture.legacy_condition( source ) );
    }
}

TEST_CASE( "lua_platform_effects_add_remove_match_legacy_for_exact_body_part",
           "[lua][platform][effects][semantic]" )
{
    effect_fixture legacy( 3200 );
    effect_fixture modern( 3300 );
    const bool npc_target = GENERATE( false, true );
    const bool permanent = GENERATE( false, true );
    const int intensity = GENERATE( -1, 0, 1 );
    const std::string prefix = npc_target ? "npc_" : "u_";
    const efftype_id &bleeding = effect_bleed;
    const bodypart_id left( "arm_l" );
    const bodypart_id right( "arm_r" );
    for( effect_fixture *fixture : {
             &legacy, &modern
         } ) {
        fixture->target( npc_target ).add_effect( bleeding, 30_turns, right, false, 1, true );
        fixture->target( !npc_target ).add_effect( bleeding, 30_turns, left, false, 1, true );
    }
    sol::table options = modern.lua.create_table();
    options["body_part"] = cata::lua_platform::script_game_id( "body_part", "arm_l" );
    options["intensity"] = intensity;
    options["force"] = true;
    options["permanent"] = permanent;
    for( int repeat = 0; repeat < 2; ++repeat ) {
        legacy.legacy_effect( R"({")" + prefix + R"(add_effect": "bleed", )"
                              R"("duration": )" + ( permanent ? std::string( R"("PERMANENT")" ) : "10" ) +
                              R"(, "target_part": "arm_l", "intensity": )" + std::to_string( intensity ) +
                              R"(, "force": true})" );
        sol::protected_function add = modern.services["effects"]["add"];
        sol::protected_function_result call = add( modern.handle( npc_target ),
            cata::lua_platform::script_game_id( "effect", "bleed" ),
            cata::lua_platform::script_time_duration::from_native( permanent ? 1_turns : 10_turns ),
            options );
        REQUIRE( call.valid() );
        sol::table result = call;
        REQUIRE( result["ok"].get<bool>() );
        const effect &before = legacy.target( npc_target ).get_effect( bleeding, left );
        const effect &after = modern.target( npc_target ).get_effect( bleeding, left );
        REQUIRE_FALSE( before.is_null() );
        REQUIRE_FALSE( after.is_null() );
        CHECK( before.get_duration() == after.get_duration() );
        CHECK( before.get_intensity() == after.get_intensity() );
        CHECK( before.is_permanent() == after.is_permanent() );
    }
    for( int repeat = 0; repeat < 2; ++repeat ) {
        legacy.legacy_effect( R"({")" + prefix +
                              R"(lose_effect": "bleed", "target_part": "arm_l"})" );
        sol::protected_function remove = modern.services["effects"]["remove"];
        sol::protected_function_result call = remove( modern.handle( npc_target ),
            cata::lua_platform::script_game_id( "effect", "bleed" ),
            cata::lua_platform::script_game_id( "body_part", "arm_l" ) );
        REQUIRE( call.valid() );
        sol::table result = call;
        REQUIRE( result["ok"].get<bool>() );
        for( effect_fixture *fixture : {
                 &legacy, &modern
             } ) {
            CHECK_FALSE( fixture->target( npc_target ).has_effect( bleeding, left ) );
            CHECK( fixture->target( npc_target ).has_effect( bleeding, right ) );
            CHECK( fixture->target( !npc_target ).has_effect( bleeding, left ) );
        }
    }
}

TEST_CASE( "lua_platform_effects_fractional_duration_matches_legacy_truncation",
           "[lua][platform][effects][semantic]" )
{
    effect_fixture legacy( 3900 );
    effect_fixture modern( 4000 );
    const bool npc_target = GENERATE( false, true );
    const double turns = GENERATE( 0.8, 1.8, 2.9 );
    const std::string prefix = npc_target ? "npc_" : "u_";
    legacy.legacy_effect( R"({")" + prefix + R"(add_effect": "bleed", )"
                          R"("duration": {"math": [")" + std::to_string( turns ) +
                          R"("]}, "target_part": "arm_l", "intensity": 1})" );
    sol::table options = modern.lua.create_table();
    options["body_part"] = cata::lua_platform::script_game_id( "body_part", "arm_l" );
    options["intensity"] = 1;
    sol::protected_function add = modern.services["effects"]["add"];
    sol::protected_function_result call = add( modern.handle( npc_target ),
        cata::lua_platform::script_game_id( "effect", "bleed" ),
        cata::lua_platform::script_time_duration::from_native(
            time_duration::from_turns( static_cast<int>( turns ) ) ), options );
    REQUIRE( call.valid() );
    sol::table result = call;
    REQUIRE( result["ok"].get<bool>() );
    const effect &before = legacy.target( npc_target ).get_effect(
                               effect_bleed, body_part_arm_l.id() );
    const effect &after = modern.target( npc_target ).get_effect(
                              effect_bleed, body_part_arm_l.id() );
    REQUIRE_FALSE( before.is_null() );
    REQUIRE_FALSE( after.is_null() );
    CHECK( before.get_duration() == time_duration::from_turns( static_cast<int>( turns ) ) );
    CHECK( before.get_duration() == after.get_duration() );
}

TEST_CASE( "lua_platform_effects_zero_duration_matches_legacy_application",
           "[lua][platform][effects][semantic]" )
{
    effect_fixture legacy( 3400 );
    effect_fixture modern( 3500 );
    const bool npc_target = GENERATE( false, true );
    const std::string prefix = npc_target ? "npc_" : "u_";
    legacy.legacy_effect( R"({")" + prefix + R"(add_effect": "bleed", )"
                          R"("duration": 0, "target_part": "arm_l", "intensity": 1})" );
    sol::table options = modern.lua.create_table();
    options["body_part"] = cata::lua_platform::script_game_id( "body_part", "arm_l" );
    options["intensity"] = 1;
    sol::protected_function add = modern.services["effects"]["add"];
    sol::protected_function_result call = add( modern.handle( npc_target ),
        cata::lua_platform::script_game_id( "effect", "bleed" ),
        cata::lua_platform::script_time_duration::from_native( 0_turns ), options );
    REQUIRE( call.valid() );
    sol::table result = call;
    REQUIRE( result["ok"].get<bool>() );
    const effect &before = legacy.target( npc_target ).get_effect(
                               effect_bleed, body_part_arm_l.id() );
    const effect &after = modern.target( npc_target ).get_effect(
                              effect_bleed, body_part_arm_l.id() );
    REQUIRE_FALSE( before.is_null() );
    REQUIRE_FALSE( after.is_null() );
    CHECK( before.get_duration() == 0_turns );
    CHECK( after.get_duration() == 0_turns );
}

TEST_CASE( "lua_platform_effects_negative_add_intensity_is_not_a_delta",
           "[lua][platform][effects][semantic]" )
{
    effect_fixture legacy( 3600 );
    effect_fixture modern( 3700 );
    const bool npc_target = GENERATE( false, true );
    const std::string prefix = npc_target ? "npc_" : "u_";
    const efftype_id &bleeding = effect_bleed;
    const bodypart_id part( "arm_l" );
    for( effect_fixture *fixture : {
             &legacy, &modern
         } ) {
        fixture->target( npc_target ).add_effect( bleeding, 30_turns, part, false, 1, true );
        REQUIRE( fixture->target( npc_target ).get_effect( bleeding, part ).get_intensity() == 1 );
    }
    legacy.legacy_effect( R"({")" + prefix + R"(add_effect": "bleed", )"
                          R"("duration": 0, "target_part": "arm_l", "intensity": -1})" );
    sol::protected_function adjust = modern.services["effects"]["adjust_intensity"];
    sol::protected_function_result call = adjust( modern.handle( npc_target ),
        cata::lua_platform::script_game_id( "effect", "bleed" ), -1,
        cata::lua_platform::script_game_id( "body_part", "arm_l" ) );
    REQUIRE( call.valid() );
    sol::table result = call;
    REQUIRE( result["ok"].get<bool>() );
    CHECK( legacy.target( npc_target ).has_effect( bleeding, part ) );
    CHECK_FALSE( modern.target( npc_target ).has_effect( bleeding, part ) );
}

#endif
