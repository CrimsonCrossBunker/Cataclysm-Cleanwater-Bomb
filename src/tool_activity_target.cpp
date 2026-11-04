#include "tool_activity_target.h"

#include "action.h"
#include "character.h"
#include "flag.h"
#include "item.h"
#include "item_location.h"
#include "item_source.h"
#include "item_uid.h"
#include "json.h"
#include "line.h"
#include "map.h"
#include "mapdata.h"
#include "output.h"
#include "player_activity.h"
#include "translations.h"
#include "vehicle.h"
#include "vpart_position.h"

adjacent_tool_action adjacent_tool_method( const std::string &method )
{
    if( method == "CROWBAR" || method == "CROWBAR_WEAK" ) {
        return adjacent_tool_action::pry;
    }
    if( method == "PICKAXE" ) {
        return adjacent_tool_action::mine;
    }
    if( method == "JACKHAMMER" ) {
        return adjacent_tool_action::drill;
    }
    return method == "PICK_LOCK" ? adjacent_tool_action::lockpick : adjacent_tool_action::none;
}

bool valid_adjacent_tool_target( adjacent_tool_action action, const Character &who,
                                 map &here, const item &tool, const tripoint_abs_ms &target )
{
    if( !here.inbounds( target ) || who.pos_abs().z() != target.z() ||
        rl_dist( who.pos_abs(), target ) != 1 || who.is_mounted() ) {
        return false;
    }
    const tripoint_bub_ms pos = here.get_bub( target );
    switch( action ) {
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
    const std::string prompt = action == adjacent_tool_action::pry ? _( "Pry where?" ) :
                               action == adjacent_tool_action::lockpick ? _( "Use your lockpick where?" ) :
                               action == adjacent_tool_action::drill ? _( "Drill where?" ) : _( "Mine where?" );
    const auto valid = [&]( const tripoint_bub_ms & pos ) {
        return valid_adjacent_tool_target( action, who, here, tool, here.get_abs( pos ) );
    };
    const auto target = choose_adjacent_highlight( here, prompt,
                        _( "There is no suitable target nearby." ), valid, false );
    return target && valid( *target ) ? std::make_optional( here.get_abs( *target ) ) : std::nullopt;
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
    out.end_object();
}

void tool_activity_target::deserialize( const JsonObject &data )
{
    data.read( "position", position, true );
    data.read( "terrain", terrain, true );
    data.read( "furniture", furniture, true );
    data.read( "vehicle", vehicle, true );
    data.read( "locked_part", locked_part, true );
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
        }
        continue_owned_tool_activity( activity, who, tool, target );
    }
}
