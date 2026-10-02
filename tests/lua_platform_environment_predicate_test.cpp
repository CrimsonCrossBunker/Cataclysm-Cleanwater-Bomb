#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include "map_iterator.h"
#include "field.h"
#include "dialogue_helpers.h"
#include <algorithm>
#include <array>
#include <functional>
#include <initializer_list>
#include <limits>
#include <memory>
#include <string>
#include <utility>
#include <vector>

#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "condition.h"
#include "coordinates.h"
#include "debug.h"
#include "dialogue.h"
#include "field_type.h"
#include "flexbuffer_json.h"
#include "global_vars.h"
#include "json_loader.h"
#include "line.h"
#include "lua_platform_bindings_coords.h"
#include "lua_platform_runtime.h"
#include "lua_platform_runtime_internal.h"
#include "lua_platform_sol.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "map_scale_constants.h"
#include "npctalk.h"
#include "player_helpers.h"
#include "worldfactory.h"
#include "trap.h"
#if defined(LOCALIZE)
#include "translation_manager.h"
#include "translations.h"
#endif
#include "type_id.h"
#include "weather.h"
#include "weather_type.h"

static const field_type_str_id field_fd_web( "fd_web" );
static const field_type_str_id field_fd_blood( "fd_blood" );
static const field_type_str_id field_fd_smoke( "fd_smoke" );
static const field_type_str_id field_fd_fire( "fd_fire" );
static const efftype_id effect_webbed_for_test( "webbed" );
static const ter_str_id ter_t_floor( "t_floor" );
static const ter_str_id ter_t_wall( "t_wall" );
static const furn_str_id furn_test_f_eoc( "test_f_eoc" );

static int loaded_adjacent_map_zlevel( map &here, const tripoint_bub_ms &center )
{
    for( const int z : {
             center.z() + 1, center.z() - 1
         } ) {
        if( here.inbounds_z( z ) && map_meddler::get_submap_at_grid( here, tripoint_rel_sm{ center.x() / SEEX,
                center.y() / SEEY, z } ) != nullptr ) {
            return z;
        }
    }
    return center.z();
}

namespace cata::lua_platform
{
class runtime;
} // namespace cata::lua_platform

TEST_CASE( "lua_platform_environment_strings_match_native_predicates",
           "[lua][platform][environment_predicate][semantic]" )
{
    using namespace cata::lua_platform;
    clear_active_runtimes();
    restore_on_out_of_scope restore_turn( calendar::turn );
    restore_on_out_of_scope restore_weather( get_weather().weather_id );
    const bool old_eternal = calendar::eternal_season();
    sol::state lua;
    sol::table ccb = lua.create_table();
    const std::shared_ptr<runtime> owner = make_runtime( "environment_strings", 4902, lua );
    on_out_of_scope cleanup( [old_eternal]() {
        clear_active_runtimes();
        calendar::set_eternal_season( old_eternal );
    } );
    install_runtime_api( owner, lua, ccb );
    set_active_runtimes( { owner } );
    runtime_world_ready( true );
    lua["services"] = ccb["services"];
    dialogue context;
    sol::protected_function season_query = lua.load(
            "return services.time_snapshot().season_id == wanted" );
    for( const bool eternal : {
             false, true
         } ) {
        calendar::set_eternal_season( eternal );
        for( int season = 0; season <= 8; ++season ) {
            for( const time_duration offset : {
                     -1_turns, 0_turns, 1_turns
                     } ) {
                if( season == 0 && offset < 0_turns ) {
                    continue;
                }
                calendar::turn = calendar::turn_zero + calendar::season_length() * season + offset;
                for( const std::string wanted : {
                         "spring", "summer", "autumn", "winter", "", "unknown"
                     } ) {
                    CAPTURE( eternal, season, to_turns<int>( offset ), wanted );
                    lua["wanted"] = wanted;
                    conditional_t legacy( json_loader::from_string(
                                              R"({"is_season":")" + wanted + R"("})" ).get_object() );
                    const sol::protected_function_result actual = season_query();
                    REQUIRE( actual.valid() );
                    CHECK( actual.get<bool>() == legacy( context ) );
                }
            }
        }
    }
    sol::protected_function weather_query = lua.load(
            "return services.weather.current().weather.value == wanted" );
    std::vector<std::string> weather_ids;
    weather_ids.reserve( weather_types::get_all().size() );
    for( const weather_type &definition : weather_types::get_all() ) {
        weather_ids.push_back( definition.id.str() );
    }
    REQUIRE_FALSE( weather_ids.empty() );
    std::vector<std::string> wanted_ids = weather_ids;
    wanted_ids.emplace_back( "" );
    wanted_ids.emplace_back( "unknown" );
    for( const std::string &current : weather_ids ) {
        get_weather().weather_id = weather_type_id( current );
        for( const std::string &wanted : wanted_ids ) {
            CAPTURE( current, wanted );
            lua["wanted"] = wanted;
            conditional_t legacy( json_loader::from_string(
                                      R"({"is_weather":")" + wanted + R"("})" ).get_object() );
            const sol::protected_function_result actual = weather_query();
            REQUIRE( actual.valid() );
            CHECK( actual.get<bool>() == legacy( context ) );
        }
    }

    // Exercise the native str_or_var translation object accepted by these
    // selectors, and compare it with the migration's services.translate path.
    const std::array<std::string, 4> season_ids = { "spring", "summer", "autumn", "winter" };
    const std::string translated_season_source =
        season_ids[season_of_year( calendar::turn )];
    lua["wanted"] = translated_season_source;
    conditional_t translated_season( json_loader::from_string(
                                         R"({"is_season":{"str":")" +
                                         translated_season_source + R"(","i18n":true}})"
                                     ).get_object() );
    sol::protected_function translated_season_query = lua.load(
                "return services.time_snapshot().season_id == services.translate(wanted)" );
    const sol::protected_function_result translated_season_result = translated_season_query();
    REQUIRE( translated_season_result.valid() );
    CHECK( translated_season_result.get<bool>() == translated_season( context ) );

    const std::string translated_weather_source = weather_ids.front();
    get_weather().weather_id = weather_type_id( translated_weather_source );
    lua["wanted"] = translated_weather_source;
    conditional_t translated_weather( json_loader::from_string(
                                          R"({"is_weather":{"str":")" +
                                          translated_weather_source + R"(","i18n":true}})"
                                      ).get_object() );
    sol::protected_function translated_weather_query = lua.load(
                "return services.weather.current().weather.value == services.translate(wanted)" );
    const sol::protected_function_result translated_weather_result = translated_weather_query();
    REQUIRE( translated_weather_result.valid() );
    CHECK( translated_weather_result.get<bool>() == translated_weather( context ) );

#if defined(LOCALIZE)
    // The TEST_DATA Russian MO has a deliberate non-identity mapping to a
    // canonical season ID, so matching predicates prove both paths translate.
    TranslationManager &translation_manager = TranslationManager::GetInstance();
    const std::string old_language = translation_manager.GetCurrentLanguage();
    const std::string intermediate_language = old_language == "en" ? "ru" : "en";
    on_out_of_scope restore_language( [old_language, intermediate_language]() {
        set_language( intermediate_language );
        set_language( old_language );
    } );
    set_language( "ru" );
    translation_manager.LoadDocuments( {
        "./data/mods/TEST_DATA/lang/mo/ru/LC_MESSAGES/TEST_DATA.mo"
    } );

    calendar::set_eternal_season( false );
    restore_on_out_of_scope restore_initial_season( calendar::initial_season );
    calendar::initial_season = SPRING;
    calendar::turn = calendar::turn_zero;
    const std::string localized_spring_source = "__ccb_test_environment_spring__";
    lua["wanted"] = localized_spring_source;
    conditional_t localized_spring( json_loader::from_string(
                                        R"({"is_season":{"str":")" +
                                        localized_spring_source + R"(","i18n":true}})"
                                    ).get_object() );
    const sol::protected_function_result translated_spring = translated_season_query();
    REQUIRE( translated_spring.valid() );
    sol::protected_function translate_query = lua.load( "return services.translate(wanted)" );
    const sol::protected_function_result translated_spring_text = translate_query();
    REQUIRE( translated_spring_text.valid() );
    const std::string translated_spring_value = translated_spring_text.get<std::string>();
    CHECK( translated_spring_value == "spring" );
    CHECK( translated_spring_value != localized_spring_source );
    CHECK( localized_spring( context ) );
    CHECK( translated_spring.get<bool>() == localized_spring( context ) );
    CHECK( translated_spring.get<bool>() );
#endif

    map &here = get_map();
    const tripoint_abs_ms origin = get_avatar().pos_abs();
    const tripoint_abs_ms outside_position = origin + tripoint_rel_ms(
                here.getmapsize() * SEEX, 0, 0 );
    const tripoint_bub_ms outside_bubble = here.get_bub( outside_position );
    REQUIRE_FALSE( here.inbounds( outside_bubble ) );
    lua["outside_position"] = script_tripoint_coord::from_native(
                                  coords::origin::abs, coords::scale::map_square,
                                  outside_position.raw() );
    const sol::protected_function outside_query = lua.load(
                "return services.gameplay.environment.is_outside(outside_position)" );
    const sol::protected_function_result outside_result = outside_query();
    REQUIRE( outside_result.valid() );
    CHECK( outside_result.get<bool>() == here.is_outside( outside_bubble ) );

    const sol::protected_function character_snapshot_query = lua.load(
                "local snapshot = services.characters.snapshot(services.characters.avatar()); "
                "return snapshot.ok and snapshot.value.environment.outside" );
    const sol::protected_function_result character_snapshot_result =
        character_snapshot_query();
    REQUIRE( character_snapshot_result.valid() );
    CHECK( character_snapshot_result.get<bool>() == is_creature_outside( get_avatar() ) );

    const sol::protected_function creature_snapshot_query = lua.load(
                "local snapshot = services.creatures.snapshot(services.characters.avatar()); "
                "return snapshot.ok and snapshot.value.outside" );
    const sol::protected_function_result creature_snapshot_result =
        creature_snapshot_query();
    REQUIRE( creature_snapshot_result.valid() );
    CHECK( creature_snapshot_result.get<bool>() == is_creature_outside( get_avatar() ) );
}

