#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include <string>
#include <vector>

#include "cata_scope_helpers.h"
#include "character_id.h"
#include "condition.h"
#include "json_loader.h"
#include "lua_platform_test_map_support.h"
#include "map_scale_constants.h"
#include "npc.h"
#include "overmap_connection.h"
#include "overmapbuffer.h"

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
    CHECK_FALSE( non_camp_start_result.get<bool>() );

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
    const auto compare_at = [&]( const std::string &condition_json,
    const std::string &location ) {
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
    const auto compare_near = [&]( const std::string &condition_json,
    const std::string &location, const int native_radius ) {
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
    const auto compare_at = [&]( const std::string &condition_json,
    const std::string &location ) {
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
    const auto compare_near = [&]( const std::string &condition_json,
    const std::string &location, const int native_radius ) {
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

    const int om_base_x = fixture.source_omt.x() - fixture.source_local.x();
    const int om_base_y = fixture.source_omt.y() - fixture.source_local.y();
    const tripoint_abs_omt start( om_base_x + OMAPX / 2,
                                  om_base_y + OMAPY / 2,
                                  fixture.source_omt.z() );
    const tripoint_abs_omt end = start + tripoint::east;
    const tripoint_om_omt local_start( OMAPX / 2, OMAPY / 2,
                                       fixture.source_omt.z() );
    const oter_id road_terrain = oter_str_id( "road" ).id();
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

#endif // CATA_ENABLE_LUA_PLATFORM
