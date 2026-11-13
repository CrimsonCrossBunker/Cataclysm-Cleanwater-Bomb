#include "vehicle_power_connection.h"

#include "action.h"
#include "character.h"
#include "character_action_guard.h"
#include "flag.h"
#include "item.h"
#include "item_location.h"
#include "item_source.h"
#include "itype.h"
#include "iuse_actor.h"
#include "json.h"
#include "map.h"
#include "messages.h"
#include "player_activity.h"
#include "ret_val.h"
#include "safe_reference.h"
#include "translations.h"
#include "veh_type.h"
#include "vehicle.h"
#include "vpart_position.h"

namespace
{
std::optional<vpart_reference> vehicle_cable_endpoint_at( map &here, const tripoint_abs_ms &position,
        link_state kind = link_state::vehicle_port )
{
    if( !here.inbounds( position ) ) {
        return std::nullopt;
    }
    const auto at = here.veh_at( position );
    if( !at || at->vehicle().magic ) {
        return std::nullopt;
    }
    vehicle &veh = at->vehicle();
    const bool towing = kind == link_state::vehicle_tow;
    if( towing && ( !veh.is_external_part( &here, here.get_bub( position ) ) ||
                    veh.has_tow_attached() || veh.is_towed() || veh.is_towing() ) ) {
        return std::nullopt;
    }
    const int port = towing ? veh.part_at( veh.coord_translate( at->mount_pos() ) ) :
                     veh.avail_linkable_part( at->mount_pos(), kind == link_state::vehicle_port );
    if( port < 0 || veh.part( port ).removed || veh.part( port ).is_fake ||
        veh.abs_part_pos( port ) != position ||
        ( towing && ( veh.part( port ).is_broken() || !veh.part( port ).carried_stack.empty() ) ) ) {
        return std::nullopt;
    }
    return vpart_reference( veh, port );
}

bool reachable_vehicle_cable_endpoint( const Character &who, const tripoint_abs_ms &position )
{
    const tripoint_abs_ms origin = who.pos_abs();
    const int64_t dx = static_cast<int64_t>( position.x() ) - origin.x();
    const int64_t dy = static_cast<int64_t>( position.y() ) - origin.y();
    return position.z() == origin.z() && dx >= -1 && dx <= 1 && dy >= -1 && dy <= 1;
}

bool matches_vehicle_cable_endpoint( const vpart_reference &port, const vehicle_cable_endpoint &endpoint )
{
    return port.pos_abs() == endpoint.position && port.vehicle().uid().get_value() == endpoint.vehicle_id &&
           port.part().get_base().uid().get_value() == endpoint.part_id &&
           port.vehicle().get_owner() == endpoint.owner;
}

std::optional<vpart_reference> resolve_vehicle_cable_endpoint( const Character &who, map &here,
        const vehicle_cable_endpoint &endpoint, link_state kind = link_state::vehicle_port )
{
    if( endpoint.vehicle_id <= 0 || endpoint.part_id <= 0 ) {
        return std::nullopt;
    }
    const auto port = vehicle_cable_endpoint_at( here, endpoint.position, kind );
    if( !port ) {
        return std::nullopt;
    }
    const vehicle &veh = port->vehicle();
    if( !matches_vehicle_cable_endpoint( *port, endpoint ) ||
        ( veh.has_owner() && !veh.is_owned_by( who ) && !endpoint.allow_theft ) ) {
        return std::nullopt;
    }
    return port;
}

bool authorize_vehicle_cable_endpoint( Character &who, map &here, vehicle_cable_endpoint &endpoint,
                           link_state kind )
{
    const auto port = resolve_vehicle_cable_endpoint( who, here, endpoint, kind );
    if( !port ) {
        return false;
    }
    vehicle &veh = port->vehicle();
    if( !veh.has_owner() || veh.is_owned_by( who ) ) {
        return true;
    }
    const auto retained = veh.get_safe_reference();
    const character_action_guard actor( who );
    const auto context = here.get_context_reference();
    const auto generation = who.activity.identity_generation();
    const tripoint_abs_ms origin = who.pos_abs();
    if( !veh.handle_potential_theft( who, false, false ) || !actor || !context || !retained ||
        who.activity.identity_generation() != generation || who.pos_abs() != origin ) {
        return false;
    }
    endpoint.owner = retained->get_owner();
    return true;
}

bool confirm_vehicle_cable_endpoint( Character &who, map &here, vehicle_cable_endpoint &endpoint, link_state kind )
{
    const auto at = vehicle_cable_endpoint_at( here, endpoint.position, kind );
    if( !at || !matches_vehicle_cable_endpoint( *at, endpoint ) ) {
        return false;
    }
    const vehicle &veh = at->vehicle();
    if( veh.has_owner() && !veh.is_owned_by( who ) ) {
        endpoint.allow_theft = who.query_yn(
                                   _( "This vehicle belongs to: %s, there may be consequences if you are observed interacting with it, continue?" ),
                                   veh.get_owner_name() );
        return endpoint.allow_theft;
    }
    return true;
}

bool electrical_endpoint( link_state state )
{
    return state == link_state::vehicle_port || state == link_state::vehicle_battery;
}

link_state attached_vehicle_kind( link_state source, link_state target )
{
    if( source == link_state::vehicle_tow || target == link_state::vehicle_tow ) {
        return link_state::vehicle_tow;
    }
    return electrical_endpoint( target ) ? target : link_state::no_link;
}

link_state destination_vehicle_kind( const cable_link_selection &selection )
{
    if( selection.action == "tow" ) {
        return link_state::vehicle_tow;
    }
    return selection.to_ports ? link_state::vehicle_port : link_state::vehicle_battery;
}

link_state supply_kind( const std::string &action )
{
    if( action == "bionic" ) {
        return link_state::bio_cable;
    }
    if( action == "ups" ) {
        return link_state::ups;
    }
    if( action == "solarpack" ) {
        return link_state::solarpack;
    }
    return link_state::no_link;
}

std::optional<vpart_reference> current_vehicle_cable_endpoint( map &here, const item &cable )
{
    if( !cable.has_link_data() ) {
        return std::nullopt;
    }
    const item::link_data &state = cable.link();
    const link_state kind = attached_vehicle_kind( state.source, state.target );
    if( kind == link_state::no_link ) {
        return std::nullopt;
    }
    vehicle *target = state.t_veh.get();
    if( !target && here.inbounds( state.t_abs_pos ) ) {
        target = veh_pointer_or_null( here.veh_at( state.t_abs_pos ) );
    }
    if( !target ) {
        return std::nullopt;
    }
    const auto port = vehicle_cable_endpoint_at( here, target->mount_to_tripoint_abs( state.t_mount ),
                                    kind );
    if( !port || &port->vehicle() != target ||
        ( state.t_part_uid > 0 && port->part().get_base().uid().get_value() != state.t_part_uid ) ||
        state.last_processed <= port->part().last_disconnected ) {
        return std::nullopt;
    }
    return port;
}

vehicle_cable_endpoint describe_vehicle_cable_endpoint( const vpart_reference &port )
{
    return { port.pos_abs(), port.vehicle().uid().get_value(),
             port.part().get_base().uid().get_value(), port.vehicle().get_owner() };
}
} // namespace

