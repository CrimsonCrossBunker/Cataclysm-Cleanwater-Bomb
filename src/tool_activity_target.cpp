#include "tool_activity_target.h"

#include <vector>

#include "action.h"
#include "activity_actor_definitions.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "character_action_guard.h"
#include "flag.h"
#include "game.h"
#include "item.h"
#include "item_location.h"
#include "item_source.h"
#include "item_uid.h"
#include "json.h"
#include "itype.h"
#include "line.h"
#include "map.h"
#include "map_selector.h"
#include "mapdata.h"
#include "messages.h"
#include "output.h"
#include "player_activity.h"
#include "rng.h"
#include "translations.h"
#include "vehicle.h"
#include "vehicle_selector.h"
#include "vpart_position.h"

adjacent_tool_action adjacent_tool_method( const std::string &method )
{
    if( method == "MAKEMOUND" ) {
        return adjacent_tool_action::till;
    }
    if( method == "CHOP_TREE" ) {
        return adjacent_tool_action::tree;
    }
    if( method == "CHOP_LOGS" ) {
        return adjacent_tool_action::logs;
    }
    if( method == "CROWBAR" || method == "CROWBAR_WEAK" ) {
        return adjacent_tool_action::pry;
    }
    if( method == "PICKAXE" ) {
        return adjacent_tool_action::mine;
    }
    if( method == "HACKSAW" ) {
        return adjacent_tool_action::saw;
    }
    if( method == "OXYTORCH" ) {
        return adjacent_tool_action::torch;
    }
    if( method == "BOLTCUTTERS" ) {
        return adjacent_tool_action::boltcut;
    }
    if( method == "JACKHAMMER" ) {
        return adjacent_tool_action::drill;
    }
    return method == "PICK_LOCK" ? adjacent_tool_action::lockpick : adjacent_tool_action::none;
}

std::string automatic_mining_method( const Character &who, map &here,
                                     const tripoint_abs_ms &target )
{
    const item_location tool = who.get_wielded_item();
    if( !tool || !tool->has_flag( flag_DIG_TOOL ) ||
        who.has_effect( efftype_id( "stunned" ) ) ||
        who.has_effect( efftype_id( "psi_stunned" ) ) ||
        who.has_effect( efftype_id( "incorporeal" ) ) ||
        who.has_flag( json_character_flag( "CANNOT_MOVE" ) ) ) {
        return {};
    }
    const std::string method = tool->type->can_use( "PICKAXE" ) ? "PICKAXE" :
                               tool->type->can_use( "JACKHAMMER" ) ? "JACKHAMMER" : "";
    return valid_adjacent_tool_target( adjacent_tool_method( method ), who, here, *tool, target ) ?
           method : std::string();
}

bool valid_adjacent_tool_target( adjacent_tool_action action, const Character &who,
                                 map &here, const item &tool, const tripoint_abs_ms &target )
{
    if( !here.inbounds( target ) || who.pos_abs().z() != target.z() ||
        rl_dist( who.pos_abs(), target ) > 1 ||
        ( action != adjacent_tool_action::logs && who.pos_abs() == target ) || who.is_mounted() ) {
        return false;
    }
    const tripoint_bub_ms pos = here.get_bub( target );
    switch( action ) {
        case adjacent_tool_action::till:
            return tool.get_quality( quality_id( "DIG" ) ) >= 1 &&
                   here.has_flag( ter_furn_flag::TFLAG_PLOWABLE, pos ) &&
                   !here.has_flag( ter_furn_flag::TFLAG_PLANT, pos );
        case adjacent_tool_action::tree:
            return tool.get_quality( quality_id( "AXE" ) ) >= 1 &&
                   here.has_flag( ter_furn_flag::TFLAG_TREE, pos );
        case adjacent_tool_action::logs:
            return tool.get_quality( quality_id( "AXE" ) ) >= 1 &&
                   ( here.ter( pos ) == ter_str_id( "t_trunk" ) ||
                     here.ter( pos ) == ter_str_id( "t_stump" ) );
        case adjacent_tool_action::saw:
            return tool.get_quality( quality_id( "SAW_M" ) ) >= 2 &&
                   ( here.has_furn( pos ) ? here.furn( pos )->hacksaw->valid() :
                     here.ter( pos )->hacksaw->valid() );
        case adjacent_tool_action::torch:
            return who.has_quality( quality_id( "GLARE" ), 1 ) &&
                   ( here.has_furn( pos ) ? here.furn( pos )->oxytorch->valid() :
                     here.ter( pos )->oxytorch->valid() );
        case adjacent_tool_action::boltcut:
            return here.has_furn( pos ) ? here.furn( pos )->boltcut->valid() :
                   here.ter( pos )->boltcut->valid();
        case adjacent_tool_action::pry:
            return here.has_furn( pos ) ? here.furn( pos )->prying->valid() :
                   here.ter( pos )->prying->valid();
        case adjacent_tool_action::mine:
        case adjacent_tool_action::drill:
            return !who.is_underwater() && !here.impassable_field_at( pos ) && !here.veh_at( pos ) &&
                   here.has_flag( ter_furn_flag::TFLAG_MINEABLE, pos ) &&
                   ( action != adjacent_tool_action::drill ||
                     !here.has_flag_ter_or_furn( ter_furn_flag::TFLAG_WALL, pos ) ||
                     tool.has_flag( flag_id( "MULTI_DRILL" ) ) );
        case adjacent_tool_action::lockpick: {
            if( here.has_furn( pos ) ) {
                return !here.furn( pos )->lockpick_result.is_null();
            }
            const auto part = here.veh_at( pos );
            return ( part && part->vehicle().next_part_to_unlock( part->part_index() ) >= 0 ) ||
                   !here.ter( pos )->lockpick_result.is_null();
        }
        case adjacent_tool_action::none:
            return false;
    }
    return false;
}

