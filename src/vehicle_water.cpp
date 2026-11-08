#include "vehicle_water.h"

#include <algorithm>
#include <climits>

#include "activity_actor.h"
#include "activity_actor_definitions.h"
#include "character.h"
#include "character_action_guard.h"
#include "game.h"
#include "item.h"
#include "item_consumption.h"
#include "itype.h"
#include "json.h"
#include "liquid_transfer.h"
#include "map.h"
#include "mp_inventory_activity.h"
#include "player_activity.h"
#include "string_formatter.h"
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

int water_tank( const vehicle &target, int64_t tank, int64_t liquid, bool for_purification = false )
{
    for( const vpart_reference &part : target.get_all_parts() ) {
        const vehicle_part &p = part.part();
        if( p.removed || !p.is_available() || !p.is_tank() ||
            p.get_base().uid().get_value() != tank || p.ammo_remaining() <= 0 ||
            ( p.ammo_current() != water && ( for_purification || p.ammo_current() != clean_water ) ) ) {
            continue;
        }
        const item &contents = p.get_base().only_item();
        if( contents.uid().get_value() == liquid &&
            ( for_purification || contents.made_of( phase_id::LIQUID ) ) ) {
            return part.part_index();
        }
    }
    return -1;
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

class vehicle_water_activity_actor : public activity_actor
{
    public:
        item_source source;
        unload_liquid_choice destination;
        const activity_id &get_type() const override {
            static const activity_id id( "ACT_FILL_LIQUID" );
            return id;
        }
        void start( player_activity &act, Character & ) override {
            act.moves_total = act.moves_left = 1;
        }
        void do_turn( player_activity &act, Character &who ) override {
            map &here = get_map();
            item_location liquid = resolve_vehicle_water_source( who, here, source );
            liquid_dest_opt to;
            std::optional<int> destination_tank;
            if( !liquid || !resolve_liquid_destination( who, destination,
                    *liquid.parent_item(), to, destination_tank ) ) {
                act.set_to_null();
                return;
            }
            // Same 250 ml per world turn as native vehicle liquid transfer.
            item portion = *liquid;
            portion.charges = std::min( liquid->charges,
                                        std::max( 1, liquid->charges_per_volume( 250_ml ) ) );
            if( portion.has_temperature() && units::to_joule_per_gram( portion.specific_energy ) < 0 ) {
                portion.set_item_temperature( std::max( get_weather().get_temperature( who.pos_bub() ),
                                                        temperatures::cold ) );
            }
            const int available = portion.charges;
            const character_action_guard lifetime( who );
            const item_source identity = source;
            liquid_handler::transfer_liquid( who, portion, to, destination_tank, true, false );
            if( !lifetime ) {
                return;
            }
            const int moved = available - portion.charges;
            liquid = resolve_vehicle_water_source( who, here, identity );
            if( !liquid || moved <= 0 ) {
                act.set_to_null();
                return;
            }
            vehicle *target = vehicle::find_vehicle_by_uid( here, identity.path[0] );
            const int tank = water_tank( *target, identity.path[2], identity.path[3] );
            target->drain( here, tank, moved );
            who.set_moves( 0 );
            if( moved < available || !resolve_vehicle_water_source( who, here, identity ) ) {
                act.set_to_null();
            }
        }
        void finish( player_activity &act, Character & ) override {
            act.set_to_null();
        }
        std::unique_ptr<activity_actor> clone() const override {
            return std::make_unique<vehicle_water_activity_actor>( *this );
        }
        void serialize( JsonOut &out ) const override {
            out.start_object();
            out.member( "source", source );
            out.member( "destination", destination );
            out.end_object();
        }
};
} // namespace

std::unique_ptr<activity_actor> deserialize_vehicle_water_activity( JsonValue &data )
{
    vehicle_water_activity_actor actor;
    const JsonObject object = data.get_object();
    object.read( "source", actor.source, true );
    object.read( "destination", actor.destination, true );
    return actor.clone();
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
        return who.can_eat( *tank_liquid( target, index ) ).success();
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
    const item_location liquid = tank_liquid( target, tank );
    if( choice.operation == "drink" ) {
        if( !owned_consumption_allowed( who, liquid, choice.allow_consequences, allow_theft ) ) {
            return false;
        }
        who.assign_activity( consume_activity_actor( liquid, false, true,
                             choice.allow_consequences, allow_theft ) );
    } else {
        vehicle_water_activity_actor actor;
        actor.source = faucet_source( target, position, choice );
        actor.destination = *choice.destination;
        who.assign_activity( actor );
        who.activity.set_execution( activity_execution::authoritative );
    }
    return static_cast<bool>( who.activity );
}

std::optional<item_source> capture_vehicle_water_source( const Character &who,
        const item_location &source )
{
    if( !source || !source.has_parent() ||
        ( source->typeId() != water && source->typeId() != clean_water ) ) {
        return std::nullopt;
    }
    const item_location root = source.parent_item();
    if( root.where() != item_location::type::vehicle ) {
        return std::nullopt;
    }
    const vehicle_cursor *cursor = root.veh_cursor();
    if( !cursor || root.has_parent() ||
        &*root != &cursor->veh.part( cursor->part ).get_base() ||
        water_tank( cursor->veh, root->uid().get_value(), source->uid().get_value() ) < 0 ) {
        return std::nullopt;
    }
    for( const vpart_reference &part : cursor->veh.get_all_parts() ) {
        if( supplies_tool( cursor->veh, part.part(), faucet ) && part.pos_abs().z() == who.pos_abs().z() &&
            rl_dist( part.pos_abs(), who.pos_abs() ) <= 1 ) {
            return item_source{ "vehicle_faucet", part.pos_abs(),
                {
                    cursor->veh.uid().get_value(), part.part().get_base().uid().get_value(),
                    root->uid().get_value(), source->uid().get_value()
                } };
        }
    }
    return std::nullopt;
}

item_location resolve_vehicle_water_source( Character &who, map &here, const item_source &source )
{
    if( source.kind != "vehicle_faucet" || source.path.size() != 4 ||
        source.position.z() != who.pos_abs().z() || rl_dist( source.position, who.pos_abs() ) > 1 ) {
        return item_location::nowhere;
    }
    vehicle *target = vehicle::find_vehicle_by_uid( here, source.path[0] );
    if( !target || tool_at( *target, source.position, faucet, source.path[1] ) < 0 ) {
        return item_location::nowhere;
    }
    const int tank = water_tank( *target, source.path[2], source.path[3] );
    return tank >= 0 ? tank_liquid( *target, tank ) : item_location::nowhere;
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
