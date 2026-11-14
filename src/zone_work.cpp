#include "zone_work.h"

#include <memory>

#include "activity_actor_definitions.h"
#include "character.h"
#include "character_action_guard.h"
#include "map.h"
#include "mp_client_conn.h"
#include "player_activity.h"

zone_query_context active_zone_query( const Character &who )
{
    const auto query = [&]( const player_activity & activity ) -> std::optional<zone_query_context> {
        if( const auto *zone = dynamic_cast<const zone_activity_actor *>( activity.actor.get() ) )
        {
            return zone->query_for( who );
        }
        if( const auto *multi = dynamic_cast<const multi_zone_activity_actor *>( activity.actor.get() ) )
        {
            return multi->query_for( who );
        }
        return std::nullopt;
    };
    if( const auto current = query( who.activity ) ) {
        return *current;
    }
    if( !who.backlog.empty() && who.backlog.front().auto_resume ) {
        if( const auto parent = query( who.backlog.front() ) ) {
            return *parent;
        }
    }
    return zone_query_context::for_character( who, who.pos_abs() );
}

bool start_owned_zone_work( Character &who, const std::string &action )
{
    if( cata_mp::is_client_mode() || who.is_dead_state() || who.activity || who.get_moves() <= 0 ) {
        return false;
    }
    if( action == "sort" || action == "sort_static" || action == "sort_personal" ) {
        return start_owned_zone_sort( who, action == "sort_static" ? zone_scope::static_only :
                                      action == "sort_personal" ? zone_scope::personal_only : zone_scope::all );
    }
    std::unique_ptr<activity_actor> actor;
    zone_type_id type;
    if( action == "unload" ) {
        actor = std::make_unique<unload_loot_activity_actor>();
        type = zone_type_id( "UNLOAD_ALL" );
    } else if( action == "construct" ) {
        actor = std::make_unique<multi_build_construction_activity_actor>();
        type = zone_type_id( "CONSTRUCTION_BLUEPRINT" );
    } else if( action == "farm" ) {
        actor = std::make_unique<multi_farm_activity_actor>();
        type = zone_type_id( "FARM_PLOT" );
    } else if( action == "chop_trees" ) {
        actor = std::make_unique<multi_chop_trees_activity_actor>();
        type = zone_type_id( "CHOP_TREES" );
    } else if( action == "chop_planks" ) {
        actor = std::make_unique<multi_chop_planks_activity_actor>();
        type = zone_type_id( "LOOT_WOOD" );
    } else if( action == "vehicle_deconstruct" ) {
        actor = std::make_unique<multi_vehicle_deconstruct_activity_actor>();
        type = zone_type_id( "VEHICLE_DECONSTRUCT" );
    } else if( action == "vehicle_repair" ) {
        actor = std::make_unique<multi_vehicle_repair_activity_actor>();
        type = zone_type_id( "VEHICLE_REPAIR" );
    } else if( action == "butcher" ) {
        actor = std::make_unique<multi_butchery_activity_actor>();
        type = zone_type_id( "LOOT_CORPSE" );
    } else if( action == "mine" ) {
        actor = std::make_unique<multi_mine_activity_actor>();
        type = zone_type_id( "MINING" );
    } else if( action == "disassemble" ) {
        actor = std::make_unique<multi_disassemble_activity_actor>();
        type = zone_type_id( "DISASSEMBLE" );
    } else if( action == "mop" ) {
        actor = std::make_unique<multi_mop_activity_actor>();
        type = zone_type_id( "MOPPING" );
    } else if( action == "study" ) {
        actor = std::make_unique<multi_study_activity_actor>();
        type = zone_type_id( "STUDY_ZONE" );
    } else {
        return false;
    }
    const auto query = zone_query_context::for_character( who, who.pos_abs() );
    zone_manager &manager = zone_manager::get_manager();
    const faction_id faction = who.get_faction_id();
    if( !manager.has_near( type, who.pos_abs(), MAX_VIEW_DISTANCE, faction, &query ) &&
        !( action == "unload" && manager.has_near( zone_type_id( "STRIP_CORPSES" ), who.pos_abs(),
                MAX_VIEW_DISTANCE, faction, &query ) ) ) {
        return false;
    }
    const character_action_guard lifetime( who );
    player_activity activity( *actor );
    activity.auto_resume = activity.is_multi_type();
    activity.set_execution( activity_execution::authoritative );
    who.assign_activity( activity );
    return lifetime && who.activity && who.activity.execution() == activity_execution::authoritative;
}
