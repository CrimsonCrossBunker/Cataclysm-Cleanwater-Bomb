#include "vehicle_water.h"

#include <algorithm>
#include <climits>
#include <cstdlib>
#include <utility>

#include "activity_actor.h"
#include "activity_actor_definitions.h"
#include "cached_options.h"
#include "character.h"
#include "character_action_guard.h"
#include "enums.h"
#include "game.h"
#include "item.h"
#include "item_consumption.h"
#include "item_uid.h"
#include "itype.h"
#include "json.h"
#include "liquid_transfer.h"
#include "map.h"
#include "mp_inventory_activity.h"
#include "player_activity.h"
#include "string_formatter.h"
#include "temp_crafting_inventory.h"
#include "translations.h"
#include "uilist.h"
#include "veh_interact.h"
#include "veh_type.h"
#include "veh_utils.h"
#include "vehicle.h"
#include "vehicle_control.h"
#include "vehicle_selector.h"
#include "vpart_range.h"
#include "weather.h"

namespace
{
const itype_id water( "water" );
const itype_id clean_water( "water_clean" );
const itype_id faucet( "water_faucet" );
const itype_id purifier( "water_purifier" );
const quality_id hose( "HOSE" );

bool supplies_tool( const vehicle &target, const vehicle_part &part, const itype_id &type )
{
    if( part.removed || !part.is_available() ) {
        return false;
    }
    const auto tools = part.info().get_pseudo_tools();
    const auto &installed = target.get_tools( part );
    return std::any_of( tools.begin(), tools.end(), [&]( const auto & entry ) {
        return entry.first == type;
    } ) || std::any_of( installed.begin(), installed.end(), [&]( const item & tool ) {
        return tool.typeId() == type;
    } );
}

int tool_at( const vehicle &target, const tripoint_abs_ms &position, const itype_id &type,
             int64_t identity = 0 )
{
    for( const vpart_reference &part : target.get_all_parts() ) {
        if( part.pos_abs() == position && supplies_tool( target, part.part(), type ) &&
            ( identity == 0 || part.part().get_base().uid().get_value() == identity ) ) {
            return part.part_index();
        }
    }
    return -1;
}

int liquid_tank( const vehicle &target, int64_t tank, int64_t liquid, bool allow_frozen = false )
{
    for( const vpart_reference &entry : target.get_all_parts() ) {
        const vehicle_part &part = entry.part();
        if( !part.is_available() || !part.is_tank() || part.has_flag( vp_flag::carried_flag ) ||
            part.get_base().uid().get_value() != tank || part.ammo_remaining() <= 0 ) {
            continue;
        }
        const item &contents = part.get_base().only_item();
        if( contents.uid().get_value() == liquid &&
            ( allow_frozen || contents.made_of( phase_id::LIQUID ) ) ) {
            return entry.part_index();
        }
    }
    return -1;
}

int water_tank( const vehicle &target, int64_t tank, int64_t liquid, bool for_purification = false )
{
    const int index = liquid_tank( target, tank, liquid, for_purification );
    if( index < 0 ) {
        return -1;
    }
    const itype_id type = target.part( index ).ammo_current();
    return type == water || ( !for_purification && type == clean_water ) ? index : -1;
}

bool can_siphon( Character &who, map &here, const vehicle &target )
{
    if( who.controlling_vehicle || std::abs( target.velocity ) > 100 ) {
        return false;
    }
    if( target.is_appliance() ) {
        return who.has_quality( hose );
    }
    // Nearby tools may have been moved by another player this turn.
    who.invalidate_crafting_inventory();
    return who.crafting_inventory( &here, who.pos_bub( here ), pickup_range, false ).has_quality( hose );
}

int preferred_water_tank( const vehicle &target )
{
    int tank = -1;
    for( const itype_id &type : {
             clean_water, water
         } ) {
        for( const vpart_reference &part : target.get_all_parts() ) {
            if( part.part().is_tank() && part.part().ammo_current() == type &&
                part.part().ammo_remaining() > 0 &&
                water_tank( target, part.part().get_base().uid().get_value(),
                            part.part().get_base().only_item().uid().get_value() ) >= 0 ) {
                tank = part.part_index();
                break;
            }
        }
        if( tank >= 0 ) {
            break;
        }
    }
    return tank;
}

item_location tank_liquid( vehicle &target, int part )
{
    item_location tank = item_location::from_vehicle_part( vehicle_cursor( target, part ) );
    return item_location( tank, &tank->only_item() );
}

item_source faucet_source( const vehicle &target, const tripoint_abs_ms &position,
                           const vehicle_water_selection &choice )
{
    return item_source{ "vehicle_faucet", position,
        { target.uid().get_value(), choice.tool, choice.tank, choice.liquid } };
}

item_source siphon_source( const vehicle &target, const tripoint_abs_ms &position,
                           const vehicle_water_selection &choice )
{
    return item_source{ "vehicle_siphon", position,
        { target.uid().get_value(), choice.tank, choice.liquid } };
}

item_location resolve_vehicle_siphon_source( Character &who, map &here, const item_source &source,
        const std::optional<faction_id> &owner )
{
    if( source.path.size() != 3 || !here.inbounds( source.position ) ||
        source.position.z() != who.pos_abs().z() || rl_dist( source.position, who.pos_abs() ) > 1 ) {
        return item_location::nowhere;
    }
    const auto at = here.veh_at( source.position );
    if( !at || at->vehicle().uid().get_value() != source.path[0] || at->vehicle().magic ||
        ( owner && at->vehicle().get_owner() != *owner ) || !can_siphon( who, here, at->vehicle() ) ) {
        return item_location::nowhere;
    }
    vehicle &target = at->vehicle();
    const int tank = liquid_tank( target, source.path[1], source.path[2] );
    return tank >= 0 ? tank_liquid( target, tank ) : item_location::nowhere;
}

// Reserve only the portion passed to native gameplay. A consumption or
// placement callback can move or destroy the tank while it runs.
template<typename Use>
int settle_tank_portion( Character &who, map &here, item_location liquid, item &portion, Use use )
{
    const item_location tank = liquid.parent_item();
    const vehicle_cursor *cursor = tank.veh_cursor();
    if( !cursor ) {
        return 0;
    }
    const auto vehicle_ref = cursor->veh.get_safe_reference();
    const auto context = here.get_context_reference();
    const character_action_guard lifetime( who );
    const tripoint_abs_ms position = liquid.pos_abs();
    const int reserved = portion.charges;
    liquid->charges -= reserved;
    use( portion );
    portion.charges = std::clamp( portion.charges, 0, reserved );
    const int used = reserved - portion.charges;
    if( !context ) {
        return used;
    }
    if( liquid ) {
        liquid->charges += portion.charges;
        if( liquid->charges == 0 ) {
            liquid.remove_item();
        } else {
            liquid.on_contents_changed();
        }
    } else if( portion.charges > 0 && here.inbounds( position ) ) {
        here.add_item_or_charges( here.get_bub( position ), portion, true,
                                  lifetime ? &who : nullptr );
    }
    if( vehicle_ref ) {
        vehicle_ref->invalidate_mass();
    }
    return used;
}
} // namespace

