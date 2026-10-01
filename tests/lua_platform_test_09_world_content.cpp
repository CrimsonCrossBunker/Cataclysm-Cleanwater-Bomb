#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include <array>
#include <cstddef>
#include <cstdint>
#include <iterator>
#include <limits>
#include <memory>
#include <list>
#include <sstream>
#include <string>
#include <utility>
#include <vector>

#include "calendar.h"
#include "flag.h"
#include "global_vars.h"
#include "lua_platform_test_map_support.h"
#include "magic_teleporter_list.h"
#include "lua_platform_test_support.h"
#include "timed_event.h"

namespace
{
struct platform_world_spawn_contract_fixture {
    platform_world_spawn_contract_fixture() :
        runtime_owner( cata::lua_platform::make_game_handle_runtime_owner() ),
        runtime( runtime_owner, 501 ),
        active_runtime( runtime ),
        active_world_generation( 1 ) {
        services = lua.create_table();
        cata::lua_platform::install_value_type_api(
            lua, services, []() {} );
        cata::lua_platform::install_game_handle_api(
            lua, services,
        [this]() {
            return active_runtime;
        },
        [this]() {
            return active_world_generation;
        }, []() {} );
        cata::lua_platform::install_world_api(
            services,
        [this]() {
            return active_runtime;
        },
        [this]() {
            return active_world_generation;
        }, []() {},
        [this]() {
            ++write_gate_calls;
        } );
    }

    sol::state lua;
    sol::table services;
    std::shared_ptr<const cata::lua_platform::game_handle_runtime_owner> runtime_owner;
    cata::lua_platform::game_handle_runtime runtime;
    cata::lua_platform::game_handle_runtime active_runtime;
    std::size_t active_world_generation;
    int write_gate_calls = 0;
};

struct platform_world_copy_globals_restore {
    global_variables::impl_t previous = get_globals().get_global_values();

    ~platform_world_copy_globals_restore() {
        get_globals().set_global_values( std::move( previous ) );
    }
};

const item *find_world_copy_cable( const submap &source,
                                   const point_sm_ms &position )
{
    for( const item &entry : source.get_items( position ) ) {
        if( entry.typeId() == itype_id( "power_cord" ) ) {
            return &entry;
        }
    }
    return nullptr;
}

struct location_copy_event_record {
    timed_event_type type = timed_event_type::NONE;
    time_point when = calendar::turn_zero;
    int faction_id = -1;
    tripoint_abs_ms map_square = tripoint_abs_ms::invalid;
    tripoint_abs_sm map_point = tripoint_abs_sm::invalid;
    int strength = -1;
    std::string string_id;
    std::string key;
    ter_id terrain;
    furn_id furniture;
};

std::string serialized_translocator_name( const tripoint_abs_omt &position )
{
    std::ostringstream stream;
    {
        JsonOut json( stream );
        get_avatar().translocators.serialize( json );
    }
    const JsonObject root = json_loader::from_string( stream.str() ).get_object();
    for( JsonObject entry : root.get_array( "known_teleporters" ) ) {
        tripoint_abs_omt candidate;
        entry.read( "position", candidate );
        if( candidate == position ) {
            return entry.get_string( "name" );
        }
    }
    return {};
}
} // namespace

TEST_CASE( "location_copy_due_time_matches_native_range_and_offset",
           "[lua][platform][world][semantic]" )
{
    platform_calendar_turn_scope calendar_scope;
    calendar::turn = time_point::from_turn( 1000 );

    CHECK( location_copy_due_time( 1_minutes ) ==
           calendar::turn + 1_minutes + 1_seconds );
    CHECK( location_copy_due_time( 0_turns ) ==
           calendar::turn + 1_seconds );
    CHECK( location_copy_due_time( -3_turns ) ==
           calendar::turn + ( -3_turns ) + 1_seconds );

    const int phase_offset = to_turns<int>( 1_seconds );
    calendar::turn = time_point::from_turn( 0 );
    const int exact_upper_delay = std::numeric_limits<int>::max() - phase_offset;
    CHECK( location_copy_due_time( time_duration::from_turns( exact_upper_delay ) ) ==
           time_point::from_turn( std::numeric_limits<int>::max() ) );
    CHECK( location_copy_due_time( calendar::INDEFINITELY_LONG_DURATION ) ==
           time_point::from_turn( std::numeric_limits<int>::max() ) );

    calendar::turn = time_point::from_turn( 0 );
    CHECK( location_copy_due_time( time_duration::from_turns(
                                       std::numeric_limits<int>::min() ) ) ==
           time_point::from_turn( std::numeric_limits<int>::min() + phase_offset ) );
    calendar::turn = time_point::from_turn( std::numeric_limits<int>::min() );
    CHECK( location_copy_due_time( time_duration::from_turns(
                                       std::numeric_limits<int>::min() ) ) ==
           time_point::from_turn( std::numeric_limits<int>::min() ) );
}

