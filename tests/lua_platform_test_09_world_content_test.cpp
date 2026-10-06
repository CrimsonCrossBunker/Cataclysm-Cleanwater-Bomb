#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include <avatar.h>
#include <cata_scope_helpers.h>
#include <coordinates.h>
#include <debug.h>
#include <dialogue.h>
#include <enums.h>
#include "flexbuffer_json.h"
#include <game.h>
#include <item.h>
#include <item_uid.h>
#include <json.h>
#include <json_loader.h>
#include <lua_platform_bindings_coords.h>
#include <lua_platform_bindings_values.h>
#include <lua_platform_handle.h>
#include <lua_platform_runtime.h>
#include <lua_platform_world.h>
#include <lua_platform_world_content.h>
#include <map.h>
#include <mapbuffer.h>
#include <math_parser_diag_value.h>
#include <overmap_ui.h>
#include <pimpl.h>
#include <point.h>
#include <submap.h>
#include <type_id.h>
#include <units.h>
#include <weather.h>
#include <weather_gen.h>
#include <array>
#include <cstddef>
#include <cstdint>
#include <functional>
#include <initializer_list>
#include <limits>
#include <list>
#include <memory>
#include <optional>
#include <sstream>
#include <string>
#include <type_traits>
#include <unordered_map>
#include <utility>
#include <vector>

#include "calendar.h"
#include "cata_catch.h"
#include "flag.h"
#include "global_vars.h"
#include "lua_platform_sol.h"
#include "lua_platform_test_map_support.h"

using cata::lua_platform::test::platform_overmap_travel_fixture;
#include "lua_platform_test_support.h"
#include "magic_teleporter_list.h"
#include "timed_event.h"
#include "translation.h"

static const itype_id itype_apple( "apple" );
static const itype_id itype_flyer_evac( "flyer_evac" );
static const itype_id itype_glock_19( "glock_19" );
static const itype_id itype_power_cord( "power_cord" );
static const ter_str_id ter_t_dirt( "t_dirt" );
static const ter_str_id ter_t_floor( "t_floor" );

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
        if( entry.typeId() == itype_power_cord ) {
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
        const std::string name = entry.get_string( "name" );
        if( candidate == position ) {
            return name;
        }
    }
    return {};
}

std::string native_location_copy_effect_json( const std::string &delay,
        const std::string &key )
{
    std::ostringstream stream;
    {
        JsonOut json( stream );
        json.start_object();
        json.member( "copy_location" );
        json.start_object();
        json.member( "global_val", "lua_platform_copy_source" );
        json.end_object();
        json.member( "new_loc" );
        json.start_object();
        json.member( "global_val", "lua_platform_copy_destination" );
        json.end_object();
        json.member( "time_in_future", delay );
        json.member( "key", key );
        json.end_object();
    }
    return stream.str();
}

std::string native_alter_timed_events_effect_json( const std::string &delay,
        const std::string &key )
{
    std::ostringstream stream;
    {
        JsonOut json( stream );
        json.start_object();
        json.member( "alter_timed_events", key );
        json.member( "time_in_future", delay );
        json.end_object();
    }
    return stream.str();
}
} // namespace

TEST_CASE( "timed_event_due_time_matches_native_range_and_offset",
           "[lua][platform][world][semantic]" )
{
    platform_calendar_turn_scope calendar_scope;
    calendar::turn = time_point::from_turn( 1000 );

    CHECK( timed_event_due_time( 1_minutes, 1_seconds ) ==
           calendar::turn + 1_minutes + 1_seconds );
    CHECK( timed_event_due_time( 0_turns, 1_seconds ) ==
           calendar::turn + 1_seconds );
    CHECK( timed_event_due_time( -3_turns, 1_seconds ) ==
           calendar::turn + ( -3_turns ) + 1_seconds );
    CHECK( timed_event_due_time( 0_turns, 0_seconds ) == calendar::turn );
    CHECK( timed_event_due_time( -3_turns, 0_seconds ) ==
           calendar::turn - 3_turns );

    const int phase_offset = to_turns<int>( 1_seconds );
    calendar::turn = time_point::from_turn( 0 );
    const int exact_upper_delay = std::numeric_limits<int>::max() - phase_offset;
    CHECK( timed_event_due_time( time_duration::from_turns( exact_upper_delay ),
                                 1_seconds ) ==
           time_point::from_turn( std::numeric_limits<int>::max() ) );
    CHECK( timed_event_due_time( calendar::INDEFINITELY_LONG_DURATION,
                                 1_seconds ) ==
           time_point::from_turn( std::numeric_limits<int>::max() ) );
    CHECK( timed_event_due_time( time_duration::from_turns(
                                     std::numeric_limits<int>::max() ), 0_seconds ) ==
           time_point::from_turn( std::numeric_limits<int>::max() ) );

    calendar::turn = time_point::from_turn( 0 );
    CHECK( timed_event_due_time( time_duration::from_turns(
                                     std::numeric_limits<int>::min() ), 1_seconds ) ==
           time_point::from_turn( std::numeric_limits<int>::min() + phase_offset ) );
    CHECK( timed_event_due_time( time_duration::from_turns(
                                     std::numeric_limits<int>::min() ), 0_seconds ) ==
           time_point::from_turn( std::numeric_limits<int>::min() ) );
    calendar::turn = time_point::from_turn( std::numeric_limits<int>::min() );
    CHECK( timed_event_due_time( time_duration::from_turns(
                                     std::numeric_limits<int>::min() ), 1_seconds ) ==
           time_point::from_turn( std::numeric_limits<int>::min() ) );
    calendar::turn = time_point::from_turn( std::numeric_limits<int>::max() );
    CHECK( timed_event_due_time( 1_turns, 0_seconds ) ==
           time_point::from_turn( std::numeric_limits<int>::max() ) );
}