void drink_vehicle_liquid( Character &who, map &here, item_location liquid )
{
    if( !liquid || liquid->charges <= 0 ) {
        return;
    }
    item portion = *liquid;
    // Food uses one serving. Immediate medication can use multiple charges
    // through its native iuse and returns any unused charges to the tank.
    if( !portion.is_medication() ) {
        portion.charges = 1;
    }
    const int reserved = portion.charges;
    settle_tank_portion( who, here, liquid, portion, [&]( item & drink ) {
        switch( who.consume( drink, true, true ) ) {
            case trinary::NONE:
                drink.charges = reserved;
                break;
            case trinary::ALL:
                drink.charges = 0;
                break;
            case trinary::SOME:
                drink.charges = std::min( drink.charges, reserved - 1 );
                break;
        }
    } );
}

void vehicle_liquid_transfer_turn( player_activity &act, Character &who, const item_source &source,
                                    const unload_liquid_choice &destination )
{
    map &here = get_map();
    item_location liquid = resolve_vehicle_water_source( who, here, source );
    liquid_dest_opt to;
    std::optional<int> destination_tank;
    if( !liquid || destination.source != liquid->uid().get_value() ||
        !resolve_liquid_destination( who, destination, *liquid.parent_item(), to, destination_tank ) ) {
        act.set_to_null();
        return;
    }
    item portion = *liquid;
    portion.charges = std::min( liquid->charges,
                                std::max( 1, liquid->charges_per_volume( 250_ml ) ) );
    if( portion.has_temperature() && units::to_joule_per_gram( portion.specific_energy ) < 0 ) {
        portion.set_item_temperature( std::max( get_weather().get_temperature( who.pos_bub() ),
                                                temperatures::cold ) );
    }

    const int available = portion.charges;
    const character_action_guard lifetime( who );
    const auto context = here.get_context_reference();
    const auto generation = act.identity_generation();
    const item_source identity = source;
    const int moved = settle_tank_portion( who, here, liquid, portion, [&]( item & load ) {
        liquid_handler::transfer_liquid( who, load, to, destination_tank, true, false );
    } );
    if( !lifetime || !context || who.activity.identity_generation() != generation ) {
        return;
    }
    if( moved > 0 ) {
        who.set_moves( 0 );
    }
    if( moved < available || !resolve_vehicle_water_source( who, here, identity ) ) {
        act.set_to_null();
    }
}