TEST_CASE( "lua_platform_location_copy_matches_native_timed_submap_copy",
           "[lua][platform][world][semantic]" )
{
    platform_overmap_travel_fixture fixture( 851, 81 );
    platform_calendar_turn_scope calendar_scope;
    platform_world_copy_globals_restore restore_globals;
    calendar::turn = time_point::from_turn( 1000 );

    const tripoint_abs_omt source = fixture.source_omt + tripoint( 2000, 1700, 0 );
    const tripoint_abs_omt destination = source + tripoint( 19, -7, 0 );
    const tripoint_abs_omt missing_source = source + tripoint( 4000, 4100, 0 );
    const tripoint_abs_omt missing_destination = missing_source + tripoint( 13, 17, 0 );
    const tripoint_abs_sm source_base = project_to<coords::sm>( source );
    const tripoint_abs_ms source_position = project_to<coords::ms>( source );
    const tripoint_abs_ms destination_position = project_to<coords::ms>( destination );

    REQUIRE_FALSE( get_avatar().translocators.knows_translocator( source ) );
    REQUIRE_FALSE( get_avatar().translocators.knows_translocator( destination ) );
    REQUIRE_FALSE( get_avatar().translocators.knows_translocator( missing_source ) );
    REQUIRE_FALSE( get_avatar().translocators.knows_translocator( missing_destination ) );
    on_out_of_scope clear_copy_test_state( [&]() {
        get_avatar().translocators.remove_translocator( source );
        get_avatar().translocators.remove_translocator( destination );
        get_avatar().translocators.remove_translocator( missing_source );
        get_avatar().translocators.remove_translocator( missing_destination );
        MAPBUFFER.clear_outside_reality_bubble();
    } );

    timed_event_manager &events = get_timed_events();
    restore_on_out_of_scope<timed_event_manager> restore_events( std::move( events ) );
    events = timed_event_manager();

    tinymap source_map;
    source_map.load( source, true );
    submap *source_submap = MAPBUFFER.lookup_submap( source_base );
    REQUIRE( source_submap != nullptr );
    submap original_source = source_submap->get_revert_submap();
    on_out_of_scope restore_source( [&]() {
        source_submap->revert_submap( original_source );
    } );
    source_submap->ensure_nonuniform();
    const point_sm_ms cable_position( 0, 0 );
    source_submap->get_items( cable_position ).clear();
    item cable( itype_id( "power_cord" ), calendar::turn );
    REQUIRE( cable.can_link_up() );
    const tripoint_abs_ms linked_target = source_position + tripoint( 71, 29, 0 );
    cable.link().target = link_state::vehicle_port;
    cable.link().t_abs_pos = linked_target;
    cable.link().s_bub_pos = tripoint_bub_ms( 3, 5, 0 );
    source_submap->get_items( cable_position ).insert( std::move( cable ) );

    std::ostringstream teleporter_json;
    {
        JsonOut json( teleporter_json );
        json.start_object();
        json.member( "known_teleporters" );
        json.start_array();
        json.start_object();
        json.member( "position", source );
        json.member( "name", "location-copy-source" );
        json.end_object();
        json.end_array();
        json.end_object();
    }
    get_avatar().translocators.deserialize(
        json_loader::from_string( teleporter_json.str() ).get_object() );
    REQUIRE( get_avatar().translocators.knows_translocator( source ) );

    get_globals().set_global_value( "lua_platform_copy_source", source_position );
    get_globals().set_global_value( "lua_platform_copy_destination", destination_position );
    dialogue conversation( get_talker_for( get_avatar() ), get_talker_for( get_avatar() ) );
    const std::array<std::pair<std::string, time_duration>, 5> delays = {{
            { "1 turn", 1_turns },
            { "0 turns", 0_turns },
            { "-3 turns", -3_turns },
            { "infinite", calendar::INDEFINITELY_LONG_DURATION },
            {
                std::to_string( std::numeric_limits<int>::min() ) + " turns",
                time_duration::from_turns( std::numeric_limits<int>::min() )
            },
        }
    };
    const sol::protected_function copy =
        fixture.services["world"]["schedule_location_copy"];
    REQUIRE( copy.valid() );

    for( std::size_t delay_index = 0; delay_index < delays.size(); ++delay_index ) {
        const std::pair<std::string, time_duration> &delay = delays[delay_index];
        const std::string key = "lua_platform_location_copy_parity_" +
                                std::to_string( delay_index );
        events = timed_event_manager();
        REQUIRE_FALSE( get_avatar().translocators.knows_translocator( destination ) );
        const std::string effect_source =
            std::string( R"({"copy_location":{"global_val":"lua_platform_copy_source"},)" ) +
            R"("new_loc":{"global_val":"lua_platform_copy_destination"},)" +
            R"("time_in_future":")" + delay.first + R"(","key":")" + key + "}";
        const JsonValue native_json = json_loader::from_string( effect_source );
        talk_effect_t native_effect( native_json.get_object(), "effect",
                                     "lua_platform_location_copy_native_parity" );
        native_effect.apply( conversation );
        REQUIRE( events.get_all().size() == 4 );
        REQUIRE( get_avatar().translocators.knows_translocator( destination ) );
        CHECK( serialized_translocator_name( destination ) == "location-copy-source" );

        const std::list<timed_event> &native_queue = events.get_all();
        auto native = native_queue.begin();
        CHECK( native->when == location_copy_due_time( delay.second ) );
        CHECK( native->when == ( delay.second == calendar::INDEFINITELY_LONG_DURATION ?
                                 time_point::from_turn( std::numeric_limits<int>::max() ) :
                                 calendar::turn + delay.second + 1_seconds ) );
        CHECK( native->key == key );
        CHECK( native->type == timed_event_type::REVERT_SUBMAP );
        CHECK( native->faction_id == -1 );
        CHECK( native->strength == 0 );
        CHECK( native->string_id.empty() );
        CHECK( native->map_square == project_to<coords::ms>(
                   project_to<coords::sm>( destination ) ) );
        const item *native_cable = find_world_copy_cable(
                                       native->revert, cable_position );
        REQUIRE( native_cable != nullptr );
        const tripoint_abs_ms native_link_target = native_cable->link().t_abs_pos;
        const tripoint_bub_ms native_link_source = native_cable->link().s_bub_pos;
        const std::string native_relocation_turn =
            native_cable->get_var( "eoc_cable_relocation_turn" );
        CHECK( native_link_target == linked_target + ( destination_position - source_position ) );
        CHECK( native_link_source == tripoint_bub_ms::invalid );
        CHECK( native_relocation_turn == "-1" );

        if( delay.first == std::string( "infinite" ) ) {
            const JsonValue alter_json = json_loader::from_string(
                                             "{\"alter_timed_events\":\"" + key + "\"}" );
            talk_effect_t native_alter( alter_json.get_object(), "effect",
                                        "lua_platform_location_copy_native_retime" );
            native_alter.apply( conversation );
            for( const timed_event &event : events.get_all() ) {
                CHECK( event.key == key );
                CHECK( event.when == calendar::turn );
            }
        }

        std::array<location_copy_event_record, 4> native_records;
        std::size_t record_index = 0;
        for( int x = 0; x < 2; ++x ) {
            for( int y = 0; y < 2; ++y, ++native, ++record_index ) {
                const tripoint_abs_ms expected_position = project_to<coords::ms>(
                        project_to<coords::sm>( destination ) + point( x, y ) );
                CHECK( native->map_square == expected_position );
                native_records[record_index] = {
                    native->type,
                    native->when,
                    native->faction_id,
                    native->map_square,
                    native->map_point,
                    native->strength,
                    native->string_id,
                    native->key,
                    native->revert.get_ter( cable_position ),
                    native->revert.get_furn( cable_position ),
                };
            }
        }
        REQUIRE( get_avatar().translocators.remove_translocator( destination ) );
        events = timed_event_manager();

        const sol::protected_function_result platform_result = copy(
                fixture.abs_omt_position( source ),
                fixture.abs_omt_position( destination ),
                cata::lua_platform::script_time_duration::from_native( delay.second ), key );
        REQUIRE( platform_result.valid() );
        const sol::table envelope = platform_result.get<sol::table>();
        REQUIRE( envelope["ok"].get<bool>() );
        const sol::table value = envelope["value"].get<sol::table>();
        CHECK( value["when"].get<cata::lua_platform::script_time_point>().to_native() ==
               location_copy_due_time( delay.second ) );
        REQUIRE( get_avatar().translocators.knows_translocator( destination ) );
        CHECK( serialized_translocator_name( destination ) == "location-copy-source" );

        if( delay.first == std::string( "infinite" ) ) {
            const sol::protected_function reschedule =
                fixture.services["world"]["reschedule_events"];
            REQUIRE( reschedule.valid() );
            const sol::protected_function_result retime_result = reschedule(
                    key,
                    cata::lua_platform::script_time_duration::from_native( 0_turns ) );
            REQUIRE( retime_result.valid() );
            const sol::table retime_envelope = retime_result.get<sol::table>();
            REQUIRE( retime_envelope["ok"].get<bool>() );
            const sol::table retime_value = retime_envelope["value"].get<sol::table>();
            CHECK( retime_value["matched"].get<std::size_t>() == 4 );
            CHECK( retime_value["when"].get<cata::lua_platform::script_time_point>().to_native() ==
                   calendar::turn );
        }

        const std::list<timed_event> &queued = events.get_all();
        native = queued.begin();
        REQUIRE( queued.size() == 4 );
        std::size_t platform_index = 0;
        for( int x = 0; x < 2; ++x ) {
            for( int y = 0; y < 2; ++y, ++native, ++platform_index ) {
                const tripoint_abs_ms expected_position = project_to<coords::ms>(
                        project_to<coords::sm>( destination ) + point( x, y ) );
                CHECK( native->map_square == expected_position );
                const location_copy_event_record &expected =
                    native_records[platform_index];
                CHECK( native->type == expected.type );
                CHECK( native->when == expected.when );
                CHECK( native->faction_id == expected.faction_id );
                CHECK( native->map_square == expected.map_square );
                CHECK( native->map_point == expected.map_point );
                CHECK( native->strength == expected.strength );
                CHECK( native->string_id == expected.string_id );
                CHECK( native->key == expected.key );
                CHECK( native->revert.get_ter( cable_position ) == expected.terrain );
                CHECK( native->revert.get_furn( cable_position ) == expected.furniture );
                if( x == 0 && y == 0 ) {
                    const item *platform_cable = find_world_copy_cable(
                                                     native->revert, cable_position );
                    REQUIRE( platform_cable != nullptr );
                    CHECK( platform_cable->link().t_abs_pos == native_link_target );
                    CHECK( platform_cable->link().s_bub_pos == native_link_source );
                    CHECK( platform_cable->get_var( "eoc_cable_relocation_turn" ) ==
                           native_relocation_turn );
                }
            }
        }
        REQUIRE( get_avatar().translocators.remove_translocator( destination ) );
    }

    const std::size_t before_missing_source = events.get_all().size();
    const std::string missing_key = "lua_platform_location_copy_missing_source";
    const tripoint_abs_sm missing_source_base = project_to<coords::sm>( missing_source );
    const tripoint_abs_sm missing_destination_base = project_to<coords::sm>(
            missing_destination );
    for( int x = 0; x < 2; ++x ) {
        for( int y = 0; y < 2; ++y ) {
            REQUIRE_FALSE( MAPBUFFER.submap_exists( missing_source_base + point( x, y ) ) );
            REQUIRE_FALSE( MAPBUFFER.submap_exists( missing_destination_base + point( x, y ) ) );
        }
    }
    const sol::protected_function_result missing_result = copy(
            fixture.abs_omt_position( missing_source ),
            fixture.abs_omt_position( missing_destination ),
            cata::lua_platform::script_time_duration::from_native( 1_turns ), missing_key );
    CHECK_FALSE( missing_result.valid() );
    CHECK( events.get_all().size() == before_missing_source );
    CHECK_FALSE( get_avatar().translocators.knows_translocator( missing_destination ) );
    for( int x = 0; x < 2; ++x ) {
        for( int y = 0; y < 2; ++y ) {
            CHECK_FALSE( MAPBUFFER.submap_exists( missing_source_base + point( x, y ) ) );
            CHECK( MAPBUFFER.submap_exists( missing_destination_base + point( x, y ) ) );
        }
    }
}

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

