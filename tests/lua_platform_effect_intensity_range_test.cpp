#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <cstdint>
#include <limits>
#include <memory>
#include <string>
#include <vector>

#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character_id.h"
#include "condition.h"
#include "dialogue.h"
#include "dialogue_helpers.h"
#include "effect.h"
#include "json_loader.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"
#include "lua_platform_npcs.h"
#include "lua_platform_runtime.h"
#include "lua_platform_runtime_internal.h"
#include "lua_platform_sol.h"
#include "map_helpers.h"
#include "npc.h"
#include "npctalk.h"
#include "type_id.h"
#include "units.h"

namespace
{

// catch_up has int_add_val=1 and max_intensity=15, so stacking is observable.
const efftype_id effect_catch_up( "catch_up" );

struct effect_intensity_fixture {
    explicit effect_intensity_fixture( const int first_id ) {
        native_speaker.normalize();
        native_speaker.setID( character_id( first_id + 1 ), true );
        native_interlocutor.normalize();
        native_interlocutor.setID( character_id( first_id + 2 ), true );

        platform_interlocutor.normalize();
        platform_interlocutor.setID( character_id( first_id + 3 ), true );
        cata::lua_platform::register_npc_handle_identity( platform_interlocutor );

        lua.open_libraries( sol::lib::base );
        ccb = lua.create_table();
        runtime_owner = cata::lua_platform::make_runtime(
                            "effect_intensity_range", first_id, lua );
        cata::lua_platform::install_runtime_api( runtime_owner, lua, ccb );
        lua["ccb"] = ccb;
        cata::lua_platform::set_active_runtimes( { runtime_owner } );
        cata::lua_platform::runtime_world_ready( true );

        const cata::lua_platform::game_handle_runtime runtime_identity =
            cata::lua_platform::detail::runtime_handle_identity( runtime_owner );
        const cata::lua_platform::game_handle_locator locator = {
            "npc", platform_interlocutor.getID().get_value(), 0, 0, 0, {}
        };
        platform_handle = cata::lua_platform::game_handle::from_creature(
                              platform_interlocutor, locator, runtime_identity,
                              cata::lua_platform::runtime_world_generation() );
    }

    ~effect_intensity_fixture() {
        cata::lua_platform::clear_active_runtimes();
        cata::lua_platform::retire_npc_handle_identity( platform_interlocutor );
    }

    void seed_existing_effect( const int intensity ) {
        native_interlocutor.add_effect( effect_catch_up, 20_turns, false, intensity, true );
        platform_interlocutor.add_effect( effect_catch_up, 20_turns, false, intensity, true );
    }

    void apply_native( const int intensity, const int duration = 1 ) {
        dialogue conversation(
            get_talker_for( native_speaker ), get_talker_for( native_interlocutor ) );
        const std::string source =
            R"({"npc_add_effect":"catch_up","duration":)" +
            std::to_string( duration ) + R"(,"intensity":)" +
            std::to_string( intensity ) + "}";
        talk_effect_t native_effect;
        native_effect.parse_sub_effect(
            json_loader::from_string( source ).get_object(), "effect_intensity_range_test" );
        finalize_conditions();
        for( const talk_effect_fun_t &operation : native_effect.effects ) {
            operation( conversation );
        }
    }

    sol::protected_function_result apply_platform( const std::int64_t intensity,
            const std::int64_t duration = 1 ) {
        lua["effect_target"] = platform_handle;
        lua["requested_intensity"] = intensity;
        lua["requested_duration"] = duration;
        return [this]() {
            cata::lua_platform::detail::callback_scope callback( *runtime_owner );
            return lua.safe_script( R"(
                return ccb.services.effects.add(
                    effect_target,
                    ccb.services.types.id("effect", "catch_up"),
                    ccb.services.time.duration(requested_duration, "turn"),
                    { intensity = requested_intensity })
            )", sol::script_pass_on_error );
        }
        ();
    }

    avatar native_speaker;
    npc native_interlocutor;
    npc platform_interlocutor;
    sol::state lua;
    sol::table ccb;
    std::shared_ptr<cata::lua_platform::runtime> runtime_owner;
    cata::lua_platform::game_handle platform_handle;
};

struct effect_intensity_case {
    int initial_intensity;
    int requested_intensity;
};

} // namespace

TEST_CASE( "lua_platform_effect_add_accepts_native_signed_intensities",
           "[lua][platform][effects][semantic]" )
{
    cata::lua_platform::clear_active_runtimes();
    clear_map_without_vision();
    on_out_of_scope cleanup( []() {
        cata::lua_platform::clear_active_runtimes();
        clear_map_without_vision();
    } );

    REQUIRE( effect_catch_up.is_valid() );
    const std::vector<effect_intensity_case> cases = {
        { 0, std::numeric_limits<int>::min() },
        { 0, -1000001 },
        { 0, 1000001 },
        { 0, std::numeric_limits<int>::max() },
        { 2, std::numeric_limits<int>::min() },
        { 2, -1000001 },
        { 2, 0 },
        { 2, 1000001 },
        { 2, std::numeric_limits<int>::max() },
    };

    int fixture_index = 0;
    for( const effect_intensity_case &test_case : cases ) {
        CAPTURE( test_case.initial_intensity, test_case.requested_intensity );
        effect_intensity_fixture fixture( 8600 + fixture_index * 10 );
        if( test_case.initial_intensity > 0 ) {
            fixture.seed_existing_effect( test_case.initial_intensity );
        }

        fixture.apply_native( test_case.requested_intensity );
        const sol::protected_function_result call =
            fixture.apply_platform( test_case.requested_intensity );
        REQUIRE( call.valid() );
        const sol::table result = call;
        REQUIRE( result["ok"].get<bool>() );

        const effect &native = fixture.native_interlocutor.get_effect( effect_catch_up );
        const effect &platform = fixture.platform_interlocutor.get_effect( effect_catch_up );
        REQUIRE_FALSE( native.is_null() );
        REQUIRE_FALSE( platform.is_null() );
        CHECK( platform.get_intensity() == native.get_intensity() );
        CHECK( platform.get_duration() == native.get_duration() );
        const int expected_intensity = test_case.initial_intensity == 0 ?
                                       ( test_case.requested_intensity <= 0 ? 1 : 15 ) :
                                       ( test_case.requested_intensity <= 0 ? 3 : 15 );
        CHECK( native.get_intensity() == expected_intensity );
        ++fixture_index;
    }
}