void vehicle_cable_endpoint::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "position", position );
    out.member( "vehicle", vehicle_id );
    out.member( "part", part_id );
    out.member( "owner", owner );
    out.member( "allow_theft", allow_theft );
    out.end_object();
}

void vehicle_cable_endpoint::deserialize( const JsonObject &data )
{
    data.read( "position", position, true );
    data.read( "vehicle", vehicle_id, true );
    data.read( "part", part_id, true );
    data.read( "owner", owner, true );
    allow_theft = data.get_bool( "allow_theft", false );
}

void appliance_connection_selection::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "origin", origin );
    out.member( "source", source );
    out.member( "destination", destination );
    out.end_object();
}

void appliance_connection_selection::deserialize( const JsonObject &data )
{
    data.read( "origin", origin, true );
    data.read( "source", source, true );
    data.read( "destination", destination, true );
}

std::optional<appliance_connection_selection> query_appliance_connection( Character &who,
        map &here, vehicle &source, const point_rel_ms &mount )
{
    const character_action_guard actor( who );
    const auto context = here.get_context_reference();
    const auto source_ref = source.get_safe_reference();
    const tripoint_abs_ms origin = who.pos_abs();
    const tripoint_abs_ms source_pos = source.mount_to_tripoint_abs( mount );
    const auto port = vehicle_cable_endpoint_at( here, source_pos );
    if( !actor || who.get_moves() <= 0 || !source.is_appliance() || !port ||
        &port->vehicle() != &source || !reachable_vehicle_cable_endpoint( who, source_pos ) ) {
        return std::nullopt;
    }
    appliance_connection_selection selection;
    selection.origin = origin;
    selection.source = describe_vehicle_cable_endpoint( *port );
    const auto current = [&]() {
        return actor && context && source_ref && who.pos_abs() == origin;
    };
    const auto position = choose_adjacent_highlight( here, who.pos_bub( here ),
                          _( "Attach the cable where?" ), "", [&]( const tripoint_bub_ms & candidate ) {
        if( !current() ) {
            return false;
        }
        const auto destination = vehicle_cable_endpoint_at( here, here.get_abs( candidate ) );
        return destination && destination->vehicle().uid().get_value() != selection.source.vehicle_id;
    }, false, false );
    if( !position || !current() ) {
        return std::nullopt;
    }
    const auto port_at_destination = vehicle_cable_endpoint_at( here, here.get_abs( *position ) );
    if( !port_at_destination || &port_at_destination->vehicle() == source_ref.get() ) {
        return std::nullopt;
    }
    selection.destination = describe_vehicle_cable_endpoint( *port_at_destination );

    if( !confirm_vehicle_cable_endpoint( who, here, selection.source, link_state::vehicle_port ) || !current() ||
        !confirm_vehicle_cable_endpoint( who, here, selection.destination, link_state::vehicle_port ) || !current() ) {
        return std::nullopt;
    }
    return selection;
}