void vehicle_water_selection::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "operation", operation );
    out.member( "tool", tool );
    out.member( "tank", tank );
    out.member( "liquid", liquid );
    out.member( "allow_consequences", allow_consequences );
    if( destination ) {
        out.member( "destination", *destination );
    }
    out.end_object();
}

void vehicle_water_selection::deserialize( const JsonObject &data )
{
    data.read( "operation", operation, true );
    data.read( "tool", tool, true );
    data.read( "tank", tank, true );
    data.read( "liquid", liquid, true );
    data.read( "allow_consequences", allow_consequences );
    destination.reset();
    data.read( "destination", destination );
}

bool has_vehicle_water_tool( const vehicle &target, const tripoint_abs_ms &position )
{
    return tool_at( target, position, faucet ) >= 0 || tool_at( target, position, purifier ) >= 0;
}

bool valid_vehicle_water_selection( Character &who, map &here, vehicle &target,
                                    const tripoint_abs_ms &position, const vehicle_water_selection &choice )
{
    if( choice.operation == "siphon" || choice.operation == "siphon_drink" ) {
        if( choice.tool != 0 ) {
            return false;
        }
        const item_location liquid = resolve_vehicle_water_source( who, here,
                                     siphon_source( target, position, choice ) );
        if( !liquid ) {
            return false;
        }
        if( choice.operation == "siphon_drink" ) {
            return !choice.destination &&
                   owned_consumption_allowed( who, liquid, choice.allow_consequences, true );
        }
        liquid_dest_opt to;
        std::optional<int> part;
        return !choice.allow_consequences && choice.destination &&
               choice.destination->source == choice.liquid &&
               resolve_liquid_destination( who, *choice.destination, *liquid.parent_item(), to, part );
    }
    const bool purify = choice.operation == "purify";
    if( choice.tool <= 0 || ( !purify && choice.operation != "drink" && choice.operation != "fill" ) ||
        ( choice.operation == "fill" ) != choice.destination.has_value() ||
        ( choice.operation != "drink" && choice.allow_consequences ) ||
        tool_at( target, position, purify ? purifier : faucet, choice.tool ) < 0 ||
        ( purify && target.is_locked ) ) {
        return false;
    }
    const int index = water_tank( target, choice.tank, choice.liquid, purify );
    if( index < 0 ) {
        return false;
    }
    if( choice.destination ) {
        liquid_dest_opt to;
        std::optional<int> part;
        return choice.destination->source == choice.liquid &&
               resolve_liquid_destination( who, *choice.destination, target.part( index ).get_base(), to, part );
    }
    if( choice.operation == "drink" ) {
        return owned_consumption_allowed( who, tank_liquid( target, index ),
                                          choice.allow_consequences, true );
    }
    const int64_t cost = static_cast<int64_t>( target.part( index ).ammo_remaining() ) *
                         purifier->charges_to_use();
    if( cost <= 0 || cost > INT_MAX || target.fuel_left( here, itype_id( "battery" ) ) < cost ) {
        who.add_msg_if_player( m_bad,
                               _( "Insufficient power to purify the contents of the %1$s's %2$s" ),
                               target.name, target.part( index ).name() );
        return false;
    }
    return true;
}

