#include <optional>
#include <string>

#include "activity_actor_definitions.h"
#include "activity_handlers.h"
#include "avatar.h"
#include "cata_catch.h"
#include "clzones.h"
#include "construction.h"
#include "coordinates.h"
#include "faction.h"
#include "map.h"
#include "map_helpers.h"
#include "memory_fast.h"
#include "player_helpers.h"
#include "point.h"
#include "type_id.h"

TEST_CASE( "blueprints_dig_directly_instead_of_creating_graves", "[blueprint_prerequisite]" )
{
    clear_avatar();
    clear_map();
    avatar &you = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms pos( 60, 61, 0 );
    you.setpos( here, pos + tripoint::north );
    const std::string target = GENERATE( "constr_pit", "constr_concrete" );
    const construction &build = construction_str_id( target ).obj();
    const std::string ground = GENERATE( "t_dirt", "t_sand", "t_grave_new" );
    here.ter_set( pos, ter_id( ground ) );
    auto options = make_shared_fast<blueprint_options>( "", build.group, build.id );
    zone_manager::get_manager().add( "digging blueprint", zone_type_id( "CONSTRUCTION_BLUEPRINT" ),
                                     you.get_faction()->id, false, true,
                                     here.get_abs( pos ), here.get_abs( pos ), options );
    multi_build_construction_activity_actor actor;
    const activity_reason_info first =
        actor.multi_build_construction_activity_actor::multi_activity_can_do( you, pos );
    REQUIRE( first.con_idx.has_value() );
    const std::string expected = ground == "t_grave_new" ? "constr_exhume_new" :
                                 ground == "t_sand" ? "constr_pit_shallow_sand" : "constr_pit_shallow";
    CAPTURE( target, ground );
    CHECK( *first.con_idx == construction_str_id( expected ).id() );

    // After digging the shallow pit, advance to the requested construction;
    // do not fill it or start another prerequisite cycle.
    here.ter_set( pos, ter_id( "t_pit_shallow" ) );
    const activity_reason_info next =
        actor.multi_build_construction_activity_actor::multi_activity_can_do( you, pos );
    REQUIRE( next.con_idx.has_value() );
    CHECK( *next.con_idx == build.id );

    here.ter_set( pos, ter_id( build.post_terrain ) );
    const activity_reason_info done =
        actor.multi_build_construction_activity_actor::multi_activity_can_do( you, pos );
    CHECK( done.reason == do_activity_reason::ALREADY_DONE );
    CHECK_FALSE( done.can_do );
    clear_zones();
}
