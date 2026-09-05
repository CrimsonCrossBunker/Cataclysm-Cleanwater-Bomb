#include <sstream>

#include "calendar.h"
#include "cata_catch.h"
#include "flag.h"
#include "flexbuffer_json.h"
#include "iexamine.h"
#include "item.h"
#include "itype.h"
#include "json.h"
#include "json_loader.h"
#include "map.h"
#include "map_helpers.h"
#include "mapdata.h"
#include "type_id.h"

TEST_CASE( "smoking_rack_finishes_after_absence_and_item_reload", "[item][smoking][save]" )
{
    clear_map_without_vision();
    map &here = get_map();
    const tripoint_bub_ms pos( 60, 60, 0 );
    const bool metal = GENERATE( false, true );
    here.furn_set( pos, furn_str_id( metal ? "f_metal_smoking_rack_active" :
                                     "f_smoking_rack_active" ) );
    calendar::turn = calendar::turn_zero + 12_hours;
    item meat( itype_id( "meat" ), calendar::turn );
    meat.set_flag( flag_PROCESSING );
    const itype_id result = meat.get_comestible()->smoking_result;
    REQUIRE_FALSE( result.is_null() );
    here.add_item( pos, meat );
    item embers( itype_id( "fake_smoke_plume" ), calendar::turn );
    embers.item_counter = to_turns<int>( 6_hours );
    embers.activate();
    std::ostringstream saved;
    JsonOut out( saved );
    embers.serialize( out );
    item loaded;
    loaded.deserialize( json_loader::from_string( saved.str() ).get_object() );
    here.add_item( pos, loaded );
    calendar::turn += 3_days;
    here.process_items();
    CHECK( here.furn( pos ) == furn_str_id( metal ? "f_metal_smoking_rack" : "f_smoking_rack" ) );
    REQUIRE( here.i_at( pos ).size() == 1 );
    CHECK( here.i_at( pos ).only_item().typeId() == result );
}

TEST_CASE( "smoking_rack_without_embers_can_be_relit", "[item][smoking][save]" )
{
    clear_map_without_vision();
    map &here = get_map();
    const tripoint_bub_ms pos( 60, 60, 0 );
    const bool metal = GENERATE( false, true );
    const furn_str_id active( metal ? "f_metal_smoking_rack_active" : "f_smoking_rack_active" );
    here.furn_set( pos, active );
    item meat( itype_id( "meat" ), calendar::turn );
    meat.set_flag( flag_PROCESSING );
    here.add_item( pos, meat );
    // Missing, inactive and live embers are distinct saved states.
    const int timer_state = GENERATE( -1, 0, 1 );
    const bool has_timer = timer_state == 1;
    if( timer_state >= 0 ) {
        item embers( itype_id( "fake_smoke_plume" ), calendar::turn );
        if( has_timer ) {
            embers.activate();
        }
        embers.item_counter = to_turns<int>( 6_hours );
        here.add_item( pos, embers );
    }
    iexamine::smoker_reconcile( here, pos );
    CHECK( ( here.furn( pos ) == active ) == has_timer );
    CHECK( here.i_at( pos ).begin()->typeId() == itype_id( "meat" ) );
    CHECK( here.i_at( pos ).begin()->has_flag( flag_PROCESSING ) == has_timer );
    CHECK( here.i_at( pos ).size() == ( has_timer ? 2 : 1 ) );
}