TEST_CASE( "lua_platform_environment_set_furniture_matches_bounded_map_semantics",
           "[lua][platform][environment_mutation][semantic]" )
{
    using namespace cata::lua_platform;
    clear_active_runtimes();
    clear_map_without_vision();
    clear_avatar();
    sol::state lua;
    lua.open_libraries( sol::lib::base );
    sol::table ccb = lua.create_table();
    const std::shared_ptr<runtime> owner = make_runtime( "environment_set_furniture", 4904, lua );
    on_out_of_scope cleanup( []() {
        clear_active_runtimes();
        runtime_world_ready( false );
    } );
    install_runtime_api( owner, lua, ccb );
    set_active_runtimes( { owner } );
    runtime_world_ready( true );
    lua["services"] = ccb["services"];

    map &here = get_map();
    const int map_width = here.getmapsize() * SEEX;
    const int map_height = here.getmapsize() * SEEY;
    const tripoint_abs_ms actor_abs = get_avatar().pos_abs();
    const tripoint_bub_ms actor_bubble = here.get_bub( actor_abs );
    REQUIRE( here.inbounds( actor_bubble ) );
    tripoint_bub_ms center( map_width / 2, map_height / 2, actor_bubble.z() );
    if( trig_dist( center, actor_bubble ) < 3.0f ) {
        const int offset_x = actor_bubble.x() + 7 < map_width ? 7 : -7;
        const int offset_y = actor_bubble.y() + 7 < map_height ? 7 : -7;
        center = actor_bubble + tripoint_rel_ms( offset_x, offset_y, 0 );
    }
    REQUIRE( trig_dist( center, actor_bubble ) >= 3.0f );
    const tripoint_bub_ms edge = center + tripoint_rel_ms( 2, 1, 0 );
    const tripoint_bub_ms corner = center + tripoint_rel_ms( 2, 2, 0 );
    const tripoint_abs_ms center_abs = here.get_abs( center );
    const tripoint_bub_ms far_center( -32767, -32767, center.z() );
    const tripoint_bub_ms far_corner( 0, 0, center.z() );
    const tripoint_abs_ms far_abs = here.get_abs( far_center );
    const tripoint_abs_ms out_of_bounds_z_abs( std::numeric_limits<int>::max(),
            std::numeric_limits<int>::lowest(), std::numeric_limits<int>::max() );
    lua["center_position"] = script_tripoint_coord::from_native(
                                 coords::origin::abs, coords::scale::map_square, center_abs.raw() );
    lua["actor_position"] = script_tripoint_coord::from_native(
                                coords::origin::abs, coords::scale::map_square, actor_abs.raw() );
    lua["far_position"] = script_tripoint_coord::from_native(
                              coords::origin::abs, coords::scale::map_square, far_abs.raw() );
    lua["out_of_bounds_z_position"] = script_tripoint_coord::from_native(
                                          coords::origin::abs, coords::scale::map_square,
                                          out_of_bounds_z_abs.raw() );
    const std::string clear_furniture_id = furn_str_id::NULL_ID().str();
    lua["clear_furniture_id"] = clear_furniture_id;

    REQUIRE( furn_test_f_eoc.is_valid() );
    REQUIRE( here.furn_set( actor_bubble, furn_test_f_eoc.id() ) );
    REQUIRE( here.furn_set( center, furn_test_f_eoc.id() ) );
    REQUIRE( here.furn_set( edge, furn_test_f_eoc.id() ) );
    REQUIRE( here.furn_set( corner, furn_test_f_eoc.id() ) );

    const tripoint_bub_ms edge_center( 1, 1, center.z() );
    REQUIRE( here.inbounds( edge_center ) );
    const tripoint_abs_ms edge_center_abs = here.get_abs( edge_center );
    lua["edge_center_position"] = script_tripoint_coord::from_native(
                                      coords::origin::abs, coords::scale::map_square,
                                      edge_center_abs.raw() );
    std::array<ter_id, 25> edge_original_terrain;
    std::array<furn_id, 25> edge_original_furniture;
    std::array<bool, 25> edge_inbounds{};
    for( int dy = -2; dy <= 2; ++dy ) {
        for( int dx = -2; dx <= 2; ++dx ) {
            const tripoint_bub_ms position = edge_center + tripoint_rel_ms( dx, dy, 0 );
            const std::size_t index = static_cast<std::size_t>( ( dy + 2 ) * 5 + dx + 2 );
            edge_inbounds[index] = here.inbounds( position );
            if( edge_inbounds[index] ) {
                edge_original_terrain[index] = here.ter( position );
                edge_original_furniture[index] = here.furn( position );
            }
        }
    }
    on_out_of_scope restore_edge_area( [&]() {
        for( int dy = -2; dy <= 2; ++dy ) {
            for( int dx = -2; dx <= 2; ++dx ) {
                const std::size_t index = static_cast<std::size_t>( ( dy + 2 ) * 5 + dx + 2 );
                if( edge_inbounds[index] ) {
                    const tripoint_bub_ms position = edge_center + tripoint_rel_ms( dx, dy, 0 );
                    here.ter_set( position, edge_original_terrain[index] );
                    here.furn_set( position, edge_original_furniture[index] );
                }
            }
        }
    } );
    for( int dy = -2; dy <= 2; ++dy ) {
        for( int dx = -2; dx <= 2; ++dx ) {
            const std::size_t index = static_cast<std::size_t>( ( dy + 2 ) * 5 + dx + 2 );
            if( edge_inbounds[index] ) {
                const tripoint_bub_ms position = edge_center + tripoint_rel_ms( dx, dy, 0 );
                here.ter_set( position, ter_t_floor );
                here.furn_set( position, furn_test_f_eoc.id() );
                REQUIRE( here.ter( position ) == ter_t_floor.id() );
                REQUIRE( here.furn( position ) == furn_test_f_eoc.id() );
            }
        }
    }
    const std::string edge_location_key = "lua_platform_set_furniture_edge_semantics_center";
    REQUIRE( get_globals().maybe_get_global_value( edge_location_key ) == nullptr );
    on_out_of_scope clear_edge_location( [&]() {
        get_globals().remove_global_value( edge_location_key );
    } );
    get_globals().set_global_value( edge_location_key, edge_center_abs );
    const std::string edge_effect_json =
        R"({"set_furniture":")" + clear_furniture_id +
        R"(","location":{"global_val":"lua_platform_set_furniture_edge_semantics_center"},"radius":2})";
    talk_effect_t edge_native_effect;
    edge_native_effect.parse_sub_effect( json_loader::from_string( edge_effect_json ).get_object(),
                                         "lua_platform_set_furniture_edge_semantics" );
    dialogue edge_native_context;
    const std::string native_edge_diagnostic = capture_debugmsg_during( [&]() {
        for( const talk_effect_fun_t &operation : edge_native_effect.effects ) {
            operation( edge_native_context );
        }
    } );
    CHECK( native_edge_diagnostic.find( "map::furn_set" ) != std::string::npos );
    CHECK( native_edge_diagnostic.find( "out of bounds" ) != std::string::npos );
    get_globals().remove_global_value( edge_location_key );
    std::array<bool, 25> native_edge_furniture_cleared{};
    int native_edge_furniture_count = 0;
    for( int dy = -2; dy <= 2; ++dy ) {
        for( int dx = -2; dx <= 2; ++dx ) {
            const std::size_t index = static_cast<std::size_t>( ( dy + 2 ) * 5 + dx + 2 );
            if( edge_inbounds[index] ) {
                const tripoint_bub_ms position = edge_center + tripoint_rel_ms( dx, dy, 0 );
                native_edge_furniture_cleared[index] = here.furn( position ) == furn_str_id::NULL_ID().id();
                native_edge_furniture_count += native_edge_furniture_cleared[index] ? 1 : 0;
                here.furn_set( position, furn_test_f_eoc.id() );
                REQUIRE( here.furn( position ) == furn_test_f_eoc.id() );
            }
        }
    }
    lua["clear_furniture_id"] = clear_furniture_id;
    sol::protected_function_result edge_furniture_result;
    {
        cata::lua_platform::detail::callback_scope active_callback( *owner );
        edge_furniture_result = lua.safe_script(
                                    "return services.gameplay.environment.set_furniture("
                                    "edge_center_position, clear_furniture_id, 2, false, false)",
                                    sol::script_pass_on_error );
    }
    if( !edge_furniture_result.valid() ) {
        const sol::error error = edge_furniture_result;
        INFO( error.what() );
    }
    REQUIRE( edge_furniture_result.valid() );
    CHECK( edge_furniture_result.get<int>() == native_edge_furniture_count );
    for( int dy = -2; dy <= 2; ++dy ) {
        for( int dx = -2; dx <= 2; ++dx ) {
            const std::size_t index = static_cast<std::size_t>( ( dy + 2 ) * 5 + dx + 2 );
            if( edge_inbounds[index] ) {
                const tripoint_bub_ms position = edge_center + tripoint_rel_ms( dx, dy, 0 );
                CHECK( ( here.furn( position ) == furn_str_id::NULL_ID().id() ) ==
                       native_edge_furniture_cleared[index] );
            }
        }
    }

    if( !here.supports_zlevels() ) {
        const std::string location_key = "lua_platform_set_furniture_z_semantics_center";
        REQUIRE( get_globals().maybe_get_global_value( location_key ) == nullptr );
        on_out_of_scope clear_location( [&]() {
            get_globals().remove_global_value( location_key );
        } );
        const std::string effect_json =
            R"({"set_furniture":")" + clear_furniture_id +
            R"(","location":{"global_val":"lua_platform_set_furniture_z_semantics_center"},"radius":0})";
        const auto run_native_effect_at_z = [&]( const int z ) {
            get_globals().set_global_value( location_key,
                                            here.get_abs( tripoint_bub_ms( center.x(), center.y(), z ) ) );
            talk_effect_t native_effect;
            native_effect.parse_sub_effect( json_loader::from_string( effect_json ).get_object(),
                                            "lua_platform_set_furniture_z_semantics" );
            dialogue native_context;
            for( const talk_effect_fun_t &operation : native_effect.effects ) {
                operation( native_context );
            }
            get_globals().remove_global_value( location_key );
        };
        for( const int z : {
                 -OVERMAP_DEPTH, OVERMAP_HEIGHT, -OVERMAP_DEPTH - 1,
                 OVERMAP_HEIGHT + 1
             } ) {
            const tripoint_bub_ms target( center.x(), center.y(), z );
            lua["boundary_position"] = script_tripoint_coord::from_native(
                                           coords::origin::abs, coords::scale::map_square,
                                           here.get_abs( target ).raw() );
            REQUIRE( here.furn_set( center, furn_test_f_eoc.id() ) );
            run_native_effect_at_z( z );
            const furn_id native_result = here.furn( center );
            const int native_accepted = native_result == furn_str_id::NULL_ID().id() ? 1 : 0;

            REQUIRE( here.furn_set( center, furn_test_f_eoc.id() ) );
            sol::protected_function_result lua_result;
            {
                cata::lua_platform::detail::callback_scope active_callback( *owner );
                lua_result = lua.safe_script(
                                 "return services.gameplay.environment.set_furniture("
                                 "boundary_position, clear_furniture_id, 0, false, false)",
                                 sol::script_pass_on_error );
            }
            if( !lua_result.valid() ) {
                const sol::error error = lua_result;
                INFO( error.what() );
            }
            REQUIRE( lua_result.valid() );
            CHECK( lua_result.get<int>() == native_accepted );
            CHECK( here.furn( center ) == native_result );
        }
    } else {
        const int target_z = loaded_adjacent_map_zlevel( here, center );
        REQUIRE( target_z != center.z() );
        const tripoint_bub_ms target( center.x(), center.y(), target_z );
        REQUIRE( map_meddler::get_submap_at_grid( here, tripoint_rel_sm{ target.x() / SEEX, target.y() / SEEY, target_z } ) !=
                 nullptr );
        const ter_id original_target_terrain = here.ter( target );
        const ter_id original_current_terrain = here.ter( center );
        const furn_id original_target = here.furn( target );
        const furn_id original_current = here.furn( center );
        on_out_of_scope restore_furniture( [&]() {
            here.ter_set( target, original_target_terrain );
            here.ter_set( center, original_current_terrain );
            here.furn_set( target, original_target );
            here.furn_set( center, original_current );
        } );

        const std::string location_key = "lua_platform_set_furniture_loaded_z_semantics_center";
        REQUIRE( get_globals().maybe_get_global_value( location_key ) == nullptr );
        on_out_of_scope clear_location( [&]() {
            get_globals().remove_global_value( location_key );
        } );
        const std::string effect_json =
            R"({"set_furniture":")" + clear_furniture_id +
            R"(","location":{"global_val":"lua_platform_set_furniture_loaded_z_semantics_center"},"radius":0})";
        const tripoint_abs_ms target_abs = here.get_abs( target );
        lua["loaded_z_position"] = script_tripoint_coord::from_native(
                                       coords::origin::abs, coords::scale::map_square,
                                       target_abs.raw() );

        here.ter_set( target, ter_t_floor );
        here.ter_set( center, ter_t_floor );
        REQUIRE( here.furn_set( target, furn_test_f_eoc.id() ) );
        REQUIRE( here.furn_set( center, furn_test_f_eoc.id() ) );
        get_globals().set_global_value( location_key, target_abs );
        talk_effect_t native_effect;
        native_effect.parse_sub_effect( json_loader::from_string( effect_json ).get_object(),
                                        "lua_platform_set_furniture_loaded_z_semantics" );
        dialogue native_context;
        for( const talk_effect_fun_t &operation : native_effect.effects ) {
            operation( native_context );
        }
        get_globals().remove_global_value( location_key );
        const furn_id native_target = here.furn( target );
        const furn_id native_current = here.furn( center );
        const int native_accepted = native_target == furn_str_id::NULL_ID().id() ? 1 : 0;
        CHECK( native_target == furn_str_id::NULL_ID().id() );
        CHECK( native_current == furn_test_f_eoc.id() );

        REQUIRE( here.furn_set( target, furn_test_f_eoc.id() ) );
        REQUIRE( here.furn_set( center, furn_test_f_eoc.id() ) );
        sol::protected_function_result lua_result;
        {
            cata::lua_platform::detail::callback_scope active_callback( *owner );
            lua_result = lua.safe_script(
                             "return services.gameplay.environment.set_furniture("
                             "loaded_z_position, clear_furniture_id, 0, false, false)",
                             sol::script_pass_on_error );
        }
        if( !lua_result.valid() ) {
            const sol::error error = lua_result;
            INFO( error.what() );
        }
        REQUIRE( lua_result.valid() );
        CHECK( lua_result.get<int>() == native_accepted );
        CHECK( here.furn( target ) == native_target );
        CHECK( here.furn( center ) == native_current );
    }
    {
        cata::lua_platform::detail::callback_scope active_callback( *owner );
        const sol::protected_function_result result = lua.safe_script( R"(
            local environment = services.gameplay.environment
            -- The native default is a circle; radius 2 includes (2, 1) but not (2, 2).
            assert(environment.set_furniture(
                center_position, clear_furniture_id, 2, false, false) == 21)
            assert(not pcall(environment.set_furniture,
                center_position, "missing_furniture_id", 0))
        )", sol::script_pass_on_error );
        if( !result.valid() ) {
            const sol::error error = result;
            INFO( error.what() );
        }
        REQUIRE( result.valid() );
    }
    CHECK( here.furn( actor_bubble ) == furn_test_f_eoc.id() );
    CHECK( here.furn( edge ) == furn_str_id::NULL_ID().id() );
    CHECK( here.furn( corner ) == furn_test_f_eoc.id() );

    REQUIRE( here.furn_set( center, furn_test_f_eoc.id() ) );
    REQUIRE( here.furn_set( edge, furn_test_f_eoc.id() ) );
    {
        cata::lua_platform::detail::callback_scope active_callback( *owner );
        const sol::protected_function_result result = lua.safe_script(
                    "assert(services.gameplay.environment.set_furniture("
                    "center_position, clear_furniture_id, 2, true, false) == 25)",
                    sol::script_pass_on_error );
        if( !result.valid() ) {
            const sol::error error = result;
            INFO( error.what() );
        }
        REQUIRE( result.valid() );
    }
    CHECK( here.furn( corner ) == furn_str_id::NULL_ID().id() );

    REQUIRE( here.furn_set( center, furn_test_f_eoc.id() ) );
    REQUIRE( here.furn_set( edge, furn_test_f_eoc.id() ) );
    {
        cata::lua_platform::detail::callback_scope active_callback( *owner );
        const sol::protected_function_result result = lua.safe_script(
                    "assert(services.gameplay.environment.set_furniture("
                    "center_position, clear_furniture_id) == 9)",
                    sol::script_pass_on_error );
        if( !result.valid() ) {
            const sol::error error = result;
            INFO( error.what() );
        }
        REQUIRE( result.valid() );
    }
    CHECK( here.furn( edge ) == furn_test_f_eoc.id() );

    REQUIRE( here.furn_set( center, furn_test_f_eoc.id() ) );
    REQUIRE( here.furn_set( edge, furn_test_f_eoc.id() ) );
    REQUIRE( here.furn_set( far_corner, furn_test_f_eoc.id() ) );
    {
        cata::lua_platform::detail::callback_scope active_callback( *owner );
        const sol::protected_function_result result = lua.safe_script( R"(
            local environment = services.gameplay.environment
            -- 1.9 truncates to radius 1; (2, 1) remains outside the circle.
            assert(environment.set_furniture(
                center_position, clear_furniture_id, 1.9, false, false) == 9)
            -- The extreme corner delta is still evaluated with bounded int64 arithmetic.
            assert(environment.set_furniture(
                far_position, clear_furniture_id, 32767, false, false) == 0)
            assert(not pcall(environment.set_furniture,
                far_position, clear_furniture_id, 32768, false, false))
            -- Out-of-range z-levels and distant coordinates are not loaded.
            assert(environment.set_furniture(
                out_of_bounds_z_position, clear_furniture_id, 0, false, false) == 0)
        )", sol::script_pass_on_error );
        if( !result.valid() ) {
            const sol::error error = result;
            INFO( error.what() );
        }
        REQUIRE( result.valid() );
    }
    CHECK( here.furn( edge ) == furn_test_f_eoc.id() );
    CHECK( here.furn( center ) == furn_str_id::NULL_ID().id() );
    CHECK( here.furn( far_corner ) == furn_test_f_eoc.id() );

    const tripoint_bub_ms actor_position = here.get_bub( actor_abs );
    REQUIRE( here.furn_set( actor_position, furn_test_f_eoc.id() ) );
    {
        cata::lua_platform::detail::callback_scope active_callback( *owner );
        const sol::protected_function_result result = lua.safe_script( R"(
            local environment = services.gameplay.environment
            assert(environment.set_furniture(
                actor_position, clear_furniture_id, 0, false, true) == 0)
            assert(environment.set_furniture(
                actor_position, clear_furniture_id, 0, false, false) == 1)
        )", sol::script_pass_on_error );
        if( !result.valid() ) {
            const sol::error error = result;
            INFO( error.what() );
        }
        REQUIRE( result.valid() );
    }
    CHECK( here.furn( actor_position ) == furn_str_id::NULL_ID().id() );
}