bool execute_appliance_connection( Character &who, map &here,
                                   const appliance_connection_selection &selection )
{
    const character_action_guard actor( who );
    if( !actor || who.activity || who.get_moves() <= 0 || who.pos_abs() != selection.origin ||
        selection.source.vehicle_id == selection.destination.vehicle_id ||
        !reachable_vehicle_cable_endpoint( who, selection.source.position ) ||
        !reachable_vehicle_cable_endpoint( who, selection.destination.position ) ) {
        return false;
    }
    vehicle_cable_endpoint from = selection.source;
    vehicle_cable_endpoint to = selection.destination;
    const auto source = resolve_vehicle_cable_endpoint( who, here, from );
    const auto destination = resolve_vehicle_cable_endpoint( who, here, to );
    if( !source || !destination || !source->vehicle().is_appliance() ) {
        return false;
    }
    static const itype_id power_cord( "power_cord" );
    const use_function *use = power_cord->get_use( "link_up" );
    const auto *link = use ? dynamic_cast<const link_up_actor *>( use->get_actor_ptr() ) : nullptr;
    if( !link || link->targets.count( link_state::vehicle_port ) == 0 ) {
        return false;
    }
    if( !authorize_vehicle_cable_endpoint( who, here, from, link_state::vehicle_port ) ||
        !authorize_vehicle_cable_endpoint( who, here, to, link_state::vehicle_port ) ) {
        return false;
    }
    const auto first = resolve_vehicle_cable_endpoint( who, here, from );
    const auto second = resolve_vehicle_cable_endpoint( who, here, to );
    if( !first || !second || !first->vehicle().is_appliance() ) {
        return false;
    }

    // The appliance supplies this built-in cord. No inventory item or client
    // cable payload is involved in plugging an appliance into a nearby port.
    item cord( power_cord );
    if( !cord.link_to( first->vehicle(), first->part().mount, link_state::vehicle_port ).success() ) {
        return false;
    }
    return link->attach_to_vehicle( who, cord, here, *second, true ) == 1;
}

