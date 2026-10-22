#include <functional>
#include <string>
#include <vector>

#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "coordinates.h"
#include "mod_manager.h"
#include "omdata.h"
#include "options.h"
#include "options_helpers.h"
#include "overmap.h"
#include "overmapbuffer.h"
#include "point.h"
#include "type_id.h"

static const oter_str_id oter_test_forest_very_thick( "test_forest_very_thick" );

TEST_CASE( "overmap_mod_source_can_be_hidden_at_every_elevation", "[overmap][mod_source]" )
{
    const int z = GENERATE( -1, 0, 1 );
    const tripoint_abs_omt pos( 60, 60, z );
    const oter_id old_terrain = overmap_buffer.ter( pos );
    const om_vision_level old_vision = overmap_buffer.seen( pos );
    on_out_of_scope restore( [&]() {
        overmap_buffer.ter_set( pos, old_terrain );
        overmap_buffer.set_seen( pos, old_vision );
    } );
    overmap_buffer.ter_set( pos, oter_test_forest_very_thick.id() );
    overmap_buffer.set_seen( pos, om_vision_level::full );

    const std::string origin = get_origin( oter_test_forest_very_thick->get_type_id()->src );
    REQUIRE_FALSE( oter_test_forest_very_thick->get_type_id()->src.empty() );
    const tripoint_abs_sm where = project_to<coords::sm>( pos );
    std::string shown;
    {
        const override_option enabled( "SHOW_OVERMAP_MOD_SOURCE", "true" );
        shown = overmap_buffer.get_description_at( where,
                get_option<bool>( "SHOW_OVERMAP_MOD_SOURCE" ) );
        CHECK( shown.find( origin ) != std::string::npos );
    }
    {
        const override_option disabled( "SHOW_OVERMAP_MOD_SOURCE", "false" );
        const std::string hidden = overmap_buffer.get_description_at( where,
                                   get_option<bool>( "SHOW_OVERMAP_MOD_SOURCE" ) );
        CHECK( hidden.find( origin ) == std::string::npos );
        // Hiding attribution must not change the terrain or city description.
        CHECK( shown == hidden + "\n" + origin );
    }
}
