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
#include "vehicle.h"
#include "vpart_position.h"

static const vpart_id vpart_aisle( "aisle" );
static const vpart_id vpart_ladder_3( "ladder_3" );

static const vproto_id vproto_test_turret_rig( "test_turret_rig" );

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
    // Snapshot the shared engine for the state comparison below.
    const cata_default_random_engine engine = rng_get_engine(); // NOLINT(cata-determinism)
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
    CHECK_FALSE( terrain->fixed_light );
    CHECK_FALSE( furniture->fixed_light );
    CHECK_FALSE( trap->fixed_light );
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
    const memorized_tile before = you.get_memorized_tile( absolute );
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
    const memorized_tile before = you.get_memorized_tile( absolute );
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
            CHECK( view->fixed_light );
            CHECK( view->absolute_position == absolute );
        }
        CHECK( you.get_memorized_tile( absolute ) == before );
    }
}
TEST_CASE( "reused_layer_capture_keeps_owned_values_and_refreshes_every_field",
           "[tiles][layer_view]" )
{
    clear_map_without_vision();
    clear_avatar();
    map &here = get_map();
    avatar &you = get_avatar();
    const tripoint_bub_ms pos( 50, 50, 0 );
    const tripoint_abs_ms absolute = here.get_abs( pos );
    you.prepare_map_memory_region( absolute - tripoint( 2, 2, 0 ), absolute + tripoint( 2, 2, 0 ) );
    tile_render_info::sprite cached{ lit_level::LOW, {} };
    cached.set_ter_content( ter_id( "t_floor" ), 3, 1 );
    cached.set_furn_content( furn_id( "f_chair" ), 2, 2 );
    cached.set_trap_content( trap_id( "tr_beartrap" ), 1, 0 );
    tile_layer_capture_input input{ pos, lit_level::LOW, {}, cached, true, false };
    tile_layer_view output{ std::string( 128, 'x' ), TILE_CATEGORY::NONE,
                            "obsolete subcategory", pos, 99, 99, lit_level::DARK, false,
                            tripoint_abs_ms( 1, 2, 3 ), true };
    const std::size_t capacity = output.id.capacity();
    // Snapshot the shared engine for the state comparison below.
    const cata_default_random_engine engine = rng_get_engine(); // NOLINT(cata-determinism)
    REQUIRE( capture_terrain_layer( here, you, input, {}, output ) );
    CHECK( output.id == "t_floor" );
    CHECK( output.category == TILE_CATEGORY::TERRAIN );
    CHECK( output.subcategory.empty() );
    CHECK( output.subtile == 3 );
    CHECK( output.rotation == 1 );
    CHECK( output.position == pos );
    CHECK( output.absolute_position == here.get_abs( pos ) );
    CHECK( output.light == lit_level::LOW );
    CHECK( output.night_vision );
    CHECK_FALSE( output.fixed_light );
    const tile_layer_view retained = output;
    REQUIRE( capture_furniture_layer( here, you, input, {}, output ) );
    CHECK( output.id == "f_chair" );
    CHECK( output.category == TILE_CATEGORY::FURNITURE );
    CHECK( output.subtile == 2 );
    CHECK( output.rotation == 2 );
    input.light = lit_level::LIT;
    input.night_vision = false;
    REQUIRE( capture_trap_layer( here, you, input, {}, output ) );
    CHECK( output.id == "tr_beartrap" );
    CHECK( output.category == TILE_CATEGORY::TRAP );
    CHECK( output.subtile == 1 );
    CHECK( output.rotation == 0 );
    CHECK( output.light == lit_level::LIT );
    CHECK_FALSE( output.night_vision );
    CHECK_FALSE( output.fixed_light );
    CHECK( output.id.capacity() >= capacity );
    CHECK( retained.id == "t_floor" );
    CHECK( retained.category == TILE_CATEGORY::TERRAIN );
    CHECK( retained.light == lit_level::LOW );
    CHECK( retained.night_vision );
    // Reusing storage must still query this capture's preview/memory state.
    // Seed existing memory explicitly; clear_avatar need not clear every region.
    you.memorize_terrain( here.get_abs( pos ), "t_floor", 2, 1 );
    const memorized_tile before_preview = you.get_memorized_tile( here.get_abs( pos ) );
    input.invisible.fill( true );
    REQUIRE( capture_terrain_layer( here, you, input,
    { { pos, ter_id( "t_wall" ) } }, output ) );
    CHECK( output.id == "t_wall" );
    CHECK( output.light == lit_level::LIT );
    CHECK_FALSE( output.night_vision );
    CHECK( output.fixed_light );
    CHECK( you.get_memorized_tile( here.get_abs( pos ) ).get_ter_id() == before_preview.get_ter_id() );
    CHECK( you.get_memorized_tile( here.get_abs( pos ) ).get_ter_subtile() ==
           before_preview.get_ter_subtile() );
    CHECK( you.get_memorized_tile( here.get_abs( pos ) ).get_ter_rotation() ==
           before_preview.get_ter_rotation() );
    you.memorize_terrain( here.get_abs( pos ), "t_grass", 4, 3 );
    REQUIRE( capture_terrain_layer( here, you, input, {}, output ) );
    CHECK( output.id == "t_grass" );
    CHECK( output.subtile == 4 );
    CHECK( output.rotation == 3 );
    CHECK( output.light == lit_level::MEMORIZED );
    CHECK_FALSE( output.fixed_light );
    you.memorize_terrain( here.get_abs( pos ), "", 0, 0 );
    CHECK_FALSE( capture_terrain_layer( here, you, input, {}, output ) );
    CHECK( rng_get_engine() == engine );
}