TEST_CASE( "lua_platform_environment_set_terrain_matches_native_eoc_area_semantics",
           "[lua][platform][environment_mutation][semantic]" )
{
    using namespace cata::lua_platform;
    clear_active_runtimes();
    clear_map_without_vision();
    clear_avatar();
    sol::state lua;
    lua.open_libraries( sol::lib::base );
    sol::table ccb = lua.create_table();
    const std::shared_ptr<runtime> owner = make_runtime( "environment_set_terrain", 4905, lua );
    on_out_of_scope cleanup( []() {
        clear_active_runtimes();
        runtime_world_ready( false );
    } );
    install_runtime_api( owner, lua, ccb );
    set_active_runtimes( { owner } );
    runtime_world_ready( true );
    lua["services"] = ccb["services"];

    map &here = get_map();
    REQUIRE( ter_t_floor.is_valid() );
    REQUIRE( ter_t_wall.is_valid() );
    const int map_width = here.getmapsize() * SEEX;
    const int map_height = here.getmapsize() * SEEY;
    const tripoint_bub_ms actor_center = here.get_bub( get_avatar().pos_abs() );
    REQUIRE( here.inbounds( actor_center ) );
    REQUIRE( here.inbounds( actor_center + tripoint_rel_ms( -2, -2, 0 ) ) );
    REQUIRE( here.inbounds( actor_center + tripoint_rel_ms( 2, 2, 0 ) ) );
    tripoint_bub_ms center( map_width / 2, map_height / 2, actor_center.z() );
    if( trig_dist( center, actor_center ) < 3.0f ) {
        center = actor_center + tripoint_rel_ms( 7, 7, 0 );
        if( !here.inbounds( center + tripoint_rel_ms( 2, 2, 0 ) ) ) {
            center = actor_center + tripoint_rel_ms( -7, -7, 0 );
        }
    }
    REQUIRE( here.inbounds( center + tripoint_rel_ms( -2, -2, 0 ) ) );
    REQUIRE( here.inbounds( center + tripoint_rel_ms( 2, 2, 0 ) ) );

    const std::string location_key = "lua_platform_set_terrain_semantics_center";
    REQUIRE( get_globals().maybe_get_global_value( location_key ) == nullptr );
    on_out_of_scope clear_location( [&]() {
        get_globals().remove_global_value( location_key );
    } );
    const std::string terrain_id = ter_t_wall.str();
    lua["terrain_position"] = script_tripoint_coord::from_native(
                                  coords::origin::abs, coords::scale::map_square,
                                  here.get_abs( center ).raw() );
    lua["terrain_id"] = terrain_id;
    const tripoint_abs_ms out_of_bounds_z_abs( std::numeric_limits<int>::max(),
            std::numeric_limits<int>::lowest(), OVERMAP_HEIGHT + 1 );
    lua["out_of_bounds_z_position"] = script_tripoint_coord::from_native(
                                          coords::origin::abs, coords::scale::map_square,
                                          out_of_bounds_z_abs.raw() );

    struct terrain_area_case {
        tripoint_bub_ms center;
        double radius;
        bool square;
        bool avoid_creatures;
        int expected_changed;
    };
    const std::array<terrain_area_case, 4> cases = {{
            { center, 2.0, false, false, 21 },
            { center, 2.0, true, false, 25 },
            { center, 1.9, false, false, 9 },
            { actor_center, 1.0, false, true, -1 },
        }
    };

    for( const terrain_area_case &test_case : cases ) {
        lua["terrain_position"] = script_tripoint_coord::from_native(
                                      coords::origin::abs, coords::scale::map_square,
                                      here.get_abs( test_case.center ).raw() );
        std::array<ter_id, 25> original;
        for( int dy = -2; dy <= 2; ++dy ) {
            for( int dx = -2; dx <= 2; ++dx ) {
                const tripoint_bub_ms position = test_case.center + tripoint_rel_ms( dx, dy, 0 );
                REQUIRE( here.inbounds( position ) );
                const std::size_t index = static_cast<std::size_t>( ( dy + 2 ) * 5 + dx + 2 );
                original[index] = here.ter( position );
                here.ter_set( position, ter_t_floor );
            }
        }
        on_out_of_scope restore_terrain( [&]() {
            for( int dy = -2; dy <= 2; ++dy ) {
                for( int dx = -2; dx <= 2; ++dx ) {
                    const tripoint_bub_ms position = test_case.center + tripoint_rel_ms( dx, dy, 0 );
                    const std::size_t index = static_cast<std::size_t>( ( dy + 2 ) * 5 + dx + 2 );
                    here.ter_set( position, original[index] );
                }
            }
        } );

        get_globals().set_global_value( location_key, here.get_abs( test_case.center ) );
        std::string effect_json =
            R"({"set_terrain":"t_wall","location":{"global_val":"lua_platform_set_terrain_semantics_center"},"radius":)"
            +
            std::to_string( test_case.radius ) +
        ",\"square\":" + ( test_case.square ? "true" : "false" ) +
        ",\"avoid_creatures\":" + ( test_case.avoid_creatures ? "true" : "false" ) + "}";
        talk_effect_t native_effect;
        native_effect.parse_sub_effect( json_loader::from_string( effect_json ).get_object(),
                                        "lua_platform_set_terrain_semantics" );
        dialogue native_context;
        for( const talk_effect_fun_t &operation : native_effect.effects ) {
            operation( native_context );
        }
        get_globals().remove_global_value( location_key );

        std::array<ter_id, 25> native_result;
        int native_changed = 0;
        for( int dy = -2; dy <= 2; ++dy ) {
            for( int dx = -2; dx <= 2; ++dx ) {
                const tripoint_bub_ms position = test_case.center + tripoint_rel_ms( dx, dy, 0 );
                const std::size_t index = static_cast<std::size_t>( ( dy + 2 ) * 5 + dx + 2 );
                native_result[index] = here.ter( position );
                native_changed += native_result[index] == ter_t_wall.id() ? 1 : 0;
            }
        }
        if( test_case.expected_changed >= 0 ) {
            CHECK( native_changed == test_case.expected_changed );
        }

        for( int dy = -2; dy <= 2; ++dy ) {
            for( int dx = -2; dx <= 2; ++dx ) {
                const tripoint_bub_ms position = test_case.center + tripoint_rel_ms( dx, dy, 0 );
                here.ter_set( position, ter_t_floor );
            }
        }
        const std::string call =
            "return services.gameplay.environment.set_terrain(terrain_position, terrain_id, " +
            std::to_string( test_case.radius ) + ", " +
            ( test_case.square ? "true" : "false" ) + ", " +
            ( test_case.avoid_creatures ? "true" : "false" ) + ")";
        sol::protected_function_result lua_result;
        {
            cata::lua_platform::detail::callback_scope active_callback( *owner );
            lua_result = lua.safe_script( call, sol::script_pass_on_error );
        }
        if( !lua_result.valid() ) {
            const sol::error error = lua_result;
            INFO( error.what() );
        }
        REQUIRE( lua_result.valid() );
        CHECK( lua_result.get<int>() == native_changed );
        for( int dy = -2; dy <= 2; ++dy ) {
            for( int dx = -2; dx <= 2; ++dx ) {
                const tripoint_bub_ms position = test_case.center + tripoint_rel_ms( dx, dy, 0 );
                const std::size_t index = static_cast<std::size_t>( ( dy + 2 ) * 5 + dx + 2 );
                CHECK( here.ter( position ) == native_result[index] );
            }
        }
    }

    const tripoint_bub_ms edge_center( 1, 1, center.z() );
    REQUIRE( here.inbounds( edge_center ) );
    const tripoint_abs_ms edge_center_abs = here.get_abs( edge_center );
    lua["terrain_position"] = script_tripoint_coord::from_native(
                                  coords::origin::abs, coords::scale::map_square,
                                  edge_center_abs.raw() );
    std::array<ter_id, 25> edge_original;
    std::array<bool, 25> edge_inbounds{};
    for( int dy = -2; dy <= 2; ++dy ) {
        for( int dx = -2; dx <= 2; ++dx ) {
            const tripoint_bub_ms position = edge_center + tripoint_rel_ms( dx, dy, 0 );
            const std::size_t index = static_cast<std::size_t>( ( dy + 2 ) * 5 + dx + 2 );
            edge_inbounds[index] = here.inbounds( position );
            if( edge_inbounds[index] ) {
                edge_original[index] = here.ter( position );
            }
        }
    }
    on_out_of_scope restore_edge_terrain( [&]() {
        for( int dy = -2; dy <= 2; ++dy ) {
            for( int dx = -2; dx <= 2; ++dx ) {
                const std::size_t index = static_cast<std::size_t>( ( dy + 2 ) * 5 + dx + 2 );
                if( edge_inbounds[index] ) {
                    const tripoint_bub_ms position = edge_center + tripoint_rel_ms( dx, dy, 0 );
                    here.ter_set( position, edge_original[index] );
                }
            }
        }
    } );
    for( int dy = -2; dy <= 2; ++dy ) {
        for( int dx = -2; dx <= 2; ++dx ) {
            const std::size_t index = static_cast<std::size_t>( ( dy + 2 ) * 5 + dx + 2 );
            if( edge_inbounds[index] ) {
                const tripoint_bub_ms position = edge_center + tripoint_rel_ms( dx, dy, 0 );
                here.ter_set( position, ter_t_floor );
                REQUIRE( here.ter( position ) == ter_t_floor.id() );
            }
        }
    }
    get_globals().set_global_value( location_key, edge_center_abs );
    const std::string edge_effect_json =
        R"({"set_terrain":"t_wall","location":{"global_val":"lua_platform_set_terrain_semantics_center"},"radius":2})";
    talk_effect_t edge_native_effect;
    edge_native_effect.parse_sub_effect( json_loader::from_string( edge_effect_json ).get_object(),
                                         "lua_platform_set_terrain_edge_semantics" );
    dialogue edge_native_context;
    for( const talk_effect_fun_t &operation : edge_native_effect.effects ) {
        operation( edge_native_context );
    }
    get_globals().remove_global_value( location_key );
    std::array<bool, 25> native_edge_coverage{};
    int native_edge_changed = 0;
    for( int dy = -2; dy <= 2; ++dy ) {
        for( int dx = -2; dx <= 2; ++dx ) {
            const std::size_t index = static_cast<std::size_t>( ( dy + 2 ) * 5 + dx + 2 );
            if( edge_inbounds[index] ) {
                const tripoint_bub_ms position = edge_center + tripoint_rel_ms( dx, dy, 0 );
                native_edge_coverage[index] = here.ter( position ) == ter_t_wall.id();
                native_edge_changed += native_edge_coverage[index] ? 1 : 0;
                here.ter_set( position, ter_t_floor );
                REQUIRE( here.ter( position ) == ter_t_floor.id() );
            }
        }
    }
    sol::protected_function_result edge_terrain_result;
    {
        cata::lua_platform::detail::callback_scope active_callback( *owner );
        edge_terrain_result = lua.safe_script(
                                  "return services.gameplay.environment.set_terrain("
                                  "terrain_position, terrain_id, 2, false, false)",
                                  sol::script_pass_on_error );
    }
    if( !edge_terrain_result.valid() ) {
        const sol::error error = edge_terrain_result;
        INFO( error.what() );
    }
    REQUIRE( edge_terrain_result.valid() );
    CHECK( edge_terrain_result.get<int>() == native_edge_changed );
    for( int dy = -2; dy <= 2; ++dy ) {
        for( int dx = -2; dx <= 2; ++dx ) {
            const std::size_t index = static_cast<std::size_t>( ( dy + 2 ) * 5 + dx + 2 );
            if( edge_inbounds[index] ) {
                const tripoint_bub_ms position = edge_center + tripoint_rel_ms( dx, dy, 0 );
                CHECK( ( here.ter( position ) == ter_t_wall.id() ) == native_edge_coverage[index] );
            }
        }
    }

    sol::protected_function_result out_of_bounds_z_result;
    {
        cata::lua_platform::detail::callback_scope active_callback( *owner );
        out_of_bounds_z_result = lua.safe_script(
                                     "return services.gameplay.environment.set_terrain("
                                     "out_of_bounds_z_position, terrain_id, 0, false, false)",
                                     sol::script_pass_on_error );
    }
    if( !out_of_bounds_z_result.valid() ) {
        const sol::error error = out_of_bounds_z_result;
        INFO( error.what() );
    }
    REQUIRE( out_of_bounds_z_result.valid() );
    CHECK( out_of_bounds_z_result.get<int>() == 0 );

    if( !here.supports_zlevels() ) {
        const ter_id original_terrain = here.ter( center );
        on_out_of_scope restore_center_terrain( [&]() {
            here.ter_set( center, original_terrain );
        } );
        const std::string z_effect_json =
            R"({"set_terrain":"t_wall","location":{"global_val":"lua_platform_set_terrain_semantics_center"},"radius":0})";
        for( const int z : {
                 -OVERMAP_DEPTH, OVERMAP_HEIGHT, -OVERMAP_DEPTH - 1,
                 OVERMAP_HEIGHT + 1
             } ) {
            const tripoint_bub_ms target( center.x(), center.y(), z );
            lua["boundary_position"] = script_tripoint_coord::from_native(
                                           coords::origin::abs, coords::scale::map_square,
                                           here.get_abs( target ).raw() );

            here.ter_set( center, ter_t_floor );
            get_globals().set_global_value( location_key, here.get_abs( target ) );
            talk_effect_t native_effect;
            native_effect.parse_sub_effect( json_loader::from_string( z_effect_json ).get_object(),
                                            "lua_platform_set_terrain_z_semantics" );
            dialogue native_context;
            for( const talk_effect_fun_t &operation : native_effect.effects ) {
                operation( native_context );
            }
            get_globals().remove_global_value( location_key );
            const ter_id native_result = here.ter( center );
            const int native_changed = native_result == ter_t_wall.id() ? 1 : 0;

            here.ter_set( center, ter_t_floor );
            sol::protected_function_result lua_result;
            {
                cata::lua_platform::detail::callback_scope active_callback( *owner );
                lua_result = lua.safe_script(
                                 "return services.gameplay.environment.set_terrain("
                                 "boundary_position, terrain_id, 0, false, false)",
                                 sol::script_pass_on_error );
            }
            if( !lua_result.valid() ) {
                const sol::error error = lua_result;
                INFO( error.what() );
            }
            REQUIRE( lua_result.valid() );
            CHECK( lua_result.get<int>() == native_changed );
            CHECK( here.ter( center ) == native_result );
        }
    } else {
        const int target_z = loaded_adjacent_map_zlevel( here, center );
        REQUIRE( target_z != center.z() );
        const tripoint_bub_ms target( center.x(), center.y(), target_z );
        REQUIRE( map_meddler::get_submap_at_grid( here, tripoint_rel_sm{ target.x() / SEEX, target.y() / SEEY, target_z } ) !=
                 nullptr );
        const ter_id original_target = here.ter( target );
        const ter_id original_current = here.ter( center );
        on_out_of_scope restore_terrain( [&]() {
            here.ter_set( target, original_target );
            here.ter_set( center, original_current );
        } );

        const tripoint_abs_ms target_abs = here.get_abs( target );
        lua["loaded_z_position"] = script_tripoint_coord::from_native(
                                       coords::origin::abs, coords::scale::map_square,
                                       target_abs.raw() );
        REQUIRE( get_globals().maybe_get_global_value( location_key ) == nullptr );
        here.ter_set( target, ter_t_floor );
        here.ter_set( center, ter_t_floor );
        get_globals().set_global_value( location_key, target_abs );
        const std::string z_effect_json =
            R"({"set_terrain":"t_wall","location":{"global_val":"lua_platform_set_terrain_semantics_center"},"radius":0})";
        talk_effect_t native_effect;
        native_effect.parse_sub_effect( json_loader::from_string( z_effect_json ).get_object(),
                                        "lua_platform_set_terrain_loaded_z_semantics" );
        dialogue native_context;
        for( const talk_effect_fun_t &operation : native_effect.effects ) {
            operation( native_context );
        }
        get_globals().remove_global_value( location_key );
        const ter_id native_target = here.ter( target );
        const ter_id native_current = here.ter( center );
        const int native_changed = native_target == ter_t_wall.id() ? 1 : 0;
        CHECK( native_target == ter_t_wall.id() );
        CHECK( native_current == ter_t_floor.id() );

        here.ter_set( target, ter_t_floor );
        here.ter_set( center, ter_t_floor );
        sol::protected_function_result lua_result;
        {
            cata::lua_platform::detail::callback_scope active_callback( *owner );
            lua_result = lua.safe_script(
                             "return services.gameplay.environment.set_terrain("
                             "loaded_z_position, terrain_id, 0, false, false)",
                             sol::script_pass_on_error );
        }
        if( !lua_result.valid() ) {
            const sol::error error = lua_result;
            INFO( error.what() );
        }
        REQUIRE( lua_result.valid() );
        CHECK( lua_result.get<int>() == native_changed );
        CHECK( here.ter( target ) == native_target );
        CHECK( here.ter( center ) == native_current );
    }
}