TEST_CASE( "native_json_infinite_duration_is_distinct_from_int_max_duration",
           "[lua][platform][world][semantic]" )
{
    time_duration json_infinite;
    json_infinite.deserialize( json_loader::from_string( "\"infinite\"" ) );
    CHECK( to_turns<int>( json_infinite ) == calendar::INDEFINITELY_LONG );
    CHECK( to_turns<int>( json_infinite ) == std::numeric_limits<int>::max() / 100 );
    CHECK( json_infinite != calendar::INDEFINITELY_LONG_DURATION );

    time_duration explicit_maximum;
    explicit_maximum.deserialize( json_loader::from_string(
                                      std::to_string( std::numeric_limits<int>::max() ) ) );
    CHECK( explicit_maximum == calendar::INDEFINITELY_LONG_DURATION );
}

TEST_CASE( "lua_platform_place_override_matches_native_event_queue_and_range",
           "[lua][platform][world][semantic]" )
{
    platform_world_spawn_contract_fixture fixture;
    platform_calendar_turn_scope calendar_scope;
    timed_event_manager &events = get_timed_events();
    restore_on_out_of_scope<timed_event_manager> restore_events( std::move( events ) );
    const sol::protected_function override_name = fixture.services["world"]["override_place_name"];
    REQUIRE( override_name.valid() );
    const std::vector<std::string> names = {
        "", "CCB place regression.", std::string( "CCB place" ) + '\0' + "suffix",
        std::string( 10000, 'x' ), "CCB 地点名称。"
    };
    const std::vector<std::string> keys = {
        "", "place-key", std::string( "key" ) + '\0' + "suffix", std::string( 10000, 'k' )
    };
    for( const int now : {
             1000, std::numeric_limits<int>::min(), std::numeric_limits<int>::max()
         } ) {
        calendar::turn = time_point::from_turn( now );
        for( const int duration : {
                 -1, 0, 1, calendar::INDEFINITELY_LONG,
                 std::numeric_limits<int>::min(), std::numeric_limits<int>::max()
                 } ) {
            for( const std::string &name : names ) {
                for( const std::string &key : keys ) {
                    CAPTURE( now, duration, name.size(), key.size() );
                    events = timed_event_manager();
                    std::ostringstream input;
                    JsonOut writer( input );
                    writer.start_object();
                    writer.member( "place_override", name );
                    writer.member( "length", duration );
                    writer.member( "key", key );
                    writer.end_object();
                    talk_effect_t native;
                    // Capture optional test-mode text-style diagnostics while
                    // loading; this case compares runtime queue semantics.
                    capture_debugmsg_during( [&]() {
                        native.parse_sub_effect( json_loader::from_string( input.str() ).get_object(),
                                                 "lua_place_override_native" );
                    } );
                    dialogue conversation;
                    native.apply( conversation );
                    REQUIRE( events.get_all().size() == 1 );
                    const time_point expected_when = events.get_all().back().when;
                    const std::string expected_name = events.get_all().back().string_id;
                    const std::string expected_key = events.get_all().back().key;
                    CHECK( expected_name == to_translation( name ).translated() );

                    events = timed_event_manager();
                    const time_point sentinel_when = time_point::from_turn( 77 );
                    events.add( timed_event_type::CUSTOM_LIGHT_LEVEL, sentinel_when, -1,
                                tripoint_abs_ms::zero, 72, "sentinel-name", "sentinel-key" );
                    const sol::protected_function_result call = override_name(
                                expected_name, cata::lua_platform::script_time_duration::from_native(
                                    time_duration::from_turns( duration ) ), key );
                    REQUIRE( call.valid() );
                    const sol::table result = call;
                    REQUIRE( result["ok"].get<bool>() );
                    const sol::table value = result["value"];
                    CHECK( value["name"].get<std::string>() == expected_name );
                    CHECK( value["key"].get<std::string>() == expected_key );
                    CHECK( value["when"].get<cata::lua_platform::script_time_point>().to_native() == expected_when );
                    REQUIRE( events.get_all().size() == 2 );
                    const timed_event &actual = events.get_all().back();
                    CHECK( actual.type == timed_event_type::OVERRIDE_PLACE );
                    CHECK( actual.when == expected_when );
                    CHECK( actual.string_id == expected_name );
                    CHECK( actual.key == expected_key );
                    CHECK( actual.map_square == tripoint_abs_ms::zero );
                    CHECK( actual.faction_id == -1 );
                    CHECK( actual.strength == -1 );
                    CHECK( events.get_all().front().key == "sentinel-key" );
                    CHECK( events.get_all().front().when == sentinel_when );
                }
            }
        }
    }
    CHECK( static_cast<std::size_t>( fixture.write_gate_calls ) == 3 * 6 * names.size() * keys.size() );
}