void cable_link_selection::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "origin", origin );
    out.member( "action", action );
    out.member( "expected_source", expected_source );
    out.member( "expected_target", expected_target );
    out.member( "expected_part", expected_part );
    out.member( "expected_device", expected_device );
    out.member( "first", first );
    out.member( "destination", destination );
    out.member( "to_ports", to_ports );
    out.member( "to_towing", to_towing );
    out.member( "allow_spill", allow_spill );
    out.member( "device", device );
    out.end_object();
}

void cable_link_selection::deserialize( const JsonObject &data )
{
    data.read( "origin", origin, true );
    data.read( "action", action, true );
    data.read( "expected_source", expected_source, true );
    data.read( "expected_target", expected_target, true );
    data.read( "expected_part", expected_part, true );
    data.read( "expected_device", expected_device, true );
    data.read( "first", first );
    data.read( "destination", destination );
    data.read( "to_ports", to_ports, true );
    data.read( "to_towing", to_towing, true );
    allow_spill = data.get_bool( "allow_spill", false );
    data.read( "device", device );
}

std::optional<cable_link_selection> query_cable_link( Character &who, map &here,
        const item_location &location, const link_up_actor &link )
{
    if( !location ) {
        return std::nullopt;
    }
    const item &cable = *location;
    const character_action_guard actor( who );
    const auto context = here.get_context_reference();
    cable_link_selection selection;
    selection.origin = who.pos_abs();
    if( cable.has_link_data() ) {
        selection.expected_source = cable.link().source;
        selection.expected_target = cable.link().target;
        selection.expected_part = cable.link().t_part_uid;
        selection.expected_device = cable.link().s_item_uid;
    }
    if( const auto port = current_vehicle_cable_endpoint( here, cable ) ) {
        selection.first = describe_vehicle_cable_endpoint( *port );
    }
    const auto current = [&]() {
        return actor && context && location && who.pos_abs() == selection.origin;
    };
    const int action = link.query_link_action( who, cable );
    if( action < 0 || !current() ) {
        return std::nullopt;
    }
    if( action >= 998 ) {
        selection.action = "detach";
        return selection;
    }

    if( action == 31 ) {
        selection.action = "remove_extensions";
        return selection;
    }

    const link_state first_kind = attached_vehicle_kind( selection.expected_source,
                                 selection.expected_target );
    if( first_kind != link_state::no_link && !selection.first ) {
        who.add_msg_if_player( m_bad, _( "The first end of the cable is no longer connected." ) );
        return std::nullopt;
    }
    if( action >= 20 && action <= 22 ) {
        selection.action = action == 20 ? "bionic" : action == 21 ? "ups" : "solarpack";
        if( action != 20 ) {
            const item_location device = link.query_supply_device( who, supply_kind( selection.action ) );
            if( !current() || !device ) {
                return std::nullopt;
            }
            selection.device = capture_item_source( who, device );
        }
        if( selection.first &&
            ( !confirm_vehicle_cable_endpoint( who, here, *selection.first, first_kind ) || !current() ) ) {
            return std::nullopt;
        }
        return selection;
    }

    if( action == 30 ) {
        selection.action = "extend";
        const item_location extension = link.query_cable_extension( who, location );
        if( !current() || !extension ||
            !link.confirm_cable_extension( who, location, extension, selection.allow_spill ) ||
            !current() || !extension ) {
            return std::nullopt;
        }
        selection.device = capture_item_source( who, extension );
        if( selection.first &&
            ( !confirm_vehicle_cable_endpoint( who, here, *selection.first, first_kind ) || !current() ) ) {
            return std::nullopt;
        }
        return selection;
    }

    if( action == 10 || action == 11 ) {
        selection.action = "tow";
        selection.to_towing = action == 10;
    } else if( action == 0 || action == 1 ) {
        selection.to_ports = action == 0;
    } else {
        return std::nullopt;
    }
    const link_state kind = destination_vehicle_kind( selection );
    const std::string prompt = kind != link_state::vehicle_tow ? _( "Attach the cable where?" ) :
                               selection.to_towing ? _( "Attach cable to the vehicle that will do the towing." ) :
                               _( "Attach cable to the vehicle that will be towed." );
    const auto chosen = choose_adjacent_highlight( here, who.pos_bub( here ),
                        prompt, "", [&]( const tripoint_bub_ms & candidate ) {
        if( !current() ) {
            return false;
        }
        const auto port = vehicle_cable_endpoint_at( here, here.get_abs( candidate ), kind );
        return port && ( !selection.first ||
                         port->vehicle().uid().get_value() != selection.first->vehicle_id );
    }, false, false );
    if( !chosen || !current() ) {
        return std::nullopt;
    }
    const auto port = vehicle_cable_endpoint_at( here, here.get_abs( *chosen ), kind );
    if( !port ) {
        return std::nullopt;
    }
    selection.destination = describe_vehicle_cable_endpoint( *port );
    if( selection.first &&
        ( !confirm_vehicle_cable_endpoint( who, here, *selection.first, first_kind ) || !current() ) ) {
        return std::nullopt;
    }
    if( !confirm_vehicle_cable_endpoint( who, here, *selection.destination, kind ) || !current() ) {
        return std::nullopt;
    }
    return selection;
}

