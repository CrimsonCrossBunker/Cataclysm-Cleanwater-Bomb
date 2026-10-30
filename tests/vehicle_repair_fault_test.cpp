#include <enums.h>
#include <string>
#include <utility>

#include "avatar.h"
#include "cata_catch.h"
#include "coordinates.h"
#include "item.h"
#include "map.h"
#include "map_helpers.h"
#include "player_helpers.h"
#include "point.h"
#include "skill.h"
#include "type_id.h"
#include "units.h"
#include "veh_utils.h"
#include "vehicle.h"

static const fault_id fault_engine_immobiliser( "fault_engine_immobiliser" );
static const fault_id fault_steel_pipe_bent( "fault_steel_pipe_bent" );
static const fault_id fault_steel_pipe_bent_heavy( "fault_steel_pipe_bent_heavy" );
static const skill_id skill_mechanics( "mechanics" );
static const trait_id trait_DEBUG_HS( "DEBUG_HS" );
static const vpart_id vpart_frame_handle( "frame_handle" );
static const vproto_id vehicle_prototype_none( "none" );

TEST_CASE( "vehicle_handle_repair_removes_damage_faults_once", "[vehicle][repair][fault]" )
{
    clear_avatar();
    clear_map_without_vision();
    avatar &you = get_avatar();
    map &here = get_map();
    you.setpos( here, tripoint_bub_ms( 60, 60, 0 ) );
    // Exercise the real repair completion without interactive tool selection.
    you.set_mutation( trait_DEBUG_HS );
    vehicle *veh = here.add_vehicle( vehicle_prototype_none, you.pos_bub(),
                                     0_degrees, 0, veh_spawn_status::UNDAMAGED );
    REQUIRE( veh != nullptr );
    const int index = veh->install_part( here, point_rel_ms::zero, vpart_frame_handle );
    REQUIRE( index >= 0 );
    vehicle_part &part = veh->part( index );
    SECTION( "broken_parts_can_still_be_replaced" ) {
        veh->set_hp( part, 0, false );
        REQUIRE( part.is_broken() );
        REQUIRE( veh_utils::repair_part( here, *veh, part, you ) );
        REQUIRE( veh->part_count_real() == 1 );
        CHECK_FALSE( veh->part( 0 ).is_broken() );
        CHECK( veh->part( 0 ).get_base().damage() == 0 );
        return;
    }
    SECTION( "damage_faults_do_not_leave_a_repair_loop" ) {
        const int wear = GENERATE( 0, 100 );
        const fault_id damage_fault = GENERATE( fault_steel_pipe_bent, fault_steel_pipe_bent_heavy );
        item base = part.get_base();
        base.set_degradation( wear );
        base.force_set_damage( 1000 );
        REQUIRE( base.set_fault( damage_fault, true, nullptr, true ) );
        // A dedicated fault must survive a structural repair, even on an unusual part.
        REQUIRE( base.set_fault( fault_engine_immobiliser, true, nullptr, true ) );
        part.set_base( std::move( base ) );
        REQUIRE( part.is_repairable() );

        REQUIRE( veh_utils::repair_part( here, *veh, part, you ) );

        CHECK_FALSE( part.get_base().has_fault_of_type( "mechanical_damage" ) );
        CHECK( part.get_base().has_fault( fault_engine_immobiliser ) );
        CHECK( part.get_base().degradation() == wear );
        CHECK( part.get_base().damage() == wear );
        CHECK_FALSE( part.is_repairable() );
        const int experience = you.get_skill_level_object( skill_mechanics ).exercise( true );
        CHECK_FALSE( veh_utils::repair_part( here, *veh, part, you ) );
        CHECK( you.get_skill_level_object( skill_mechanics ).exercise( true ) == experience );
    }
}