TEST_CASE( "lua_platform_location_revert_matches_native_queue_and_range",
           "[lua][platform][world][semantic]" )
{
    platform_overmap_travel_fixture fixture( 853, 83 );
    platform_calendar_turn_scope calendar_scope;
    platform_world_copy_globals_restore restore_globals;
    timed_event_manager &events = get_timed_events();
    restore_on_out_of_scope<timed_event_manager> restore_events( std::move( events ) );
    // Generate new submaps inside the existing overmap, outside the reality bubble.
    const point_abs_omt om_origin = project_to<coords::omt>(
                                        project_to<coords::om>( fixture.source_omt.xy() ) );
    const tripoint_abs_omt source( om_origin + point( 30, 30 ), fixture.source_omt.z() );
    const tripoint_abs_sm base = project_to<coords::sm>( source );
    REQUIRE_FALSE( MAPBUFFER.submap_exists( base ) );
    on_out_of_scope clear_revert_maps( []() {
        MAPBUFFER.clear_outside_reality_bubble();
    } );
    get_globals().set_global_value( "lua_platform_revert_source",
                                    project_to<coords::ms>( source ) );
    dialogue conversation( get_talker_for( get_avatar() ), get_talker_for( get_avatar() ) );
    const sol::protected_function revert = fixture.services["world"]["schedule_location_revert"];
    REQUIRE( revert.valid() );
    const point_sm_ms sample( 0, 0 );
    const std::vector<std::string> keys = {
        "", "revert-key", std::string( "key" ) + '\0' + "tail", std::string( 10000, 'k' )
    };
    for( const int now : {
             1000, std::numeric_limits<int>::min(), std::numeric_limits<int>::max()
         } ) {
        for( const int duration : {
                 -3, 0, 1, calendar::INDEFINITELY_LONG,
                 std::numeric_limits<int>::min(), std::numeric_limits<int>::max()
                 } ) {
            for( const std::string &key : keys ) {
                for( const bool variable_key : {
                         false, true
                     } ) {
                    CAPTURE( now, duration, key.size(), variable_key );
                    calendar::turn = time_point::from_turn( now );
                    events = timed_event_manager();
                    get_globals().set_global_value( "lua_platform_revert_key", key );
                    std::ostringstream input;
                    JsonOut writer( input );
                    writer.start_object();
                    writer.member( "revert_location" );
                    writer.start_object();
                    writer.member( "global_val", "lua_platform_revert_source" );
                    writer.end_object();
                    writer.member( "time_in_future", duration );
                    writer.member( "key" );
                    if( variable_key ) {
                        writer.start_object();
                        writer.member( "global_val", "lua_platform_revert_key" );
                        writer.end_object();
                    } else {
                        writer.write( key );
                    }
                    writer.end_object();
                    talk_effect_t native;
                    native.parse_sub_effect( json_loader::from_string( input.str() ).get_object(),
                                             "lua_platform_revert_native" );
                    native.apply( conversation );
                    REQUIRE( events.get_all().size() == 4 );
                    std::array<location_copy_event_record, 4> expected;
                    auto queued = events.get_all().begin();
                    std::size_t index = 0;
                    for( int x = 0; x < 2; ++x ) {
                        for( int y = 0; y < 2; ++y, ++queued, ++index ) {
                            REQUIRE( MAPBUFFER.submap_exists( base + point( x, y ) ) );
                            CHECK( queued->map_square == project_to<coords::ms>( base + point( x, y ) ) );
                            expected[index] = {
                                queued->type, queued->when, queued->faction_id, queued->map_square,
                                queued->map_point, queued->strength, queued->string_id, queued->key,
                                queued->revert.get_ter( sample ), queued->revert.get_furn( sample ),
                            };
                        }
                    }
                    events = timed_event_manager();
                    int key_reads = 0;
                    fixture.lua.set_function( "revert_key_provider", [&]() {
                        ++key_reads;
                        return get_globals().get_global_value( "lua_platform_revert_key" ).str();
                    } );
                    const sol::object key_argument = variable_key ?
                                                     fixture.lua["revert_key_provider"].get<sol::object>() :
                                                     sol::make_object( fixture.lua, key );
                    const sol::protected_function_result call = revert(
                                fixture.abs_omt_position( source ),
                                cata::lua_platform::script_time_duration::from_native(
                                    time_duration::from_turns( duration ) ), key_argument );
                    REQUIRE( call.valid() );
                    const sol::table envelope = call;
                    REQUIRE( envelope["ok"].get<bool>() );
                    const sol::table value = envelope["value"];
                    const sol::table result_keys = value["keys"];
                    CHECK( value["events"].get<int>() == 4 );
                    CHECK( value["when"].get<cata::lua_platform::script_time_point>().to_native() ==
                           expected.front().when );
                    CHECK( key_reads == ( variable_key ? 4 : 0 ) );
                    CHECK( value["key"].get<sol::object>().get_type() ==
                           ( variable_key ? sol::type::nil : sol::type::string ) );
                    REQUIRE( events.get_all().size() == 4 );
                    queued = events.get_all().begin();
                    for( std::size_t i = 0; i < expected.size(); ++i, ++queued ) {
                        CHECK( queued->type == expected[i].type );
                        CHECK( queued->when == expected[i].when );
                        CHECK( queued->faction_id == expected[i].faction_id );
                        CHECK( queued->map_square == expected[i].map_square );
                        CHECK( queued->map_point == expected[i].map_point );
                        CHECK( queued->strength == expected[i].strength );
                        CHECK( queued->string_id == expected[i].string_id );
                        CHECK( queued->key == expected[i].key );
                        CHECK( queued->revert.get_ter( sample ) == expected[i].terrain );
                        CHECK( queued->revert.get_furn( sample ) == expected[i].furniture );
                        CHECK( result_keys[i + 1].get<std::string>() == expected[i].key );
                    }
                }
            }
        }
    }
}