bool valid_cable_link( Character &who, map &here, const item &cable, const link_up_actor &link,
                      const cable_link_selection &selection )
{
    if( who.is_dead_state() || who.activity || who.pos_abs() != selection.origin ) {
        return false;
    }
    const link_state source = cable.has_link_data() ? cable.link().source : link_state::no_link;
    const link_state target = cable.has_link_data() ? cable.link().target : link_state::no_link;
    const int64_t part_id = cable.has_link_data() ? cable.link().t_part_uid : 0;
    const int64_t device_id = cable.has_link_data() ? cable.link().s_item_uid : 0;
    if( source != selection.expected_source || target != selection.expected_target ||
        part_id != selection.expected_part || device_id != selection.expected_device ) {
        return false;
    }
    const auto first = current_vehicle_cable_endpoint( here, cable );
    if( first.has_value() != selection.first.has_value() ||
        ( first && !matches_vehicle_cable_endpoint( *first, *selection.first ) ) ) {
        return false;
    }
    if( selection.action == "detach" ) {
        return !selection.destination && !selection.device && !cable.has_no_links() &&
               link.targets.count( link_state::no_link );
    }
    if( selection.action == "remove_extensions" ) {
        return !selection.destination && !selection.device && cable.link_length() != -1 &&
               !cable.cables().empty();
    }

    const link_state first_kind = attached_vehicle_kind( source, target );
    if( first_kind != link_state::no_link &&
        ( !first || !resolve_vehicle_cable_endpoint( who, here, *selection.first, first_kind ) ) ) {
        return false;
    }
    if( selection.action == "extend" ) {
        if( selection.destination || !selection.device || selection.device->kind != "carried" ) {
            return false;
        }
        const item_location device = resolve_item_source( who, here, *selection.device );
        return device && device->is_owned_by( who, true ) && link.compatible_extension( cable, *device );
    }

    const link_state supply = supply_kind( selection.action );
    if( supply != link_state::no_link ) {
        const bool needs_device = supply != link_state::bio_cable;
        if( selection.destination || selection.device.has_value() != needs_device ) {
            return false;
        }
        const item_location device = selection.device ?
                                     resolve_item_source( who, here, *selection.device ) : item_location();
        return link.can_attach_supply( who, cable, supply, device );
    }

    if( !selection.destination || selection.device ||
        ( selection.action != "attach" && selection.action != "tow" ) ) {
        return false;
    }
    const bool spool = cable.has_flag( flag_CABLE_SPOOL );
    const bool loose = spool ? cable.link_has_state( link_state::no_link ) : cable.has_no_links();
    const auto &destination = *selection.destination;
    const link_state kind = destination_vehicle_kind( selection );
    if( !loose || cable.link_length() == -1 || !link.targets.count( kind ) ||
        !reachable_vehicle_cable_endpoint( who, destination.position ) ||
        !resolve_vehicle_cable_endpoint( who, here, destination, kind ) ) {
        return false;
    }
    if( first && ( selection.first->vehicle_id == destination.vehicle_id ||
                   rl_dist( selection.first->position, destination.position ) > cable.max_link_length() ) ) {
        return false;
    }
    if( kind == link_state::vehicle_tow ) {
        return cable.has_no_links() ||
               ( first_kind == kind &&
                 cable.link_has_states( selection.to_towing ? link_state::no_link : link_state::vehicle_tow,
                                        selection.to_towing ? link_state::vehicle_tow : link_state::no_link ) );
    }
    return electrical_endpoint( first_kind ) || cable.has_no_links() ||
           cable.link_has_states( link_state::no_link, link_state::bio_cable );
}

