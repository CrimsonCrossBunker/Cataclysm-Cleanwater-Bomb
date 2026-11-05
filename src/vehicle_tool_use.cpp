#include "vehicle_tool_use.h"

#include <algorithm>

#include "calendar.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "game.h"
#include "flag.h"
#include "hacksaw_activity.h"
#include "item_location.h"
#include "tool_activity_target.h"
#include "vpart_position.h"
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
    out.member( "target", target );
    out.end_object();
}

void vehicle_tool_use_selection::deserialize( const JsonObject &data )
{
    data.read( "part", part, true );
    data.read( "installed_tool", installed_tool, true );
    data.read( "tool", tool, true );
    data.read( "method", method, true );
    target.reset();
    data.read( "target", target );
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
                     "TOWEL", "WEATHER_TOOL", "HACKSAW"
                 } ) {
                if( type->get_use( method ) ) {
                    result.push_back( { part.part().get_base().uid().get_value(), installed,
                                        type.str(), method, std::nullopt } );
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
        ( !immediate_vehicle_tool_method( choice.method ) && choice.method != "HACKSAW" ) ) {
        return false;
    }
    const auto options = vehicle_tool_use_options( target, position );
    if( std::none_of( options.begin(), options.end(), [&]( const auto & option ) {
    return option.part == choice.part && option.installed_tool == choice.installed_tool &&
           option.tool == choice.tool && option.method == choice.method;
} ) ) {
        return false;
    }
    const mounted_tool_source source{ target.uid().get_value(), position, choice };
    const auto tool = mounted_tool_item( who, here, source );
    if( !tool ) {
        return false;
    }
    const use_function *use = tool->type->get_use( choice.method );
    const bool target_valid = choice.method == "HACKSAW" ? choice.target &&
                              valid_adjacent_tool_target( adjacent_tool_action::saw, who, here, *tool, *choice.target ) :
                              !choice.target;
    return target_valid && valid_item_activation_choices( *tool, choice.method, {} ) &&
           tool->ammo_sufficient( nullptr, choice.method ) &&
           use->can_call( who, *tool, &here, here.get_bub( position ) ).success();
}

bool execute_vehicle_tool_use( Character &who, map &here, vehicle &target,
                               const tripoint_abs_ms &position, const vehicle_tool_use_selection &choice )
{
    if( !valid_vehicle_tool_use( who, here, target, position, choice ) ) {
        return false;
    }
    if( choice.method == "HACKSAW" ) {
        const mounted_tool_source source{ target.uid().get_value(), position, choice };
        return start_hacksaw_work( who, item_location::nowhere, *choice.target, &source );
    }
    return invoke_vehicle_tool( who, target, here, here.get_bub( position ),
                                itype_id( choice.tool ), choice.method );
}