TEST_CASE( "lua_platform_location_revert_provider_owns_snapshots_and_runs_synchronously",
           "[lua][platform][world][semantic]" )
{
    platform_overmap_travel_fixture fixture( 854, 84 );
    platform_calendar_turn_scope calendar_scope;
    timed_event_manager &events = get_timed_events();
    restore_on_out_of_scope<timed_event_manager> restore_events( std::move( events ) );
    events = timed_event_manager();
    const point_abs_omt om_origin = project_to<coords::omt>(
                                        project_to<coords::om>( fixture.source_omt.xy() ) );
    const tripoint_abs_omt source( om_origin + point( 32, 30 ), fixture.source_omt.z() );
    const tripoint_abs_sm base = project_to<coords::sm>( source );
    REQUIRE_FALSE( MAPBUFFER.submap_exists( base ) );
    on_out_of_scope clear_revert_maps( []() {
        MAPBUFFER.clear_outside_reality_bubble();
    } );
    const sol::protected_function revert = fixture.services["world"]["schedule_location_revert"];
    calendar::turn = time_point::from_turn( 1000 );
    const time_point expected_when = timed_event_due_time( 0_turns, 1_seconds );
    int calls = 0;
    std::array<ter_id, 4> before;
    const point_sm_ms sample( 0, 0 );
    ter_id changed = ter_t_floor.id();
    const sol::protected_function_result invalid_key = revert(
                fixture.abs_omt_position( source ),
                cata::lua_platform::script_time_duration::from_native( 0_turns ), 42 );
    CHECK_FALSE( invalid_key.valid() );
    CHECK( events.get_all().empty() );
    CHECK_FALSE( MAPBUFFER.submap_exists( base ) );
    fixture.lua.set_function( "revert_key_provider", [&]() {
        // The first callback must see all four generated submaps. Deliberate
        // native test mutations verify the public provider's snapshot order;
        // legacy string mutators do not mutate these maps or the clock.
        for( int x = 0; x < 2; ++x ) {
            for( int y = 0; y < 2; ++y ) {
                submap *sm = MAPBUFFER.lookup_submap( base + point( x, y ) );
                REQUIRE( sm != nullptr );
                if( calls == 0 ) {
                    before[x * 2 + y] = sm->get_ter( sample );
                    if( x == 0 && y == 0 && before[0] == changed ) {
                        changed = ter_t_dirt.id();
                    }
                }
                sm->set_ter( sample, changed );
            }
        }
        ++calls;
        calendar::turn += 1_hours;
        return "provider-key-" + std::to_string( calls );
    } );
    const sol::protected_function_result call = revert(
                fixture.abs_omt_position( source ),
                cata::lua_platform::script_time_duration::from_native( 0_turns ),
                fixture.lua["revert_key_provider"].get<sol::object>() );
    REQUIRE( call.valid() );
    REQUIRE( call.get<sol::table>()["ok"].get<bool>() );
    CHECK( calls == 4 );
    REQUIRE( events.get_all().size() == 4 );
    std::size_t index = 0;
    for( const timed_event &event : events.get_all() ) {
        CHECK( event.when == expected_when );
        CHECK( event.key == "provider-key-" + std::to_string( index + 1 ) );
        CHECK( event.revert.get_ter( sample ) == ( index == 0 ? before[0] : changed ) );
        ++index;
    }
    fixture.lua["revert_key_provider"] = sol::nil;
    fixture.lua.collect_garbage();
    CHECK( calls == 4 );
    CHECK( events.get_all().size() == 4 );

    events = timed_event_manager();
    int bad_calls = 0;
    fixture.lua.set_function( "bad_revert_key", [&]() -> sol::object {
        ++bad_calls;
        return bad_calls == 3 ? sol::make_object( fixture.lua, 42 ) :
        sol::make_object( fixture.lua, std::string( "already-queued" ) );
    } );
    const sol::protected_function bad_key = fixture.lua["bad_revert_key"];
    const sol::protected_function_result failed = revert(
                fixture.abs_omt_position( source ),
                cata::lua_platform::script_time_duration::from_native( 0_turns ), bad_key );
    CHECK_FALSE( failed.valid() );
    CHECK( bad_calls == 3 );
    CHECK( events.get_all().size() == 2 );
    events = timed_event_manager();
    const sol::protected_function_result omitted = revert(
                fixture.abs_omt_position( source ),
                cata::lua_platform::script_time_duration::from_native( 0_turns ) );
    REQUIRE( omitted.valid() );
    REQUIRE( events.get_all().size() == 4 );
    for( const timed_event &event : events.get_all() ) {
        CHECK( event.key.empty() );
    }
}

