#include <optional>
#include <sstream>

#include "calendar.h"
#include "cata_catch.h"
#include "flexbuffer_json.h"
#include "item.h"
#include "json.h"
#include "json_loader.h"
#include "map.h"
#include "map_helpers.h"
#include "player_helpers.h"
#include "type_id.h"
#include "veh_appliance.h"
#include "vehicle.h"
#include "vpart_position.h"
#include "vpart_range.h"

TEST_CASE( "appliance_power_failure_recovers_after_save_load", "[vehicle][power][save]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    const tripoint_bub_ms battery_pos( 60, 60, 0 );
    const tripoint_bub_ms lamp_pos( 62, 60, 0 );
    std::optional<item> battery( itype_id( "test_storage_battery" ) );
    std::optional<item> lamp( itype_id( "test_standing_lamp" ) );
    place_appliance( here, battery_pos, vpart_id( "ap_test_storage_battery" ),
                     get_player_character(), battery );
    place_appliance( here, lamp_pos, vpart_id( "ap_test_standing_lamp" ),
                     get_player_character(), lamp );
    item cord( itype_id( "test_power_cord" ) );
    REQUIRE( cord.link_to( here.veh_at( battery_pos ), here.veh_at( lamp_pos ),
                           link_state::vehicle_port ).success() );
    vehicle &consumer = here.veh_at( lamp_pos )->vehicle();
    vehicle &supply = here.veh_at( battery_pos )->vehicle();
    bool tested_consumer = false;
    for( const vpart_reference &vp : consumer.get_all_parts() ) {
        if( !vp.info().has_flag( "ENABLED_DRAINS_EPOWER" ) ) {
            continue;
        }
        tested_consumer = true;
        const bool deficit = GENERATE( false, true );
        vp.part().enabled = false;
        vp.part().power_disabled = deficit;
        std::ostringstream saved;
        JsonOut out( saved );
        vp.part().serialize( out );
        vehicle_part restored;
        restored.deserialize( json_loader::from_string( saved.str() ).get_object() );
        CHECK( restored.power_disabled == deficit );
        vp.part().power_disabled = restored.power_disabled;
        supply.discharge_battery( here, 100000000 );
        REQUIRE( supply.charge_battery( here, 1000 ) == 0 );
        calendar::turn += 1_turns;
        here.vehmove();
        CHECK( vp.part().enabled == deficit );
        CHECK_FALSE( vp.part().power_disabled );
    }
    REQUIRE( tested_consumer );
}