bool execute_vehicle_water( Character &who, map &here, vehicle &target,
                            const tripoint_abs_ms &position, const vehicle_water_selection &choice,
                            bool allow_theft )
{
    if( !valid_vehicle_water_selection( who, here, target, position, choice ) ) {
        return false;
    }
    if( choice.operation == "drink" || choice.operation == "siphon_drink" ) {
        item_source source = choice.operation == "drink" ? faucet_source( target, position, choice ) :
                             siphon_source( target, position, choice );
        const item_location liquid = resolve_vehicle_water_source( who, here, source );
        if( !owned_consumption_allowed( who, liquid, choice.allow_consequences, allow_theft ) ) {
            return false;
        }
        who.assign_activity( consume_activity_actor( std::move( source ), target.get_owner(),
                             choice.allow_consequences, allow_theft ) );
        return static_cast<bool>( who.activity );
    }
    if( choice.operation == "siphon" ) {
        start_owned_liquid_transfer( who, siphon_source( target, position, choice ),
                                     *choice.destination );
        return static_cast<bool>( who.activity );
    }
    const int tank = water_tank( target, choice.tank, choice.liquid, choice.operation == "purify" );
    if( choice.operation == "purify" ) {
        const int amount = target.part( tank ).ammo_remaining();
        const int cost = static_cast<int64_t>( amount ) * purifier->charges_to_use();
        target.discharge_battery( here, cost );
        target.part( tank ).ammo_set( clean_water, amount );
        who.add_msg_if_player( m_good, _( "You purify the contents of the %1$s's %2$s" ),
                               target.name, target.part( tank ).name() );
        return true;
    }
    start_owned_liquid_transfer( who, faucet_source( target, position, choice ),
                                 *choice.destination );
    return static_cast<bool>( who.activity );
}

bool is_vehicle_liquid_source( const item_source &source )
{
    return source.kind == "vehicle_faucet" || source.kind == "vehicle_siphon";
}

item_location resolve_vehicle_water_source( Character &who, map &here, const item_source &source,
        const std::optional<faction_id> &owner )
{
    if( source.kind == "vehicle_siphon" ) {
        return resolve_vehicle_siphon_source( who, here, source, owner );
    }
    if( source.kind != "vehicle_faucet" || source.path.size() != 4 ||
        !here.inbounds( source.position ) ||
        source.position.z() != who.pos_abs().z() || rl_dist( source.position, who.pos_abs() ) > 1 ) {
        return item_location::nowhere;
    }
    const auto at = here.veh_at( source.position );
    if( !at || at->vehicle().uid().get_value() != source.path[0] ||
        ( owner && at->vehicle().get_owner() != *owner ) ) {
        return item_location::nowhere;
    }
    vehicle &target = at->vehicle();
    if( tool_at( target, source.position, faucet, source.path[1] ) < 0 ) {
        return item_location::nowhere;
    }
    const int tank = water_tank( target, source.path[2], source.path[3] );
    return tank >= 0 ? tank_liquid( target, tank ) : item_location::nowhere;
}