TEST_CASE( "lua_platform_location_revert_survives_native_save_and_actualizes",
           "[lua][platform][world][semantic][save]" )
{
    platform_overmap_travel_fixture fixture( 855, 85 );
    platform_calendar_turn_scope calendar_scope;
    platform_world_copy_globals_restore restore_globals;
    timed_event_manager &events = get_timed_events();
    restore_on_out_of_scope<timed_event_manager> restore_events( std::move( events ) );
    const point_abs_omt om_origin = project_to<coords::omt>(
                                        project_to<coords::om>( fixture.source_omt.xy() ) );
    const tripoint_abs_omt source( om_origin + point( 34, 30 ), fixture.source_omt.z() );
    const tripoint_abs_sm base = project_to<coords::sm>( source );
    on_out_of_scope clear_revert_maps( []() {
        MAPBUFFER.clear_outside_reality_bubble();
    } );
    tinymap loaded;
    loaded.load( source, true );
    const point_sm_ms sample( 2, 3 );
    const std::string text = std::string( "saved graffiti" ) + '\0' + "尾部";
    const std::string key = std::string( 300, 'k' ) + '\0' + "tail";
    get_globals().set_global_value( "lua_platform_revert_source",
                                    project_to<coords::ms>( source ) );
    const sol::protected_function revert = fixture.services["world"]["schedule_location_revert"];
    dialogue conversation( get_talker_for( get_avatar() ), get_talker_for( get_avatar() ) );
    for( const bool native_authoring : {
             true, false
         } ) {
        CAPTURE( native_authoring );
        calendar::turn = time_point::from_turn( 1000 );
        events = timed_event_manager();
        for( int x = 0; x < 2; ++x ) {
            for( int y = 0; y < 2; ++y ) {
                submap *sm = MAPBUFFER.lookup_submap( base + point( x, y ) );
                REQUIRE( sm != nullptr );
                const int index = x * 2 + y;
                sm->set_ter( sample, ter_t_dirt.id() );
                sm->set_furn( sample, furn_str_id::NULL_ID() );
                sm->set_trap( sample, trap_str_id::NULL_ID() );
                sm->set_terrain_growth( sample, { time_point::from_turn( 200 + index ) } );
                sm->set_finite_liquid( sample, 17 + index );
                sm->cosmetics.clear();
                sm->set_graffiti( sample, text );
                sm->insert_cosmetic( sample, "ccb-test-decoration", "custom" );
                sm->get_items( sample ).clear();
                sm->get_items( sample ).insert( item( itype_apple, calendar::turn ) );
            }
        }
        if( native_authoring ) {
            std::ostringstream input;
            JsonOut writer( input );
            writer.start_object();
            writer.member( "revert_location" );
            writer.start_object();
            writer.member( "global_val", "lua_platform_revert_source" );
            writer.end_object();
            writer.member( "time_in_future", "0 turns" );
            writer.member( "key", key );
            writer.end_object();
            talk_effect_t native;
            native.parse_sub_effect( json_loader::from_string( input.str() ).get_object(),
                                     "lua_platform_revert_save_native" );
            native.apply( conversation );
        } else {
            const sol::protected_function_result call = revert(
                        fixture.abs_omt_position( source ),
                        cata::lua_platform::script_time_duration::from_native( 0_turns ), key );
            REQUIRE( call.valid() );
            REQUIRE( call.get<sol::table>()["ok"].get<bool>() );
        }
        REQUIRE( events.get_all().size() == 4 );
        const time_point due = events.get_all().front().when;
        std::ostringstream saved;
        JsonOut output( saved );
        timed_event_manager::serialize_all( output );
        events = timed_event_manager();
        timed_event_manager::unserialize_all( json_loader::from_string( saved.str() ).get_array() );
        REQUIRE( events.get_all().size() == 4 );
        std::size_t index = 0;
        for( const timed_event &event : events.get_all() ) {
            CHECK( event.key == key );
            CHECK( event.when == due );
            REQUIRE( event.revert.get_terrain_growth( sample ) != nullptr );
            CHECK( event.revert.get_terrain_growth( sample )->fertilized_at ==
                   time_point::from_turn( 200 + static_cast<int>( index ) ) );
            CHECK( event.revert.get_finite_liquid( sample ) == 17 + static_cast<int>( index ) );
            CHECK( event.revert.get_graffiti( sample ) == text );
            REQUIRE( event.revert.cosmetics.size() == 2 );
            CHECK( event.revert.cosmetics.back().type == "ccb-test-decoration" );
            CHECK( event.revert.cosmetics.back().str == "custom" );
            ++index;
        }
        for( int x = 0; x < 2; ++x ) {
            for( int y = 0; y < 2; ++y ) {
                submap *sm = MAPBUFFER.lookup_submap( base + point( x, y ) );
                sm->set_ter( sample, ter_t_floor.id() );
                sm->clear_terrain_growth( sample );
                sm->set_finite_liquid( sample, 99 );
                sm->cosmetics.clear();
                sm->set_graffiti( sample, "changed after snapshot" );
                sm->get_items( sample ).clear();
            }
        }
        events.process();
        CHECK( events.get_all().size() == 4 );
        calendar::turn = due;
        events.process();
        CHECK( events.get_all().empty() );
        for( int x = 0; x < 2; ++x ) {
            for( int y = 0; y < 2; ++y ) {
                submap *sm = MAPBUFFER.lookup_submap( base + point( x, y ) );
                REQUIRE( sm != nullptr );
                REQUIRE( sm->get_terrain_growth( sample ) != nullptr );
                CHECK( sm->get_ter( sample ) == ter_t_dirt.id() );
                CHECK( sm->get_terrain_growth( sample )->fertilized_at ==
                       time_point::from_turn( 200 + x * 2 + y ) );
                CHECK( sm->get_finite_liquid( sample ) == 17 + x * 2 + y );
                CHECK( sm->get_graffiti( sample ) == text );
                REQUIRE( sm->cosmetics.size() == 2 );
                CHECK( sm->cosmetics.back().str == "custom" );
                REQUIRE( sm->get_items( sample ).size() == 1 );
                CHECK( sm->get_items( sample ).begin()->typeId() == itype_apple );
            }
        }
    }
}

