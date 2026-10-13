#if defined(TILES)
#include <array>
#include <map>

#include "avatar.h"
#include "cata_catch.h"
#include "enums.h"
#include "map.h"
#include "map_helpers.h"
#include "map_memory.h"
#include "player_helpers.h"
#include "rng.h"
#include "tile_layer_capture.h"
#include "type_id.h"

TEST_CASE( "static_layer_values_keep_cached_content_after_world_changes", "[tiles][layer_view]" )
{
    clear_map_without_vision();
    clear_avatar();
    map &here = get_map();
    avatar &you = get_avatar();
    const tripoint_bub_ms pos( 50, 50, 0 );
    tile_render_info::sprite cached{ lit_level::LOW, {} };
    cached.set_ter_content( ter_id( "t_floor" ), 3, 1 );
    cached.set_furn_content( furn_id( "f_chair" ), 2, 2 );
    cached.set_trap_content( trap_id( "tr_beartrap" ), 1, 0 );
    const tile_layer_capture_input input{ pos, lit_level::LOW, {}, cached, true, false };
    const auto engine = rng_get_engine();
    const auto terrain = capture_terrain_layer( here, you, input, {} );
    const auto furniture = capture_furniture_layer( here, you, input, {} );
    const auto trap = capture_trap_layer( here, you, input, {} );
    REQUIRE( terrain );
    REQUIRE( furniture );
    REQUIRE( trap );
    CHECK( terrain->id == "t_floor" );
    CHECK( terrain->subtile == 3 );
    CHECK( terrain->rotation == 1 );
    CHECK( furniture->id == "f_chair" );
    CHECK( furniture->rotation == 2 );
    CHECK( trap->id == "tr_beartrap" );
    CHECK( terrain->absolute_position == here.get_abs( pos ) );
    CHECK( terrain->light == lit_level::LOW );
    CHECK( terrain->night_vision );
    CHECK( rng_get_engine() == engine );
    here.ter_set( pos, ter_id( "t_grass" ) );
    here.furn_set( pos, furn_id( "f_null" ) );
    CHECK( terrain->id == "t_floor" );
    CHECK( furniture->id == "f_chair" );
}

TEST_CASE( "memory_layer_values_own_content_and_classify_decoration_prefixes",
           "[tiles][layer_view]" )
{
    clear_map_without_vision();
    clear_avatar();
    map &here = get_map();
    avatar &you = get_avatar();
    const tripoint_bub_ms pos( 50, 50, 0 );
    const tripoint_abs_ms absolute = here.get_abs( pos );
    you.prepare_map_memory_region( absolute - tripoint( 2, 2, 0 ), absolute + tripoint( 2, 2, 0 ) );
    you.memorize_terrain( absolute, "t_floor", 2, 3 );
    you.memorize_decoration( absolute, "f_chair", 1, 2 );
    const auto before = you.get_memorized_tile( absolute );
    tile_render_info::sprite cached{ lit_level::MEMORIZED, { true, true, true, true, true } };
    const tile_layer_capture_input input{ pos, lit_level::DARK, cached.invisible, cached, true, false };
    const auto terrain = capture_terrain_layer( here, you, input, {} );
    const auto furniture = capture_furniture_layer( here, you, input, {} );
    REQUIRE( terrain );
    REQUIRE( furniture );
    CHECK( terrain->id == "t_floor" );
    CHECK( terrain->rotation == 3 );
    CHECK( furniture->id == "f_chair" );
    CHECK( terrain->light == lit_level::MEMORIZED );
    CHECK( terrain->night_vision );
    CHECK_FALSE( capture_trap_layer( here, you, input, {} ) );
    CHECK( you.get_memorized_tile( absolute ) == before );
    you.memorize_decoration( absolute, "tr_beartrap", 3, 1 );
    const auto trap = capture_trap_layer( here, you, input, {} );
    REQUIRE( trap );
    CHECK( trap->id == "tr_beartrap" );
    CHECK( trap->rotation == 1 );
    CHECK_FALSE( capture_furniture_layer( here, you, input, {} ) );
    you.memorize_clear_decoration( absolute );
    CHECK( furniture->id == "f_chair" );
    CHECK( trap->id == "tr_beartrap" );
}

TEST_CASE( "explicit_layer_overrides_keep_full_light_and_do_not_memorize", "[tiles][layer_view]" )
{
    clear_map_without_vision();
    clear_avatar();
    map &here = get_map();
    avatar &you = get_avatar();
    const tripoint_bub_ms pos( 50, 50, 0 );
    const tripoint_abs_ms absolute = here.get_abs( pos );
    you.prepare_map_memory_region( absolute - tripoint( 2, 2, 0 ), absolute + tripoint( 2, 2, 0 ) );
    const auto before = you.get_memorized_tile( absolute );
    tile_render_info::sprite cached{ lit_level::DARK, {} };
    for( bool hidden : {
             false, true
         } ) {
        INFO( hidden );
        std::array<bool, 5> invisible;
        invisible.fill( hidden );
        const tile_layer_capture_input input{ pos, lit_level::DARK, invisible, cached, true, false };
        const auto terrain = capture_terrain_layer( here, you, input, { { pos, ter_id( "t_wall" ) } } );
        const auto furniture = capture_furniture_layer( here, you, input, { { pos, furn_id( "f_chair" ) } } );
        const auto trap = capture_trap_layer( here, you, input, { { pos, trap_id( "tr_beartrap" ) } } );
        REQUIRE( terrain );
        REQUIRE( furniture );
        REQUIRE( trap );
        CHECK( terrain->id == "t_wall" );
        CHECK( furniture->id == "f_chair" );
        CHECK( trap->id == "tr_beartrap" );
        for( const auto *view : {
                 &*terrain, &*furniture, &*trap
             } ) {
            CHECK( view->light == lit_level::LIT );
            CHECK_FALSE( view->night_vision );
            CHECK( view->absolute_position == absolute );
        }
        CHECK( you.get_memorized_tile( absolute ) == before );
    }
}
#endif // TILES
