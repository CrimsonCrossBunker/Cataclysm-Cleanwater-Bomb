#include "avatar.h"
#include "bodypart.h"
#include "cata_catch.h"
#include "coordinates.h"
#include "creature.h"
#include "map.h"
#include "map_helpers.h"
#include "player_helpers.h"
#include "type_id.h"
#include "units.h"
#include "vehicle.h"
#include "veh_type.h"

static const trait_id trait_SMALL( "SMALL" );
static const vpart_id vpart_controls( "controls" );
static const vproto_id vehicle_prototype_motorcycle( "motorcycle" );

// Requires --mods=magiclysm; exclude it from core-only default test runs.
TEST_CASE( "mojocycle_controls_allow_small_and_leg_disabled_casters", "[.][magiclysm][mojocycle]" )
{
    const bool cooperative = GENERATE( false, true );
    const bool small = GENERATE( false, true );
    CAPTURE( cooperative, small );
    clear_avatar();
    clear_map();
    map &here = get_map();
    avatar &you = get_avatar();
    you.setpos( here, { 60, 60, 0 } );
    if( small ) {
        you.set_mutation( trait_SMALL );
        REQUIRE( you.get_size() == creature_size::small );
    } else {
        you.set_part_hp_cur( body_part_leg_l.id(), 0 );
        you.set_part_hp_cur( body_part_leg_r.id(), 0 );
        REQUIRE( you.get_working_leg_count() == 0 );
    }
    const vproto_id prototype( cooperative ? "magic_comcycle" : "magic_motorcycle" );
    REQUIRE( prototype.is_valid() );
    vehicle *veh = here.add_vehicle( prototype, you.pos_bub(), 0_degrees, 100,
                                     veh_spawn_status::UNDAMAGED );
    REQUIRE( veh != nullptr );
    REQUIRE( !veh->engines.empty() );
    CHECK( veh->has_part( you.pos_abs(), "CONTROLS" ) );
    CHECK_FALSE( veh->has_part( you.pos_abs(), "NEED_LEG" ) );
    CHECK_FALSE( veh->has_part( you.pos_abs(), "INOPERABLE_SMALL" ) );
    vehicle_part &engine = veh->part( veh->engines.front() );
    engine.enabled = true;
    REQUIRE( veh->auto_select_fuel( here, engine ) );
    CHECK( veh->start_engine( here, engine ) );

    // The change must not remove restrictions from ordinary vehicle controls.
    CHECK( vpart_controls->has_flag( "NEED_LEG" ) );
    CHECK( vpart_controls->has_flag( "INOPERABLE_SMALL" ) );
    here.destroy_vehicle( veh );

    vehicle *ordinary = here.add_vehicle( vehicle_prototype_motorcycle, you.pos_bub(), 0_degrees,
                                          100, veh_spawn_status::UNDAMAGED );
    REQUIRE( ordinary != nullptr );
    REQUIRE( !ordinary->engines.empty() );
    REQUIRE( ordinary->has_part( you.pos_abs(), "CONTROLS" ) );
    vehicle_part &ordinary_engine = ordinary->part( ordinary->engines.front() );
    ordinary_engine.enabled = true;
    REQUIRE( ordinary->auto_select_fuel( here, ordinary_engine ) );
    CHECK_FALSE( ordinary->start_engine( here, ordinary_engine ) );
    here.destroy_vehicle( ordinary );
}
