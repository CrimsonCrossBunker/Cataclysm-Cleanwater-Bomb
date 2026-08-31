#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"

TEST_CASE( "lua_platform_creature_handles_fail_closed_after_unload", "[lua][platform]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 9 );
    std::optional<cata::lua_platform::game_handle> stale;
    std::optional<cata::lua_platform::game_handle_error> live_error;
    {
        monster value;
        value.set_hp( 1 );
        stale = cata::lua_platform::game_handle::from_creature(
                    value, { "monster", 0, 0, 0, 0, {} }, runtime, 4 );
        CHECK( cata::lua_platform::resolve_exact_monster(
                   *stale, runtime, 4, live_error ) == &value );
    }

    std::optional<cata::lua_platform::game_handle_error> error;
    CHECK( cata::lua_platform::resolve_exact_monster(
               *stale, runtime, 4, error ) == nullptr );
    REQUIRE( error );
    CHECK( error->code == "destroyed" );
}

TEST_CASE( "lua_platform_native_identity_is_not_reused_by_copy_or_move", "[lua][platform]" )
{
    cata::lua_platform::native_object_identity original;
    const std::uint64_t original_value = original.value();
    cata::lua_platform::native_object_identity copied( original );
    CHECK( copied.value() != original_value );

    cata::lua_platform::native_object_identity moved( std::move( original ) );
    CHECK( moved.value() == original_value );
    CHECK( original.value() != original_value );
}

TEST_CASE( "lua_platform_hooks_use_semantic_participant_fields", "[lua][platform]" )
{
    const auto contains = []( const std::vector<std::string_view> &fields,
                              const std::string_view wanted ) {
        return std::find( fields.begin(), fields.end(), wanted ) != fields.end();
    };
    const cata::lua_platform::script_hook_spec *start =
        cata::lua_platform::find_script_hook_spec( "on_dialogue_start" );
    const cata::lua_platform::script_hook_spec *option =
        cata::lua_platform::find_script_hook_spec( "on_dialogue_option" );
    REQUIRE( start );
    REQUIRE( option );
    CHECK( contains( start->payload_fields, "speaker" ) );
    CHECK( contains( start->payload_fields, "interlocutor" ) );
    CHECK( contains( option->payload_fields, "selected_topic" ) );
    CHECK_FALSE( contains( start->payload_fields, "alpha" ) );
    CHECK_FALSE( contains( start->payload_fields, "beta" ) );
    CHECK_FALSE( contains( option->payload_fields, "avatar" ) );

    const_talker detached_talker;
    const cata::lua_platform::native_callback_talker snapshot =
        cata::lua_platform::snapshot_native_callback_talker( detached_talker );
    CHECK( snapshot.present );
    CHECK_FALSE( snapshot.entity );
    CHECK( snapshot.kind == "topic" );
}

#endif // CATA_ENABLE_LUA_PLATFORM
