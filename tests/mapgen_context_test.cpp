#include <stdexcept>

#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "coordinates.h"
#include "game.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "map_scale_constants.h"
#include "mapbuffer.h"
#include "overmapbuffer.h"
#include "submap.h"
#include "type_id.h"
#include "worldfactory.h"

static const furn_str_id furn_f_chair( "f_chair" );
static const ter_str_id ter_t_floor( "t_floor" );
static const ter_str_id ter_t_soil( "t_soil" );

namespace
{
class mapgen_context_map : public smallmap
{
    public:
        void attach_origin( submap &sm ) {
            setsubmap( get_nonant( tripoint_rel_sm::zero ), &sm );
        }
};
} // namespace

TEST_CASE( "edits_after_map_generation_are_player_adjustments", "[mapgen][context]" )
{
    const tripoint_abs_omt position( 50, 50, 0 );
    for( int z = -OVERMAP_DEPTH; z <= OVERMAP_HEIGHT; ++z ) {
        overmap_buffer.ter_set( tripoint_abs_omt( position.xy(), z ), oter_id( "solid_earth" ) );
    }
    smallmap generated;
    generated.main_cleanup_override( false );
    on_out_of_scope cleanup( [&]() {
        generated.delete_unmerged_submaps();
    } );
    generated.generate( position, calendar::turn, false, false );
    map &here = *generated.cast_to_map();
    submap *sm = map_meddler::get_submap_at_grid( here, tripoint_rel_sm::zero );
    REQUIRE( sm );
    REQUIRE_FALSE( sm->player_adjusted_map );
    SECTION( "terrain edit" ) {
        REQUIRE( here.ter_set( tripoint_bub_ms::zero, ter_t_floor ) );
    }
    SECTION( "furniture edit" ) {
        REQUIRE( here.furn_set( tripoint_bub_ms::zero, furn_f_chair ) );
    }
    CHECK( sm->player_adjusted_map );
}

TEST_CASE( "failed_generation_does_not_leave_map_in_generation_mode", "[mapgen][context]" )
{
    // Fail at the real storage boundary before generate has allocated any new
    // grid entries. No production-only hook or throwing test generator is used.
    get_map() = map();
    MAPBUFFER.clear();
    WORLD *active = world_generator->active_world;
    on_out_of_scope restore( [&]() {
        world_generator->active_world = active;
        clear_overmaps();
    } );
    submap existing;
    existing.set_all_ter( ter_t_soil );
    mapgen_context_map target;
    target.main_cleanup_override( false );
    world_generator->active_world = nullptr;
    REQUIRE_THROWS_AS( target.generate( tripoint_abs_omt::zero, calendar::turn, true, false ),
                       std::logic_error );
    world_generator->active_world = active;
    target.attach_origin( existing );
    REQUIRE_FALSE( existing.player_adjusted_map );
    REQUIRE( target.cast_to_map()->ter_set( tripoint_bub_ms::zero, ter_t_floor ) );
    CHECK( existing.player_adjusted_map );
}
