#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include <avatar.h>
#include <coordinates.h>
#include <dialogue.h>
#include <dialogue_helpers.h>
#include "debug.h"
#include <enums.h>
#include "flexbuffer_json.h"
extern "C" {
#include <lua.h>
}
#include <lua_platform_bindings_coords.h>
#include <lua_platform_bindings_enums.h>
#include <overmap.h>
#include <point.h>
#include <type_id.h>
#include <cstddef>
#include <functional>
#include <limits>
#include <optional>
#include <string>
#include <vector>

#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character_id.h"
#include "condition.h"
#include "json_loader.h"
#include "lua_platform_sol.h"
#include "lua_platform_test_map_support.h"

using cata::lua_platform::test::platform_overmap_travel_fixture;
#include "map_scale_constants.h"
#include "mission.h"
#include "npc.h"
#include "overmap_connection.h"
#include "overmapbuffer.h"
#include "recipe_groups.h"

static const oter_str_id oter_road_nesw( "road_nesw" );

TEST_CASE( "lua_platform_native_overmap_condition_queries_preserve_terrain_and_camp_rules",
           "[lua][platform][overmap][conditions]" )
{
    platform_overmap_travel_fixture fixture( 821, 51 );
    REQUIRE( fixture.edit_ready );

    const tripoint_abs_omt position = fixture.source_omt;
    fixture.source_overmap->ter_set(
        fixture.source_local, oter_id( "field" ) );

    const sol::table overmap = fixture.overmap_api();
    const sol::protected_function matches_terrain =
        overmap["matches_terrain"];
    const sol::protected_function matches_location =
        overmap["matches_location"];
    const cata::lua_platform::script_tripoint_coord lua_position =
        fixture.abs_omt_position( position );

    const sol::protected_function_result field_result =
        matches_terrain( lua_position, "field" );
    REQUIRE( field_result.valid() );
    CHECK( field_result.get<bool>() );

    const sol::protected_function_result wrong_terrain_result =
        matches_terrain( lua_position, "forest" );
    REQUIRE( wrong_terrain_result.valid() );
    CHECK_FALSE( wrong_terrain_result.get<bool>() );

    const sol::protected_function_result invalid_terrain_result =
        matches_terrain( lua_position, "field\n" );
    CHECK_FALSE( invalid_terrain_result.valid() );

    const sol::protected_function_result field_location_result =
        matches_location( lua_position, "field" );
    REQUIRE( field_location_result.valid() );
    CHECK( field_location_result.get<bool>() );

    const sol::protected_function_result camp_start_result =
        matches_location( lua_position, "FACTION_CAMP_START" );
    REQUIRE( camp_start_result.valid() );
    CHECK( camp_start_result.get<bool>() );

    const sol::protected_function_result no_camp_result =
        matches_location( lua_position, "FACTION_CAMP_ANY" );
    REQUIRE( no_camp_result.valid() );
    CHECK_FALSE( no_camp_result.get<bool>() );

    fixture.source_overmap->ter_set(
        fixture.source_local, oter_id( "forest" ) );
    const sol::protected_function_result non_camp_start_result =
        matches_location( lua_position, "FACTION_CAMP_START" );
    REQUIRE( non_camp_start_result.valid() );
    const oter_id native_terrain = overmap_buffer.ter( position );
    const auto *native_args = overmap_buffer.mapgen_args( position );
    const bool native_camp_start = !recipe_group::get_recipes_by_id(
                                       "all_faction_base_types", native_terrain, native_args ).empty();
    CHECK( non_camp_start_result.get<bool>() == native_camp_start );

    fixture.source_overmap->ter_set(
        fixture.source_local, oter_id( "faction_base_camp_0" ) );
    const sol::protected_function_result legacy_camp_result =
        matches_location( lua_position, "FACTION_CAMP_ANY" );
    REQUIRE( legacy_camp_result.valid() );
    CHECK( legacy_camp_result.get<bool>() );

    const sol::protected_function_result point_camp_result =
        matches_terrain( lua_position, "FACTION_CAMP_ANY" );
    REQUIRE( point_camp_result.valid() );
    CHECK_FALSE( point_camp_result.get<bool>() );
    CHECK_FALSE( fixture.write_called );
}

