#include <string>
#include <utility>

#include "cata_catch.h"
#include "color.h"
#include "coordinates.h"
#include "omdata.h"
#include "overmap.h"
#include "point.h"

TEST_CASE( "overmap_mission_markers_indicate_the_target_level", "[overmap][ui][mission]" )
{
    const int viewed_z = GENERATE( -2, 0, 2 );
    const int target_z = GENERATE( -2, 0, 2 );
    const bool highlight_mission = GENERATE( false, true );
    const bool blink = GENERATE( false, true );
    const tripoint_abs_omt viewed( 10, 20, viewed_z );
    oter_display_options opts( viewed, 0 );
    opts.blink = blink;
    opts.hilite_mission = highlight_mission;
    opts.show_pc = false;
    opts.showhordes = false;
    oter_display_args args( om_vision_level::unseen );
    args.los = 0;
    const std::pair<std::string, nc_color> terrain = oter_symbol_and_color( viewed, args, opts );

    opts.mission_target = tripoint_abs_omt( viewed.xy() + point::east, target_z );
    CHECK( oter_symbol_and_color( viewed, args, opts ) == terrain );

    opts.mission_target = tripoint_abs_omt( viewed.xy(), target_z );
    const std::pair<std::string, nc_color> marker = oter_symbol_and_color( viewed, args, opts );
    if( target_z == viewed_z && highlight_mission ) {
        CHECK( marker.first == terrain.first );
        CHECK( marker.second == red_background( terrain.second ) );
    } else if( blink || highlight_mission ) {
        CHECK( marker.first == ( target_z > viewed_z ? "^" : target_z < viewed_z ? "v" : "*" ) );
        CHECK( marker.second == c_red );
    } else {
        CHECK( marker == terrain );
    }
}