TEST_CASE( "lua_platform_environment_add_field_area_matches_native_f_field",
           "[lua][platform][environment_mutation][semantic]" )
{
    using namespace cata::lua_platform;
    clear_active_runtimes();
    clear_map_without_vision();
    clear_avatar();
    sol::state lua;
    lua.open_libraries( sol::lib::base );
    sol::table ccb = lua.create_table();
    const std::shared_ptr<runtime> owner = make_runtime( "environment_add_field_area", 4905, lua );
    on_out_of_scope cleanup( []() {
        clear_active_runtimes();
        runtime_world_ready( false );
    } );
    install_runtime_api( owner, lua, ccb );
    set_active_runtimes( { owner } );
    runtime_world_ready( true );
    lua["services"] = ccb["services"];

    map &here = get_map();
    const int map_width = here.getmapsize() * SEEX;
    const int map_height = here.getmapsize() * SEEY;
    const tripoint_bub_ms avatar_position = here.get_bub( get_avatar().pos_abs() );
    tripoint_bub_ms center( map_width / 2, map_height / 2, here.get_abs_sub().z() );
    if( trig_dist( center, avatar_position ) < 4.0f ) {
        const int offset_x = avatar_position.x() + 7 < map_width ? 7 : -7;
        const int offset_y = avatar_position.y() + 7 < map_height ? 7 : -7;
        center = avatar_position + tripoint_rel_ms( offset_x, offset_y, 0 );
    }
    REQUIRE( here.inbounds( center ) );
    REQUIRE( trig_dist( center, avatar_position ) >= 4.0f );
    const tripoint_bub_ms edge = center + tripoint_rel_ms( 2, 1, 0 );
    const tripoint_bub_ms corner = center + tripoint_rel_ms( 2, 2, 0 );
    REQUIRE( here.inbounds( edge ) );
    REQUIRE( here.inbounds( corner ) );
    const tripoint_abs_ms center_abs = here.get_abs( center );
    const tripoint_abs_ms out_of_world_z_abs( center_abs.x(), center_abs.y(),
            OVERMAP_HEIGHT + 1 );
    lua["center_position"] = script_tripoint_coord::from_native(
                                 coords::origin::abs, coords::scale::map_square, center_abs.raw() );
    lua["out_of_world_z_position"] = script_tripoint_coord::from_native(
                                      coords::origin::abs, coords::scale::map_square,
                                      out_of_world_z_abs.raw() );

    REQUIRE( field_fd_web.is_valid() );
    REQUIRE( field_fd_blood.is_valid() );
    REQUIRE( field_fd_smoke.is_valid() );
    REQUIRE( field_fd_fire.is_valid() );
    REQUIRE( here.ter_set( center, ter_t_floor ) );
    here.set_outside_cache_dirty( center.z() );
    here.build_outside_cache( center.z() );
    CHECK_FALSE( here.is_outside( center ) );
    CHECK( here.is_outside( edge ) );

    auto clear_test_field = [&]( const field_type_id &field_id ) {
        for( int dx = -2; dx <= 2; ++dx ) {
            for( int dy = -2; dy <= 2; ++dy ) {
                const tripoint_bub_ms point = center + tripoint_rel_ms( dx, dy, 0 );
                if( here.inbounds( point ) ) {
                    here.remove_field( point, field_id );
                }
            }
        }
    };
    auto field_coverage = [&]( const field_type_id &field_id ) {
        std::array<bool, 25> coverage{};
        std::size_t index = 0;
        for( int dx = -2; dx <= 2; ++dx ) {
            for( int dy = -2; dy <= 2; ++dy ) {
                const tripoint_bub_ms point = center + tripoint_rel_ms( dx, dy, 0 );
                coverage[index++] = here.inbounds( point ) &&
                                    here.get_field( point, field_id ) != nullptr;
            }
        }
        return coverage;
    };
    tripoint_abs_ms native_target_position = center_abs;
    auto run_native_field_effect = [&]( const std::string &effect_json ) {
        dialogue context( get_talker_for( get_avatar() ), nullptr );
        context.set_value( "field_center", native_target_position );
        talk_effect_t native_effect;
        native_effect.parse_sub_effect(
            json_loader::from_string( effect_json ).get_object(), "field_area_parity" );
        finalize_conditions();
        for( const talk_effect_fun_t &operation : native_effect.effects ) {
            operation( context );
        }
    };

    run_native_field_effect( R"({"u_set_field":"fd_web", "target_var":{"context_val":"field_center"}, "radius":2, "intensity":3, "age":"17 turns", "hit_player":false})" );
    const std::array<bool, 25> native_circle_coverage = field_coverage( field_fd_web.id() );
    CHECK( std::count( native_circle_coverage.begin(), native_circle_coverage.end(), true ) == 21 );
    clear_test_field( field_fd_web.id() );
    {
        cata::lua_platform::detail::callback_scope active_callback( *owner );
        const sol::protected_function_result result = lua.safe_script( R"(
            local environment = services.gameplay.environment
            assert(environment.add_field_area(center_position, "fd_web", {
                radius = 2, intensity = 3,
                age = services.time.duration(17, "turn"), hit_player = false
            }) == 21)
            assert(environment.add_field_area(out_of_world_z_position, "fd_web", {radius=0}) == 0)
            assert(environment.add_field_area(center_position, "unknown_field_for_test") == 0)
            assert(not pcall(environment.add_field_area,
                center_position, "fd_web", {radius=32768}))
            assert(not pcall(environment.add_field_area,
                center_position, "fd_web", {unknown_option=true}))
        )", sol::script_pass_on_error );
        if( !result.valid() ) {
            const sol::error error = result;
            INFO( error.what() );
        }
        REQUIRE( result.valid() );
    }
    const field_entry *web_edge = here.get_field( edge, field_fd_web.id() );
    REQUIRE( web_edge != nullptr );
    CHECK( web_edge->get_field_intensity() == 3 );
    CHECK( web_edge->get_field_age() == 17_turns );
    CHECK( here.get_field( corner, field_fd_web.id() ) == nullptr );
    CHECK( field_coverage( field_fd_web.id() ) == native_circle_coverage );

    run_native_field_effect( R"({"u_set_field":"fd_blood", "target_var":{"context_val":"field_center"}, "radius":2, "square":true, "hit_player":false})" );
    const std::array<bool, 25> native_square_coverage = field_coverage( field_fd_blood.id() );
    CHECK( std::count( native_square_coverage.begin(), native_square_coverage.end(), true ) == 25 );
    clear_test_field( field_fd_blood.id() );
    {
        cata::lua_platform::detail::callback_scope active_callback( *owner );
        const sol::protected_function_result result = lua.safe_script(
                    "assert(services.gameplay.environment.add_field_area("
                    "center_position, \"fd_blood\", {radius=2, square=true, hit_player=false}) == 25)",
                    sol::script_pass_on_error );
        if( !result.valid() ) {
            const sol::error error = result;
            INFO( error.what() );
        }
        REQUIRE( result.valid() );
    }
    CHECK( here.get_field( corner, field_fd_blood.id() ) != nullptr );
    CHECK( field_coverage( field_fd_blood.id() ) == native_square_coverage );

    run_native_field_effect( R"({"u_set_field":"fd_smoke", "target_var":{"context_val":"field_center"}, "radius":2, "outdoor_only":true, "hit_player":false})" );
    const std::array<bool, 25> native_outdoor_coverage = field_coverage( field_fd_smoke.id() );
    const int expected_outdoor = static_cast<int>( std::count(
                                     native_outdoor_coverage.begin(), native_outdoor_coverage.end(), true ) );
    REQUIRE( expected_outdoor > 0 );
    REQUIRE( expected_outdoor == 12 );
    clear_test_field( field_fd_smoke.id() );
    lua["expected_outdoor"] = expected_outdoor;
    {
        cata::lua_platform::detail::callback_scope active_callback( *owner );
        const sol::protected_function_result result = lua.safe_script(
                    "assert(services.gameplay.environment.add_field_area("
                    "center_position, \"fd_smoke\", {radius=2, outdoor_only=true, hit_player=false}) == "
                    "expected_outdoor)",
                    sol::script_pass_on_error );
        if( !result.valid() ) {
            const sol::error error = result;
            INFO( error.what() );
        }
        REQUIRE( result.valid() );
    }
    CHECK( here.get_field( center, field_fd_smoke.id() ) == nullptr );
    CHECK( here.get_field( edge, field_fd_smoke.id() ) != nullptr );
    CHECK( field_coverage( field_fd_smoke.id() ) == native_outdoor_coverage );

    run_native_field_effect( R"({"u_set_field":"fd_fire", "target_var":{"context_val":"field_center"}, "radius":2, "indoor_only":true, "hit_player":false})" );
    const std::array<bool, 25> native_indoor_coverage = field_coverage( field_fd_fire.id() );
    const int expected_indoor = static_cast<int>( std::count(
                                    native_indoor_coverage.begin(), native_indoor_coverage.end(), true ) );
    REQUIRE( expected_indoor > 0 );
    REQUIRE( expected_indoor == 9 );
    clear_test_field( field_fd_fire.id() );
    lua["expected_indoor"] = expected_indoor;
    {
        cata::lua_platform::detail::callback_scope active_callback( *owner );
        const sol::protected_function_result result = lua.safe_script(
                    "assert(services.gameplay.environment.add_field_area("
                    "center_position, \"fd_fire\", {radius=2, indoor_only=true, hit_player=false}) == "
                    "expected_indoor)",
                    sol::script_pass_on_error );
        if( !result.valid() ) {
            const sol::error error = result;
            INFO( error.what() );
        }
        REQUIRE( result.valid() );
    }
    CHECK( here.get_field( center, field_fd_fire.id() ) != nullptr );
    CHECK( here.get_field( edge, field_fd_fire.id() ) == nullptr );
    CHECK( field_coverage( field_fd_fire.id() ) == native_indoor_coverage );

    if( here.supports_zlevels() ) {
        const int target_z = loaded_adjacent_map_zlevel( here, center );
        REQUIRE( target_z != center.z() );
        const tripoint_bub_ms target_center( center.x(), center.y(), target_z );
        REQUIRE( here.inbounds( target_center ) );
        const tripoint_rel_sm target_grid( target_center.x() / SEEX,
                                           target_center.y() / SEEY, target_z );
        submap *const target_submap = map_meddler::get_submap_at_grid( here, target_grid );
        REQUIRE( target_submap != nullptr );
        const ter_id original_target_terrain = here.ter( target_center );
        REQUIRE( here.ter_set( target_center, ter_t_floor ) );
        on_out_of_scope restore_target_tile( [&]() {
            here.remove_field( target_center, field_fd_smoke.id() );
            here.ter_set( target_center, original_target_terrain );
        } );
        const tripoint_abs_ms target_center_abs = here.get_abs( target_center );
        lua["target_center_position"] = script_tripoint_coord::from_native(
                                           coords::origin::abs, coords::scale::map_square,
                                           target_center_abs.raw() );
        native_target_position = target_center_abs;
        here.remove_field( target_center, field_fd_smoke.id() );
        run_native_field_effect(
            R"({"u_set_field":"fd_smoke", "target_var":{"context_val":"field_center"}, "radius":0, "hit_player":false})" );
        REQUIRE( here.get_field( target_center, field_fd_smoke.id() ) != nullptr );
        CHECK( here.get_field( center, field_fd_smoke.id() ) == nullptr );
        here.remove_field( target_center, field_fd_smoke.id() );
        {
            cata::lua_platform::detail::callback_scope active_callback( *owner );
            const sol::protected_function_result result = lua.safe_script(
                        "assert(services.gameplay.environment.add_field_area("
                        "target_center_position, \"fd_smoke\", {radius=0, hit_player=false}) == 1)",
                        sol::script_pass_on_error );
            if( !result.valid() ) {
                const sol::error error = result;
                INFO( error.what() );
            }
            REQUIRE( result.valid() );
        }
        CHECK( here.get_field( target_center, field_fd_smoke.id() ) != nullptr );
        CHECK( here.get_field( center, field_fd_smoke.id() ) == nullptr );
        CHECK( map_meddler::get_submap_at_grid( here, target_grid ) == target_submap );
        here.remove_field( target_center, field_fd_smoke.id() );
    }

    center = tripoint_bub_ms( 1, 1, center.z() );
    REQUIRE( here.inbounds( center ) );
    const tripoint_abs_ms edge_center_abs = here.get_abs( center );
    lua["center_position"] = script_tripoint_coord::from_native(
                                 coords::origin::abs, coords::scale::map_square,
                                 edge_center_abs.raw() );
    native_target_position = edge_center_abs;
    clear_test_field( field_fd_smoke.id() );
    run_native_field_effect(
        R"({"u_set_field":"fd_smoke", "target_var":{"context_val":"field_center"}, "radius":2, "hit_player":false})" );
    const std::array<bool, 25> native_edge_coverage = field_coverage( field_fd_smoke.id() );
    const int native_edge_count = static_cast<int>( std::count(
            native_edge_coverage.begin(), native_edge_coverage.end(), true ) );
    REQUIRE( native_edge_count > 0 );
    clear_test_field( field_fd_smoke.id() );
    lua["expected_edge_count"] = native_edge_count;
    {
        cata::lua_platform::detail::callback_scope active_callback( *owner );
        const sol::protected_function_result result = lua.safe_script( R"(
            assert(services.gameplay.environment.add_field_area(
                center_position, "fd_smoke", {
                    radius=2, hit_player=false
                }) == expected_edge_count)
        )", sol::script_pass_on_error );
        if( !result.valid() ) {
            const sol::error error = result;
            INFO( error.what() );
        }
        REQUIRE( result.valid() );
    }
    CHECK( field_coverage( field_fd_smoke.id() ) == native_edge_coverage );
    clear_test_field( field_fd_smoke.id() );

    const tripoint_bub_ms far_center( -32767, -32767, center.z() );
    const tripoint_abs_ms far_center_abs = here.get_abs( far_center );
    lua["far_center_position"] = script_tripoint_coord::from_native(
                                     coords::origin::abs, coords::scale::map_square,
                                     far_center_abs.raw() );
    native_target_position = far_center_abs;
    run_native_field_effect(
        R"({"u_set_field":"fd_smoke", "target_var":{"context_val":"field_center"}, "radius":0, "hit_player":false})" );
    const std::array<bool, 25> native_far_coverage = field_coverage( field_fd_smoke.id() );
    CHECK( std::count( native_far_coverage.begin(), native_far_coverage.end(), true ) == 0 );
    {
        cata::lua_platform::detail::callback_scope active_callback( *owner );
        const sol::protected_function_result result = lua.safe_script(
                "assert(services.gameplay.environment.add_field_area("
                "far_center_position, \"fd_smoke\", {radius=0, hit_player=false}) == 0)",
                sol::script_pass_on_error );
        if( !result.valid() ) {
            const sol::error error = result;
            INFO( error.what() );
        }
        REQUIRE( result.valid() );
    }
    CHECK( field_coverage( field_fd_smoke.id() ) == native_far_coverage );

    const ter_id original_avatar_terrain = here.ter( avatar_position );
    on_out_of_scope restore_avatar_field_fixture( [&]() {
        here.remove_field( avatar_position, field_fd_web.id() );
        get_avatar().remove_effect( effect_webbed_for_test );
        here.ter_set( avatar_position, original_avatar_terrain );
    } );
    here.ter_set( avatar_position, ter_t_floor );
    lua["field_avatar_position"] = script_tripoint_coord::from_native(
                                       coords::origin::abs, coords::scale::map_square,
                                       here.get_abs( avatar_position ).raw() );

    run_native_field_effect(
        R"({"u_set_field":"fd_web", "radius":0, "intensity":3, "age":"17 turns"})" );
    const field_entry *native_default_hit = here.get_field( avatar_position, field_fd_web.id() );
    REQUIRE( native_default_hit != nullptr );
    const int native_default_intensity = native_default_hit->get_field_intensity();
    CHECK( native_default_intensity == 2 );
    CHECK( get_avatar().has_effect( effect_webbed_for_test ) );
    here.remove_field( avatar_position, field_fd_web.id() );
    get_avatar().remove_effect( effect_webbed_for_test );
    {
        cata::lua_platform::detail::callback_scope active_callback( *owner );
        const sol::protected_function_result result = lua.safe_script( R"(
            assert(services.gameplay.environment.add_field_area(
                field_avatar_position, "fd_web", {
                    radius=0, intensity=3, age=services.time.duration(17, "turn")
                }) == 1)
        )", sol::script_pass_on_error );
        if( !result.valid() ) {
            const sol::error error = result;
            INFO( error.what() );
        }
        REQUIRE( result.valid() );
    }
    const field_entry *platform_default_hit = here.get_field( avatar_position, field_fd_web.id() );
    REQUIRE( platform_default_hit != nullptr );
    const int platform_default_intensity = platform_default_hit->get_field_intensity();
    CHECK( platform_default_intensity == native_default_intensity );
    CHECK( get_avatar().has_effect( effect_webbed_for_test ) );
    here.remove_field( avatar_position, field_fd_web.id() );
    get_avatar().remove_effect( effect_webbed_for_test );

    run_native_field_effect(
        R"({"u_set_field":"fd_web", "radius":0, "intensity":3, "age":"17 turns", "hit_player":false})" );
    const field_entry *native_no_hit = here.get_field( avatar_position, field_fd_web.id() );
    REQUIRE( native_no_hit != nullptr );
    const int native_no_hit_intensity = native_no_hit->get_field_intensity();
    CHECK( native_no_hit_intensity == 3 );
    CHECK_FALSE( get_avatar().has_effect( effect_webbed_for_test ) );
    here.remove_field( avatar_position, field_fd_web.id() );
    {
        cata::lua_platform::detail::callback_scope active_callback( *owner );
        const sol::protected_function_result result = lua.safe_script( R"(
            assert(services.gameplay.environment.add_field_area(
                field_avatar_position, "fd_web", {
                    radius=0, intensity=3, age=services.time.duration(17, "turn"),
                    hit_player=false
                }) == 1)
        )", sol::script_pass_on_error );
        if( !result.valid() ) {
            const sol::error error = result;
            INFO( error.what() );
        }
        REQUIRE( result.valid() );
    }
    const field_entry *platform_no_hit = here.get_field( avatar_position, field_fd_web.id() );
    REQUIRE( platform_no_hit != nullptr );
    const int platform_no_hit_intensity = platform_no_hit->get_field_intensity();
    CHECK( platform_no_hit_intensity == native_no_hit_intensity );
    CHECK_FALSE( get_avatar().has_effect( effect_webbed_for_test ) );
    CHECK( platform_default_intensity < platform_no_hit_intensity );
}