TEST_CASE( "lua_platform_overmap_location_queries_match_native_conditions",
           "[lua][platform][overmap][conditions][semantic]" )
{
    platform_overmap_travel_fixture fixture( 822, 52 );
    REQUIRE( fixture.edit_ready );

    avatar &player = get_avatar();
    dialogue conversation( get_talker_for( player ), get_talker_for( player ) );
    fixture.source_overmap->ter_set(
        fixture.source_local, oter_id( "field" ) );

    fixture.lua.open_libraries( sol::lib::base );
    fixture.lua["services"] = fixture.services;
    const cata::lua_platform::script_tripoint_coord center =
        fixture.abs_omt_position( fixture.source_omt );
    const sol::protected_function matches_location =
        fixture.services["overmap"]["matches_location"];
    const auto compare_at = [&]( const std::string & condition_json,
    const std::string & location ) {
        const conditional_t native_condition( json_loader::from_string(
                condition_json ).get_object() );
        const bool native_result = native_condition( conversation );
        const sol::protected_function_result platform_result =
            matches_location( center, location );
        REQUIRE( platform_result.valid() );
        CHECK( platform_result.get<bool>() == native_result );
    };
    compare_at( R"({"u_at_om_location":"field"})", "field" );
    compare_at( R"({"u_at_om_location":"FACTION_CAMP_START"})",
                "FACTION_CAMP_START" );
    compare_at( R"({"u_at_om_location":"FACTION_CAMP_ANY"})",
                "FACTION_CAMP_ANY" );

    const sol::protected_function matches_near =
        fixture.services["overmap"]["matches_location_near"];
    const auto compare_near = [&]( const std::string & condition_json,
    const std::string & location, const int native_radius ) {
        const conditional_t native_condition( json_loader::from_string(
                condition_json ).get_object() );
        const bool native_result = native_condition( conversation );
        const sol::protected_function_result platform_result =
            matches_near( center, location, native_radius );
        REQUIRE( platform_result.valid() );
        CHECK( platform_result.get<bool>() == native_result );
    };
    compare_near( R"({"u_near_om_location":"field","range":0})",
                  "field", 0 );
    compare_near( R"({"u_near_om_location":"field"})", "field", 1 );
    compare_near( R"({"u_near_om_location":"field","range":1.9})",
                  "field", 1 );
    compare_near( R"({"u_near_om_location":"field","range":-0.9})",
                  "field", 0 );
    compare_near( R"({"u_near_om_location":"FACTION_CAMP_START","range":1})",
                  "FACTION_CAMP_START", 1 );
    compare_near( R"({"u_near_om_location":"FACTION_CAMP_ANY","range":2})",
                  "FACTION_CAMP_ANY", 2 );
}

