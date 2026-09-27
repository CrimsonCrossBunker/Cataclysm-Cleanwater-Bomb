#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_map_support.h"

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

#endif // CATA_ENABLE_LUA_PLATFORM