namespace
{
std::optional<vehicle_control_selection> select_tool( Character &who, map &here,
        vehicle &target, const tripoint_abs_ms &position, const vehicle_tool_use_selection &tool )
{
    auto selected = tool;
    if( tool.method == "HACKSAW" ) {
        mounted_tool_source source{ target.uid().get_value(), position, tool };
        const auto proxy = mounted_tool_item( who, here, source );
        if( !proxy ) {
            return std::nullopt;
        }
        selected.target = query_adjacent_tool_target( adjacent_tool_action::saw, who, here, *proxy );
        if( !selected.target || !query_hacksaw_work( who, *proxy, *selected.target, &source ) ) {
            return std::nullopt;
        }
    }
    if( !valid_vehicle_tool_use( who, here, target, position, selected ) ) {
        return std::nullopt;
    }
    auto choice = query_vehicle_control( who, here, target, position, "tool_use" );
    if( choice ) {
        choice->tool_use = selected;
    }
    return choice;
}

bool tool_available( Character &who, map &here, vehicle &target,
                     const tripoint_abs_ms &position, const vehicle_tool_use_selection &choice )
{
    if( choice.method != "HACKSAW" ) {
        return valid_vehicle_tool_use( who, here, target, position, choice );
    }
    const mounted_tool_source source{ target.uid().get_value(), position, choice };
    const auto tool = mounted_tool_item( who, here, source );
    return tool && tool->ammo_sufficient( nullptr, "HACKSAW" ) &&
           tool->get_quality( quality_id( "SAW_M" ) ) >= 2;
}

std::string tool_label( const vehicle_tool_use_selection &choice )
{
    return choice.method == "HACKSAW" ? string_format( _( "Cut metal with %s" ),
            itype_id( choice.tool )->nname( 1 ) ) :
           string_format( _( "Use %s" ), itype_id( choice.tool )->nname( 1 ) );
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
            menu.addentry( i, tool_available( who, here, target, position, options[i] ),
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
                               .enable( tool.method == "HACKSAW" ||
                                        valid_vehicle_tool_use( get_player_character(), here, target, position, tool ) )
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

void mounted_tool_source::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "vehicle", vehicle_id );
    out.member( "position", position );
    out.member( "tool", tool );
    out.end_object();
}

void mounted_tool_source::deserialize( const JsonObject &data )
{
    data.read( "vehicle", vehicle_id, true );
    data.read( "position", position, true );
    data.read( "tool", tool, true );
}

std::optional<mounted_tool_source> capture_mounted_tool( const vehicle &target,
        const tripoint_abs_ms &position, const itype_id &type, const std::string &method )
{
    for( const auto &tool : vehicle_tool_use_options( target, position ) ) {
        if( tool.tool == type.str() && tool.method == method ) {
            return mounted_tool_source{ target.uid().get_value(), position, tool };
        }
    }
    return std::nullopt;
}

namespace
{
struct mounted_tool_plan {
    item tool;
    itype_id fuel;
    int initial_ammo = 0;
    std::map<std::string, multimag_pocket_state> bindings;
};

std::optional<mounted_tool_plan> prepare_mounted_turn( Character &who, map &here,
        const mounted_tool_source &source )
{
    vehicle *target = vehicle::find_vehicle_by_uid( here, source.vehicle_id );
    if( !target || who.is_dead_state() ||
        ( source.tool.method == "HACKSAW" && who.is_mounted() ) ||
        who.has_effect( efftype_id( "incorporeal" ) ) ||
        who.pos_abs().z() != source.position.z() || rl_dist( who.pos_abs(), source.position ) > 1 ) {
        return std::nullopt;
    }
    const auto choices = vehicle_tool_use_options( *target, source.position );
    if( std::none_of( choices.begin(), choices.end(), [&]( const auto & choice ) {
    return choice.part == source.tool.part && choice.installed_tool == source.tool.installed_tool &&
           choice.tool == source.tool.tool && choice.method == source.tool.method;
} ) ) {
        return std::nullopt;
    }
    // This is a resource view, not an item spawned in the simulated world.
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    mounted_tool_plan result{ item( itype_id( source.tool.tool ), calendar::turn ), itype_id::NULL_ID(), 0, {} };
    if( result.tool.uses_firing_requirements() ) {
        result.tool.set_flag( flag_PSEUDO );
        result.bindings = vehicle::prepare_multimag_pockets( *target, here, result.tool );
        if( target->is_locked && std::any_of( result.bindings.begin(), result.bindings.end(),
        []( const auto & binding ) {
        return binding.second.kind == multimag_pocket_state::source_kind::BATTERY;
    } ) ) {
            return std::nullopt;
        }
    } else {
        result.fuel = target->tool_ammo_available( here, result.tool.typeId() ).first;
        if( target->is_locked && !result.fuel.is_null() &&
            result.fuel->ammo->type == ammotype( "battery" ) ) {
            return std::nullopt;
        }
        result.initial_ammo = target->prepare_tool( here, result.tool );
    }
    return result;
}
} // namespace

std::optional<item> mounted_tool_item( Character &who, map &here,
                                       const mounted_tool_source &source )
{
    auto prepared = prepare_mounted_turn( who, here, source );
    return prepared ? std::make_optional( std::move( prepared->tool ) ) : std::nullopt;
}

bool consume_mounted_tool_turn( Character &who, map &here, const mounted_tool_source &source )
{
    auto prepared = prepare_mounted_turn( who, here, source );
    if( !prepared || !prepared->tool.ammo_sufficient( nullptr, source.tool.method ) ) {
        return false;
    }
    const auto scale = prepared->tool.type->ammo_scale.find( source.tool.method );
    const int uses = scale == prepared->tool.type->ammo_scale.end() ? 1 : scale->second;
    const int consumed = prepared->tool.consume_tool_uses( uses, here,
                         here.get_bub( source.position ), nullptr );
    vehicle *target = vehicle::find_vehicle_by_uid( here, source.vehicle_id );
    if( !target ) {
        return false;
    }
    if( prepared->tool.uses_firing_requirements() ) {
        vehicle::drain_back_multimag( *target, here, prepared->tool, prepared->bindings );
    } else {
        const int delta = prepared->initial_ammo - prepared->tool.ammo_remaining_linked( here, nullptr );
        if( delta > 0 && !prepared->fuel.is_null() ) {
            if( prepared->fuel->ammo->type == ammotype( "battery" ) ) {
                target->discharge_battery( here, delta );
            } else {
                target->drain( &here, prepared->fuel, delta );
            }
        }
    }
    return consumed == uses;
}

bool query_mounted_saw( Character &who, const item &tool, const tripoint_bub_ms &position )
{
    map &here = get_map();
    const auto part = here.veh_at( position );
    if( !part ) {
        return false;
    }
    const auto source = capture_mounted_tool( part->vehicle(), here.get_abs( position ),
                        tool.typeId(), "HACKSAW" );
    if( !source ) {
        return false;
    }
    const auto choice = select_tool( who, here, part->vehicle(), source->position, source->tool );
    return choice && ( cata_mp::client_vehicle_control( *choice ) ||
                       execute_vehicle_control( who, here, *choice ) );
}