TEST_CASE( "lua_platform_npc_overmap_conditions_match_native_beta_positions",
           "[lua][platform][overmap][conditions][semantic]" )
{
    platform_overmap_travel_fixture fixture( 823, 53 );
    REQUIRE( fixture.edit_ready );

    avatar &player = get_avatar();
    npc partner;
    partner.normalize();
    partner.setID( character_id( 8231 ), true );

    const tripoint_abs_omt beta_position_omt{
        fixture.source_omt.x(), fixture.source_omt.y(),
        fixture.source_omt.z() + 1
    };
    const tripoint_om_omt beta_local(
        fixture.source_local.xy(), beta_position_omt.z() );
    const oter_id beta_preimage = fixture.source_overmap->ter( beta_local );
    const on_out_of_scope restore_beta_terrain( [&]() {
        if( fixture.source_overmap->ter( beta_local ) != beta_preimage ) {
            fixture.source_overmap->ter_set( beta_local, beta_preimage );
        }
    } );
    fixture.source_overmap->ter_set( fixture.source_local, oter_id( "field" ) );
    fixture.source_overmap->ter_set( beta_local, oter_id( "forest" ) );
    // Keep alpha on a field at z=0 and put beta on a forest at z=1 so the
    // native beta result cannot accidentally pass through alpha's position.
    partner.setpos( project_to<coords::ms>( beta_position_omt ), false );
    CHECK( player.pos_abs_omt() == fixture.source_omt );
    CHECK( partner.pos_abs_omt() == beta_position_omt );

    dialogue conversation( get_talker_for( player ), get_talker_for( partner ) );
    fixture.lua.open_libraries( sol::lib::base );
    fixture.lua["services"] = fixture.services;
    const cata::lua_platform::script_tripoint_coord beta_center =
        fixture.abs_omt_position( partner.pos_abs_omt() );
    const sol::protected_function matches_location =
        fixture.services["overmap"]["matches_location"];
    const auto compare_at = [&]( const std::string & condition_json,
    const std::string & location ) {
        const conditional_t native_condition( json_loader::from_string(
                condition_json ).get_object() );
        const bool native_result = native_condition( conversation );
        const sol::protected_function_result platform_result =
            matches_location( beta_center, location );
        REQUIRE( platform_result.valid() );
        CHECK( platform_result.get<bool>() == native_result );
    };
    compare_at( R"({"npc_at_om_location":"forest"})", "forest" );
    compare_at( R"({"npc_at_om_location":"field"})", "field" );
    compare_at( R"({"npc_at_om_location":"FACTION_CAMP_ANY"})",
                "FACTION_CAMP_ANY" );

    const sol::protected_function matches_near =
        fixture.services["overmap"]["matches_location_near"];
    const auto compare_near = [&]( const std::string & condition_json,
    const std::string & location, const int native_radius ) {
        const conditional_t native_condition( json_loader::from_string(
                condition_json ).get_object() );
        const bool native_result = native_condition( conversation );
        const sol::protected_function_result platform_result =
            matches_near( beta_center, location, native_radius );
        REQUIRE( platform_result.valid() );
        CHECK( platform_result.get<bool>() == native_result );
    };
    compare_near( R"({"npc_near_om_location":"forest","range":0})",
                  "forest", 0 );
    compare_near( R"({"npc_near_om_location":"field","range":0})",
                  "field", 0 );
    compare_near( R"({"npc_near_om_location":"forest","range":1.9})",
                  "forest", 1 );
    compare_near( R"({"npc_near_om_location":"forest","range":-0.9})",
                  "forest", 0 );
    compare_near(
        R"({"npc_near_om_location":"FACTION_CAMP_START","range":1})",
        "FACTION_CAMP_START", 1 );
    compare_near( R"({"npc_near_om_location":"FACTION_CAMP_ANY","range":2})",
                  "FACTION_CAMP_ANY", 2 );
}

