#include <cstddef>
#include <sstream>
#include <string>

#include "cata_catch.h"
#include "coordinates.h"
#include "enums.h"
#include "flexbuffer_json.h"
#include "item.h"
#include "json.h"
#include "json_loader.h"
#include "map.h"
#include "map_helpers.h"
#include "player_helpers.h"
#include "point.h"
#include "type_id.h"
#include "units.h"
#include "vehicle.h"

static const itype_id itype_charcoal( "charcoal" );
static const itype_id itype_coal_lump( "coal_lump" );
static const itype_id itype_fuel_bunker( "fuel_bunker" );
static const vpart_id vpart_engine_steam_makeshift( "engine_steam_makeshift" );
static const vpart_id vpart_engine_steam_medium( "engine_steam_medium" );
static const vpart_id vpart_engine_steam_small( "engine_steam_small" );
static const vpart_id vpart_frame( "frame" );
static const vpart_id vpart_fuel_bunker( "fuel_bunker" );
static const vproto_id vehicle_prototype_none( "none" );

TEST_CASE( "solid_fuel_bunker_uses_actual_fuel_volume", "[vehicle][fuel]" )
{
    const itype_id fuel = GENERATE( itype_charcoal, itype_coal_lump );
    CAPTURE( fuel );
    vehicle_part bunker( vpart_fuel_bunker, item( itype_fuel_bunker ) );
    const int charges = bunker.ammo_set( fuel );
    REQUIRE( charges > 0 );
    CHECK( bunker.get_base().legacy_front().volume() == 50_liter );
    if( fuel == itype_charcoal ) {
        CHECK( charges == 10000 );
        CHECK( bunker.get_base().legacy_front().weight() == 10400_gram );
    }
}

TEST_CASE( "steam_engines_do_not_collect_unserved_fuel_demand", "[vehicle][fuel]" )
{
    clear_avatar();
    clear_map_without_vision();
    clear_vehicles();
    map &here = get_map();
    const vpart_id engine_type = GENERATE( vpart_engine_steam_makeshift,
                                           vpart_engine_steam_small,
                                           vpart_engine_steam_medium );
    CAPTURE( engine_type );
    vehicle *veh = here.add_vehicle( vehicle_prototype_none, tripoint_bub_ms( 60, 60, 0 ),
                                     0_degrees, 0, veh_spawn_status::UNDAMAGED );
    REQUIRE( veh != nullptr );
    REQUIRE( veh->install_part( here, point_rel_ms::zero, vpart_frame ) >= 0 );
    const int engine = veh->install_part( here, point_rel_ms::zero, engine_type );
    REQUIRE( engine >= 0 );
    REQUIRE( veh->install_part( here, point_rel_ms( 1, 0 ), vpart_frame ) >= 0 );
    const int bunker = veh->install_part( here, point_rel_ms( 1, 0 ), vpart_fuel_bunker );
    REQUIRE( bunker >= 0 );
    veh->part( engine ).enabled = true;
    veh->part( engine ).fuel_set( itype_charcoal );
    veh->part( bunker ).ammo_set( itype_charcoal );
    const int full = veh->fuel_left( here, itype_charcoal );
    REQUIRE( veh->start_engine( here, veh->part( engine ) ) );
    CHECK( veh->fuel_left( here, itype_charcoal ) == full );

    SECTION( "unserved demand after an exhausted fuel store" ) {
        veh->part( bunker ).ammo_set( itype_charcoal, 1 );
        for( int turn = 0; turn < 100; ++turn ) {
            veh->consume_fuel( here, 1000, false );
        }
        REQUIRE( veh->fuel_left( here, itype_charcoal ) == 0 );
    }
    SECTION( "an_old_save_with_a_large_fuel_debt" ) {
        std::ostringstream saved;
        JsonOut out( saved );
        veh->serialize( out );
        std::string text = saved.str();
        const std::size_t begin = text.find( "\"fuel_remainder\"" );
        REQUIRE( begin != std::string::npos );
        const std::size_t end = text.find( '}', begin );
        REQUIRE( end != std::string::npos );
        text.replace( begin, end - begin + 1,
                      R"("fuel_remainder":{"charcoal":"-780000000 J"})" );
        JsonValue parsed = json_loader::from_string( text );
        JsonObject obj = parsed;
        veh->deserialize( obj );
    }

    veh->part( bunker ).ammo_set( itype_charcoal );
    REQUIRE( veh->start_engine( here, veh->part( engine ) ) );
    veh->consume_fuel( here, 1000, false );
    const int consumed = full - veh->fuel_left( here, itype_charcoal );
    CHECK( consumed > 0 );
    // A one-second full-load burn costs fewer than 11 charcoal charges for
    // every steam engine; no historical demand may empty the 10000-charge bin.
    CHECK( consumed <= 11 );
}