TEST_CASE( "lua_platform_environment_set_trap_area_matches_native_f_set_trap",
           "[lua][platform][environment_mutation][semantic]" )
{
    using namespace cata::lua_platform;
    clear_active_runtimes();
    clear_map_without_vision();
    clear_avatar();
    sol::state lua;
    lua.open_libraries( sol::lib::base );
    sol::table ccb = lua.create_table();
    const std::shared_ptr<runtime> owner = make_runtime( "environment_set_trap_area", 4906, lua );
    on_out_of_scope cleanup( []() {
        clear_active_runtimes();
        runtime_world_ready( false );
    } );
    install_runtime_api( owner, lua, ccb );
    set_active_runtimes( { owner } );
    runtime_world_ready( true );
    lua["services"] = ccb["services"];

    map &here = get_map();
    const int map_width = here.getmapsize() * SEEX;
    const int map_height = here.getmapsize() * SEEY;
    const trap_str_id beartrap( "tr_beartrap" );
    const ter_str_id floor( "t_floor" );
    const ter_str_id pit( "t_pit" );
    const trap_str_id pit_trap( "tr_pit" );
    REQUIRE( beartrap.is_valid() );
    REQUIRE( floor.is_valid() );
    REQUIRE( pit.is_valid() );
    REQUIRE( pit_trap.is_valid() );

    const tripoint_bub_ms avatar_position = here.get_bub( get_avatar().pos_abs() );
    tripoint_bub_ms center( map_width / 2, map_height / 2, here.get_abs_sub().z() );
    if( trig_dist( center, avatar_position ) < 5.0f ) {
        const int offset_x = avatar_position.x() + 8 < map_width ? 8 : -8;
        const int offset_y = avatar_position.y() + 8 < map_height ? 8 : -8;
        center = avatar_position + tripoint_rel_ms( offset_x, offset_y, 0 );
    }
    REQUIRE( here.inbounds( center ) );
    REQUIRE( center.x() > 2 );
    REQUIRE( center.x() + 2 < map_width );
    REQUIRE( center.y() > 2 );
    REQUIRE( center.y() + 2 < map_height );

    auto prepare_area = [&]( const tripoint_bub_ms &area_center ) {
        for( int dx = -2; dx <= 2; ++dx ) {
            for( int dy = -2; dy <= 2; ++dy ) {
                const tripoint_bub_ms position = area_center + tripoint_rel_ms( dx, dy, 0 );
                if( here.inbounds( position ) ) {
                    here.ter_set( position, floor );
                    REQUIRE( here.ter( position ) == floor.id() );
                    here.trap_set( position, tr_null );
                }
            }
        }
    };
    auto trap_coverage = [&]( const tripoint_bub_ms &area_center ) {
        std::array<bool, 25> coverage{};
        std::size_t index = 0;
        for( int dx = -2; dx <= 2; ++dx ) {
            for( int dy = -2; dy <= 2; ++dy ) {
                const tripoint_bub_ms position = area_center + tripoint_rel_ms( dx, dy, 0 );
                coverage[index++] = here.inbounds( position ) &&
                                    here.tr_at( position ).id == beartrap.id();
            }
        }
        return coverage;
    };
    auto run_native = [&]( const tripoint_bub_ms &area_center,
                           const std::string &radius_json, const bool has_radius,
                           const bool square ) {
        const tripoint_abs_ms absolute = here.get_abs( area_center );
        std::string effect_json =
            R"({"set_trap":"tr_beartrap", "location":{"context_val":"trap_center"})";
        if( has_radius ) {
            effect_json += ", \"radius\":" + radius_json;
        }
        if( square ) {
            effect_json += ", \"square\":true";
        }
        effect_json += "}";
        dialogue context( get_talker_for( get_avatar() ), nullptr );
        context.set_value( "trap_center", absolute );
        talk_effect_t native_effect;
        native_effect.parse_sub_effect(
            json_loader::from_string( effect_json ).get_object(), "trap_area_parity" );
        finalize_conditions();
        for( const talk_effect_fun_t &operation : native_effect.effects ) {
            operation( context );
        }
    };
    auto run_platform = [&]( const tripoint_bub_ms &area_center,
                             const bool has_radius, const double radius,
                             const bool square ) {
        const tripoint_abs_ms absolute = here.get_abs( area_center );
        lua["trap_position"] = script_tripoint_coord::from_native(
                                   coords::origin::abs, coords::scale::map_square,
                                   absolute.raw() );
        lua["trap_radius"] = radius;
        lua["trap_square"] = square;
        const std::string radius_argument = has_radius ? "trap_radius" : "nil";
        const std::string script = "return services.gameplay.environment.set_trap_area("
                                   "trap_position, \"tr_beartrap\", " + radius_argument +
                                   ", trap_square)";
        cata::lua_platform::detail::callback_scope active_callback( *owner );
        const sol::protected_function_result result = lua.safe_script(
                    script, sol::script_pass_on_error );
        if( !result.valid() ) {
            const sol::error error = result;
            INFO( error.what() );
        }
        REQUIRE( result.valid() );
        return result.get<int>();
    };
    auto compare_case = [&]( const tripoint_bub_ms &area_center,
                             const std::string &radius_json, const bool has_radius,
                             const double radius, const bool square ) {
        prepare_area( area_center );
        run_native( area_center, radius_json, has_radius, square );
        const std::array<bool, 25> native_coverage = trap_coverage( area_center );
        prepare_area( area_center );
        const int attempted_squares = run_platform( area_center, has_radius, radius, square );
        const std::array<bool, 25> platform_coverage = trap_coverage( area_center );
        CHECK( platform_coverage == native_coverage );
        CHECK( attempted_squares == std::count( native_coverage.begin(),
                                                native_coverage.end(), true ) );
        prepare_area( area_center );
        return attempted_squares;
    };

    CHECK( compare_case( center, "", false, 0.0, false ) == 5 ); // omitted radius defaults to one
    CHECK( compare_case( center, "1.9", true, 1.9, false ) == 5 ); // native double -> int truncation
    CHECK( compare_case( center, "1", true, 1.0, true ) == 9 );
    CHECK( compare_case( center, "-1.9", true, -1.9, true ) == 1 );
    prepare_area( center );
    run_native( center, "-1", true, true );
    CHECK( here.tr_at( center + tripoint_rel_ms( 1, 1, 0 ) ).id == beartrap.id() );
    prepare_area( center );
    CHECK( compare_case( center, "-1", true, -1.0, false ) == 0 );
    CHECK( compare_case( center, "-0.9", true, -0.9, false ) == 1 ); // truncates to zero

    tripoint_bub_ms edge_center( 0, map_height / 2, center.z() );
    REQUIRE( here.inbounds( edge_center ) );
    CHECK( compare_case( edge_center, "2", true, 2.0, false ) > 0 );
    CHECK( compare_case( tripoint_bub_ms( center.x(), center.y(), OVERMAP_HEIGHT + 1 ),
                         "0", true, 0.0, false ) == 0 );

    const int target_z = here.supports_zlevels() ?
                         loaded_adjacent_map_zlevel( here, center ) :
                         ( center.z() < OVERMAP_HEIGHT ? center.z() + 1 : center.z() - 1 );
    REQUIRE( target_z != center.z() );
    const tripoint_bub_ms upper_center( center.x(), center.y(), target_z );
    REQUIRE( here.inbounds( upper_center ) );
    submap *const upper_submap = map_meddler::get_submap_at_grid( here, tripoint_rel_sm{
        upper_center.x() / SEEX, upper_center.y() / SEEY, target_z
    } );
    if( here.supports_zlevels() ) {
        REQUIRE( upper_submap != nullptr );
    }
    const submap *const current_submap = map_meddler::get_submap_at_grid( here, tripoint_rel_sm{
        center.x() / SEEX, center.y() / SEEY, center.z()
    } );
    REQUIRE( current_submap != nullptr );
    const ter_id original_upper_terrain = here.ter( upper_center );
    const trap_id original_upper_trap = here.tr_at( upper_center ).id;
    on_out_of_scope restore_upper_tile( [&]() {
        here.ter_set( upper_center, floor );
        here.trap_set( upper_center, tr_null );
        here.ter_set( upper_center, original_upper_terrain );
        if( original_upper_terrain->trap == tr_null && original_upper_trap != tr_null ) {
            here.trap_set( upper_center, original_upper_trap );
        }
    } );
    here.ter_set( upper_center, floor );
    REQUIRE( here.ter( upper_center ) == floor.id() );
    here.trap_set( upper_center, tr_null );
    const tripoint_abs_ms upper_absolute = here.get_abs( upper_center );
    lua["trap_position"] = script_tripoint_coord::from_native(
                               coords::origin::abs, coords::scale::map_square,
                               upper_absolute.raw() );
    dialogue upper_native_context( get_talker_for( get_avatar() ), nullptr );
    upper_native_context.set_value( "trap_center", upper_absolute );
    talk_effect_t upper_native_effect;
    upper_native_effect.parse_sub_effect(
        json_loader::from_string(
            R"({"set_trap":"tr_beartrap", "location":{"context_val":"trap_center"}, "radius":0})"
        ).get_object(), "trap_area_z_parity" );
    finalize_conditions();
    for( const talk_effect_fun_t &operation : upper_native_effect.effects ) {
        operation( upper_native_context );
    }
    CHECK( here.tr_at( upper_center ).id == beartrap.id() );
    here.trap_set( upper_center, tr_null );
    {
        cata::lua_platform::detail::callback_scope active_callback( *owner );
        const sol::protected_function_result result = lua.safe_script(
                    "return services.gameplay.environment.set_trap_area("
                    "trap_position, \"tr_beartrap\", 0, false)",
                    sol::script_pass_on_error );
        REQUIRE( result.valid() );
        CHECK( result.get<int>() == 1 );
    }
    CHECK( here.tr_at( upper_center ).id == beartrap.id() );
    if( here.supports_zlevels() ) {
        CHECK( map_meddler::get_submap_at_grid( here, tripoint_rel_sm{ upper_center.x() / SEEX,
                                          upper_center.y() / SEEY, target_z } ) == upper_submap );
    } else {
        CHECK( map_meddler::get_submap_at_grid( here, tripoint_rel_sm{ center.x() / SEEX,
                                          center.y() / SEEY, center.z() } ) == current_submap );
    }

    // Same-id writes still pass through map::trap_set and repair its trap index.
    prepare_area( center );
    here.memory_cache_dec_set_dirty( center, false );
    run_native( center, "0", true, false );
    CHECK( here.memory_cache_dec_is_dirty( center ) );
    const auto &native_locations = here.trap_locations( beartrap.id() );
    CHECK( std::count( native_locations.begin(), native_locations.end(), center ) == 1 );
    prepare_area( center );
    here.memory_cache_dec_set_dirty( center, false );
    CHECK( run_platform( center, true, 0.0, false ) == 1 );
    CHECK( here.memory_cache_dec_is_dirty( center ) );
    CHECK( run_platform( center, true, 0.0, false ) == 1 );
    const auto &platform_locations = here.trap_locations( beartrap.id() );
    CHECK( std::count( platform_locations.begin(), platform_locations.end(), center ) == 1 );
    CHECK( here.tr_at( center ).id == beartrap.id() );
    prepare_area( center );

    // A square radius above 32767 remains usable when native endpoints are
    // representable, even when its clipped region is wholly outside this map.
    const tripoint_bub_ms distant_center( -40000, -40000, center.z() );
    lua["trap_position"] = script_tripoint_coord::from_native(
                               coords::origin::abs, coords::scale::map_square,
                               here.get_abs( distant_center ).raw() );
    lua["trap_radius"] = 32768.0;
    lua["trap_square"] = true;
    {
        cata::lua_platform::detail::callback_scope active_callback( *owner );
        const sol::protected_function_result result = lua.safe_script(
                    "return services.gameplay.environment.set_trap_area("
                    "trap_position, \"tr_beartrap\", trap_radius, trap_square)",
                    sol::script_pass_on_error );
        REQUIRE( result.valid() );
        CHECK( result.get<int>() == 0 );
    }
    lua["trap_position"] = script_tripoint_coord::from_native(
                               coords::origin::abs, coords::scale::map_square,
                               here.get_abs( center ).raw() );
    lua["trap_radius"] = 46341.0;
    lua["trap_square"] = false;
    {
        cata::lua_platform::detail::callback_scope active_callback( *owner );
        const sol::protected_function_result result = lua.safe_script(
                    "return pcall(services.gameplay.environment.set_trap_area, "
                    "trap_position, \"tr_beartrap\", trap_radius, trap_square)",
                    sol::script_pass_on_error );
        REQUIRE( result.valid() );
        CHECK_FALSE( result.get<bool>() );
    }

    // The built-in terrain trap is refused by the native setter. The platform
    // call must issue the same setter exactly once and preserve that refusal.
    const tripoint_bub_ms builtin_center = center + tripoint_rel_ms( 5, 0, 0 );
    REQUIRE( here.inbounds( builtin_center ) );
    here.ter_set( builtin_center, pit );
    REQUIRE( here.ter( builtin_center ) == pit.id() );
    dialogue builtin_context( get_talker_for( get_avatar() ), nullptr );
    const tripoint_abs_ms builtin_absolute = here.get_abs( builtin_center );
    builtin_context.set_value( "trap_center", builtin_absolute );
    talk_effect_t builtin_native_effect;
    builtin_native_effect.parse_sub_effect(
        json_loader::from_string(
            R"({"set_trap":"tr_beartrap", "location":{"context_val":"trap_center"}, "radius":0})"
        ).get_object(), "trap_area_builtin_parity" );
    finalize_conditions();
    const std::string native_builtin_diagnostic = capture_debugmsg_during( [&]() {
        for( const talk_effect_fun_t &operation : builtin_native_effect.effects ) {
            operation( builtin_context );
        }
    } );
    lua["trap_position"] = script_tripoint_coord::from_native(
                               coords::origin::abs, coords::scale::map_square,
                               builtin_absolute.raw() );
    lua["trap_radius"] = 0.0;
    lua["trap_square"] = false;
    int platform_builtin_attempts = 0;
    const std::string platform_builtin_diagnostic = capture_debugmsg_during( [&]() {
        cata::lua_platform::detail::callback_scope active_callback( *owner );
        const sol::protected_function_result result = lua.safe_script(
                    "return services.gameplay.environment.set_trap_area("
                    "trap_position, \"tr_beartrap\", trap_radius, trap_square)",
                    sol::script_pass_on_error );
        REQUIRE( result.valid() );
        platform_builtin_attempts = result.get<int>();
    } );
    CHECK( native_builtin_diagnostic.find( "built-in trap" ) != std::string::npos );
    CHECK( platform_builtin_diagnostic == native_builtin_diagnostic );
    CHECK( platform_builtin_attempts == 1 );
    CHECK( here.tr_at( builtin_center ).id == pit_trap.id() );
    CHECK( std::count( here.trap_locations( beartrap.id() ).begin(),
                       here.trap_locations( beartrap.id() ).end(), builtin_center ) == 0 );
    here.ter_set( builtin_center, floor );

    // Native trap IDs are std::string values, not 256-byte ASCII tokens. A
    // long Lua byte string with an embedded NUL must reach the same native
    // factory fallback and diagnostic as f_set_trap.
    prepare_area( center );
    std::string native_trap_json = R"({"set_trap":")";
    native_trap_json.append( 320, 'x' );
    native_trap_json +=
        R"(\u0000tail", "location":{"context_val":"trap_center"}, "radius":0})";
    const std::string long_trap_bytes = std::string( 320, 'x' ) + std::string( "\0tail", 5 );
    dialogue long_id_context( get_talker_for( get_avatar() ), nullptr );
    long_id_context.set_value( "trap_center", here.get_abs( center ) );
    talk_effect_t long_id_native_effect;
    long_id_native_effect.parse_sub_effect( json_loader::from_string( native_trap_json ).get_object(),
                                            "trap_area_long_id_parity" );
    finalize_conditions();
    const std::string native_invalid_id_diagnostic = capture_debugmsg_during( [&]() {
        for( const talk_effect_fun_t &operation : long_id_native_effect.effects ) {
            operation( long_id_context );
        }
    } );
    lua["trap_position"] = script_tripoint_coord::from_native(
                               coords::origin::abs, coords::scale::map_square,
                               here.get_abs( center ).raw() );
    lua["trap_text"] = long_trap_bytes;
    int long_id_attempts = 0;
    const std::string platform_invalid_id_diagnostic = capture_debugmsg_during( [&]() {
        cata::lua_platform::detail::callback_scope active_callback( *owner );
        const sol::protected_function_result result = lua.safe_script(
                    "return services.gameplay.environment.set_trap_area("
                    "trap_position, trap_text, 0, false)", sol::script_pass_on_error );
        REQUIRE( result.valid() );
        long_id_attempts = result.get<int>();
    } );
    CHECK( native_invalid_id_diagnostic.find( "invalid trap id" ) != std::string::npos );
    CHECK( platform_invalid_id_diagnostic == native_invalid_id_diagnostic );
    CHECK( long_id_attempts == 1 );
    CHECK( here.tr_at( center ).id == tr_null );
}

