#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <cstddef>
#include <functional>
#include <initializer_list>
#include <stdexcept>
#include <string>
#include <tuple>
#include <utility>
#include <vector>

#include "activity_actor.h"
#include "activity_actor_definitions.h"
#include "avatar.h"
#include "bodypart.h"
#include "calendar.h"
#include "cata_catch.h"
#include "character.h"
#include "character_id.h"
#include "condition.h"
#include "creature.h"
#include "dialogue.h"
#include "dialogue_helpers.h"
#include "effect.h"
#include "event.h"
#include "event_bus.h"
#include "event_subscriber.h"
#include "flexbuffer_json.h"
#include "game.h"
#include "json_loader.h"
#include "item.h"
#include "item_location.h"
#include "lua_platform_activities.h"
#include "lua_platform_bindings_coords.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_creatures.h"
#include "lua_platform_effects.h"
#include "lua_platform_npc_services.h"
#include "lua_platform_npcs.h"
#include "lua_platform_trade.h"
#include "lua_platform_world_services.h"
#include "map.h"
#include "map_helpers.h"
#include "monster.h"
#include "mtype.h"
#include "lua_platform_handle.h"
#include "lua_platform_sol.h"
#include "messages.h"
#include "npc.h"
#include "npctalk.h"
#include "npctrade.h"
#include "options_helpers.h"
#include "player_helpers.h"
#include "point.h"
#include "viewer.h"
#include "rng.h"
#include "type_id.h"

static const bodypart_str_id body_part_test_tail( "test_tail" );

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
    expected.reserve( 128 );
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
        const cata::lua_platform::script_game_id id =
            result["value"].get<cata::lua_platform::script_game_id>();
        CHECK( id.kind() == "body_part" );
        CHECK( id.value() == part );
    }
    const cata::lua_platform::game_handle stale = fixture.handle( npc_target );
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

TEST_CASE( "lua_platform_effects_accept_registered_parts_outside_current_anatomy",
           "[lua][platform][effects][semantic]" )
{
    effect_fixture legacy( 4400 );
    effect_fixture modern( 4500 );
    const bool npc_target = GENERATE( false, true );
    REQUIRE( body_part_test_tail.is_valid() );
    REQUIRE_FALSE( modern.target( npc_target ).has_part( body_part_test_tail ) );
    const std::string prefix = npc_target ? "npc_" : "u_";
    CHECK_FALSE( legacy.legacy_condition( R"({")" + prefix +
                                          R"(has_effect":"bleed","bodypart":"test_tail"})" ) );
    CHECK_FALSE( modern.query( npc_target, "bleed", "test_tail", 1 ) );
    sol::protected_function get = modern.services["effects"]["get"];
    const cata::lua_platform::script_game_id id( "effect", "bleed" );
    const cata::lua_platform::script_game_id part( "body_part", "test_tail" );
    sol::protected_function_result missing_call = get( modern.handle( npc_target ), id, part );
    REQUIRE( missing_call.valid() );
    sol::table missing = missing_call;
    CHECK_FALSE( missing["ok"].get<bool>() );
    CHECK( missing["error"]["code"].get<std::string>() == "not_found" );

    legacy.legacy_effect( R"({")" + prefix +
                          R"(add_effect":"bleed","duration":10,"target_part":"test_tail","intensity":1})" );
    sol::table options = modern.lua.create_table();
    options["body_part"] = part;
    options["intensity"] = 1;
    sol::protected_function add = modern.services["effects"]["add"];
    sol::protected_function_result add_call = add( modern.handle( npc_target ), id,
            cata::lua_platform::script_time_duration::from_native( 10_turns ), options );
    REQUIRE( add_call.valid() );
    sol::table added = add_call;
    REQUIRE( added["ok"].get<bool>() );
    const effect &before = legacy.target( npc_target ).get_effect( effect_bleed, body_part_test_tail );
    const effect &after = modern.target( npc_target ).get_effect( effect_bleed, body_part_test_tail );
    REQUIRE_FALSE( before.is_null() );
    REQUIRE_FALSE( after.is_null() );
    CHECK( before.get_duration() == after.get_duration() );
    CHECK( before.get_intensity() == after.get_intensity() );
    CHECK( modern.query( npc_target, "bleed", "test_tail", 1 ) );
    sol::protected_function remove = modern.services["effects"]["remove"];
    sol::protected_function_result remove_call = remove( modern.handle( npc_target ), id, part );
    REQUIRE( remove_call.valid() );
    sol::table removed = remove_call;
    CHECK( removed["ok"].get<bool>() );
    CHECK( removed["value"].get<bool>() );
    legacy.legacy_effect( R"({")" + prefix + R"(lose_effect":"bleed","target_part":"test_tail"})" );
    CHECK_FALSE( modern.target( npc_target ).has_effect( effect_bleed, body_part_test_tail ) );
    CHECK_FALSE( legacy.target( npc_target ).has_effect( effect_bleed, body_part_test_tail ) );
}