TEST_CASE( "lua_platform_overmap_route_reveal_matches_native_path_semantics",
           "[lua][platform][overmap][semantic]" )
{
    platform_overmap_travel_fixture fixture( 824, 54 );
    REQUIRE( fixture.edit_ready );

    const point om_base = fixture.source_omt.raw().xy() - fixture.source_local.raw().xy();
    const tripoint_abs_omt start( om_base.x + OMAPX / 2,
                                  om_base.y + OMAPY / 2,
                                  fixture.source_omt.z() );
    const tripoint_abs_omt end = start + tripoint::east;
    const tripoint_om_omt local_start( OMAPX / 2, OMAPY / 2,
                                       fixture.source_omt.z() );
    const oter_id road_terrain = oter_road.id();
    REQUIRE( road_terrain.is_valid() );
    REQUIRE( overmap_connections::guess_for( road_terrain ).is_valid() );

    struct route_tile_preimage {
        tripoint_om_omt local;
        oter_id terrain;
        om_vision_level seen;
    };
    std::vector<route_tile_preimage> preimage;
    for( int dy = -4; dy <= 4; ++dy ) {
        for( int dx = -4; dx <= 4; ++dx ) {
            const tripoint_om_omt local(
                local_start.x() + dx, local_start.y() + dy,
                local_start.z() );
            preimage.push_back( { local,
                                  fixture.source_overmap->ter( local ),
                                  fixture.source_overmap->seen( local ) } );
        }
    }
    const on_out_of_scope restore_route_tiles( [&]() {
        for( const route_tile_preimage &tile : preimage ) {
            if( fixture.source_overmap->ter( tile.local ) != tile.terrain ) {
                fixture.source_overmap->ter_set( tile.local, tile.terrain );
            }
            if( fixture.source_overmap->seen( tile.local ) != tile.seen ) {
                fixture.source_overmap->set_seen( tile.local, tile.seen, true );
            }
        }
    } );
    for( const route_tile_preimage &tile : preimage ) {
        fixture.source_overmap->ter_set( tile.local, road_terrain );
        if( fixture.source_overmap->seen( tile.local ) !=
            om_vision_level::unseen ) {
            fixture.source_overmap->set_seen(
                tile.local, om_vision_level::unseen, true );
        }
    }

    const bool native_found = overmap_buffer.reveal_route( start, end, 1, true );
    REQUIRE( native_found );
    std::vector<om_vision_level> native_seen;
    for( int dy = -2; dy <= 2; ++dy ) {
        for( int dx = -2; dx <= 3; ++dx ) {
            native_seen.push_back( fixture.source_overmap->seen(
                                       tripoint_om_omt( local_start.x() + dx,
                                               local_start.y() + dy,
                                               local_start.z() ) ) );
        }
    }
    CHECK( native_seen[13] == om_vision_level::full );
    CHECK( native_seen[14] == om_vision_level::full );
    CHECK( native_seen[15] == om_vision_level::full );
    CHECK( native_seen[16] == om_vision_level::full );
    for( const route_tile_preimage &tile : preimage ) {
        if( fixture.source_overmap->seen( tile.local ) !=
            om_vision_level::unseen ) {
            fixture.source_overmap->set_seen(
                tile.local, om_vision_level::unseen, true );
        }
    }

    const sol::protected_function reveal_route =
        fixture.overmap_api()["reveal_route"];
    const sol::protected_function_result platform_result = reveal_route(
                fixture.abs_omt_position( start ),
                fixture.abs_omt_position( end ), 1, true );
    REQUIRE( platform_result.valid() );
    CHECK( platform_result.get<bool>() == native_found );
    std::size_t seen_index = 0;
    for( int dy = -2; dy <= 2; ++dy ) {
        for( int dx = -2; dx <= 3; ++dx ) {
            CHECK( fixture.source_overmap->seen( tripoint_om_omt(
                    local_start.x() + dx, local_start.y() + dy,
                    local_start.z() ) ) == native_seen[seen_index++] );
        }
    }
    CHECK( fixture.write_called );

    const cata::lua_platform::script_tripoint_coord wrong_scale =
        cata::lua_platform::script_tripoint_coord::from_native(
            coords::origin::abs, coords::scale::map_square,
            project_to<coords::ms>( start ).raw() );
    const sol::protected_function_result wrong_scale_result = reveal_route(
                wrong_scale, fixture.abs_omt_position( end ), 1, true );
    CHECK_FALSE( wrong_scale_result.valid() );
    const sol::protected_function_result excessive_radius_result = reveal_route(
                fixture.abs_omt_position( start ),
                fixture.abs_omt_position( end ), 31, true );
    CHECK_FALSE( excessive_radius_result.valid() );
    const sol::protected_function_result fractional_radius_result = reveal_route(
                fixture.abs_omt_position( start ),
                fixture.abs_omt_position( end ), 1.5, true );
    CHECK_FALSE( fractional_radius_result.valid() );
}

