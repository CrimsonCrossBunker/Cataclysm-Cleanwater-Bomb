#include <string>

#include "cata_catch.h"
#include "cata_path.h"
#include "coordinates.h"
#include "debug.h"
#include "flexbuffer_json.h"
#include "json_loader.h"
#include "map.h"
#include "map_helpers.h"
#include "mapgen.h"
#include "mapgendata.h"
#include "path_info.h"
#include "point.h"
#include "ret_val.h"
#include "type_id.h"

TEST_CASE( "godco_fungus_mission_clears_preexisting_weeds", "[mapgen][mission]" )
{
    clear_map_without_vision();
    map &here = get_map();
    const tripoint_bub_ms target( 21, 21, 0 );
    const tripoint_bub_ms outside( 30, 30, 0 );
    here.ter_set( target, ter_str_id( "t_grass" ) );
    here.furn_set( target, furn_str_id( "f_thistle" ) );
    here.furn_set( outside, furn_str_id( "f_thistle" ) );
    JsonArray missions = json_loader::from_path(
                             PATH_INFO::datadir_path() / "json/npcs/godco/godco_missions.json" ).get_array();
    bool found = false;
    while( missions.has_more() ) {
        const JsonObject definition = missions.next_object();
        definition.allow_omitted_members();
        if( definition.get_string( "id", "" ) != "MISSION_GODCO_GREENWOOD_1" ) {
            continue;
        }
        found = true;
        const JsonObject start = definition.get_object( "start" );
        start.allow_omitted_members();
        update_mapgen_function_json generator(
            start.get_object( "update_mapgen" ), "godco fungus mission" );
        generator.setup();
        generator.finalize_parameters();
        mapgendata md( here, mapgendata::dummy_settings );
        const std::string diagnostics = capture_debugmsg_during( [&generator, &md]() {
            CHECK( generator.update_map( md ).success() );
        } );
        CHECK( diagnostics.empty() );
        CHECK( here.furn( target ) != furn_str_id( "f_thistle" ) );
        CHECK( here.furn( outside ) == furn_str_id( "f_thistle" ) );
        break;
    }
    REQUIRE( found );
}