TEST_CASE( "lua_platform_effect_add_rejects_intensities_outside_native_int_without_mutation",
           "[lua][platform][effects][semantic]" )
{
    cata::lua_platform::clear_active_runtimes();
    clear_map_without_vision();
    on_out_of_scope cleanup( []() {
        cata::lua_platform::clear_active_runtimes();
        clear_map_without_vision();
    } );

    REQUIRE( effect_catch_up.is_valid() );
    const std::vector<std::int64_t> invalid_intensities = {
        static_cast<std::int64_t>( std::numeric_limits<int>::max() ) + 1,
        static_cast<std::int64_t>( std::numeric_limits<int>::min() ) - 1,
    };

    int fixture_index = 0;
    for( const std::int64_t intensity : invalid_intensities ) {
        CAPTURE( intensity );
        effect_intensity_fixture fixture( 8800 + fixture_index * 10 );
        fixture.seed_existing_effect( 2 );
        const effect &before = fixture.platform_interlocutor.get_effect( effect_catch_up );
        REQUIRE_FALSE( before.is_null() );
        const int before_intensity = before.get_intensity();
        const time_duration before_duration = before.get_duration();

        const sol::protected_function_result call = fixture.apply_platform( intensity );
        CHECK_FALSE( call.valid() );

        const effect &after = fixture.platform_interlocutor.get_effect( effect_catch_up );
        REQUIRE_FALSE( after.is_null() );
        CHECK( after.get_intensity() == before_intensity );
        CHECK( after.get_duration() == before_duration );
        ++fixture_index;
    }
}

TEST_CASE( "lua_platform_effect_add_accepts_native_signed_turn_durations",
           "[lua][platform][effects][semantic]" )
{
    cata::lua_platform::clear_active_runtimes();
    clear_map_without_vision();
    on_out_of_scope cleanup( []() {
        cata::lua_platform::clear_active_runtimes();
        clear_map_without_vision();
    } );

    REQUIRE( effect_catch_up.is_valid() );
    const std::vector<int> durations = {
        std::numeric_limits<int>::min(),
        std::numeric_limits<int>::max(),
    };

    int fixture_index = 0;
    for( const int duration : durations ) {
        CAPTURE( duration );
        effect_intensity_fixture fixture( 9000 + fixture_index * 10 );
        fixture.apply_native( 0, duration );
        const sol::protected_function_result call = fixture.apply_platform( 0, duration );
        REQUIRE( call.valid() );
        const sol::table result = call;
        REQUIRE( result["ok"].get<bool>() );

        const effect &native = fixture.native_interlocutor.get_effect( effect_catch_up );
        const effect &platform = fixture.platform_interlocutor.get_effect( effect_catch_up );
        REQUIRE_FALSE( native.is_null() );
        REQUIRE_FALSE( platform.is_null() );
        CHECK( platform.get_duration() == native.get_duration() );
        ++fixture_index;
    }
}

TEST_CASE( "lua_platform_effect_add_rejects_durations_outside_native_int_without_mutation",
           "[lua][platform][effects][semantic]" )
{
    cata::lua_platform::clear_active_runtimes();
    clear_map_without_vision();
    on_out_of_scope cleanup( []() {
        cata::lua_platform::clear_active_runtimes();
        clear_map_without_vision();
    } );

    REQUIRE( effect_catch_up.is_valid() );
    const std::vector<std::int64_t> invalid_durations = {
        static_cast<std::int64_t>( std::numeric_limits<int>::max() ) + 1,
        static_cast<std::int64_t>( std::numeric_limits<int>::min() ) - 1,
    };

    int fixture_index = 0;
    for( const std::int64_t duration : invalid_durations ) {
        CAPTURE( duration );
        effect_intensity_fixture fixture( 9200 + fixture_index * 10 );
        fixture.seed_existing_effect( 2 );
        const effect &before = fixture.platform_interlocutor.get_effect( effect_catch_up );
        REQUIRE_FALSE( before.is_null() );
        const int before_intensity = before.get_intensity();
        const time_duration before_duration = before.get_duration();

        const sol::protected_function_result call = fixture.apply_platform( 1000001, duration );
        CHECK_FALSE( call.valid() );

        const effect &after = fixture.platform_interlocutor.get_effect( effect_catch_up );
        REQUIRE_FALSE( after.is_null() );
        CHECK( after.get_intensity() == before_intensity );
        CHECK( after.get_duration() == before_duration );
        ++fixture_index;
    }
}

#endif // CATA_ENABLE_LUA_PLATFORM