TEST_CASE( "lua_platform_overmap_native_reveal_matches_native_area_semantics",
           "[lua][platform][overmap][semantic]" )
{
    platform_overmap_travel_fixture fixture( 825, 55 );
    REQUIRE( fixture.edit_ready );

    const point om_base = fixture.source_omt.raw().xy() - fixture.source_local.raw().xy();
    const tripoint_abs_omt center( om_base.x + OMAPX / 2,
                                   om_base.y + OMAPY / 2,
                                   fixture.source_omt.z() );
    const tripoint_om_omt local_center( OMAPX / 2, OMAPY / 2,
                                        fixture.source_omt.z() );

    struct reveal_tile_preimage {
        tripoint_om_omt local;
        om_vision_level seen;
    };
    std::vector<reveal_tile_preimage> preimage;
    for( int dy = -2; dy <= 2; ++dy ) {
        for( int dx = -2; dx <= 2; ++dx ) {
            const tripoint_om_omt local(
                local_center.x() + dx, local_center.y() + dy,
                local_center.z() );
            preimage.push_back( { local,
                                  fixture.source_overmap->seen( local ) } );
            fixture.source_overmap->set_seen(
                local, om_vision_level::unseen, true );
        }
    }
    const on_out_of_scope restore_reveal_tiles( [&]() {
        for( const reveal_tile_preimage &tile : preimage ) {
            if( fixture.source_overmap->seen( tile.local ) != tile.seen ) {
                fixture.source_overmap->set_seen(
                    tile.local, tile.seen, true );
            }
        }
    } );

    const bool native_changed = overmap_buffer.reveal( center, 2 );
    REQUIRE( native_changed );
    std::vector<om_vision_level> native_seen;
    native_seen.reserve( preimage.size() );
    for( const reveal_tile_preimage &tile : preimage ) {
        native_seen.push_back(
            fixture.source_overmap->seen( tile.local ) );
        fixture.source_overmap->set_seen(
            tile.local, om_vision_level::unseen, true );
    }

    const sol::protected_function reveal_native =
        fixture.overmap_api()["reveal_native"];
    const tripoint_abs_ms center_ms = project_to<coords::ms>( center );
    const cata::lua_platform::script_tripoint_coord projected_center =
        cata::lua_platform::script_tripoint_coord::from_native(
            coords::origin::abs, coords::scale::map_square,
            center_ms.raw() ).project_to( "omt" );
    CHECK( projected_center.native_scale() ==
           coords::scale::overmap_terrain );
    CHECK( projected_center.to_native() == center.raw() );
    const sol::protected_function_result platform_result = reveal_native(
                projected_center, 2 );
    REQUIRE( platform_result.valid() );
    CHECK( platform_result.get<bool>() == native_changed );
    std::size_t seen_index = 0;
    for( const reveal_tile_preimage &tile : preimage ) {
        CHECK( fixture.source_overmap->seen( tile.local ) ==
               native_seen[seen_index++] );
        fixture.source_overmap->set_seen(
            tile.local, om_vision_level::unseen, true );
    }
    CHECK( fixture.write_called );

    const sol::protected_function_result zero_radius_result = reveal_native(
                fixture.abs_omt_position( center ), 0 );
    REQUIRE( zero_radius_result.valid() );
    CHECK( zero_radius_result.get<bool>() );
    for( const reveal_tile_preimage &tile : preimage ) {
        const bool is_center = tile.local == local_center;
        CHECK( fixture.source_overmap->seen( tile.local ) ==
               ( is_center ? om_vision_level::full :
                 om_vision_level::unseen ) );
    }

    const cata::lua_platform::script_tripoint_coord wrong_scale =
        cata::lua_platform::script_tripoint_coord::from_native(
            coords::origin::abs, coords::scale::map_square,
            project_to<coords::ms>( center ).raw() );
    CHECK_FALSE( reveal_native( wrong_scale, 0 ).valid() );
    const cata::lua_platform::script_tripoint_coord lua_center =
        fixture.abs_omt_position( center );
    CHECK_FALSE( reveal_native( lua_center, 37 ).valid() );
    CHECK_FALSE( reveal_native( lua_center, 1.5 ).valid() );
    CHECK_FALSE( reveal_native( lua_center, -1 ).valid() );
    const tripoint_abs_omt overflow_center(
        std::numeric_limits<int>::max(), center.y(), center.z() );
    CHECK_FALSE( reveal_native( fixture.abs_omt_position( overflow_center ), 1 ).valid() );
}