TEST_CASE( "lua_platform_world_spawn_item_matches_native_direct_item_initialization",
           "[lua][platform][world][spawn_item]" )
{
    REQUIRE( g != nullptr );
    platform_world_spawn_contract_fixture fixture;
    map &here = get_map();
    const tripoint_abs_ms position = get_avatar().pos_abs();
    const tripoint_bub_ms local = here.get_bub( position );
    REQUIRE( here.inbounds( local ) );
    const cata::lua_platform::script_tripoint_coord script_position =
        cata::lua_platform::script_tripoint_coord::from_native(
            coords::origin::abs, coords::scale::map_square, position.raw() );

    std::vector<std::int64_t> spawned_uids;
    on_out_of_scope restore_spawned_items( [&here, &local, &spawned_uids]() {
        for( const std::int64_t uid : spawned_uids ) {
            map_stack stack = here.i_at( local );
            for( map_stack::iterator it = stack.begin(); it != stack.end(); ) {
                if( it->uid().get_value() == uid ) {
                    it = here.i_rem( local, it );
                } else {
                    ++it;
                }
            }
        }
    } );

    const auto find_spawned = [&here, &local]( const std::int64_t uid ) -> item * {
        map_stack stack = here.i_at( local );
        for( item &entry : stack ) {
            if( entry.uid().get_value() == uid ) {
                return &entry;
            }
        }
        return nullptr;
    };
    const auto spawn_through_platform = [&]( const std::string &id ) {
        const sol::table world = fixture.services["world"];
        const sol::protected_function spawn = world["spawn_item"];
        const sol::protected_function_result result = spawn(
                script_position,
                cata::lua_platform::script_game_id( "item", id ), 1 );
        if( !result.valid() ) {
            return sol::table();
        }
        const sol::table envelope = result.get<sol::table>();
        if( !envelope.valid() || !envelope["ok"].get<bool>() ) {
            return sol::table();
        }
        return envelope["value"].get<sol::table>();
    };

    item native_flyer( itype_id( "flyer_evac" ), calendar::turn );
    REQUIRE( native_flyer.has_flag( flag_PRESERVE_SPAWN_LOC ) );
    native_flyer.preserve_location( position );
    item &native_flyer_added = here.add_item_or_charges(
                                   local, std::move( native_flyer ) );
    const std::int64_t native_flyer_uid = native_flyer_added.uid().get_value();
    spawned_uids.push_back( native_flyer_uid );

    const sol::table platform_flyer_value =
        spawn_through_platform( "flyer_evac" );
    REQUIRE( platform_flyer_value.valid() );
    REQUIRE( platform_flyer_value["added"].get<std::int64_t>() == 1 );
    const sol::table platform_flyer_items =
        platform_flyer_value["items"].get<sol::table>();
    const sol::table platform_flyer_item =
        platform_flyer_items[1].get<sol::table>();
    const std::int64_t platform_flyer_uid =
        platform_flyer_item["uid"].get<std::int64_t>();
    spawned_uids.push_back( platform_flyer_uid );
    item *const platform_flyer = find_spawned( platform_flyer_uid );
    item *const native_flyer_map_item = find_spawned( native_flyer_uid );
    REQUIRE( platform_flyer != nullptr );
    REQUIRE( native_flyer_map_item != nullptr );
    CHECK( platform_flyer->get_var(
               "spawn_location", tripoint_abs_ms::invalid ) ==
           native_flyer_map_item->get_var(
               "spawn_location", tripoint_abs_ms::invalid ) );

    item native_gun( itype_id( "glock_19" ), calendar::turn );
    REQUIRE_FALSE( native_gun.count_by_charges() );
    REQUIRE_FALSE( native_gun.ammo_default().is_null() );
    native_gun.ammo_set( native_gun.ammo_default() );
    item &native_gun_added = here.add_item_or_charges(
                                 local, std::move( native_gun ) );
    const std::int64_t native_gun_uid = native_gun_added.uid().get_value();
    spawned_uids.push_back( native_gun_uid );

    const sol::table platform_gun_value =
        spawn_through_platform( "glock_19" );
    REQUIRE( platform_gun_value.valid() );
    REQUIRE( platform_gun_value["added"].get<std::int64_t>() == 1 );
    const sol::table platform_gun_items =
        platform_gun_value["items"].get<sol::table>();
    const sol::table platform_gun_item =
        platform_gun_items[1].get<sol::table>();
    const std::int64_t platform_gun_uid =
        platform_gun_item["uid"].get<std::int64_t>();
    spawned_uids.push_back( platform_gun_uid );
    item *const platform_gun = find_spawned( platform_gun_uid );
    item *const native_gun_map_item = find_spawned( native_gun_uid );
    REQUIRE( platform_gun != nullptr );
    REQUIRE( native_gun_map_item != nullptr );
    CHECK( platform_gun->ammo_current() == native_gun_map_item->ammo_current() );
    CHECK( platform_gun->ammo_remaining() == native_gun_map_item->ammo_remaining() );
    CHECK( fixture.write_gate_calls == 2 );
}

#endif // CATA_ENABLE_LUA_PLATFORM