std::optional<tripoint_abs_ms> query_adjacent_tool_target( adjacent_tool_action action,
        Character &who, map &here, const item &tool )
{
    const std::string prompt = action == adjacent_tool_action::till ? _( "Till soil where?" ) :
                               action == adjacent_tool_action::tree ? _( "Chop down which tree?" ) :
                               action == adjacent_tool_action::logs ? _( "Chop which tree trunk?" ) :
                               action == adjacent_tool_action::pry ? _( "Pry where?" ) :
                               action == adjacent_tool_action::lockpick ? _( "Use your lockpick where?" ) :
                               ( action == adjacent_tool_action::saw || action == adjacent_tool_action::torch ||
                                 action == adjacent_tool_action::boltcut ) ? _( "Cut up metal where?" ) :
                               action == adjacent_tool_action::drill ? _( "Drill where?" ) : _( "Mine where?" );
    const auto valid = [&]( const tripoint_bub_ms & pos ) {
        return valid_adjacent_tool_target( action, who, here, tool, here.get_abs( pos ) );
    };
    const auto target = choose_adjacent_highlight( here, prompt,
                        _( "There is no suitable target nearby." ), valid, false );
    return target && valid( *target ) ? std::make_optional( here.get_abs( *target ) ) : std::nullopt;
}

item_location locate_cutting_tool( Character &who, item &tool )
{
    // Native use callbacks receive an item pointer. Recover its actual ancestry
    // before retaining it: an in-place torch can be on the ground or in cargo.
    const auto locate = [&]( auto & owner ) -> item_location {
        if( !owner.has_item( tool ) )
        {
            return item_location::nowhere;
        }
        std::vector<item *> path{ &tool };
        while( item *parent = owner.find_parent( *path.back() ) )
        {
            path.push_back( parent );
        }
        item_location result( owner, path.back() );
        for( auto part = path.rbegin() + 1; part != path.rend(); ++part )
        {
            result = item_location( result, *part );
        }
        return result;
    };
    if( item_location carried = locate( who ) ) {
        return carried;
    }
    if( tool.has_flag( flag_ALLOWS_REMOTE_USE ) ) {
        map &here = get_map();
        for( map_cursor &cursor : map_selector( who.pos_bub( here ), 1 ) ) {
            if( item_location found = locate( cursor ) ) {
                return found;
            }
        }
        for( vehicle_cursor &cursor : vehicle_selector( here, who.pos_bub( here ), 1 ) ) {
            if( item_location found = locate( cursor ) ) {
                return found;
            }
        }
    }
    return item_location::nowhere;
}

bool query_oxytorch_work( Character &who, const item &tool, const tripoint_abs_ms &target )
{
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    map &here = get_map();
    if( !valid_adjacent_tool_target( adjacent_tool_action::torch, who, here, tool, target ) ) {
        return false;
    }
    const tripoint_bub_ms position = here.get_bub( target );
    const time_duration duration = here.has_furn( position ) ?
                                   here.furn( position )->oxytorch->duration() : here.ter( position )->oxytorch->duration();
    auto owned = tool_activity_target::capture( here, target );
    const item_location source = locate_cutting_tool( who, const_cast<item &>( tool ) );
    if( !source ) {
        return false;
    }
    owned.tool_source = capture_item_source( who, source );
    player_activity proposed( oxytorch_activity_actor( position, source, owned ) );
    proposed.set_execution( activity_execution::authoritative );
    const bool resume = !who.backlog.empty() && who.backlog.front().can_resume_with( proposed, who );
    const int moves = resume ? who.backlog.front().moves_left : to_moves<int>( duration );
    return tool.ammo_sufficient( &who, moves / 100 ) || who.query_yn(
               _( "Your %1$s doesn't have enough charges to complete the job.  Continue anyway?" ),
               tool.tname() );
}