TEST_CASE( "lua_platform_overmap_target_search_matches_native_mission_target",
           "[lua][platform][overmap][semantic]" )
{
    platform_overmap_travel_fixture fixture( 826, 56 );
    REQUIRE( fixture.edit_ready );

    constexpr int target_z = 1;
    const oter_id field( "field" );
    const oter_id camp( "faction_base_camp_0" );
    REQUIRE( field.is_valid() );
    REQUIRE( camp.is_valid() );

    struct terrain_preimage {
        tripoint_om_omt local;
        oter_id terrain;
    };
    std::vector<terrain_preimage> preimage;
    preimage.reserve( OVERMAP_DEPTH + OVERMAP_HEIGHT + 1 );
    for( int z = -OVERMAP_DEPTH; z <= OVERMAP_HEIGHT; ++z ) {
        const tripoint_om_omt local( fixture.source_local.xy(), z );
        preimage.push_back( { local, fixture.source_overmap->ter( local ) } );
        fixture.source_overmap->ter_set( local, field );
    }
    const on_out_of_scope restore_terrain( [&]() {
        for( const terrain_preimage &tile : preimage ) {
            if( fixture.source_overmap->ter( tile.local ) != tile.terrain ) {
                fixture.source_overmap->ter_set( tile.local, tile.terrain );
            }
        }
    } );
    const tripoint_om_omt target_local( fixture.source_local.xy(), target_z );
    fixture.source_overmap->ter_set( target_local, camp );

    avatar &player = get_avatar();
    dialogue conversation( get_talker_for( player ), get_talker_for( player ) );
    mission_target_params native_params;
    native_params.overmap_terrain = "faction_base";
    native_params.overmap_terrain_match_type = ot_match_type::prefix;
    native_params.random = true;
    native_params.search_range = 1.9;
    native_params.min_distance = 0.9;
    native_params.z = dbl_or_var( 1.9 );
    native_params.offset = tripoint_rel_omt( 1, 0, 0 );
    const tripoint_abs_omt native_target =
        mission_util::get_om_terrain_pos( native_params, conversation );

    const sol::protected_function find_target =
        fixture.overmap_api()["find_target"];
    sol::table selector = fixture.lua.create_table();
    selector["terrain"] = "faction_base";
    selector["match"] = cata::lua_platform::script_enum_value::from(
                            "OtMatchType", "prefix" );
    sol::table options = fixture.lua.create_table();
    options["random"] = true;
    options["search_range"] = 1.9;
    options["min_distance"] = 0.9;
    options["z"] = 1.9;
    options["offset"] = cata::lua_platform::script_tripoint_coord::from_native(
                            coords::origin::relative,
                            coords::scale::overmap_terrain,
                            tripoint::east );
    const sol::protected_function_result platform_result = find_target(
                fixture.abs_omt_position( fixture.source_omt ), selector, options );
    REQUIRE( platform_result.valid() );
    const tripoint_abs_omt platform_target(
        platform_result.get<cata::lua_platform::script_tripoint_coord>().to_native() );

    const tripoint_abs_omt expected( fixture.source_omt.xy(), target_z );
    const tripoint_abs_omt expected_with_offset = expected + tripoint::east;
    CHECK( native_target == expected_with_offset );
    CHECK( platform_target == native_target );
    CHECK_FALSE( fixture.write_called );
}

TEST_CASE( "lua_platform_overmap_target_search_retries_with_generation_and_returns_origin",
           "[lua][platform][overmap][semantic]" )
{
    platform_overmap_travel_fixture fixture( 827, 57 );
    REQUIRE( fixture.edit_ready );

    tripoint_abs_omt remote_origin( 1000000, 1000000, 0 );
    for( int attempt = 0; attempt < 100 &&
         overmap_buffer.has( project_to<coords::om>( remote_origin.xy() ) );
         ++attempt ) {
        remote_origin.x() += OMAPX * 10;
    }
    const point_abs_om remote_overmap =
        project_to<coords::om>( remote_origin.xy() );
    REQUIRE_FALSE( overmap_buffer.has( remote_overmap ) );

    const sol::protected_function find_target =
        fixture.overmap_api()["find_target"];
    sol::table selector = fixture.lua.create_table();
    selector["terrain"] = "__missing_platform_test_terrain__";
    selector["match"] = cata::lua_platform::script_enum_value::from(
                            "OtMatchType", "exact" );
    sol::table options = fixture.lua.create_table();
    options["search_range"] = lua_Integer{ 3 };
    options["min_distance"] = lua_Integer{ 0 };
    options["z"] = lua_Integer{ 0 };
    const sol::protected_function_result platform_result = find_target(
                fixture.abs_omt_position( remote_origin ), selector, options );
    REQUIRE( platform_result.valid() );
    const tripoint_abs_omt platform_target(
        platform_result.get<cata::lua_platform::script_tripoint_coord>().to_native() );
    CHECK( platform_target == remote_origin );
    CHECK( fixture.write_called );
    CHECK( overmap_buffer.has( remote_overmap ) );

    npc native_origin;
    native_origin.normalize();
    native_origin.setID( character_id( 8271 ), true );
    native_origin.setpos( project_to<coords::ms>( remote_origin ), false );
    avatar &player = get_avatar();
    dialogue conversation( get_talker_for( player ), get_talker_for( player ) );
    mission_target_params native_params;
    native_params.overmap_terrain = "__missing_platform_test_terrain__";
    native_params.overmap_terrain_match_type = ot_match_type::exact;
    native_params.origin_u = false;
    native_params.guy = &native_origin;
    native_params.search_range = 3.0;
    native_params.min_distance = 0.0;
    native_params.z = dbl_or_var( 0.0 );
    const tripoint_abs_omt native_target =
        mission_util::get_om_terrain_pos( native_params, conversation );
    CHECK( native_target == platform_target );
}

#endif // CATA_ENABLE_LUA_PLATFORM
