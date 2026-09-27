#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include <limits>
#include <list>
#include <string>
#include <utility>

#include "calendar.h"
#include "lua_platform_test_support.h"
#include "timed_event.h"

TEST_CASE( "lua_platform_weather_write_contract_exposes_controls_and_limits",
           "[lua][platform][weather]" )
{
    platform_weather_read_fixture fixture;
    const sol::table weather = fixture.services["weather"];
    REQUIRE( weather.valid() );
    CHECK( weather["set_override"].valid() );
    CHECK( weather["clear_override"].valid() );
    CHECK( weather["set_temperature_override"].valid() );
    CHECK( weather["clear_temperature_override"].valid() );
    CHECK( weather["set_wind"].valid() );
    CHECK( weather["clear_overrides"].valid() );
    CHECK( weather["refresh"].valid() );
    CHECK( weather["activate_lightning"].valid() );
    CHECK( weather["override_light"].valid() );
    CHECK( weather["append_light_event"].valid() );
    CHECK_FALSE( fixture.services["gameplay"].valid() );

    const sol::protected_function_result limits_result = weather["limits"]();
    REQUIRE( limits_result.valid() );
    const sol::table limits = limits_result.get<sol::table>();
    REQUIRE( limits.valid() );
    CHECK( limits["maximum_pending_custom_light_events"].get<int>() == 256 );
    CHECK( limits["maximum_wind_direction_degrees"].get<int>() == 359 );
    CHECK( limits["maximum_custom_light_level"].get<int>() == 1000000 );
}

TEST_CASE( "lua_platform_weather_append_light_event_preserves_native_queue_semantics",
           "[lua][platform][weather]" )
{
    platform_weather_read_fixture fixture;
    REQUIRE( g != nullptr );
    platform_calendar_turn_scope calendar_scope;
    calendar::turn = time_point::from_turn( 1000 );

    timed_event_manager &events = get_timed_events();
    restore_on_out_of_scope<timed_event_manager> restore_events( std::move( events ) );
    events = timed_event_manager();

    const sol::table weather = fixture.services["weather"];
    const sol::protected_function append = weather["append_light_event"];
    const std::string long_key( 300, 'k' );
    const time_point now = calendar::turn;

    const sol::protected_function_result first_result = append(
                -17,
                cata::lua_platform::script_time_duration::from_native( -2_turns ),
                long_key );
    REQUIRE( first_result.valid() );
    const sol::table first_envelope = first_result.get<sol::table>();
    REQUIRE( first_envelope["ok"].get<bool>() );
    const sol::table first_value = first_envelope["value"].get<sol::table>();
    CHECK_FALSE( first_value["replaced"].get<bool>() );

    const sol::protected_function_result second_result = append(
                1000001,
                cata::lua_platform::script_time_duration::from_native( 10001_days ),
                long_key );
    REQUIRE( second_result.valid() );
    const sol::table second_envelope = second_result.get<sol::table>();
    REQUIRE( second_envelope["ok"].get<bool>() );
    const sol::table second_value = second_envelope["value"].get<sol::table>();
    CHECK_FALSE( second_value["replaced"].get<bool>() );

    const std::list<timed_event> &queued = events.get_all();
    REQUIRE( queued.size() == 2 );
    auto event = queued.begin();
    CHECK( event->type == timed_event_type::CUSTOM_LIGHT_LEVEL );
    CHECK( event->strength == -17 );
    CHECK( event->key == long_key );
    CHECK( event->when == now + ( -2_turns ) + 1_seconds );
    ++event;
    CHECK( event->type == timed_event_type::CUSTOM_LIGHT_LEVEL );
    CHECK( event->strength == 1000001 );
    CHECK( event->key == long_key );
    CHECK( event->when == now + 10001_days + 1_seconds );

    calendar::turn = time_point::from_turn( 0 );
    const sol::protected_function_result max_result = append(
                std::numeric_limits<int>::max(),
                cata::lua_platform::script_time_duration::from_native(
                    time_duration::from_turns( std::numeric_limits<int>::max() - 1 ) ),
                long_key );
    REQUIRE( max_result.valid() );
    const sol::protected_function_result min_result = append(
                std::numeric_limits<int>::min(),
                cata::lua_platform::script_time_duration::from_native(
                    time_duration::from_turns( std::numeric_limits<int>::min() ) ),
                long_key );
    REQUIRE( min_result.valid() );
    CHECK( events.get_all().size() == 4 );
    ++event;
    CHECK( event->strength == std::numeric_limits<int>::max() );
    CHECK( event->when == time_point::from_turn( std::numeric_limits<int>::max() ) );
    ++event;
    CHECK( event->strength == std::numeric_limits<int>::min() );
    CHECK( event->when == time_point::from_turn( std::numeric_limits<int>::min() + 1 ) );
    REQUIRE( events.get( timed_event_type::CUSTOM_LIGHT_LEVEL ) != nullptr );
    CHECK( events.get( timed_event_type::CUSTOM_LIGHT_LEVEL )->strength == -17 );

    calendar::turn = time_point::from_turn( std::numeric_limits<int>::max() - 1 );
    const sol::protected_function_result overflow_result = append(
                1,
                cata::lua_platform::script_time_duration::from_native( 1_turns ),
                long_key );
    CHECK_FALSE( overflow_result.valid() );
    CHECK( events.get_all().size() == 4 );

    calendar::turn = time_point::from_turn( std::numeric_limits<int>::min() );
    const sol::protected_function_result underflow_result = append(
                1,
                cata::lua_platform::script_time_duration::from_native( -1_turns ),
                long_key );
    CHECK_FALSE( underflow_result.valid() );
    CHECK( events.get_all().size() == 4 );
    CHECK( fixture.write_gate_calls == 6 );
}