TEST_CASE( "lua_platform_environment_line_of_sight_matches_map_semantics",
           "[lua][platform][environment_predicate][semantic]" )
{
    using namespace cata::lua_platform;
    clear_active_runtimes();
    clear_map_without_vision();
    sol::state lua;
    sol::table ccb = lua.create_table();
    const std::shared_ptr<runtime> owner = make_runtime( "environment_line_of_sight", 4903, lua );
    on_out_of_scope cleanup( []() {
        clear_active_runtimes();
    } );
    install_runtime_api( owner, lua, ccb );
    set_active_runtimes( { owner } );
    runtime_world_ready( true );
    lua["services"] = ccb["services"];

    map &here = get_map();
    const int map_width = here.getmapsize() * SEEX;
    const tripoint_bub_ms from( map_width / 2, map_width / 2, 0 );
    const tripoint_bub_ms range_from = from;
    const tripoint_bub_ms range_middle = from + tripoint_rel_ms( 1, 0, 0 );
    const tripoint_bub_ms range_to = from + tripoint_rel_ms( 2, 0, 0 );
    const tripoint_bub_ms field_from = from + tripoint_rel_ms( 0, 2, 0 );
    const tripoint_bub_ms field_middle = from + tripoint_rel_ms( 0, 3, 0 );
    const tripoint_bub_ms field_to = from + tripoint_rel_ms( 0, 4, 0 );
    for( const tripoint_bub_ms &position : {
             range_from, range_middle, range_to,
             field_from, field_middle, field_to
         } ) {
        REQUIRE( here.inbounds( position ) );
        here.ter_set( position, ter_t_floor );
    }
    REQUIRE( here.add_field( field_middle, field_fd_web.id(), 3, 0_turns, false ) );
    here.build_map_cache( 0, false );

    auto set_positions = [&]( const tripoint_bub_ms &source,
                              const tripoint_bub_ms &target ) {
        lua["from"] = script_tripoint_coord::from_native(
                           coords::origin::abs, coords::scale::map_square,
                           here.get_abs( source ).raw() );
        lua["to"] = script_tripoint_coord::from_native(
                         coords::origin::abs, coords::scale::map_square,
                         here.get_abs( target ).raw() );
    };
    set_positions( field_from, field_to );
    lua["range"] = 2.0;
    const sol::protected_function default_fields_query = lua.load(
                "return services.gameplay.environment.line_of_sight(from, to, range)" );
    const sol::protected_function_result with_fields = default_fields_query();
    REQUIRE( with_fields.valid() );
    CHECK_FALSE( here.sees( field_from, field_to, 2 ) );
    CHECK( with_fields.get<bool>() == here.sees( field_from, field_to, 2 ) );

    const sol::protected_function no_fields_query = lua.load(
                "return services.gameplay.environment.line_of_sight(from, to, range, false)" );
    const sol::protected_function_result without_fields = no_fields_query();
    REQUIRE( without_fields.valid() );
    CHECK( here.sees( field_from, field_to, 2, false ) );
    CHECK( without_fields.get<bool>() == here.sees( field_from, field_to, 2, false ) );

    set_positions( range_from, range_to );
    for( const double range : std::array<double, 6>{
             -1.9, -0.9, 1.9, 2.9,
             static_cast<double>( std::numeric_limits<int>::lowest() ),
             static_cast<double>( std::numeric_limits<int>::max() )
         } ) {
        CAPTURE( range );
        lua["range"] = range;
        const sol::protected_function_result actual = no_fields_query();
        REQUIRE( actual.valid() );
        CHECK( actual.get<bool>() == here.sees(
                   range_from, range_to, static_cast<int>( range ), false ) );
    }
    for( const double invalid_range : std::array<double, 5>{
             static_cast<double>( std::numeric_limits<int>::lowest() ) - 1.0,
             static_cast<double>( std::numeric_limits<int>::max() ) + 1.0,
             std::numeric_limits<double>::max(),
             std::numeric_limits<double>::infinity(),
             std::numeric_limits<double>::quiet_NaN()
         } ) {
        CAPTURE( invalid_range );
        lua["range"] = invalid_range;
        CHECK_FALSE( no_fields_query().valid() );
    }

    const tripoint_bub_ms edge_target( map_width - 1, range_from.y(), range_from.z() );
    const tripoint_bub_ms outside_source( map_width, range_from.y(), range_from.z() );
    REQUIRE( here.inbounds( edge_target ) );
    REQUIRE_FALSE( here.inbounds( outside_source ) );
    set_positions( outside_source, edge_target );
    lua["range"] = 1.0;
    const sol::protected_function_result outside_source_result = default_fields_query();
    REQUIRE( outside_source_result.valid() );
    CHECK( outside_source_result.get<bool>() == here.sees( outside_source, edge_target, 1 ) );

    set_positions( edge_target, outside_source );
    const sol::protected_function_result outside_target_result = default_fields_query();
    REQUIRE( outside_target_result.valid() );
    CHECK_FALSE( outside_target_result.get<bool>() );
    CHECK( outside_target_result.get<bool>() == here.sees( edge_target, outside_source, 1 ) );
}