std::optional<int> execute_cable_link( Character &who, map &here, item_location cable,
                                      const link_up_actor &link, const cable_link_selection &selection )
{
    if( !cable || !valid_cable_link( who, here, *cable, link, selection ) ) {
        return std::nullopt;
    }
    const link_state first_kind = attached_vehicle_kind( selection.expected_source,
                                 selection.expected_target );
    if( selection.action == "detach" ) {
        if( first_kind != link_state::no_link ) {
            const auto port = current_vehicle_cable_endpoint( here, *cable );
            cable->link().t_veh = port ? port->vehicle().get_safe_reference() : safe_reference<vehicle>();
        }
        link.detach_link( who, cable, true );
        return 0;
    }

    if( selection.action == "remove_extensions" ) {
        return link.remove_extensions( &who, *cable );
    }

    const character_action_guard actor( who );
    const auto context = here.get_context_reference();
    const auto cable_ref = cable->get_safe_reference();
    const item_source identity = capture_item_source( who, cable );
    auto authorized = selection;
    const auto current = [&]() {
        return actor && context && cable_ref && resolve_item_source( who, here, identity ) == cable;
    };
    const link_state kind = destination_vehicle_kind( selection );
    if( authorized.first &&
        ( !authorize_vehicle_cable_endpoint( who, here, *authorized.first, first_kind ) || !current() ) ) {
        return std::nullopt;
    }
    if( authorized.destination &&
        ( !authorize_vehicle_cable_endpoint( who, here, *authorized.destination, kind ) || !current() ) ) {
        return std::nullopt;
    }
    if( !valid_cable_link( who, here, *cable_ref, link, authorized ) ) {
        return std::nullopt;
    }
    if( const auto first = current_vehicle_cable_endpoint( here, *cable_ref ) ) {
        cable_ref->link().t_veh = first->vehicle().get_safe_reference();
        cable_ref->link().t_abs_pos = first->vehicle().pos_abs();
    }
    if( !authorized.destination ) {
        const item_location device = authorized.device ?
                                     resolve_item_source( who, here, *authorized.device ) : item_location();
        if( authorized.action == "extend" ) {
            return link.extend_cable( who, here, cable, device, authorized.allow_spill );
        }
        return link.attach_supply( who, *cable_ref, here, supply_kind( authorized.action ), device );
    }
    const auto target = resolve_vehicle_cable_endpoint( who, here, *authorized.destination, kind );
    if( !target ) {
        return std::nullopt;
    }
    if( kind == link_state::vehicle_tow ) {
        return link.attach_tow_cable( who, *cable_ref, here, *target, authorized.to_towing );
    }
    return link.attach_to_vehicle( who, *cable_ref, here, *target, authorized.to_ports );
}