TEST_CASE( "lua_platform_weather_write_controls_apply_valid_overrides",
           "[lua][platform][weather]" )
{
    platform_weather_read_fixture fixture;
    REQUIRE( g != nullptr );
    weather_manager &weather_manager_ref = get_weather();
    const units::temperature saved_temperature = weather_manager_ref.temperature;
    const bool saved_lightning_active = weather_manager_ref.lightning_active;
    const weather_type_id saved_weather_id = weather_manager_ref.weather_id;
    const int saved_winddirection = weather_manager_ref.winddirection;
    const int saved_windspeed = weather_manager_ref.windspeed;
    const bool saved_weather_changed = weather_manager_ref.weather_changed;
    const weather_type_id saved_weather_override =
        weather_manager_ref.weather_override;
    const std::optional<units::temperature> saved_forced_temperature =
        weather_manager_ref.forced_temperature;
    const std::optional<int> saved_wind_direction_override =
        weather_manager_ref.wind_direction_override;
    const std::optional<int> saved_windspeed_override =
        weather_manager_ref.windspeed_override;
    const time_point saved_nextweather = weather_manager_ref.nextweather;
    const auto saved_temperature_cache = weather_manager_ref.temperature_cache;
    using weather_precise_type = std::remove_cv_t<std::remove_reference_t<
        decltype( *weather_manager_ref.weather_precise )>>;
    constexpr bool weather_precise_copyable =
        std::is_copy_constructible_v<weather_precise_type> &&
        std::is_copy_assignable_v<weather_precise_type>;
    std::shared_ptr<const weather_precise_type> saved_weather_precise;
    if constexpr( weather_precise_copyable ) {
        saved_weather_precise = std::make_shared<weather_precise_type>(
                                    *weather_manager_ref.weather_precise );
    }
    on_out_of_scope restore_weather( [&weather_manager_ref,
                                      saved_temperature,
                                      saved_lightning_active,
                                      saved_weather_id,
                                      saved_winddirection,
                                      saved_windspeed,
                                      saved_weather_changed,
                                      saved_weather_override,
                                      saved_forced_temperature,
                                      saved_wind_direction_override,
                                      saved_windspeed_override,
                                      saved_nextweather,
                                      saved_temperature_cache,
                                      saved_weather_precise]() {
        weather_manager_ref.temperature = saved_temperature;
        weather_manager_ref.lightning_active = saved_lightning_active;
        weather_manager_ref.weather_id = saved_weather_id;
        weather_manager_ref.winddirection = saved_winddirection;
        weather_manager_ref.windspeed = saved_windspeed;
        weather_manager_ref.weather_changed = saved_weather_changed;
        weather_manager_ref.weather_override = saved_weather_override;
        weather_manager_ref.forced_temperature = saved_forced_temperature;
        weather_manager_ref.wind_direction_override = saved_wind_direction_override;
        weather_manager_ref.windspeed_override = saved_windspeed_override;
        weather_manager_ref.nextweather = saved_nextweather;
        weather_manager_ref.temperature_cache = saved_temperature_cache;
        if constexpr( weather_precise_copyable ) {
            *weather_manager_ref.weather_precise = *saved_weather_precise;
        }
    } );

    const sol::table weather = fixture.services["weather"];
    REQUIRE( weather.valid() );
    if constexpr( weather_precise_copyable ) {
        const sol::protected_function set_override = weather["set_override"];
        const cata::lua_platform::script_game_id clear_weather(
            "weather_type", "clear" );
        const sol::protected_function_result set_override_result =
            set_override( clear_weather );
        REQUIRE( set_override_result.valid() );
        const sol::table set_override_envelope =
            set_override_result.get<sol::table>();
        REQUIRE( set_override_envelope.valid() );
        REQUIRE( set_override_envelope["ok"].get<bool>() );
        CHECK( fixture.write_gate_calls == 1 );
        const sol::table set_override_snapshot =
            set_override_envelope["value"].get<sol::table>();
        REQUIRE( set_override_snapshot.valid() );
        const sol::object weather_override =
            set_override_snapshot["weather_override"];
        REQUIRE( weather_override.is<cata::lua_platform::script_game_id>() );
        CHECK( weather_override.as<cata::lua_platform::script_game_id>() ==
               clear_weather );
    }

    const sol::protected_function set_temperature_override =
        weather["set_temperature_override"];

    const cata::lua_platform::script_unit_value kelvin_temperature =
        cata::lua_platform::script_unit_value::from(
            "temperature", 273.15, "kelvin" );
    const sol::protected_function_result set_temperature_result =
        set_temperature_override( kelvin_temperature );
    REQUIRE( set_temperature_result.valid() );
    const sol::table set_temperature_envelope =
        set_temperature_result.get<sol::table>();
    REQUIRE( set_temperature_envelope.valid() );
    REQUIRE( set_temperature_envelope["ok"].get<bool>() );
    CHECK( fixture.write_gate_calls == ( weather_precise_copyable ? 2 : 1 ) );
    const sol::table set_temperature_snapshot =
        set_temperature_envelope["value"].get<sol::table>();
    REQUIRE( set_temperature_snapshot.valid() );
    const sol::object temperature_override =
        set_temperature_snapshot["temperature_override"];
    REQUIRE( temperature_override.is<cata::lua_platform::script_unit_value>() );
    CHECK( temperature_override.as<cata::lua_platform::script_unit_value>()
           .value_as( "kelvin" ) == Approx( 273.15 ).margin( 0.01 ) );
}