TEST_CASE( "vehicle_ladder_visuals_follow_real_cache_lifecycle",
           "[tiles][layer_view][vehicle][zlevel]" )
{
    clear_map_without_vision();
    clear_avatar();
    map &here = get_map();
    avatar &you = get_avatar();
    const tripoint_bub_ms top( 60, 60, 2 );
    const tripoint_bub_ms below = top + tripoint::below;
    here.ter_set( top, ter_id( "t_open_air" ) );
    here.ter_set( below, ter_id( "t_open_air" ) );
    here.furn_set( top, furn_id( "f_null" ) );
    here.furn_set( below, furn_id( "f_null" ) );
    CHECK_FALSE( here.vehicle_ladder_furniture_at( below ) );
    CHECK_FALSE( here.vehicle_ladder_furniture_at( tripoint_bub_ms( 0, 0, 2 ) ) );
    vehicle *veh = here.add_vehicle( vproto_test_turret_rig, top, 0_degrees,
                                     0, veh_spawn_status::PRISTINE, false, true );
    REQUIRE( veh );
    REQUIRE( veh->install_part( here, point_rel_ms::zero, vpart_aisle ) >= 0 );
    REQUIRE( veh->install_part( here, point_rel_ms::zero, vpart_ladder_3 ) >= 0 );
    veh->refresh();
    here.add_vehicle_to_cache( veh );
    const auto visual = here.vehicle_ladder_furniture_at( below );
    REQUIRE( visual );
    CHECK( *visual == furn_id( "f_rope_up" ) );
    CHECK_FALSE( here.vehicle_ladder_furniture_at( top ) );
    tile_render_info::sprite cached{ lit_level::LOW, {} };
    const tile_layer_capture_input input{ below, lit_level::LOW, {}, cached, true, false };
    const auto layer = capture_furniture_layer( here, you, input, {} );
    REQUIRE( layer );
    CHECK( layer->id == "f_rope_up" );
    CHECK( layer->position == below );
    here.ter_set( below, ter_id( "t_floor" ) );
    here.furn_set( below, furn_id( "f_chair" ) );
    CHECK_FALSE( here.vehicle_ladder_furniture_at( below ) );
    here.furn_set( below, furn_id( "f_null" ) );
    here.ter_set( below, ter_id( "t_open_air" ) );
    CHECK( here.vehicle_ladder_furniture_at( below ) == visual );
    here.destroy_vehicle( veh );
    CHECK_FALSE( here.vehicle_ladder_furniture_at( below ) );
    CHECK_FALSE( capture_furniture_layer( here, you, input, {} ) );
    CHECK( layer->id == "f_rope_up" );
}

#endif // TILES