bool start_metal_cutting_work( Character &who, const item_location &tool,
                               adjacent_tool_action action, const tripoint_abs_ms &target )
{
    map &here = get_map();
    if( ( action != adjacent_tool_action::torch && action != adjacent_tool_action::boltcut ) ||
        who.is_dead_state() || who.activity || !tool || tool->is_broken() ||
        who.has_effect( efftype_id( "incorporeal" ) ) ||
        resolve_item_source( who, here, capture_item_source( who, tool ) ) != tool ||
        !valid_adjacent_tool_target( action, who, here, *tool, target ) ||
        !tool->type->get_use( action == adjacent_tool_action::torch ? "OXYTORCH" : "BOLTCUTTERS" ) ||
        !tool->ammo_sufficient( &who, action == adjacent_tool_action::torch ? "OXYTORCH" :
                                "BOLTCUTTERS" ) ) {
        return false;
    }
    if( action == adjacent_tool_action::torch && !tool->activation_success() ) {
        who.add_msg_if_player( m_bad, _( "You try to light your %s, but nothing happens." ),
                               tool->tname() );
        return false;
    }
    auto owned = tool_activity_target::capture( here, target );
    owned.tool_source = capture_item_source( who, tool );
    const tripoint_bub_ms position = here.get_bub( target );
    player_activity proposed = action == adjacent_tool_action::torch ?
                               player_activity( oxytorch_activity_actor( position, tool, owned ) ) :
                               player_activity( boltcutting_activity_actor( position, tool, owned ) );
    proposed.set_execution( activity_execution::authoritative );
    const activity_id id = proposed.id();
    const character_action_guard lifetime( who );
    who.assign_activity( proposed );
    return lifetime && who.activity.id() == id;
}

bool continue_metal_cutting_work( player_activity &activity, Character &who,
                                  const item_location &tool, tripoint_bub_ms &position,
                                  const std::optional<tool_activity_target> &target,
                                  adjacent_tool_action action )
{
    if( target ) {
        activity.set_execution( activity_execution::authoritative );
    }
    if( !continue_owned_tool_activity( activity, who, tool, target ) ) {
        return false;
    }
    if( !tool || ( target && ( who.is_dead_state() || who.has_effect( efftype_id( "incorporeal" ) ) ||
                               !tool->type->get_use( action == adjacent_tool_action::torch ? "OXYTORCH" : "BOLTCUTTERS" ) ||
                               !valid_adjacent_tool_target( action, who, get_map(), *tool, target->position ) ) ) ) {
        activity.set_to_null();
        return false;
    }
    if( target ) {
        position = get_map().get_bub( target->position );
    }
    return true;
}

tool_activity_target tool_activity_target::capture( map &here, const tripoint_abs_ms &position )
{
    tool_activity_target result;
    result.position = position;
    const tripoint_bub_ms pos = here.get_bub( position );
    result.terrain = here.ter( pos ).id();
    result.furniture = here.furn( pos ).id();
    if( const auto part = here.veh_at( pos ) ) {
        part->vehicle().ensure_uid();
        result.vehicle = part->vehicle().uid().get_value();
        const int locked = part->vehicle().next_part_to_unlock( part->part_index() );
        if( locked >= 0 ) {
            result.locked_part = part->vehicle().part( locked ).get_base().uid().get_value();
        }
    }
    return result;
}

bool tool_activity_target::matches( map &here ) const
{
    if( !here.inbounds( position ) ) {
        return false;
    }
    const auto current = capture( here, position );
    return current.terrain == terrain && current.furniture == furniture &&
           current.vehicle == vehicle && current.locked_part == locked_part;
}

void tool_activity_target::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "position", position );
    out.member( "terrain", terrain );
    out.member( "furniture", furniture );
    out.member( "vehicle", vehicle );
    out.member( "locked_part", locked_part );
    out.member( "tool_source", tool_source );
    out.end_object();
}

void tool_activity_target::deserialize( const JsonObject &data )
{
    data.read( "position", position, true );
    data.read( "terrain", terrain, true );
    data.read( "furniture", furniture, true );
    data.read( "vehicle", vehicle, true );
    data.read( "locked_part", locked_part, true );
    data.read( "tool_source", tool_source );
}