TEST_CASE( "lua_platform_location_revert_loads_legacy_snapshots_without_metadata",
           "[lua][platform][world][semantic][save]" )
{
    timed_event_manager &events = get_timed_events();
    restore_on_out_of_scope<timed_event_manager> restore_events( std::move( events ) );
    const point_sm_ms sample( 2, 3 );
    const tripoint_abs_ms absolute( 12000, 14400, 0 );
    for( const bool uniform : {
             true, false
         } ) {
        CAPTURE( uniform );
        events = timed_event_manager();
        std::ostringstream legacy;
        JsonOut writer( legacy );
        writer.start_array();
        writer.start_object();
        writer.member( "type", timed_event_type::REVERT_SUBMAP );
        writer.member( "when", time_point::from_turn( 1001 ) );
        writer.member( "faction", -1 );
        writer.member( "map_point", project_to<coords::sm>( absolute ) );
        writer.member( "map_square", absolute );
        writer.member( "strength", 0 );
        writer.member( "string_id", "" );
        writer.member( "key", "legacy-key" );
        writer.member( "revert" );
        if( uniform ) {
            writer.write( ter_t_dirt.id() );
        } else {
            writer.start_array();
            writer.start_object();
            writer.member( "point", sample );
            writer.member( "ter", ter_t_dirt.id() );
            writer.member( "furn", furn_str_id::NULL_ID() );
            writer.member( "trap", trap_str_id::NULL_ID() );
            writer.member( "items" );
            writer.start_array();
            writer.end_array();
            writer.end_object();
            writer.end_array();
        }
        writer.end_object();
        writer.end_array();
        timed_event_manager::unserialize_all( json_loader::from_string( legacy.str() ).get_array() );
        REQUIRE( events.get_all().size() == 1 );
        const timed_event &event = events.get_all().front();
        CHECK( event.map_square == absolute );
        CHECK( event.map_point == project_to<coords::sm>( absolute ) );
        CHECK( event.when == time_point::from_turn( 1001 ) );
        CHECK( event.key == "legacy-key" );
        CHECK( event.revert.is_uniform() == uniform );
        CHECK( event.revert.get_ter( sample ) == ter_t_dirt.id() );
        CHECK( event.revert.get_terrain_growth( sample ) == nullptr );
        CHECK_FALSE( event.revert.has_finite_liquid( sample ) );
        CHECK( event.revert.cosmetics.empty() );
    }
}

