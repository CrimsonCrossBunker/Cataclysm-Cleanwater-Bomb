#include "vehicle_toolstation.h"

#include <algorithm>
#include <set>
#include <string>
#include <utility>
#include <vector>

#include "character.h"
#include "game.h"
#include "game_inventory.h"
#include "item.h"
#include "item_location.h"
#include "item_uid.h"
#include "json.h"
#include "map.h"
#include "mp_inventory_activity.h"
#include "ret_val.h"
#include "string_formatter.h"
#include "translations.h"
#include "uilist.h"
#include "veh_type.h"
#include "veh_utils.h"
#include "vehicle.h"
#include "vehicle_control.h"
#include "vpart_range.h"

namespace
{
bool toolstation( const vehicle_part &part )
{
    return !part.removed && part.is_available() && part.info().has_flag( "VEH_TOOLS" ) &&
           part.info().toolkit_info;
}

int station_index( const vehicle &target, const tripoint_abs_ms &position, int64_t identity )
{
    for( const vpart_reference &part : target.get_all_parts() ) {
        if( part.pos_abs() == position && part.part().get_base().uid().get_value() == identity &&
            toolstation( part.part() ) ) {
            return part.part_index();
        }
    }
    return -1;
}

std::set<itype_id> available_types( const vehicle &target, const vehicle_part &station )
{
    auto types = station.info().toolkit_info->allowed_types;
    for( const auto &builtin : station.info().get_pseudo_tools() ) {
        types.erase( builtin.first );
    }
    for( const item &tool : target.get_tools( station ) ) {
        types.erase( tool.typeId() );
    }
    return types;
}

std::string station_label( const vehicle_part &station, bool attaching )
{
    return string_format( attaching ? _( "Attach a tool to %s" ) : _( "Detach a tool from %s" ),
                          station.name( false ) );
}
} // namespace

void vehicle_tool_selection::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "part", part_id );
    out.member( "source", source );
    out.member( "tool", tool_id );
    out.end_object();
}

void vehicle_tool_selection::deserialize( const JsonObject &data )
{
    data.read( "part", part_id, true );
    data.read( "source", source, true );
    data.read( "tool", tool_id, true );
}

bool has_vehicle_toolstation( const vehicle &target, const tripoint_abs_ms &position )
{
    for( const vpart_reference &part : target.get_all_parts() ) {
        if( part.pos_abs() == position && toolstation( part.part() ) ) {
            return true;
        }
    }
    return false;
}

bool valid_vehicle_tool_selection( Character &who, map &here, const vehicle &target,
                                   const tripoint_abs_ms &position, const vehicle_tool_selection &choice )
{
    const int index = station_index( target, position, choice.part_id );
    if( index < 0 || ( choice.source.has_value() ? choice.tool_id != 0 : choice.tool_id <= 0 ) ) {
        return false;
    }
    const vehicle_part &station = target.part( index );
    if( choice.source ) {
        const item_location tool = resolve_item_source( who, here, *choice.source );
        return tool && tool->is_owned_by( who, true ) && who.can_drop( *tool ).success() &&
               tool->empty() && tool->toolmods().empty() &&
               available_types( target, station ).count( tool->typeId() ) > 0;
    }
    return std::any_of( target.get_tools( station ).begin(),
    target.get_tools( station ).end(), [&]( const item & tool ) {
        return tool.uid().get_value() == choice.tool_id;
    } );
}

bool execute_vehicle_tool_selection( Character &who, map &here, vehicle &target,
                                     const tripoint_abs_ms &position, const vehicle_tool_selection &choice )
{
    if( !valid_vehicle_tool_selection( who, here, target, position, choice ) ) {
        return false;
    }
    vehicle_part &station = target.part( station_index( target, position, choice.part_id ) );
    if( choice.source ) {
        item_location tool = resolve_item_source( who, here, *choice.source );
        who.add_msg_if_player( _( "You attach %s to %s." ), tool->tname(), station.name( false ) );
        // Keep the native whole-item transfer, including tool state. Complete
        // destination/cache writes before removal can invoke character hooks.
        target.get_tools( station ).emplace_back( *tool );
        target.invalidate_mass();
        who.invalidate_crafting_inventory();
        tool.remove_item();
    } else {
        auto selected = std::find_if( target.get_tools( station ).begin(),
        target.get_tools( station ).end(), [&]( const item & tool ) {
            return tool.uid().get_value() == choice.tool_id;
        } );
        item detached = std::move( *selected );
        target.get_tools( station ).erase( selected );
        target.invalidate_mass();
        who.invalidate_crafting_inventory();
        who.add_msg_if_player( _( "You detach %s from %s." ), detached.tname(), station.name( false ) );
        // Remove the installed identity before native placement can call back
        // into gameplay. A repeated or reentrant request cannot detach it twice.
        who.add_or_drop_with_msg( detached );
    }
    return true;
}