TEST_CASE( "lua_platform_effects_all_removal_preserves_part_events",
           "[lua][platform][effects][semantic]" )
{
    effect_fixture legacy( 4100 );
    effect_fixture modern( 4200 );
    effect_fixture bulk( 4300 );
    const bool npc_target = GENERATE( false, true );
    for( effect_fixture *fixture : {
             &legacy, &modern, &bulk
         } ) {
        Character &target = fixture->target( npc_target );
        target.add_effect( effect_bleed, 10_turns, bodypart_str_id::NULL_ID().id(), false, 1, true );
        target.add_effect( effect_bleed, 10_turns, body_part_arm_l.id(), false, 1, true );
        target.add_effect( effect_bleed, 10_turns, body_part_arm_r.id(), false, 1, true );
    }
    struct removal_observer : event_subscriber {
        using event_subscriber::notify;
        character_id watched;
        std::vector<std::string> parts;
        void notify( const cata::event &event ) override {
            if( event.type() == event_type::character_loses_effect &&
                event.get<character_id>( "character" ) == watched ) {
                parts.push_back( event.get<bodypart_id>( "bodypart" ).id().str() );
            }
        }
    } observer;
    get_event_bus().subscribe( &observer );
    observer.watched = legacy.target( npc_target ).getID();
    const std::string prefix = npc_target ? "npc_" : "u_";
    legacy.legacy_effect( R"({")" + prefix + R"(lose_effect":"bleed","target_part":"ALL"})" );
    const std::vector<std::string> expected = observer.parts;
    REQUIRE( expected.size() == 3 );
    CHECK( expected.back() == "bp_null" );

    observer.watched = bulk.target( npc_target ).getID();
    observer.parts.clear();
    bulk.target( npc_target ).remove_effect( effect_bleed );
    CHECK( observer.parts.size() == 1 );
    CHECK( observer.parts != expected );

    cata::lua_platform::install_creature_api(
    modern.services, [&]() {
        return modern.runtime;
    },
    [&]() {
        return modern.world;
    }, []() {}, []() {} );
    observer.watched = modern.target( npc_target ).getID();
    observer.parts.clear();
    sol::protected_function get_parts = modern.services["characters"]["body_parts"];
    sol::protected_function_result parts_call = get_parts( modern.handle( npc_target ) );
    REQUIRE( parts_call.valid() );
    sol::table parts_result = parts_call;
    REQUIRE( parts_result["ok"].get<bool>() );
    sol::table parts = parts_result["value"];
    const auto native_parts = modern.target( npc_target ).get_all_body_parts(
                                  get_body_part_flags::none );
    REQUIRE( parts.size() == native_parts.size() );
    sol::protected_function remove = modern.services["effects"]["remove"];
    const cata::lua_platform::script_game_id id( "effect", "bleed" );
    for( std::size_t i = 0; i < native_parts.size(); ++i ) {
        const cata::lua_platform::script_game_id part = parts[i +
                  1].get<cata::lua_platform::script_game_id>();
        CHECK( part.value() == native_parts[i].id().str() );
        sol::protected_function_result call = remove( modern.handle( npc_target ), id, part );
        REQUIRE( call.valid() );
        sol::table result = call;
        REQUIRE( result["ok"].get<bool>() );
    }
    sol::protected_function_result call = remove( modern.handle( npc_target ), id );
    REQUIRE( call.valid() );
    sol::table result = call;
    REQUIRE( result["ok"].get<bool>() );
    CHECK( observer.parts == expected );
    CHECK_FALSE( modern.target( npc_target ).has_effect( effect_bleed ) );
    const cata::lua_platform::game_handle stale = modern.handle( npc_target );
    ++modern.world;
    sol::protected_function_result stale_call = get_parts( stale );
    REQUIRE( stale_call.valid() );
    sol::table stale_result = stale_call;
    CHECK_FALSE( stale_result["ok"].get<bool>() );
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

TEST_CASE( "lua_platform_effects_signed_and_long_durations_match_legacy",
           "[lua][platform][effects][semantic]" )
{
    effect_fixture legacy( 4600 );
    effect_fixture modern( 4700 );
    const bool npc_target = GENERATE( false, true );
    const int turns = GENERATE( -10, -1, 366 * 24 * 60 * 60 );
    const std::string prefix = npc_target ? "npc_" : "u_";
    legacy.legacy_effect( R"({")" + prefix + R"(add_effect":"bleed","duration":)" +
                          std::to_string( turns ) + R"(,"target_part":"arm_l","intensity":1})" );
    sol::table options = modern.lua.create_table();
    options["body_part"] = cata::lua_platform::script_game_id( "body_part", "arm_l" );
    options["intensity"] = 1;
    sol::protected_function add = modern.services["effects"]["add"];
    sol::protected_function_result call = add( modern.handle( npc_target ),
                                          cata::lua_platform::script_game_id( "effect", "bleed" ),
                                          cata::lua_platform::script_time_duration::from_native( time_duration::from_turns( turns ) ),
                                          options );
    REQUIRE( call.valid() );
    sol::table result = call;
    REQUIRE( result["ok"].get<bool>() );
    const effect &before = legacy.target( npc_target ).get_effect( effect_bleed, body_part_arm_l.id() );
    const effect &after = modern.target( npc_target ).get_effect( effect_bleed, body_part_arm_l.id() );
    REQUIRE_FALSE( before.is_null() );
    REQUIRE_FALSE( after.is_null() );
    CHECK( before.get_duration() == after.get_duration() );
    CHECK( before.get_intensity() == after.get_intensity() );
    if( turns < 0 ) {
        CHECK( after.get_duration() == time_duration::from_turns( turns ) );
    }
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


TEST_CASE( "lua_platform_technique_large_blacklist_matches_native",
           "[lua][platform][semantic]" )
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
    std::vector<matec_id> blacklist( 300, matec_id( "tec_none" ) );
    sol::table entries = fixture.lua.create_table();
    for( std::size_t index = 0; index < blacklist.size(); ++index ) {
        entries[index + 1] = blacklist[index].str();
    }
    sol::table options = fixture.lua.create_table();
    options["blacklist"] = entries;
    rng_set_engine_seed( 58163 );
    const auto expected = fixture.target( false ).pick_technique(
                              fixture.target( true ), fixture.target( false ).used_weapon(),
                              false, false, false, blacklist );
    rng_set_engine_seed( 58163 );
    sol::protected_function pick = fixture.services["characters"]["choose_technique"];
    sol::protected_function_result call = pick(
            fixture.handle( false ), fixture.handle( true ), options );
    REQUIRE( call.valid() );
    sol::table result = call;
    REQUIRE( result["ok"].get<bool>() );
    sol::table value = result["value"];
    CHECK( value["technique"].get<cata::lua_platform::script_game_id>().value() ==
           std::get<0>( expected ).str() );
}


TEST_CASE( "lua_platform_revert_idle_npc_restores_native_state",
           "[lua][platform][activities][semantic]" )
{
    effect_fixture fixture;
    npc native;
    const auto prepare = []( npc & worker ) {
        worker.normalize();
        worker.set_mission( NPC_MISSION_GUARD );
        worker.set_attitude( NPCATT_FOLLOW );
        worker.backlog.emplace_back( activity_id( "ACT_WAIT" ), 100 );
    };
    prepare( native );
    prepare( fixture.other );
    REQUIRE_FALSE( fixture.other.activity );
    REQUIRE_FALSE( fixture.other.has_player_activity() );
    REQUIRE_FALSE( fixture.other.backlog.empty() );
    const npc_mission expected_mission = native.get_previous_mission();
    const npc_attitude expected_attitude = native.get_previous_attitude();
    native.revert_after_activity();
    cata::lua_platform::install_activity_api(
    fixture.services, [&]() {
        return fixture.runtime;
    },
    [&]() {
        return fixture.world;
    }, []() {}, []() {} );
    sol::protected_function restore = fixture.services["activities"]["revert_npc_job"];
    sol::protected_function_result call = restore( fixture.handle( true ) );
    REQUIRE( call.valid() );
    sol::table result = call;
    REQUIRE( result["ok"].get<bool>() );
    sol::table value = result["value"];
    CHECK( value["restored"].get<bool>() );
    CHECK_FALSE( value["changed"].get<bool>() );
    CHECK( fixture.other.mission == native.mission );
    CHECK( fixture.other.mission == expected_mission );
    CHECK( fixture.other.get_attitude() == native.get_attitude() );
    CHECK( fixture.other.get_attitude() == expected_attitude );
    CHECK( fixture.other.backlog.empty() );
    CHECK_FALSE( fixture.other.activity );
    CHECK( fixture.other.current_activity_id == native.current_activity_id );
    CHECK_FALSE( fixture.other.has_destination() );
}


TEST_CASE( "lua_platform_npc_jobs_match_native_assignment",
           "[lua][platform][activities][semantic]" )
{
    const std::vector<std::pair<std::string, void ( * )( npc & )>> jobs = {
        { "butcher", &talk_function::do_butcher },
        { "chop_planks", &talk_function::do_chop_plank },
        { "chop_trees", &talk_function::do_chop_trees },
        { "construction", &talk_function::do_construction },
        { "farming", &talk_function::do_farming },
        { "fishing", &talk_function::do_fishing },
        { "mining", &talk_function::do_mining },
        { "mopping", &talk_function::do_mopping },
        { "read_repeatedly", &talk_function::do_read_repeatedly },
        { "study", &talk_function::do_study },
        { "sort_loot", &talk_function::sort_loot },
        { "disassembly", &talk_function::do_disassembly },
        { "vehicle_deconstruct", &talk_function::do_vehicle_deconstruct },
        { "vehicle_repair", &talk_function::do_vehicle_repair }
    };
    for( const auto &job : jobs ) {
        CAPTURE( job.first );
        effect_fixture fixture;
        npc native;
        native.normalize();
        job.second( native );
        cata::lua_platform::install_activity_api(
        fixture.services, [&]() {
            return fixture.runtime;
        },
        [&]() {
            return fixture.world;
        }, []() {}, []() {} );
        sol::protected_function assign = fixture.services["activities"]["assign_npc_job"];
        sol::protected_function_result call = assign( fixture.handle( true ), job.first );
        REQUIRE( call.valid() );
        sol::table result = call;
        REQUIRE( result["ok"].get<bool>() );
        CHECK( fixture.other.activity.id() == native.activity.id() );
        CHECK( fixture.other.activity.moves_total == native.activity.moves_total );
        CHECK( fixture.other.activity.moves_left == native.activity.moves_left );
        REQUIRE( fixture.other.activity.actor );
        REQUIRE( native.activity.actor );
        CHECK( fixture.other.activity.actor->get_type() == native.activity.actor->get_type() );
        CHECK( fixture.other.mission == native.mission );
        CHECK( fixture.other.get_attitude() == native.get_attitude() );
        CHECK( fixture.other.current_activity_id == native.current_activity_id );
    }
}


TEST_CASE( "lua_platform_find_mount_no_match_restores_active_npc",
           "[lua][platform][activities][semantic]" )
{
    REQUIRE( g != nullptr );
    g->clear_zombies();
    for( const bool active : {
             false, true
         } ) {
        effect_fixture fixture;
        npc native;
        const auto prepare = [active]( npc & worker ) {
            worker.normalize();
            worker.set_mission( NPC_MISSION_GUARD );
            worker.set_attitude( NPCATT_FOLLOW );
            if( active ) {
                worker.assign_activity( wait_activity_actor( 100_turns ) );
                worker.set_mission( NPC_MISSION_ACTIVITY );
                worker.set_attitude( NPCATT_ACTIVITY );
            }
        };
        prepare( native );
        prepare( fixture.other );
        REQUIRE( fixture.other.has_player_activity() == active );
        talk_function::find_mount( native );
        cata::lua_platform::install_activity_api(
        fixture.services, [&]() {
            return fixture.runtime;
        },
        [&]() {
            return fixture.world;
        }, []() {}, []() {} );
        sol::protected_function assign = fixture.services["activities"]["assign_npc_job"];
        sol::protected_function_result call = assign( fixture.handle( true ), "find_mount" );
        REQUIRE( call.valid() );
        sol::table result = call;
        CHECK_FALSE( result["ok"].get<bool>() );
        sol::table error = result["error"];
        CHECK( error["code"].get<std::string>() == "no_match" );
        CHECK( fixture.other.activity.id() == native.activity.id() );
        CHECK( fixture.other.mission == native.mission );
        CHECK( fixture.other.get_attitude() == native.get_attitude() );
        CHECK( fixture.other.current_activity_id == native.current_activity_id );
    }
}


TEST_CASE( "lua_platform_seminar_checks_avatar_before_opening_selection",
           "[lua][platform][training]" )
{
    effect_fixture fixture;
    sol::table npcs = fixture.lua.create_table();
    cata::lua_platform::install_npc_domain_services(
    npcs, [&]() {
        return fixture.runtime;
    },
    [&]() {
        return fixture.world;
    }, []() {}, []() {} );
    sol::protected_function start = npcs["training"]["start_selected"];
    for( const std::string &mode : {
             std::string( "player" ), std::string( "seminar" ), std::string( "npc" )
         } ) {
        sol::protected_function_result call = start(
                fixture.handle( true ), fixture.handle( true ), mode );
        REQUIRE( call.valid() );
        sol::table result = call;
        REQUIRE_FALSE( result["ok"].get<bool>() );
        sol::table error = result["error"];
        CHECK( error["code"].get<std::string>() != "unsupported_target" );
        CHECK_FALSE( fixture.other.activity );
    }
    sol::protected_function_result call = start(
            fixture.handle( true ), fixture.handle( false ), "unknown" );
    REQUIRE( call.valid() );
    sol::table result = call;
    REQUIRE_FALSE( result["ok"].get<bool>() );
    sol::table error = result["error"];
    CHECK( error["code"].get<std::string>() == "unsupported_target" );
}


TEST_CASE( "lua_platform_trade_delegate_option_keeps_buyer_validation",
           "[lua][platform][trade]" )
{
    effect_fixture fixture;
    cata::lua_platform::install_trade_api(
    fixture.services, [&]() {
        return fixture.runtime;
    },
    [&]() {
        return fixture.world;
    }, []() {}, []() {} );
    sol::protected_function open = fixture.services["trade"]["open"];
    for( const int mode : {
             0, 1, 2
         } ) {
        sol::protected_function_result call = mode == 0 ?
                                              open( fixture.handle( true ), fixture.handle( true ), 0, "Trade" ) :
                                              open( fixture.handle( true ), fixture.handle( true ), 0, "Trade", mode == 2 );
        REQUIRE( call.valid() );
        sol::table result = call;
        REQUIRE_FALSE( result["ok"].get<bool>() );
        REQUIRE( result["error"].get<sol::table>().valid() );
    }
}


TEST_CASE( "lua_platform_wake_and_rule_reset_match_native_orders",
           "[lua][platform][npc][semantic]" )
{
    effect_fixture fixture;
    npc native;
    const auto prepare = []( npc & worker ) {
        worker.normalize();
        worker.rules.enable_override( ally_rule::allow_sleep );
        worker.rules.set_override( ally_rule::allow_sleep );
        for( const std::string id : {
                 "allow_sleep", "lying_down", "npc_suspend", "sleep"
             } ) {
            worker.add_effect( efftype_id( id ), 10_minutes );
        }
    };
    prepare( native );
    prepare( fixture.other );
    sol::table npcs = fixture.lua.create_table();
    cata::lua_platform::install_npc_domain_services(
    npcs, [&]() {
        return fixture.runtime;
    },
    [&]() {
        return fixture.world;
    }, []() {}, []() {} );
    sol::protected_function run = npcs["orders"]["run"];
    for( const std::string order : {
             "wake", "clear_temporary_rules"
         } ) {
        if( order == "wake" ) {
            talk_function::wake_up( native );
        } else {
            talk_function::clear_overrides( native );
        }
        sol::protected_function_result call = run( fixture.handle( true ), order );
        REQUIRE( call.valid() );
        sol::table result = call;
        REQUIRE( result["ok"].get<bool>() );
        for( const std::string id : {
                 "allow_sleep", "lying_down", "npc_suspend", "sleep"
             } ) {
            CHECK( fixture.other.has_effect( efftype_id( id ) ) == native.has_effect( efftype_id( id ) ) );
            CHECK_FALSE( fixture.other.has_effect( efftype_id( id ) ) );
        }
        CHECK( fixture.other.rules.has_override_enable( ally_rule::allow_sleep ) ==
               native.rules.has_override_enable( ally_rule::allow_sleep ) );
        CHECK( fixture.other.rules.has_override( ally_rule::allow_sleep ) ==
               native.rules.has_override( ally_rule::allow_sleep ) );
    }
}


TEST_CASE( "lua_platform_finish_dialogue_matches_native_topic_change",
           "[lua][platform][npc][semantic]" )
{
    effect_fixture fixture;
    npc native;
    native.normalize();
    native.chatbin.first_topic = "TALK_TEST";
    fixture.other.chatbin.first_topic = "TALK_TEST";
    native.set_attitude( NPCATT_FOLLOW );
    fixture.other.set_attitude( NPCATT_FOLLOW );
    talk_function::end_conversation( native );
    sol::table npcs = fixture.lua.create_table();
    cata::lua_platform::install_npc_domain_services(
    npcs, [&]() {
        return fixture.runtime;
    },
    [&]() {
        return fixture.world;
    }, []() {}, []() {} );
    sol::protected_function finish = npcs["dialogue"]["finish"];
    for( const bool first : {
             true, false
         } ) {
        sol::protected_function_result call = finish( fixture.handle( true ) );
        REQUIRE( call.valid() );
        sol::table result = call;
        REQUIRE( result["ok"].get<bool>() );
        sol::table value = result["value"];
        CHECK( value["changed"].get<bool>() == first );
        CHECK( value["topic_after"].get<std::string>() == "TALK_DONE" );
        CHECK( fixture.other.chatbin.first_topic == native.chatbin.first_topic );
        CHECK( fixture.other.get_attitude() == native.get_attitude() );
        CHECK( fixture.other.get_attitude() == NPCATT_FOLLOW );
    }
}


TEST_CASE( "lua_platform_combat_insult_matches_native_topic_and_attitude",
           "[lua][platform][npc][semantic]" )
{
    effect_fixture fixture;
    npc native;
    native.normalize();
    native.chatbin.first_topic = "TALK_TEST";
    fixture.other.chatbin.first_topic = "TALK_TEST";
    talk_function::insult_combat( native );
    sol::table npcs = fixture.lua.create_table();
    cata::lua_platform::install_npc_domain_services(
    npcs, [&]() {
        return fixture.runtime;
    },
    [&]() {
        return fixture.world;
    }, []() {}, []() {} );
    sol::protected_function provoke = npcs["dialogue"]["provoke_combat"];
    sol::protected_function_result call = provoke( fixture.handle( true ) );
    REQUIRE( call.valid() );
    sol::table result = call;
    REQUIRE( result["ok"].get<bool>() );
    CHECK( fixture.other.chatbin.first_topic == native.chatbin.first_topic );
    CHECK( fixture.other.chatbin.first_topic == "TALK_DONE" );
    CHECK( fixture.other.get_attitude() == native.get_attitude() );
    CHECK( fixture.other.get_attitude() == NPCATT_KILL );
}


TEST_CASE( "lua_platform_stop_following_and_neutral_match_native_state",
           "[lua][platform][npc][semantic]" )
{
    const bool allied = GENERATE( false, true );
    effect_fixture fixture;
    npc native;
    const auto prepare = [allied]( npc & worker ) {
        worker.normalize();
        if( allied ) {
            worker.set_fac( faction_id( "your_followers" ) );
        }
        worker.set_attitude( NPCATT_FOLLOW );
        worker.chatbin.first_topic = "TALK_TEST";
        worker.chatbin.talk_stranger_neutral = "TALK_STRANGER_NEUTRAL";
    };
    prepare( native );
    prepare( fixture.other );
    REQUIRE( fixture.other.is_player_ally() == allied );
    cata::lua_platform::install_npc_api(
    fixture.services, [&]() {
        return fixture.runtime;
    },
    [&]() {
        return fixture.world;
    }, []() {}, []() {}, []() {} );
    for( const std::string operation : {
             "stop_temporary_following", "make_neutral"
         } ) {
        native.name = "Test follower";
        fixture.other.name = "Test follower";
        Messages::clear_messages();
        if( operation == "stop_temporary_following" ) {
            talk_function::stop_following( native );
        } else {
            talk_function::stranger_neutral( native );
        }
        const auto expected_messages = Messages::recent_messages( 10 );
        Messages::clear_messages();
        sol::protected_function run = fixture.services["npcs"][operation];
        sol::protected_function_result call = run( fixture.handle( true ) );
        REQUIRE( call.valid() );
        sol::table result = call;
        REQUIRE( result["ok"].get<bool>() );
        CHECK( Messages::recent_messages( 10 ) == expected_messages );
        CHECK( expected_messages.size() ==
               ( operation == "stop_temporary_following" && allied ? 0 : 1 ) );
        Messages::clear_messages();
        CHECK( fixture.other.get_attitude() == native.get_attitude() );
        CHECK( fixture.other.chatbin.first_topic == native.chatbin.first_topic );
    }
}


TEST_CASE( "lua_platform_confrontation_preserves_native_messages_and_patience",
           "[lua][platform][npc][semantic]" )
{
    effect_fixture fixture;
    npc native;
    native.normalize();
    native.name = fixture.other.name = "Test confrontation";
    native.personality.aggression = fixture.other.personality.aggression = 7;
    native.patience = fixture.other.patience = 99;
    cata::lua_platform::install_npc_api(
    fixture.services, [&]() {
        return fixture.runtime;
    },
    [&]() {
        return fixture.world;
    }, []() {}, []() {}, []() {} );
    const std::vector<std::pair<std::string, void ( * )( npc & )>> operations = {
        { "start_fleeing", talk_function::flee },
        { "start_mugging", talk_function::start_mugging },
        { "warn_player_departure", talk_function::player_leaving }
    };
    for( const auto &operation : operations ) {
        Messages::clear_messages();
        operation.second( native );
        const auto expected_messages = Messages::recent_messages( 10 );
        Messages::clear_messages();
        sol::protected_function run = fixture.services["npcs"][operation.first];
        sol::protected_function_result call = run( fixture.handle( true ) );
        REQUIRE( call.valid() );
        sol::table result = call;
        REQUIRE( result["ok"].get<bool>() );
        CHECK( fixture.other.get_attitude() == native.get_attitude() );
        CHECK( fixture.other.patience == native.patience );
        CHECK( Messages::recent_messages( 10 ) == expected_messages );
        Messages::clear_messages();
    }
    CHECK( fixture.other.patience == 8 );
}

TEST_CASE( "lua_platform_stop_guard_matches_allied_and_independent_state",
           "[lua][platform][npc][semantic]" )
{
    const bool allied = GENERATE( false, true );
    effect_fixture fixture;
    npc native;
    const auto prepare = [allied]( npc & worker ) {
        worker.normalize();
        worker.name = "Test guard";
        if( allied ) {
            worker.set_fac( faction_id( "your_followers" ) );
        }
        worker.set_mission( allied ? NPC_MISSION_GUARD_ALLY : NPC_MISSION_GUARD );
        worker.set_attitude( NPCATT_NULL );
        worker.chatbin.first_topic = "TALK_TEST";
        worker.chatbin.talk_friend = "TALK_FRIEND";
        worker.goal = tripoint_abs_omt( 12, 13, 0 );
        worker.set_guard_pos( tripoint_abs_ms( 14, 15, 0 ) );
        worker.set_committed_goal( "guard_test" );
    };
    prepare( native );
    prepare( fixture.other );
    REQUIRE( fixture.other.is_player_ally() == allied );
    cata::lua_platform::install_npc_api(
    fixture.services, [&]() {
        return fixture.runtime;
    },
    [&]() {
        return fixture.world;
    }, []() {}, []() {}, []() {} );
    Messages::clear_messages();
    talk_function::stop_guard( native );
    const auto expected_messages = Messages::recent_messages( 10 );
    Messages::clear_messages();
    sol::protected_function stop = fixture.services["npcs"]["set_guarding"];
    sol::protected_function_result call = stop( fixture.handle( true ), false );
    REQUIRE( call.valid() );
    sol::table result = call;
    REQUIRE( result["ok"].get<bool>() );
    CHECK( fixture.other.get_attitude() == native.get_attitude() );
    CHECK( fixture.other.get_attitude() == ( allied ? NPCATT_FOLLOW : NPCATT_NULL ) );
    CHECK( fixture.other.mission == native.mission );
    CHECK( fixture.other.get_previous_mission() == native.get_previous_mission() );
    CHECK( fixture.other.chatbin.first_topic == native.chatbin.first_topic );
    CHECK( fixture.other.goal == native.goal );
    CHECK( fixture.other.get_guard_post() == native.get_guard_post() );
    CHECK( fixture.other.get_ai_guard_pos() == native.get_ai_guard_pos() );
    CHECK( fixture.other.get_committed_goal() == native.get_committed_goal() );
    CHECK( Messages::recent_messages( 10 ) == expected_messages );
    CHECK( expected_messages.size() == ( allied ? 1 : 0 ) );
    Messages::clear_messages();
}

TEST_CASE( "lua_platform_gratitude_matches_native_attitude_topic_and_bounds",
           "[lua][platform][npc][semantic]" )
{
    const npc_attitude attitude = GENERATE( NPCATT_NULL, NPCATT_FOLLOW, NPCATT_MUG,
                                            NPCATT_WAIT_FOR_LEAVE, NPCATT_FLEE, NPCATT_KILL,
                                            NPCATT_FLEE_TEMP );
    const int aggression = GENERATE( NPC_PERSONALITY_MIN, 0, NPC_PERSONALITY_MAX );
    const bool friend_topic = GENERATE( false, true );
    effect_fixture fixture;
    npc native;
    const auto prepare = [&]( npc & worker ) {
        worker.normalize();
        worker.set_attitude( attitude );
        worker.personality.aggression = aggression;
        worker.chatbin.talk_friend = "TALK_FRIEND";
        worker.chatbin.talk_stranger_friendly = "TALK_STRANGER_FRIENDLY";
        worker.chatbin.first_topic = friend_topic ? "TALK_FRIEND" : "TALK_TEST";
    };
    prepare( native );
    prepare( fixture.other );
    talk_function::npc_thankful( native );
    cata::lua_platform::install_npc_api(
    fixture.services, [&]() {
        return fixture.runtime;
    },
    [&]() {
        return fixture.world;
    }, []() {}, []() {}, []() {} );
    sol::protected_function run = fixture.services["npcs"]["make_thankful"];
    sol::protected_function_result call = run( fixture.handle( true ) );
    REQUIRE( call.valid() );
    sol::table result = call;
    REQUIRE( result["ok"].get<bool>() );
    CHECK( fixture.other.get_attitude() == native.get_attitude() );
    CHECK( fixture.other.chatbin.first_topic == native.chatbin.first_topic );
    CHECK( fixture.other.personality.aggression == native.personality.aggression );
    CHECK( fixture.other.personality.aggression >= NPC_PERSONALITY_MIN );
}

TEST_CASE( "lua_platform_control_rejection_preserves_identity_and_handles",
           "[lua][platform][npc][semantic]" )
{
    effect_fixture fixture;
    REQUIRE_FALSE( fixture.other.is_player_ally() );
    const character_id avatar_id = fixture.player.getID();
    const character_id npc_id = fixture.other.getID();
    const npc_attitude attitude = fixture.other.get_attitude();
    const faction_id faction = fixture.other.get_fac_id();
    int invalidations = 0;
    cata::lua_platform::install_npc_api(
    fixture.services, [&]() {
        return fixture.runtime;
    },
    [&]() {
        return fixture.world;
    }, []() {}, []() {}, [&]() {
        ++invalidations;
    } );
    sol::protected_function take = fixture.services["npcs"]["take_control"];
    for( const bool wrong_owner : {
             false, true
         } ) {
        sol::protected_function_result call = take(
                fixture.handle( true ), fixture.handle( wrong_owner ) );
        REQUIRE( call.valid() );
        sol::table result = call;
        REQUIRE_FALSE( result["ok"].get<bool>() );
        sol::table error = result["error"];
        CHECK( error["code"].get<std::string>() ==
               ( wrong_owner ? "wrong_subtype" : "not_an_ally" ) );
    }
    sol::protected_function menu = fixture.services["npcs"]["open_control_menu"];
    sol::protected_function_result call = menu( fixture.handle( true ) );
    REQUIRE( call.valid() );
    sol::table result = call;
    REQUIRE_FALSE( result["ok"].get<bool>() );
    sol::table error = result["error"];
    CHECK( error["code"].get<std::string>() == "wrong_subtype" );
    CHECK( invalidations == 0 );
    CHECK( fixture.player.getID() == avatar_id );
    CHECK( fixture.other.getID() == npc_id );
    CHECK( fixture.other.get_attitude() == attitude );
    CHECK( fixture.other.get_fac_id() == faction );
}

TEST_CASE( "lua_platform_purchased_pet_matches_native_spawn_and_disposition",
           "[lua][platform][npc][semantic]" )
{
    const std::string species = GENERATE( "mon_chicken", "mon_horse", "mon_cow" );
    clear_map();
    effect_fixture fixture;
    fixture.other.setpos( get_map(), tripoint_bub_ms( 60, 60, 0 ) );
    const efftype_id pet_effect( "pet" );
    rng_set_engine_seed( 58163 );
    if( species == "mon_chicken" ) {
        talk_function::buy_chicken( fixture.other );
    } else if( species == "mon_horse" ) {
        talk_function::buy_horse( fixture.other );
    } else {
        talk_function::buy_cow( fixture.other );
    }
    std::vector<monster *> native_pets;
    for( monster &entry : g->all_monsters() ) {
        native_pets.push_back( &entry );
    }
    REQUIRE( native_pets.size() == 1 );
    const tripoint_abs_ms expected_position = native_pets.front()->pos_abs();
    const int expected_friendly = native_pets.front()->friendly;
    const time_duration expected_duration = native_pets.front()->get_effect_dur( pet_effect );
    const bool expected_permanent = native_pets.front()->get_effect( pet_effect ).is_permanent();
    g->clear_zombies();
    cata::lua_platform::install_game_world_service_api(
    fixture.services, [&]() {
        return fixture.runtime;
    }, [&]() {
        return fixture.world;
    }, []() {}, []() {}, []() {}, []() {
        return true;
    } );
    cata::lua_platform::install_creature_api(
    fixture.services, [&]() {
        return fixture.runtime;
    }, [&]() {
        return fixture.world;
    }, []() {}, []() {} );
    sol::protected_function spawn = fixture.services["spawns"]["monster"];
    const auto position = cata::lua_platform::script_tripoint_coord::from_native(
                              coords::origin::abs, coords::scale::map_square,
                              fixture.other.pos_abs().raw() );
    rng_set_engine_seed( 58163 );
    sol::protected_function_result call = spawn(
            cata::lua_platform::script_game_id( "monster", species ), position, 1, false );
    REQUIRE( call.valid() );
    sol::table result = call;
    REQUIRE( result["ok"].get<bool>() );
    sol::table value = result["value"];
    const auto handle = value["handle"].get<cata::lua_platform::game_handle>();
    sol::protected_function friendly = fixture.services["monsters"]["set_friendly"];
    sol::protected_function_result friend_call = friendly( handle, true );
    REQUIRE( friend_call.valid() );
    sol::table friend_result = friend_call;
    REQUIRE( friend_result["ok"].get<bool>() );
    sol::table options = fixture.lua.create_table();
    options["permanent"] = true;
    sol::protected_function add = fixture.services["effects"]["add"];
    sol::protected_function_result effect_call = add(
                handle, cata::lua_platform::script_game_id( "effect", "pet" ),
                cata::lua_platform::script_time_duration::from_native( 1_turns ), options );
    REQUIRE( effect_call.valid() );
    sol::table effect_result = effect_call;
    REQUIRE( effect_result["ok"].get<bool>() );
    std::optional<cata::lua_platform::game_handle_error> error;
    monster *actual = cata::lua_platform::resolve_exact_monster(
                          handle, fixture.runtime, fixture.world, error );
    REQUIRE( actual != nullptr );
    CHECK( actual->type->id.str() == species );
    CHECK( actual->pos_abs() == expected_position );
    CHECK( actual->friendly == expected_friendly );
    CHECK( actual->get_effect_dur( pet_effect ) == expected_duration );
    CHECK( actual->get_effect( pet_effect ).is_permanent() == expected_permanent );
    g->clear_zombies();
}

TEST_CASE( "lua_platform_spawn_upgrade_option_preserves_default_and_explicit_disable",
           "[lua][platform][spawn][semantic]" )
{
    const int mode = GENERATE( 0, 1, 2 ); // omitted, explicit true, explicit false
    clear_map();
    g->clear_zombies();
    override_option evolution( "EVOLUTION_INVERSE_MULTIPLIER", "4.0" );
    effect_fixture fixture;
    cata::lua_platform::install_game_world_service_api(
    fixture.services, [&]() {
        return fixture.runtime;
    }, [&]() {
        return fixture.world;
    }, []() {}, []() {}, []() {}, []() {
        return true;
    } );
    const auto position = cata::lua_platform::script_tripoint_coord::from_native(
                              coords::origin::abs, coords::scale::map_square,
                              get_map().get_abs( get_avatar().pos_bub() + point::east ).raw() );
    sol::protected_function spawn = fixture.services["spawns"]["monster"];
    const cata::lua_platform::script_game_id type( "monster", "mon_test_zombie" );
    rng_set_engine_seed( 58163 );
    sol::protected_function_result call = mode == 0 ? spawn( type, position, 0 ) :
                                          spawn( type, position, 0, mode == 1 );
    REQUIRE( call.valid() );
    sol::table result = call;
    REQUIRE( result["ok"].get<bool>() );
    sol::table value = result["value"];
    const auto handle = value["handle"].get<cata::lua_platform::game_handle>();
    std::optional<cata::lua_platform::game_handle_error> error;
    monster *actual = cata::lua_platform::resolve_exact_monster(
                          handle, fixture.runtime, fixture.world, error );
    REQUIRE( actual != nullptr );
    if( mode == 2 ) {
        REQUIRE( actual->can_upgrade() );
        CHECK( actual->type->id == mtype_id( "mon_test_zombie" ) );
        CHECK( actual->get_upgrade_time() == -1 );
    } else {
        CHECK( actual->get_upgrade_time() >= 0 );
    }
    g->clear_zombies();
}

TEST_CASE( "lua_platform_refusal_cooldowns_match_native_repeated_requests",
           "[lua][platform][npc][semantic]" )
{
    const int index = GENERATE( 0, 1, 2, 3, 4 );
    const std::vector<std::string> requests = { "follow", "lead", "equipment", "training", "personal_info" };
    const std::vector<efftype_id> effects = {
        efftype_id( "asked_to_follow" ), efftype_id( "asked_to_lead" ),
        efftype_id( "asked_for_item" ), efftype_id( "asked_to_train" ),
        efftype_id( "asked_personal_info" )
    };
    const std::vector<void ( * )( npc & )> native_calls = {
        talk_function::deny_follow, talk_function::deny_lead, talk_function::deny_equipment,
        talk_function::deny_train, talk_function::deny_personal_info
    };
    effect_fixture fixture;
    npc native;
    native.normalize();
    cata::lua_platform::install_npc_api(
    fixture.services, [&]() {
        return fixture.runtime;
    }, [&]() {
        return fixture.world;
    }, []() {}, []() {}, []() {} );
    sol::protected_function record = fixture.services["npcs"]["record_refusal"];
    for( int repetition = 0; repetition < 2; ++repetition ) {
        native_calls[index]( native );
        sol::protected_function_result call = record( fixture.handle( true ), requests[index] );
        REQUIRE( call.valid() );
        sol::table result = call;
        REQUIRE( result["ok"].get<bool>() );
        sol::table value = result["value"];
        CHECK( value["already_active"].get<bool>() == ( repetition != 0 ) );
        CHECK( fixture.other.has_effect( effects[index] ) );
        CHECK( fixture.other.get_effect_dur( effects[index] ) == native.get_effect_dur( effects[index] ) );
        CHECK( fixture.other.get_effect( effects[index] ).is_permanent() ==
               native.get_effect( effects[index] ).is_permanent() );
    }
}

TEST_CASE( "lua_platform_radio_registration_retains_other_representatives",
           "[lua][platform][npc][semantic]" )
{
    effect_fixture fixture;
    fixture.other.faction_representative = false;
    const character_id existing( 9991 );
    fixture.player.faction_representatives.insert( existing );
    cata::lua_platform::install_npc_api(
    fixture.services, [&]() {
        return fixture.runtime;
    }, [&]() {
        return fixture.world;
    }, []() {}, []() {}, []() {} );
    sol::protected_function register_rep = fixture.services["npcs"]["set_radio_representative"];
    for( int repetition = 0; repetition < 2; ++repetition ) {
        sol::protected_function_result call = register_rep(
                fixture.handle( true ), fixture.handle( false ), true );
        REQUIRE( call.valid() );
        sol::table result = call;
        REQUIRE( result["ok"].get<bool>() );
        sol::table value = result["value"];
        CHECK( value["changed"].get<bool>() == ( repetition == 0 ) );
        CHECK( fixture.other.faction_representative );
        CHECK( fixture.player.faction_representatives.count( existing ) == 1 );
        CHECK( fixture.player.faction_representatives.count( fixture.other.getID() ) == 1 );
        CHECK( fixture.player.faction_representatives.size() == 2 );
    }
}

TEST_CASE( "lua_platform_visible_allies_matches_scene_visibility_and_order",
           "[lua][platform][npc][semantic]" )
{
    clear_map();
    clear_avatar();
    const time_point previous_turn = calendar::turn;
    struct cleanup_scene {
        time_point turn;
        ~cleanup_scene() {
            get_avatar().remove_effect( efftype_id( "blind" ) );
            clear_npcs();
            calendar::turn = turn;
        }
    } cleanup{ previous_turn };
    calendar::turn = calendar::turn_zero + 12_hours;
    avatar &player = get_avatar();
    npc &first = spawn_npc( player.pos_bub().xy() + point( 2, 0 ), "test_talker" );
    npc &second = spawn_npc( player.pos_bub().xy() + point( 0, 2 ), "test_talker" );
    npc &stranger = spawn_npc( player.pos_bub().xy() + point( -2, 0 ), "test_talker" );
    first.set_fac( faction_id( "your_followers" ) );
    second.set_fac( faction_id( "your_followers" ) );
    stranger.set_fac( faction_id( "no_faction" ) );
    REQUIRE_FALSE( stranger.is_player_ally() );
    get_map().build_map_cache( player.pos_bub().z() );
    REQUIRE( get_player_view().sees( get_map(), first ) );
    REQUIRE( get_player_view().sees( get_map(), second ) );
    std::vector<int> expected;
    for( npc &candidate : g->all_npcs() ) {
        if( candidate.is_player_ally() && get_player_view().sees( get_map(), candidate ) ) {
            expected.push_back( candidate.getID().get_value() );
        }
    }
    REQUIRE( expected.size() == 2 );
    effect_fixture fixture;
    bool readable = true;
    cata::lua_platform::install_npc_api(
    fixture.services, [&]() {
        return fixture.runtime;
    }, [&]() {
        return fixture.world;
    }, [&]() {
        if( !readable ) {
            throw std::runtime_error( "read denied" );
        }
    }, []() {}, []() {} );
    sol::protected_function query = fixture.services["npcs"]["visible_allies"];
    sol::protected_function_result call = query();
    REQUIRE( call.valid() );
    sol::table result = call;
    REQUIRE( result["ok"].get<bool>() );
    sol::table items = result["value"];
    REQUIRE( items.size() == expected.size() );
    for( std::size_t i = 0; i < expected.size(); ++i ) {
        sol::table entry = items[i + 1];
        CHECK( entry["id"].get<int>() == expected[i] );
        const auto handle = entry["handle"].get<cata::lua_platform::game_handle>();
        CHECK_FALSE( handle.validation_error( fixture.runtime, fixture.world ).has_value() );
    }
    player.add_effect( efftype_id( "blind" ), 1_hours );
    REQUIRE_FALSE( get_player_view().sees( get_map(), first ) );
    REQUIRE_FALSE( get_player_view().sees( get_map(), second ) );
    sol::protected_function_result blind_call = query();
    REQUIRE( blind_call.valid() );
    sol::table blind_result = blind_call;
    REQUIRE( blind_result["ok"].get<bool>() );
    CHECK( blind_result["value"].get<sol::table>().size() == 0 );
    CHECK( items.size() == expected.size() ); // Detached snapshot remains unchanged.
    readable = false;
    CHECK_FALSE( query().valid() );
}

TEST_CASE( "lua_platform_rule_menus_reject_wrong_or_stale_targets_before_ui",
           "[lua][platform][npc][semantic]" )
{
    effect_fixture fixture;
    cata::lua_platform::install_npc_api(
    fixture.services, [&]() {
        return fixture.runtime;
    }, [&]() {
        return fixture.world;
    }, []() {}, []() {}, []() {} );
    sol::protected_function rules = fixture.services["npcs"]["open_rules"];
    sol::protected_function pickup = fixture.services["npcs"]["orders"]["open_pickup_rules"];
    for( const sol::protected_function &menu : {
             rules, pickup
         } ) {
        sol::protected_function_result call = menu( fixture.handle( false ) );
        REQUIRE( call.valid() );
        sol::table result = call;
        CHECK_FALSE( result["ok"].get<bool>() );
        CHECK( result["error"]["code"].get<std::string>() == "wrong_subtype" );
    }
    const auto stale = fixture.handle( true );
    ++fixture.world;
    for( const sol::protected_function &menu : {
             rules, pickup
         } ) {
        sol::protected_function_result call = menu( stale );
        REQUIRE( call.valid() );
        sol::table result = call;
        CHECK_FALSE( result["ok"].get<bool>() );
    }
}

TEST_CASE( "lua_platform_player_services_reject_a_different_avatar",
           "[lua][platform][npc][semantic]" )
{
    effect_fixture fixture;
    REQUIRE( &fixture.player != &get_avatar() );
    cata::lua_platform::install_npc_api(
    fixture.services, [&]() {
        return fixture.runtime;
    }, [&]() {
        return fixture.world;
    }, []() {}, []() {}, []() {} );
    sol::protected_function repair = fixture.services["npcs"]["medical"]["repair_bionic_limbs"];
    const int moves_before = get_avatar().get_moves();
    const int debt_before = fixture.other.op_of_u.owed;
    sol::protected_function_result call = repair( fixture.handle( true ), fixture.handle( false ) );
    REQUIRE( call.valid() );
    sol::table result = call;
    CHECK_FALSE( result["ok"].get<bool>() );
    CHECK( result["error"]["code"].get<std::string>() == "invalid_patient" );
    CHECK( get_avatar().get_moves() == moves_before );
    CHECK( fixture.other.op_of_u.owed == debt_before );
    const auto rejected = []( sol::protected_function_result call ) {
        REQUIRE( call.valid() );
        sol::table result = call;
        CHECK_FALSE( result["ok"].get<bool>() );
        CHECK( result["error"]["code"].get<std::string>() == "invalid_patient" );
    };
    sol::protected_function training = fixture.services["npcs"]["training"]["start_selected"];
    for( const std::string mode : {
             "player", "npc", "seminar"
         } ) {
        rejected( training( fixture.handle( true ), fixture.handle( false ), mode ) );
    }
    sol::protected_function aid = fixture.services["npcs"]["medical"]["provide_aid"];
    for( const std::string level : {
             "basic", "advanced"
         } ) {
        for( const bool allies : {
                 false, true
             } ) {
            rejected( aid( fixture.handle( true ), fixture.handle( false ), level, allies ) );
        }
    }
    sol::protected_function style = fixture.services["npcs"]["grooming"]["open_style"];
    for( const std::string area : {
             "hair", "beard"
         } ) {
        rejected( style( fixture.handle( true ), fixture.handle( false ), area ) );
    }
    sol::protected_function groom = fixture.services["npcs"]["grooming"]["provide"];
    for( const std::string kind : {
             "haircut", "shave"
         } ) {
        rejected( groom( fixture.handle( true ), fixture.handle( false ), kind ) );
    }
    CHECK( get_avatar().get_moves() == moves_before );
    CHECK( fixture.other.op_of_u.owed == debt_before );
}

TEST_CASE( "lua_platform_bionic_service_preserves_native_patient_domain",
           "[lua][platform][npc][semantic]" )
{
    effect_fixture fixture;
    fixture.other.set_fac( faction_id( "no_faction" ) );
    REQUIRE_FALSE( fixture.other.is_player_ally() );
    REQUIRE( fixture.other.num_bionics() == 0 );
    REQUIRE( fixture.player.num_bionics() == 0 );
    bool writable = true;
    cata::lua_platform::install_npc_api(
    fixture.services, [&]() {
        return fixture.runtime;
    }, [&]() {
        return fixture.world;
    }, []() {}, [&]() {
        if( !writable ) {
            throw std::runtime_error( "write denied" );
        }
    }, []() {} );
    sol::protected_function service = fixture.services["npcs"]["medical"]["open_bionic_service"];
    // No installed bionics: native removal shows a notice and returns without
    // a selection menu. Popup is noninteractive in test_mode.
    for( const bool npc_patient : {
             false, true
         } ) {
        const int moves = fixture.target( npc_patient ).get_moves();
        sol::protected_function_result call = service(
                fixture.handle( true ), "remove", fixture.handle( npc_patient ) );
        REQUIRE( call.valid() );
        sol::table result = call;
        REQUIRE( result["ok"].get<bool>() );
        CHECK_FALSE( result["value"]["changed"].get<bool>() );
        CHECK( fixture.target( npc_patient ).num_bionics() == 0 );
        CHECK( fixture.target( npc_patient ).get_moves() == moves );
    }
    const auto stale = fixture.handle( true );
    ++fixture.world;
    sol::protected_function_result stale_call = service( stale, "remove", fixture.handle( false ) );
    REQUIRE( stale_call.valid() );
    sol::table stale_result = stale_call;
    CHECK_FALSE( stale_result["ok"].get<bool>() );
    writable = false;
    CHECK_FALSE( service( fixture.handle( true ), "remove", fixture.handle( true ) ).valid() );
}

TEST_CASE( "lua_platform_copy_rules_does_not_re_equip_or_spend_moves",
           "[lua][platform][npc][semantic]" )
{
    effect_fixture target;
    effect_fixture source( 3200 );
    target.other.remove_weapon();
    target.other.inv->add_item( item( itype_id( "katana" ), calendar::turn ), false, false, false );
    REQUIRE_FALSE( target.other.get_wielded_item() );
    // The old wrapper called wield_better_weapon after copying, even on self-copy.
    REQUIRE( target.other.evaluate_best_weapon() != &null_item_reference() );
    source.other.rules.set_flag( ally_rule::allow_sleep );
    target.other.rules.clear_flag( ally_rule::allow_sleep );
    cata::lua_platform::install_npc_api(
    target.services, [&]() {
        return target.runtime;
    }, [&]() {
        return target.world;
    }, []() {}, []() {}, []() {} );
    const auto source_handle = cata::lua_platform::game_handle::from_creature(
                                   source.other,
    { "npc", source.other.getID().get_value(), 0, 0, 0, {} },
    target.runtime, target.world );
    sol::protected_function copy = target.services["npcs"]["copy_ai_rules"];
    const int moves_before = target.other.get_moves();
    for( const auto &from : {
             source_handle, target.handle( true )
         } ) {
        sol::protected_function_result call = copy( target.handle( true ), from );
        REQUIRE( call.valid() );
        sol::table result = call;
        REQUIRE( result["ok"].get<bool>() );
        CHECK( target.other.rules.has_flag( ally_rule::allow_sleep ) );
        CHECK_FALSE( target.other.get_wielded_item() );
        CHECK( target.other.get_moves() == moves_before );
    }
}

TEST_CASE( "lua_platform_request_talk_repeated_request_has_no_notification",
           "[lua][platform][npc][semantic]" )
{
    effect_fixture fixture;
    fixture.other.set_attitude( NPCATT_TALK );
    fixture.other.chatbin.first_topic = "TALK_TEST";
    cata::lua_platform::install_npc_api(
    fixture.services, [&]() {
        return fixture.runtime;
    }, [&]() {
        return fixture.world;
    }, []() {}, []() {}, []() {} );
    Messages::clear_messages();
    sol::protected_function request = fixture.services["npcs"]["request_talk"];
    sol::protected_function_result call = request( fixture.handle( true ) );
    REQUIRE( call.valid() );
    sol::table result = call;
    REQUIRE( result["ok"].get<bool>() );
    sol::table value = result["value"];
    CHECK_FALSE( value["changed"].get<bool>() );
    CHECK( fixture.other.get_attitude() == NPCATT_TALK );
    CHECK( fixture.other.chatbin.first_topic == "TALK_TEST" );
    CHECK( Messages::recent_messages( 10 ).empty() );
    Messages::clear_messages();
}

TEST_CASE( "lua_platform_intimidation_reads_exact_live_actor_and_stimulant_change",
           "[lua][platform][character][semantic]" )
{
    effect_fixture fixture;
    cata::lua_platform::install_creature_api(
    fixture.services, [&]() {
        return fixture.runtime;
    }, [&]() {
        return fixture.world;
    }, []() {}, []() {
        FAIL( "Reading intimidation must not enter the write gate" );
    } );
    const bool npc_target = GENERATE( false, true );
    Character &target = npc_target ? static_cast<Character &>( fixture.other ) : fixture.player;
    target.set_stim( 0 );
    const int baseline = target.intimidation();
    const auto handle = fixture.handle( npc_target );
    sol::protected_function query = fixture.services["characters"]["intimidation"];
    const auto read = [&]() {
        const auto call = query( handle );
        REQUIRE( call.valid() );
        const sol::table result = call.get<sol::table>();
        REQUIRE( result["ok"].get<bool>() );
        return result["value"].get<int>();
    };
    CHECK( read() == baseline );
    target.set_stim( 21 );
    CHECK( read() == baseline + 2 );
    target.set_stim( 20 );
    CHECK( read() == baseline );
    ++fixture.world;
    const auto stale = query( handle );
    REQUIRE( stale.valid() );
    CHECK_FALSE( stale.get<sol::table>()["ok"].get<bool>() );
}

TEST_CASE( "lua_platform_selling_offers_match_native_items_and_prices",
           "[lua][platform][trade][semantic]" )
{
    effect_fixture fixture;
    fixture.other.set_fac( faction_id( "your_followers" ) );
    item stock( itype_id( "rock" ), calendar::turn );
    stock.set_owner( fixture.other );
    fixture.other.i_add( stock );
    std::vector<item_pricing> expected = npc_trading::init_selling( fixture.other );
    REQUIRE_FALSE( expected.empty() );
    cata::lua_platform::install_trade_api(
    fixture.services, [&]() {
        return fixture.runtime;
    }, [&]() {
        return fixture.world;
    }, []() {}, []() {} );
    sol::protected_function list = fixture.services["trade"]["selling_offers"];
    sol::protected_function_result call = list( fixture.handle( true ) );
    REQUIRE( call.valid() );
    sol::table result = call;
    REQUIRE( result["ok"].get<bool>() );
    sol::table offers = result["value"];
    REQUIRE( offers.size() == expected.size() );
    for( std::size_t i = 0; i < expected.size(); ++i ) {
        sol::table offer = offers[i + 1];
        const auto handle = offer["item"].get<cata::lua_platform::game_handle>();
        const auto resolved = handle.resolve_item( fixture.runtime, fixture.world );
        REQUIRE( resolved );
        CHECK( resolved.value == expected[i].loc.get_item() );
        CHECK( offer["item_name"].get<std::string>() == resolved.value->tname() );
        CHECK( offer["quantity"].get<int>() ==
               ( resolved.value->count_by_charges() ? resolved.value->charges : 1 ) );
        CHECK( offer["price"].get<double>() == expected[i].price );
        CHECK( offer["count"].get<int>() == expected[i].count );
        CHECK( offer["charges"].get<int>() == expected[i].charges );
    }
}

TEST_CASE( "lua_platform_temporary_follow_clears_native_guard_state",
           "[lua][platform][npc][semantic]" )
{
    effect_fixture fixture;
    npc native;
    const auto prepare = []( npc & worker ) {
        worker.normalize();
        worker.set_mission( NPC_MISSION_GUARD );
        worker.goal = tripoint_abs_omt( 12, 13, 0 );
        worker.set_guard_pos( tripoint_abs_ms( 14, 15, 0 ) );
        worker.set_committed_goal( "guard_test" );
        worker.cash = 123;
        worker.custom_profession = "Retained profession";
    };
    prepare( native );
    prepare( fixture.other );
    const faction_id original_faction = fixture.other.get_fac_id();
    talk_function::follow_only( native );
    cata::lua_platform::install_npc_api(
    fixture.services, [&]() {
        return fixture.runtime;
    },
    [&]() {
        return fixture.world;
    }, []() {}, []() {}, []() {} );
    sol::protected_function follow = fixture.services["npcs"]["follow_temporarily"];
    sol::protected_function_result call = follow( fixture.handle( true ) );
    REQUIRE( call.valid() );
    sol::table result = call;
    REQUIRE( result["ok"].get<bool>() );
    CHECK( fixture.other.get_attitude() == native.get_attitude() );
    CHECK( fixture.other.mission == native.mission );
    CHECK( fixture.other.get_previous_mission() == native.get_previous_mission() );
    CHECK( fixture.other.goal == native.goal );
    CHECK( fixture.other.get_guard_post() == native.get_guard_post() );
    CHECK( fixture.other.get_ai_guard_pos() == native.get_ai_guard_pos() );
    CHECK( fixture.other.get_committed_goal() == native.get_committed_goal() );
    CHECK( fixture.other.get_committed_goal().empty() );
    CHECK( fixture.other.get_fac_id() == original_faction );
    CHECK( fixture.other.cash == 123 );
    CHECK( fixture.other.custom_profession == "Retained profession" );
}

#endif