bool continue_owned_tool_activity( player_activity &activity, Character &who,
                                   const std::optional<item_location> &tool,
                                   const std::optional<tool_activity_target> &target )
{
    if( activity.execution() != activity_execution::authoritative ) {
        return true;
    }
    map &here = get_map();
    if( !target || who.pos_abs().z() != target->position.z() ||
        rl_dist( who.pos_abs(), target->position ) != 1 || !target->matches( here ) ||
        // A restored item_location resolves lazily and reports a debug error
        // when its target has disappeared. Check the saved stable source first
        // so losing a tool between load and continuation cancels normally.
        ( tool && target->tool_source && !resolve_item_source( who, here, *target->tool_source ) ) ||
        ( tool && ( !*tool || ( *tool )->is_broken() ||
                    resolve_item_source( who, here, capture_item_source( who, *tool ) ) != *tool ) ) ) {
        activity.set_to_null();
        return false;
    }
    return true;
}

void start_owned_tool_activity( player_activity &activity, Character &who,
                                const std::optional<item_location> &tool,
                                const tripoint_abs_ms &position,
                                std::optional<tool_activity_target> &target )
{
    if( activity.execution() == activity_execution::authoritative ) {
        map &here = get_map();
        if( here.inbounds( position ) ) {
            target = tool_activity_target::capture( here, position );
            if( tool && *tool ) {
                target->tool_source = capture_item_source( who, *tool );
            }
        }
        continue_owned_tool_activity( activity, who, tool, target );
    }
}

owned_tool_activity_source owned_tool_activity_source::capture( Character &who,
        const item_location &tool, const tripoint_abs_ms &position )
{
    owned_tool_activity_source result;
    result.operator_id = who.getID();
    result.origin = who.pos_abs();
    result.target = tool_activity_target::capture( get_map(), position );
    if( tool ) {
        result.target.tool_source = capture_item_source( who, tool );
    }
    return result;
}

bool owned_tool_activity_source::matches( Character &who ) const
{
    return operator_id == who.getID() && origin == who.pos_abs() && !who.is_dead_state() &&
           !who.is_mounted() && !who.has_effect( efftype_id( "incorporeal" ) ) && target.matches( get_map() );
}

bool owned_tool_activity_source::valid( Character &who, const item_location &tool,
                                        adjacent_tool_action action ) const
{
    map &here = get_map();
    if( !matches( who ) || !target.tool_source ) {
        return false;
    }
    // Resolve the stable source first: an erased saved item_location must not
    // trigger a missing-item diagnostic while cancelling an obsolete activity.
    const item_location live = resolve_item_source( who, here, *target.tool_source );
    return live && tool && live == tool && !tool->is_broken() &&
           valid_adjacent_tool_target( action,
                                       who, here, *tool, target.position );
}

void owned_tool_activity_source::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "operator", operator_id );
    out.member( "origin", origin );
    out.member( "target", target );
    out.end_object();
}

void owned_tool_activity_source::deserialize( const JsonObject &data )
{
    data.read( "operator", operator_id, true );
    data.read( "origin", origin, true );
    data.read( "target", target, true );
}


bool start_tilling_work( Character &who, const item_location &tool,
                         const tripoint_abs_ms &position, bool automatic )
{
    map &here = get_map();
    if( ( who.activity && !automatic ) || !here.inbounds( position ) ) {
        return false;
    }
    const auto source = owned_tool_activity_source::capture( who, tool, position );
    if( !source.matches( who ) || position.z() != who.pos_abs().z() ||
        rl_dist( who.pos_abs(), position ) > 1 ) {
        return false;
    }
    const tripoint_bub_ms tile = here.get_bub( position );
    if( automatic ) {
        // Zone work can use a tool or a native intrinsic DIG capability. Keep
        // the old capability rule and its lack of per-invocation tool billing.
        if( tool || !who.has_unreserved_quality( quality_id( "DIG" ), 1 ) ||
            !here.has_flag( ter_furn_flag::TFLAG_PLOWABLE, tile ) || here.has_furn( tile ) ) {
            return false;
        }
    } else if( !source.valid( who, tool, adjacent_tool_action::till ) ||
               !tool->type->can_use( "MAKEMOUND" ) || !tool->ammo_sufficient( &who, "MAKEMOUND" ) ) {
        return false;
    }
    player_activity proposed( churn_activity_actor( 18000, tool ) );
    proposed.placement = position;
    proposed.set_execution( activity_execution::authoritative );
    const character_action_guard lifetime( who );
    const auto context = here.get_context_reference();
    who.add_msg_if_player( _( "You start churning up the earth here." ) );
    who.assign_activity( proposed );
    return lifetime && context && who.activity.id() == activity_id( "ACT_CHURN" ) &&
           who.activity.placement == position;
}