std::optional<vehicle_control_selection> query_vehicle_toolstation( Character &who, map &here,
        vehicle &target, const tripoint_abs_ms &position, int64_t part_id,
        std::optional<bool> attaching )
{
    auto request = query_vehicle_control( who, here, target, position, "toolstation" );
    if( !request ) {
        return std::nullopt;
    }
    std::vector<std::pair<int, bool>> options;
    uilist menu;
    menu.title = _( "Attached vehicle tools" );
    for( const vpart_reference &part : target.get_all_parts() ) {
        if( part.pos_abs() != position || !toolstation( part.part() ) ||
            ( part_id && part.part().get_base().uid().get_value() != part_id ) ) {
            continue;
        }
        for( const bool attach : {
                 true, false
             } ) {
            if( attaching && *attaching != attach ) {
                continue;
            }
            const bool enabled = attach ? !available_types( target, part.part() ).empty() :
                                 !target.get_tools( part.part() ).empty();
            menu.addentry( options.size(), enabled, MENU_AUTOASSIGN, station_label( part.part(), attach ) );
            options.emplace_back( part.part_index(), attach );
        }
    }
    if( options.empty() ) {
        return std::nullopt;
    }
    int picked = 0;
    if( options.size() > 1 ) {
        menu.query();
        picked = menu.ret;
    }
    if( picked < 0 || static_cast<size_t>( picked ) >= options.size() ) {
        return std::nullopt;
    }
    const auto [index, attach] = options[picked];
    const vehicle_part &station = target.part( index );
    vehicle_tool_selection choice;
    choice.part_id = station.get_base().uid().get_value();
    if( attach ) {
        const item_location tool = game_menus::inv::veh_tool_attach( who, station.name( false ),
                                   available_types( target, station ) );
        if( !tool ) {
            return std::nullopt;
        }
        choice.source = capture_item_source( who, tool );
    } else {
        uilist tools;
        tools.title = station_label( station, false );
        std::vector<int64_t> identities;
        for( const item &tool : target.get_tools( station ) ) {
            tools.addentry( identities.size(), true, MENU_AUTOASSIGN, tool.display_name() );
            identities.push_back( tool.uid().get_value() );
        }
        if( identities.empty() ) {
            return std::nullopt;
        }
        tools.query();
        if( tools.ret < 0 || static_cast<size_t>( tools.ret ) >= identities.size() ) {
            return std::nullopt;
        }
        choice.tool_id = identities[tools.ret];
    }
    request->toolstation = std::move( choice );
    return request;
}

void add_vehicle_toolstation_menu( veh_menu &menu, map &here, vehicle &target,
                                   const tripoint_abs_ms &position )
{
    for( const vpart_reference &part : target.get_all_parts() ) {
        if( part.pos_abs() != position || !toolstation( part.part() ) ) {
            continue;
        }
        const int64_t vehicle_id = target.uid().get_value();
        const int64_t part_id = part.part().get_base().uid().get_value();
        for( const bool attach : {
                 true, false
             } ) {
            menu.add( station_label( part.part(), attach ) )
            .enable( attach ? !available_types( target,
                                                part.part() ).empty() : !target.get_tools( part.part() ).empty() )
            .skip_locked_check().skip_theft_check()
            .on_submit( [&here, vehicle_id, part_id, position, attach] {
                vehicle *current = vehicle::find_vehicle_by_uid( here, vehicle_id );
                if( !current )
                {
                    return;
                }
                Character &who = get_player_character();
                const auto request = query_vehicle_toolstation( who, here, *current, position, part_id, attach );
                if( request && !cata_mp::client_vehicle_control( *request ) )
                {
                    execute_vehicle_control( who, here, *request );
                }
            } );
        }
    }
}