TEST_CASE( "lua_platform_location_copy_matches_native_timed_submap_copy",
           "[lua][platform][world][semantic]" )
{
    platform_overmap_travel_fixture fixture( 851, 81 );
    platform_calendar_turn_scope calendar_scope;
    platform_world_copy_globals_restore restore_globals;
    calendar::turn = time_point::from_turn( 1000 );

    // Stay outside the reality bubble but within the existing overmap, so
    // submap-copy acceptance does not generate several unrelated overmaps.
    const tripoint_abs_omt source = fixture.source_omt + tripoint( 20, 20, 0 );
    const tripoint_abs_omt destination = source + tripoint( 19, -7, 0 );
    const tripoint_abs_omt missing_source = source + tripoint( 40, 41, 0 );
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
    item cable( itype_power_cord, calendar::turn );
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
    struct parity_case {
        std::string key;
        std::string copy_delay_text;
        time_duration copy_delay;
        std::string retime_delay_text;
        time_duration retime_delay;
    };
    const std::array<parity_case, 7> cases = {{
            {
                "native-duration-spellings", "1t", 1_turns,
                "1 minute 2 seconds", 1_minutes + 2_seconds
            },
            { "", "1 turn", 1_turns, "0 turns", 0_turns },
            { std::string( 300, 'k' ), "0 turns", 0_turns, "-3 turns", -3_turns },
            {
                "任务\"quoted", "-3 turns", -3_turns, "infinite",
                time_duration::from_turns( calendar::INDEFINITELY_LONG )
            },
            {
                std::string( "nul\0key", 7 ), "infinite",
                time_duration::from_turns( calendar::INDEFINITELY_LONG ),
                std::to_string( std::numeric_limits<int>::max() ) + " turns",
                time_duration::from_turns( std::numeric_limits<int>::max() )
            },
            {
                "tp_key", "infinite", time_duration::from_turns( calendar::INDEFINITELY_LONG ),
                "0 turns", 0_turns
            },
            {
                "copy-int-min",
                std::to_string( std::numeric_limits<int>::min() ) + " turns",
                time_duration::from_turns( std::numeric_limits<int>::min() ),
                std::to_string( std::numeric_limits<int>::min() ) + " turns",
                time_duration::from_turns( std::numeric_limits<int>::min() )
            },
        }
    };
    const sol::protected_function copy =
        fixture.services["world"]["schedule_location_copy"];
    REQUIRE( copy.valid() );

    const std::string sentinel_key = "lua-platform-unmatched-sentinel";
    const time_point sentinel_when = time_point::from_turn( 8777 );
    const tripoint_abs_ms sentinel_position( 17, 19, 0 );
    for( const parity_case &test_case : cases ) {
        const std::string &key = test_case.key;
        events = timed_event_manager();
        REQUIRE_FALSE( get_avatar().translocators.knows_translocator( destination ) );
        const JsonValue native_json = json_loader::from_string(
                                          native_location_copy_effect_json(
                                              test_case.copy_delay_text, key ) );
        talk_effect_t native_effect;
        native_effect.parse_sub_effect( native_json.get_object(),
                                        "lua_platform_location_copy_native_parity" );
        native_effect.apply( conversation );
        REQUIRE( events.get_all().size() == 4 );
        REQUIRE( get_avatar().translocators.knows_translocator( destination ) );
        CHECK( serialized_translocator_name( destination ) == "location-copy-source" );

        const std::list<timed_event> &native_queue = events.get_all();
        auto native = native_queue.begin();
        const time_point native_copy_when = timed_event_due_time(
                                                test_case.copy_delay, 1_seconds );
        CHECK( native->when == native_copy_when );
        CHECK( native->when == ( test_case.copy_delay == calendar::INDEFINITELY_LONG_DURATION ||
                                 test_case.copy_delay == time_duration::from_turns(
                                     std::numeric_limits<int>::max() ) ?
                                 time_point::from_turn( std::numeric_limits<int>::max() ) :
                                 calendar::turn + test_case.copy_delay + 1_seconds ) );
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
        const double native_relocation_turn =
            native_cable->get_var( "eoc_cable_relocation_turn", 0.0 );
        CHECK( native_link_target == linked_target + ( destination_position - source_position ) );
        CHECK( native_link_source == tripoint_bub_ms::invalid );
        CHECK( native_relocation_turn == -1.0 );

        events.add( timed_event_type::CUSTOM_LIGHT_LEVEL, sentinel_when, -1,
                    sentinel_position, 72, "sentinel-id", sentinel_key );
        const JsonValue alter_json = json_loader::from_string(
                                         native_alter_timed_events_effect_json(
                                             test_case.retime_delay_text, key ) );
        talk_effect_t native_alter;
        native_alter.parse_sub_effect( alter_json.get_object(),
                                       "lua_platform_location_copy_native_retime" );
        native_alter.apply( conversation );
        const time_point native_retime_when = timed_event_due_time(
                test_case.retime_delay, 0_seconds );
        REQUIRE( events.get_all().size() == 5 );
        native = events.get_all().begin();
        for( int x = 0; x < 2; ++x ) {
            for( int y = 0; y < 2; ++y, ++native ) {
                CHECK( native->key == key );
                CHECK( native->type == timed_event_type::REVERT_SUBMAP );
                CHECK( native->when == native_retime_when );
                CHECK( native->map_square == project_to<coords::ms>(
                           project_to<coords::sm>( destination ) + point( x, y ) ) );
            }
        }
        REQUIRE( native != events.get_all().end() );
        CHECK( native->type == timed_event_type::CUSTOM_LIGHT_LEVEL );
        CHECK( native->when == sentinel_when );
        CHECK( native->key == sentinel_key );
        CHECK( native->faction_id == -1 );
        CHECK( native->map_square == sentinel_position );
        CHECK( native->strength == 72 );
        CHECK( native->string_id == "sentinel-id" );
        ++native;
        CHECK( native == events.get_all().end() );

        std::array<location_copy_event_record, 4> native_records;
        std::size_t record_index = 0;
        native = native_queue.begin();
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
                    cata::lua_platform::script_time_duration::from_native(
                        test_case.copy_delay ), key );
        REQUIRE( platform_result.valid() );
        const sol::table envelope = platform_result.get<sol::table>();
        REQUIRE( envelope["ok"].get<bool>() );
        const sol::table value = envelope["value"].get<sol::table>();
        CHECK( value["when"].get<cata::lua_platform::script_time_point>().to_native() ==
               native_copy_when );
        CHECK( value["key"].get<std::string>() == key );
        CHECK( value["events"].get<int>() == 4 );
        REQUIRE( get_avatar().translocators.knows_translocator( destination ) );
        CHECK( serialized_translocator_name( destination ) == "location-copy-source" );

        events.add( timed_event_type::CUSTOM_LIGHT_LEVEL, sentinel_when, -1,
                    sentinel_position, 72, "sentinel-id", sentinel_key );
        const sol::protected_function reschedule =
            fixture.services["world"]["reschedule_events"];
        REQUIRE( reschedule.valid() );
        const sol::protected_function_result retime_result = reschedule(
                    key,
                    cata::lua_platform::script_time_duration::from_native(
                        test_case.retime_delay ) );
        REQUIRE( retime_result.valid() );
        const sol::table retime_envelope = retime_result.get<sol::table>();
        REQUIRE( retime_envelope["ok"].get<bool>() );
        const sol::table retime_value = retime_envelope["value"].get<sol::table>();
        CHECK( retime_value["matched"].get<std::size_t>() == 4 );
        CHECK( retime_value["key"].get<std::string>() == key );
        CHECK( retime_value["when"].get<cata::lua_platform::script_time_point>().to_native() ==
               native_retime_when );

        const std::list<timed_event> &queued = events.get_all();
        native = queued.begin();
        REQUIRE( queued.size() == 5 );
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
                    CHECK( platform_cable->get_var( "eoc_cable_relocation_turn", 0.0 ) ==
                           native_relocation_turn );
                }
            }
        }
        REQUIRE( native != queued.end() );
        CHECK( native->type == timed_event_type::CUSTOM_LIGHT_LEVEL );
        CHECK( native->when == sentinel_when );
        CHECK( native->key == sentinel_key );
        CHECK( native->faction_id == -1 );
        CHECK( native->map_square == sentinel_position );
        CHECK( native->strength == 72 );
        CHECK( native->string_id == "sentinel-id" );
        ++native;
        CHECK( native == queued.end() );
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