TEST_CASE( "lua_platform_mod_world_query_matches_native_alias_predicate",
           "[lua][platform][mods][semantic]" )
{
    using namespace cata::lua_platform;
    clear_active_runtimes();
    REQUIRE( world_generator != nullptr );
    WORLD *old_world = world_generator->active_world;
    WORLD isolated_world( "mod_active_order_semantics" );
    sol::state lua;
    sol::table ccb = lua.create_table();
    const std::shared_ptr<runtime> owner = make_runtime( "runtime_only_mod", 4904, lua );
    on_out_of_scope cleanup( [old_world]() {
        clear_active_runtimes();
        world_generator->active_world = old_world;
    } );
    world_generator->active_world = &isolated_world;
    isolated_world.active_mod_order = { mod_id( "dda" ), mod_id( "aftershock" ) };
    install_runtime_api( owner, lua, ccb );
    set_active_runtimes( { owner } );
    runtime_world_ready( true );
    lua["services"] = ccb["services"];

    const sol::protected_function world_query = lua.load(
                "return services.gameplay.mods.is_active_in_world(mod_id)" );
    const std::array<std::pair<std::string, bool>, 5> legacy_world_cases = {{
            { "ccb", true },
            { "dda", true },
            { "aftershock", true },
            { "runtime_only_mod", false },
            { "missing_mod", false },
        }
    };
    dialogue context;
    for( const auto &test_case : legacy_world_cases ) {
        const std::string &id = test_case.first;
        CAPTURE( id );
        lua["mod_id"] = id;
        const sol::protected_function_result actual = world_query();
        REQUIRE( actual.valid() );
        conditional_t legacy( json_loader::from_string(
                                  R"({"mod_is_loaded":")" + id + R"("})" ).get_object() );
        CHECK( actual.get<bool>() == legacy( context ) );
        CHECK( actual.get<bool>() == test_case.second );
    }

    isolated_world.active_mod_order = { mod_id( "ccb" ) };
    lua["mod_id"] = "dda";
    const sol::protected_function_result requested_alias = world_query();
    REQUIRE( requested_alias.valid() );
    conditional_t legacy_alias( json_loader::from_string(
                                    R"({"mod_is_loaded":"dda"})" ).get_object() );
    CHECK( requested_alias.get<bool>() == legacy_alias( context ) );
    CHECK( requested_alias.get<bool>() );

    lua["mod_id"] = "runtime_only_mod";
    const sol::protected_function loaded_query = lua.load(
                "return services.gameplay.mods.is_loaded(mod_id)" );
    const sol::protected_function_result runtime_loaded = loaded_query();
    REQUIRE( runtime_loaded.valid() );
    CHECK( runtime_loaded.get<bool>() );
    const sol::protected_function_result runtime_world_only = world_query();
    REQUIRE( runtime_world_only.valid() );
    CHECK_FALSE( runtime_world_only.get<bool>() );
}

#endif