std::optional<vehicle_control_selection> query_vehicle_water( Character &who, map &here,
        vehicle &target, const tripoint_abs_ms &position, const std::string &operation )
{
    if( !vehicle_control_accessible( who, here, target, position, "water" ) ) {
        return std::nullopt;
    }
    vehicle_water_selection choice;
    choice.operation = operation;
    if( choice.operation.empty() ) {
        uilist menu;
        menu.addentry( 0, tool_at( target, position, faucet ) >= 0, MENU_AUTOASSIGN,
                       _( "Fill a container with water" ) );
        menu.addentry( 1, tool_at( target, position, faucet ) >= 0, MENU_AUTOASSIGN, _( "Have a drink" ) );
        menu.addentry( 2, tool_at( target, position, purifier ) >= 0, MENU_AUTOASSIGN,
                       _( "Purify water in vehicle tank" ) );
        menu.query();
        if( menu.ret < 0 || menu.ret > 2 ) {
            return std::nullopt;
        }
        choice.operation = menu.ret == 0 ? "fill" : menu.ret == 1 ? "drink" : "purify";
    }
    const bool purify = choice.operation == "purify";
    const int tool = tool_at( target, position, purify ? purifier : faucet );
    if( tool < 0 ) {
        return std::nullopt;
    }
    choice.tool = target.part( tool ).get_base().uid().get_value();
    int tank = -1;
    if( purify ) {
        const auto selected = veh_interact::select_part( here, target,
        []( const map &, const vehicle_part & part ) {
            return part.is_tank() && part.ammo_current() == water;
        }, _( "Select tank to purify" ) );
        if( selected ) {
            tank = selected->part_index();
        }
    } else {
        tank = preferred_water_tank( target );
    }
    if( tank < 0 ) {
        return std::nullopt;
    }
    const item &liquid = target.part( tank ).get_base().only_item();
    choice.tank = target.part( tank ).get_base().uid().get_value();
    choice.liquid = liquid.uid().get_value();
    if( choice.operation == "fill" ) {
        choice.destination = query_liquid_destination( liquid, &target.part( tank ).get_base(),
                             choice.liquid );
        if( choice.destination->kind == LD_NULL ) {
            return std::nullopt;
        }
    } else if( choice.operation == "drink" ) {
        if( !who.will_eat( liquid, true ).success() ) {
            return std::nullopt;
        }
        choice.allow_consequences = true;
    }
    auto request = query_vehicle_control( who, here, target, position, "water" );
    if( request ) {
        request->water = choice;
    }
    return request;
}

void add_vehicle_water_menu( veh_menu &menu, map &here, vehicle &target,
                             const tripoint_abs_ms &position )
{
    const auto add = [&]( const std::string & label, const std::string & hotkey,
    const std::string & operation, const itype_id & tool ) {
        const int part = tool_at( target, position, tool );
        if( part < 0 ) {
            return;
        }
        const int water_part = preferred_water_tank( target );
        if( tool == faucet && water_part < 0 ) {
            return;
        }
        bool enabled = true;
        if( operation == "drink" ) {
            enabled = get_player_character().will_eat( target.part(
                          water_part ).get_base().only_item() ).success();
        } else if( operation == "purify" ) {
            enabled = target.fuel_left( here, water ) > 0 &&
                      target.fuel_left( here, itype_id( "battery" ) ) >= purifier->charges_to_use();
        }
        const int64_t vehicle_id = target.uid().get_value();
        const int64_t hardware = target.part( part ).get_base().uid().get_value();
        menu.add( label ).enable( enabled ).hotkey( hotkey ).skip_locked_check().skip_theft_check()
        .on_submit( [&here, vehicle_id, hardware, position, operation, tool] {
            vehicle *current = vehicle::find_vehicle_by_uid( here, vehicle_id );
            if( !current || tool_at( *current, position, tool, hardware ) < 0 )
            {
                return;
            }
            Character &who = get_player_character();
            const auto request = query_vehicle_water( who, here, *current, position, operation );
            if( request && !cata_mp::client_vehicle_control( *request ) )
            {
                execute_vehicle_control( who, here, *request );
            }
        } );
    };
    add( _( "Fill a container with water" ), "FAUCET_FILL", "fill", faucet );
    add( _( "Have a drink" ), "FAUCET_DRINK", "drink", faucet );
    add( _( "Purify water in vehicle tank" ), "PURIFY_WATER", "purify", purifier );
}