TEST_CASE( "lua_platform_location_copy_provider_owns_each_snapshot_and_fixes_due_time",
           "[lua][platform][world][semantic]" )
{
    platform_overmap_travel_fixture fixture( 859, 89 );
    platform_calendar_turn_scope calendar_scope;
    calendar::turn = time_point::from_turn( 1000 );
    const tripoint_abs_omt source = fixture.source_omt + tripoint( 28, 19, 0 );
    const tripoint_abs_omt destination = source + tripoint( 17, -9, 0 );
    const tripoint_abs_sm source_base = project_to<coords::sm>( source );
    const tripoint_abs_sm destination_base = project_to<coords::sm>( destination );
    on_out_of_scope clear_copy_maps( []() {
        MAPBUFFER.clear_outside_reality_bubble();
    } );
    timed_event_manager &events = get_timed_events();
    restore_on_out_of_scope<timed_event_manager> restore_events( std::move( events ) );
    events = timed_event_manager();
    tinymap source_map;
    source_map.load( source, true );
    const sol::protected_function copy = fixture.services["world"]["schedule_location_copy"];
    const cata::lua_platform::script_time_duration delay =
        cata::lua_platform::script_time_duration::from_native( -3_turns );
    const point_sm_ms sample( 0, 0 );
    const ter_id original = ter_t_floor.id();
    const ter_id changed = ter_t_dirt.id();
    const std::array<std::string, 4> keys = {{
            "", std::string( "raw\0tail", 8 ), std::string( 10000, 'k' ), "copy-last"
        }
    };
    const sol::protected_function_result invalid_key = copy(
                fixture.abs_omt_position( source ), fixture.abs_omt_position( destination ), delay, 42 );
    CHECK_FALSE( invalid_key.valid() );
    CHECK( events.get_all().empty() );
    CHECK_FALSE( MAPBUFFER.submap_exists( destination_base ) );
    int calls = 0;
    fixture.lua.set_function( "copy_key_provider", [&]() {
        for( int x = 0; x < 2; ++x ) {
            for( int y = 0; y < 2; ++y ) {
                REQUIRE( MAPBUFFER.lookup_submap( destination_base + point( x, y ) ) != nullptr );
            }
        }
        CHECK( events.get_all().size() == static_cast<std::size_t>( calls ) );
        const int index = calls++;
        submap *current = MAPBUFFER.lookup_submap( source_base + point( index / 2, index % 2 ) );
        REQUIRE( current != nullptr );
        // The current snapshot is owned already, but the next snapshot must
        // observe changes made by this synchronous callback.
        current->set_ter( sample, original );
        if( index < 3 ) {
            submap *next = MAPBUFFER.lookup_submap(
                               source_base + point( ( index + 1 ) / 2, ( index + 1 ) % 2 ) );
            REQUIRE( next != nullptr );
            next->set_ter( sample, changed );
        }
        calendar::turn += 100_turns;
        return keys[index];
    } );
    for( int x = 0; x < 2; ++x ) {
        for( int y = 0; y < 2; ++y ) {
            submap *sm = MAPBUFFER.lookup_submap( source_base + point( x, y ) );
            REQUIRE( sm != nullptr );
            sm->ensure_nonuniform();
            sm->set_ter( sample, original );
        }
    }
    const time_point expected_when = timed_event_due_time( -3_turns, 1_seconds );
    const sol::protected_function_result call = copy(
                fixture.abs_omt_position( source ), fixture.abs_omt_position( destination ), delay,
                fixture.lua["copy_key_provider"].get<sol::protected_function>() );
    REQUIRE( call.valid() );
    const sol::table response = call.get<sol::table>();
    REQUIRE( response["ok"].get<bool>() );
    const sol::table value = response["value"];
    CHECK( value["key"].get<sol::object>().get_type() == sol::type::nil );
    CHECK( value["when"].get<cata::lua_platform::script_time_point>().to_native() == expected_when );
    CHECK( calls == 4 );
    REQUIRE( events.get_all().size() == 4 );
    const sol::table returned_keys = value["keys"];
    int index = 0;
    for( const timed_event &event : events.get_all() ) {
        CHECK( event.when == expected_when );
        CHECK( event.key == keys[index] );
        CHECK( returned_keys[index + 1].get<std::string>() == keys[index] );
        CHECK( event.map_square == project_to<coords::ms>(
                   destination_base + point( index / 2, index % 2 ) ) );
        CHECK( event.revert.get_ter( sample ) == ( index == 0 ? original : changed ) );
        ++index;
    }
    // Each failure leaves only events from completed earlier calls. Failed
    // operations do not claim success or queue a fabricated fallback key.
    fixture.lua.open_libraries( sol::lib::base );
    for( const std::string &body : {
             std::string( "if copy_calls == 3 then error('copy provider failed') end return 'key'" ),
             std::string( "if copy_calls == 3 then return 42 end return 'key'" ),
             std::string( "if copy_calls == 3 then return end return 'key'" )
         } ) {
        events = timed_event_manager();
        const sol::protected_function_result loaded = fixture.lua.safe_script(
                    "copy_calls=0; function failing_copy_key() copy_calls=copy_calls+1; " + body + " end",
                    sol::script_pass_on_error );
        REQUIRE( loaded.valid() );
        const sol::protected_function_result failed = copy(
                    fixture.abs_omt_position( source ), fixture.abs_omt_position( destination ), delay,
                    fixture.lua["failing_copy_key"].get<sol::protected_function>() );
        CHECK_FALSE( failed.valid() );
        CHECK( fixture.lua["copy_calls"].get<int>() == 3 );
        CHECK( events.get_all().size() == 2 );
    }
    // A nil key remains the constant empty key and needs no provider.
    events = timed_event_manager();
    const sol::protected_function_result nil_key = copy(
                fixture.abs_omt_position( source ), fixture.abs_omt_position( destination ), delay, sol::nil );
    REQUIRE( nil_key.valid() );
    const sol::table nil_response = nil_key.get<sol::table>();
    REQUIRE( nil_response["ok"].get<bool>() );
    const sol::table nil_value = nil_response["value"];
    CHECK( nil_value["key"].get<std::string>().empty() );
    REQUIRE( events.get_all().size() == 4 );
    for( const timed_event &event : events.get_all() ) {
        CHECK( event.key.empty() );
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
        // Restore the exact incoming override; scoped_weather_override resets to WEATHER_NULL.
        // NOLINTNEXTLINE(cata-tests-must-restore-global-state)
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
        for( item &entry : stack )
        {
            if( entry.uid().get_value() == uid ) {
                return &entry;
            }
        }
        return nullptr;
    };
    const auto spawn_through_platform = [&]( const std::string & id ) {
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

    item native_flyer( itype_flyer_evac, calendar::turn );
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

    item native_gun( itype_glock_19, calendar::turn );
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
