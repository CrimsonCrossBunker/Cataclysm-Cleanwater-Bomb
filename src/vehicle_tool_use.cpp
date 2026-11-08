#include "vehicle_tool_use.h"

#include <algorithm>

#include "calendar.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "game.h"
#include "item.h"
#include "item_activation.h"
#include "itype.h"
#include "iuse.h"
#include "json.h"
#include "line.h"
#include "mp_inventory_activity.h"
#include "ret_val.h"
#include "rng.h"
#include "string_formatter.h"
#include "translations.h"
#include "uilist.h"
#include "veh_type.h"
#include "veh_utils.h"
#include "vehicle.h"
#include "vehicle_control.h"
#include "vpart_range.h"

bool immediate_vehicle_tool_method( const std::string &method )
{
    // These native callbacks neither prompt nor retain the temporary tool.
    // Activity-backed tools must keep their own persistent hardware binding.
    return method == "TOWEL" || method == "WEATHER_TOOL";
}

void vehicle_tool_use_selection::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "part", part );
    out.member( "installed_tool", installed_tool );
    out.member( "tool", tool );
    out.member( "method", method );
    out.end_object();
}

void vehicle_tool_use_selection::deserialize( const JsonObject &data )
{
    data.read( "part", part, true );
    data.read( "installed_tool", installed_tool, true );
    data.read( "tool", tool, true );
    data.read( "method", method, true );
}

std::vector<vehicle_tool_use_selection> vehicle_tool_use_options( const vehicle &target,
        const tripoint_abs_ms &position )
{
    std::vector<vehicle_tool_use_selection> result;
    for( const vpart_reference &part : target.get_all_parts() ) {
        if( part.pos_abs() != position || part.part().removed || !part.part().is_available() ) {
            continue;
        }
        const auto add = [&]( const itype_id & type, int64_t installed ) {
            for( const std::string method : {
                     "TOWEL", "WEATHER_TOOL"
                 } ) {
                if( type->get_use( method ) ) {
                    result.push_back( { part.part().get_base().uid().get_value(), installed,
                                        type.str(), method } );
                }
            }
        };
        for( const auto &builtin : part.part().info().get_pseudo_tools() ) {
            if( builtin.second > 0 ) {
                add( builtin.first, 0 );
            }
        }
        for( const item &tool : target.get_tools( part.part() ) ) {
            if( !tool.is_broken() ) {
                add( tool.typeId(), tool.uid().get_value() );
            }
        }
    }
    return result;
}

bool valid_vehicle_tool_use( Character &who, map &here, vehicle &target,
                             const tripoint_abs_ms &position, const vehicle_tool_use_selection &choice )
{
    if( who.is_dead_state() || who.has_effect( efftype_id( "incorporeal" ) ) ||
        who.pos_abs().z() != position.z() || rl_dist( who.pos_abs(), position ) > 1 ||
        !immediate_vehicle_tool_method( choice.method ) ) {
        return false;
    }
    const auto options = vehicle_tool_use_options( target, position );
    if( std::none_of( options.begin(), options.end(), [&]( const auto & option ) {
    return option.part == choice.part && option.installed_tool == choice.installed_tool &&
           option.tool == choice.tool && option.method == choice.method;
} ) ) {
        return false;
    }
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    item tool( itype_id( choice.tool ), calendar::turn );
    const auto [fuel, available] = target.tool_ammo_available( here, tool.typeId() );
    if( ( !fuel.is_null() && fuel->ammo->type == ammotype( "battery" ) && target.is_locked ) ||
        ( !tool.uses_firing_requirements() && available < tool.ammo_required() ) ) {
        return false;
    }
    target.prepare_tool( here, tool );
    const use_function *use = tool.type->get_use( choice.method );
    return valid_item_activation_choices( tool, choice.method, {} ) &&
           tool.ammo_sufficient( &who, choice.method ) &&
           use->can_call( who, tool, &here, here.get_bub( position ) ).success();
}

bool execute_vehicle_tool_use( Character &who, map &here, vehicle &target,
                               const tripoint_abs_ms &position, const vehicle_tool_use_selection &choice )
{
    return valid_vehicle_tool_use( who, here, target, position, choice ) &&
           invoke_vehicle_tool( who, target, here, here.get_bub( position ),
                                itype_id( choice.tool ), choice.method );
}

namespace
{
std::optional<vehicle_control_selection> select_tool( Character &who, map &here,
        vehicle &target, const tripoint_abs_ms &position, const vehicle_tool_use_selection &tool )
{
    if( !valid_vehicle_tool_use( who, here, target, position, tool ) ) {
        return std::nullopt;
    }
    auto choice = query_vehicle_control( who, here, target, position, "tool_use" );
    if( choice ) {
        choice->tool_use = tool;
    }
    return choice;
}

std::string tool_label( const vehicle_tool_use_selection &choice )
{
    return string_format( _( "Use %s" ), itype_id( choice.tool )->nname( 1 ) );
}
} // namespace

std::optional<vehicle_control_selection> query_vehicle_tool_use( Character &who, map &here,
        vehicle &target, const tripoint_abs_ms &position )
{
    const auto options = vehicle_tool_use_options( target, position );
    if( options.empty() ) {
        return std::nullopt;
    }
    int selected = 0;
    if( options.size() > 1 ) {
        uilist menu;
        menu.title = _( "Select a vehicle tool" );
        for( size_t i = 0; i < options.size(); ++i ) {
            menu.addentry( i, valid_vehicle_tool_use( who, here, target, position, options[i] ),
                           MENU_AUTOASSIGN, tool_label( options[i] ) );
        }
        menu.query();
        selected = menu.ret;
    }
    if( selected < 0 || static_cast<size_t>( selected ) >= options.size() ) {
        return std::nullopt;
    }
    return select_tool( who, here, target, position, options[selected] );
}

void add_vehicle_tool_use_menu( veh_menu &menu, map &here, vehicle &target,
                                const tripoint_abs_ms &position )
{
    for( const auto &tool : vehicle_tool_use_options( target, position ) ) {
        int hotkey = 0;
        for( const vpart_reference &part : target.get_all_parts() ) {
            if( part.part().get_base().uid().get_value() != tool.part ) {
                continue;
            }
            if( tool.installed_tool ) {
                for( const item &installed : target.get_tools( part.part() ) ) {
                    if( installed.uid().get_value() == tool.installed_tool ) {
                        hotkey = installed.invlet;
                    }
                }
            } else {
                for( const auto &builtin : part.part().info().get_pseudo_tools() ) {
                    if( builtin.first.str() == tool.tool ) {
                        hotkey = builtin.second;
                    }
                }
            }
        }
        veh_menu_item &entry = menu.add( tool_label( tool ) )
                               .enable( valid_vehicle_tool_use( get_player_character(), here, target, position, tool ) )
                               .skip_locked_check().skip_theft_check()
        .on_submit( [id = target.uid().get_value(), position, tool, &here] {
            vehicle *live = vehicle::find_vehicle_by_uid( here, id );
            if( !live )
            {
                return;
            }
            auto choice = select_tool( get_player_character(), here, *live, position, tool );
            if( choice && !cata_mp::client_vehicle_control( *choice ) )
            {
                execute_vehicle_control( get_player_character(), here, *choice );
            }
        } );
        if( hotkey > 0 ) {
            entry.hotkey( static_cast<char>( hotkey ) );
        }
    }
}
