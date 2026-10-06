#include <functional>
#include <map>
#include <memory>
#include <string>
#include <utility>
#include <vector>

#include "cata_catch.h"
#include "coordinates.h"
#include "debug.h"
#include "item.h"
#include "map.h"
#include "mapgen.h"
#include "mapgendata.h"
#include "map_helpers.h"
#include "point.h"
#include "type_id.h"
#include "weighted_list.h"

static const furn_str_id furn_f_chair( "f_chair" );
static const itype_id itype_rock( "rock" );
static const nested_mapgen_id nested_mapgen_bedroom_4x4_adult_2_W( "bedroom_4x4_adult_2_W" );
static const ter_str_id ter_t_floor( "t_floor" );

TEST_CASE( "adult_bedroom_nests_preserve_items_when_setting_terrain", "[mapgen][bedroom]" )
{
    clear_map();
    map &here = get_map();
    const auto found = nested_mapgens.find( nested_mapgen_bedroom_4x4_adult_2_W );
    REQUIRE( found != nested_mapgens.end() );
    REQUIRE( found->second.funcs().size() == 7 );
    int variant = 0;
    for( const auto &entry : found->second.funcs() ) {
        CAPTURE( variant );
        for( int x = 0; x < 4; ++x ) {
            for( int y = 0; y < 4; ++y ) {
                const tripoint_bub_ms p( x, y, 0 );
                here.ter_set( p, ter_t_floor );
                here.furn_set( p, furn_f_chair );
                here.i_clear( p );
                item sentinel( itype_rock );
                sentinel.set_var( "bedroom_sentinel", "preserve" );
                here.add_item_or_charges( p, sentinel );
            }
        }
        mapgendata md( here, mapgendata::dummy_settings );
        const std::string messages = capture_debugmsg_during( [&entry, &md]() {
            entry.first->nest( md, tripoint_rel_ms::zero, "bedroom regression" );
        } );
        CHECK( messages.empty() );
        for( int x = 0; x < 4; ++x ) {
            for( int y = 0; y < 4; ++y ) {
                bool retained = false;
                for( const item &it : here.i_at( tripoint_bub_ms( x, y, 0 ) ) ) {
                    retained = retained || ( it.typeId() == itype_rock &&
                                             it.get_var( "bedroom_sentinel" ) == "preserve" );
                }
                CHECK( retained );
            }
        }
        ++variant;
    }
}