TEST_CASE( "lua_platform_content_finalization_is_single_use_and_rollback_is_terminal",
           "[lua][platform][content]" )
{
    cata::lua_platform::content_transaction transaction( "registrar_test", 1 );
    std::string error;
    REQUIRE( transaction.apply( error ) );
    REQUIRE( transaction.validate_finalized( error ) );
    CHECK_FALSE( transaction.validate_finalized( error ) );
    CHECK( error.find( "already validated" ) != std::string::npos );

    transaction.rollback();
    CHECK_FALSE( transaction.apply( error ) );
    CHECK( error.find( "no longer building" ) != std::string::npos );
}

TEST_CASE( "lua_platform_world_registrar_finalization_failure_boundary_is_terminal",
           "[lua][platform][content]" )
{
    cata::lua_platform::world_content_transaction transaction( "world_test", 1 );
    std::string error;
    CHECK_FALSE( transaction.validate_finalized( error ) );
    CHECK( error.find( "not applied" ) != std::string::npos );
    REQUIRE( transaction.apply( error ) );
    REQUIRE( transaction.validate_finalized( error ) );
    CHECK_FALSE( transaction.validate_finalized( error ) );
    CHECK( error.find( "already validated" ) != std::string::npos );

    transaction.rollback();
    CHECK_FALSE( transaction.apply( error ) );
    CHECK( error.find( "no longer building" ) != std::string::npos );
}

#endif // CATA_ENABLE_LUA_PLATFORM
