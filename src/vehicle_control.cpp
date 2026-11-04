#include "vehicle_control.h"

#include <charconv>
#include <cstdlib>
#include <string>
#include <system_error>

#include "character.h"
#include "character_action_guard.h"
#include "cata_scope_helpers.h"
#include "game.h"
#include "flag.h"
#include "item.h"
#include "item_location.h"
#include "json.h"
#include "player_activity.h"
#include "translations.h"
#include "map.h"
#include "line.h"
#include "npc.h"
#include "rng.h"
#include "math_parser_diag_value.h"
#include "vehicle.h"
#include "vpart_position.h"
#include "vpart_range.h"

namespace
{
constexpr const char *binding_uid = "remote_vehicle_uid";
constexpr const char *binding_position = "remote_vehicle_position";
constexpr const char *legacy_position = "remote_controlling_vehicle";

bool has_remote_controller( const Character &who )
{
    return who.has_active_bionic( bionic_id( "bio_remote" ) ) ||
           who.has_active_item( itype_id( "remotevehcontrol" ) );
}

bool connection_available( const Character &who, map &here, const vehicle &target )
{
    if( target.fuel_left( here, itype_id( "battery" ) ) <= 0 ) {
        return false;
    }
    for( const vpart_reference &part : target.get_avail_parts( "REMOTE_CONTROLS" ) ) {
        if( rl_dist( who.pos_abs(), part.pos_abs() ) <= 40 ) {
            return true;
        }
    }
    return false;
}

vehicle *bound_vehicle( const Character &who, map &here )
{
    if( const diag_value *value = who.maybe_get_value( binding_uid ) ) {
        const std::string &text = value->str();
        int64_t uid = 0;
        const auto parsed = std::from_chars( text.data(), text.data() + text.size(), uid );
        if( parsed.ec != std::errc() || parsed.ptr != text.data() + text.size() || uid <= 0 ) {
            return nullptr;
        }
        // The saved absolute position is only a lookup hint. Identity is always
        // checked, and movement can be resolved through the loaded vehicle set.
        if( const diag_value *position = who.maybe_get_value( binding_position ) ) {
            const tripoint_abs_ms at = position->tripoint();
            if( here.inbounds( at ) ) {
                const optional_vpart_position found = here.veh_at( at );
                if( found && found->vehicle().uid().get_value() == uid ) {
                    return &found->vehicle();
                }
            }
        }
        return vehicle::find_vehicle_by_uid( here, uid );
    }
    if( const diag_value *legacy = who.maybe_get_value( legacy_position ) ) {
        // Old saves stored bubble coordinates under an absolute-coordinate type.
        // Read that format once, then the mutable accessor records the real UID.
        const tripoint_bub_ms at( legacy->tripoint().raw() );
        return here.inbounds( at ) ? veh_pointer_or_null( here.veh_at( at ) ) : nullptr;
    }
    return nullptr;
}
} // namespace

vehicle *resolve_remote_vehicle( const Character &who, map &here )
{
    if( ( !who.maybe_get_value( binding_uid ) && !who.maybe_get_value( legacy_position ) ) ||
        !has_remote_controller( who ) ) {
        return nullptr;
    }
    vehicle *target = bound_vehicle( who, here );
    return target && connection_available( who, here, *target ) ? target : nullptr;
}

bool set_remote_vehicle( Character &who, map &here, vehicle *target )
{
    if( !target || !has_remote_controller( who ) || !connection_available( who, here, *target ) ) {
        who.remove_value( binding_uid );
        who.remove_value( binding_position );
        who.remove_value( legacy_position );
        return target == nullptr;
    }
    who.set_value( binding_uid, std::to_string( target->uid().get_value() ) );
    who.set_value( binding_position, target->pos_abs() );
    who.remove_value( legacy_position );
    return true;
}

vehicle *get_remote_vehicle( Character &who, map &here )
{
    vehicle *target = resolve_remote_vehicle( who, here );
    if( target ) {
        const diag_value *hint = who.maybe_get_value( binding_position );
        if( !who.maybe_get_value( binding_uid ) || !hint || hint->tripoint() != target->pos_abs() ) {
            set_remote_vehicle( who, here, target );
        }
    } else if( who.maybe_get_value( binding_uid ) || who.maybe_get_value( legacy_position ) ) {
        set_remote_vehicle( who, here, nullptr );
    }
    return target;
}

Character *vehicle_operator( const vehicle &target, map &here )
{
    if( Character *driver = target.get_driver( here ) ) {
        if( !driver->is_dead_state() ) {
            return driver;
        }
    }
    // Most parked vehicles cannot be remotely controlled. Do not walk the
    // character list (or anyone's inventory) for those vehicles.
    if( empty( target.get_avail_parts( "REMOTE_CONTROLS" ) ) ) {
        return nullptr;
    }
    Character &avatar = get_player_character();
    if( !avatar.is_dead_state() && resolve_remote_vehicle( avatar, here ) == &target ) {
        return &avatar;
    }
    for( npc &candidate : g->all_npcs() ) {
        if( !candidate.is_dead_state() && resolve_remote_vehicle( candidate, here ) == &target ) {
            return &candidate;
        }
    }
    return nullptr;
}

vehicle *controlled_vehicle( const Character &who, map &here )
{
    if( who.is_dead_state() ) {
        return nullptr;
    }
    vehicle *target = resolve_remote_vehicle( who, here );
    if( !target ) {
        target = veh_pointer_or_null( here.veh_at( who.pos_bub() ) );
    }
    return target && vehicle_operator( *target, here ) == &who ? target : nullptr;
}

bool drive_vehicle( Character &who, map &here, const tripoint_rel_ms &input )
{
    if( input.x() < -1 || input.x() > 1 || input.y() < -1 || input.y() > 1 ||
        input.z() < -1 || input.z() > 1 || input == tripoint_rel_ms::zero ||
        ( input.z() != 0 && ( input.x() != 0 || input.y() != 0 ) ) ) {
        return false;
    }
    vehicle *target = controlled_vehicle( who, here );
    if( !target ) {
        who.controlling_vehicle = false;
        who.add_msg_if_player( m_info, _( "You cannot operate these vehicle controls right now." ) );
        return false;
    }
    if( target->is_on_ramp && input.x() != 0 ) {
        who.add_msg_if_player( m_bad, _( "You can't turn the vehicle while on a ramp." ) );
        return false;
    }
    if( input.z() != 0 ) {
        if( !target->can_control_in_air( who ) ) {
            who.add_msg_if_player( m_info, _( "You have no idea how to make the vehicle fly." ) );
            return false;
        }
        if( !target->is_flyable() ) {
            who.add_msg_if_player( m_info, _( "This vehicle doesn't look very airworthy." ) );
            return false;
        }
        if( input.z() < 0 ) {
            if( !target->check_heli_descend( here, who ) ) {
                return false;
            }
            who.add_msg_if_player( m_info, _( "You steer the vehicle into a descent." ) );
        } else {
            if( !target->check_heli_ascend( here, who ) ) {
                return false;
            }
            who.add_msg_if_player( m_info, _( "You steer the vehicle into an ascent." ) );
        }
    }
    if( !target->is_flying_in_air() && !target->can_control_on_land( who ) ) {
        who.add_msg_if_player( m_info, _( "You have no idea how to make the vehicle move." ) );
        return false;
    }
    const character_action_guard lifetime( who );
    target->pldrive( here, who, input.x(), input.y(), input.z() );
    return true;
}

bool adjust_vehicle_cruise( Character &who, map &here, int direction )
{
    if( direction < -1 || direction > 1 ) {
        return false;
    }
    vehicle *target = controlled_vehicle( who, here );
    if( !target || ( !target->is_flying_in_air() && !target->can_control_on_land( who ) ) ) {
        return false;
    }
    target->cruise_thrust( here, -direction * 400 );
    return true;
}

bool brake_vehicle( Character &who, map &here )
{
    vehicle *target = controlled_vehicle( who, here );
    if( !target ) {
        return false;
    }
    who.add_msg_player_or_npc( _( "You pull a handbrake." ), _( "<npcname> pulls a handbrake." ) );
    target->cruise_velocity = 0;
    if( target->last_turn != 0_degrees && rng( 15, 60 ) * 100 < std::abs( target->velocity ) ) {
        target->skidding = true;
        who.add_msg_player_or_npc( m_warning, _( "You lose control of %s." ),
                                   _( "<npcname> loses control of %s." ), target->name );
        target->turn( target->last_turn > 0_degrees ? 60_degrees : -60_degrees );
    } else {
        const int braking_power = std::abs( target->velocity ) / 2 + 1000;
        if( std::abs( target->velocity ) < braking_power ) {
            target->stop( here );
        } else {
            const int sign = target->velocity > 0 ? 1 : -1;
            target->velocity = sign * ( std::abs( target->velocity ) - braking_power );
        }
    }
    who.set_moves( 0 );
    return true;
}

void vehicle_control_selection::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "vehicle", vehicle_id );
    out.member( "position", position );
    out.member( "action", action );
    out.member( "allow_theft", allow_theft );
    out.member( "weapon", weapon_id );
    if( unwield ) {
        out.member( "unwield" );
        out.start_object();
        out.member( "action", unwield->action );
        out.member( "container", unwield->container );
        out.member( "pocket", unwield->pocket );
        out.end_object();
    }
    out.end_object();
}

void vehicle_control_selection::deserialize( const JsonObject &data )
{
    data.read( "vehicle", vehicle_id, true );
    data.read( "position", position, true );
    data.read( "action", action, true );
    data.read( "allow_theft", allow_theft );
    data.read( "weapon", weapon_id );
    unwield.reset();
    if( data.has_object( "unwield" ) ) {
        const JsonObject choice = data.get_object( "unwield" );
        unwield = item_disposition{ choice.get_string( "action" ), choice.get_int64( "container" ),
                                    choice.get_int64( "pocket" ) };
    }
}

bool vehicle_control_accessible( const Character &who, map &here, const vehicle &target,
                                 const tripoint_abs_ms &position, const std::string &action )
{
    if( who.is_dead_state() || !here.inbounds( position ) ) {
        return false;
    }
    const optional_vpart_position at = here.veh_at( position );
    if( !at || &at->vehicle() != &target ) {
        return false;
    }
    const bool releasing = action == "release";
    const bool stopping = action == "stop" || action == "stop_driving";
    const bool taking = action == "take";
    if( !releasing && !stopping && !taking && action != "start" ) {
        return false;
    }
    if( releasing ) {
        return target.player_in_control( here, who );
    }
    if( target.is_locked || ( action == "stop_driving" && !target.player_in_control( here, who ) ) ) {
        return false;
    }
    if( resolve_remote_vehicle( who, here ) != &target ) {
        if( rl_dist( who.pos_abs(), position ) > 1 || who.pos_abs().z() != position.z() ||
            ( taking && who.pos_abs() != position ) ) {
            return false;
        }
        const bool controls = target.avail_part_with_feature( at->mount_pos(), "CONTROLS" ) >= 0;
        const bool reins = target.avail_part_with_feature( at->mount_pos(), "CONTROL_ANIMAL" ) >= 0 &&
                           target.has_engine_type( itype_id( "animal" ), false ) && target.get_harnessed_animal( here );
        if( !controls && !reins ) {
            return false;
        }
    }
    // A second player may reach another control tile on the same vehicle.
    // Seated and remote drivers both participate in the same ownership check.
    return g->get_creatures_if( [&]( const Creature & creature ) {
        const Character *other = creature.as_character();
        return other && other != &who && target.player_in_control( here, *other );
    } ).empty();
}

std::optional<vehicle_control_selection> query_vehicle_control( Character &who, map &here,
        vehicle &target, const tripoint_abs_ms &position, const std::string &action )
{
    if( !vehicle_control_accessible( who, here, target, position, action ) ) {
        who.add_msg_if_player( _( "You cannot operate these vehicle controls right now." ) );
        return std::nullopt;
    }
    vehicle_control_selection selection;
    selection.vehicle_id = target.uid().get_value();
    selection.position = position;
    selection.action = action;
    if( action == "take" && target.has_owner() && !target.is_owned_by( who ) ) {
        selection.allow_theft = who.query_yn(
                                    _( "This vehicle belongs to: %s, there may be consequences if you are observed interacting with it, continue?" ),
                                    target.get_owner_name() );
        if( !selection.allow_theft ) {
            return std::nullopt;
        }
    }
    const item_location weapon = who.get_wielded_item();
    if( action == "take" && weapon ) {
        if( who.worn_with_flag( flag_RESTRICT_HANDS ) ) {
            who.add_msg_if_player( _( "Something you are wearing hinders the use of both hands." ) );
            return std::nullopt;
        }
        if( !who.has_two_arms_lifting() || weapon->is_two_handed( who ) ) {
            selection.weapon_id = weapon->uid().get_value();
            selection.unwield = query_item_disposition( who, weapon,
                                _( "Put your weapon away to use the vehicle controls?" ) );
            if( !selection.unwield ) {
                return std::nullopt;
            }
        }
    }
    return selection;
}

bool execute_vehicle_control( Character &who, map &here,
                              const vehicle_control_selection &selection )
{
    vehicle *target = vehicle::find_vehicle_by_uid( here, selection.vehicle_id );
    if( !target || who.activity || who.get_moves() <= 0 ||
        !vehicle_control_accessible( who, here, *target, selection.position, selection.action ) ) {
        return false;
    }
    const bool taking = selection.action == "take";
    if( taking && target->has_owner() && !target->is_owned_by( who ) && !selection.allow_theft ) {
        return false;
    }
    const character_action_guard lifetime( who );
    if( taking ) {
        const item_location weapon = who.get_wielded_item();
        if( weapon && who.worn_with_flag( flag_RESTRICT_HANDS ) ) {
            return false;
        }
        if( weapon && ( !who.has_two_arms_lifting() || weapon->is_two_handed( who ) ) ) {
            if( !selection.unwield || weapon->uid().get_value() != selection.weapon_id ||
                !execute_item_disposition( who, weapon, *selection.unwield ) ) {
                return false;
            }
            if( !lifetime || who.activity || who.get_wielded_item() ) {
                return false;
            }
            target = vehicle::find_vehicle_by_uid( here, selection.vehicle_id );
            if( !target ||
                !vehicle_control_accessible( who, here, *target, selection.position, selection.action ) ) {
                return false;
            }
        }
        // Native theft consequences run once, after a real owner choice.
        if( !target->handle_potential_theft( who, false, false ) || !lifetime ) {
            return false;
        }
        target = vehicle::find_vehicle_by_uid( here, selection.vehicle_id );
        if( !target || who.activity ||
            !vehicle_control_accessible( who, here, *target, selection.position, selection.action ) ) {
            return false;
        }
    }
    if( selection.action == "release" || selection.action == "stop_driving" ) {
        if( selection.action == "stop_driving" ) {
            target->disable_smart_controller_if_needed();
            target->stop_engines( here );
        }
        who.controlling_vehicle = false;
        if( resolve_remote_vehicle( who, here ) == target ) {
            set_remote_vehicle( who, here, nullptr );
        }
        // Letting go does not make the seated player exit the vehicle.
        who.add_msg_if_player( _( "You let go of the controls." ) );
        return true;
    }
    if( selection.action == "stop" ) {
        target->disable_smart_controller_if_needed();
        target->stop_engines( here );
        who.add_msg_if_player( _( "You turn the engine off." ) );
        return true;
    }
    if( taking ) {
        if( resolve_remote_vehicle( who, here ) != target ) {
            const optional_vpart_position seat = here.veh_at( who.pos_bub() );
            if( seat && seat->part_with_feature( VPFLAG_BOARDABLE, false ) ) {
                here.board_vehicle( who.pos_bub(), &who );
            }
        }
        if( target->engine_on ) {
            who.controlling_vehicle = true;
            who.add_msg_if_player( _( "You take control of the %s." ), target->name );
        }
        target->is_following = false;
        target->is_patrolling = false;
        target->autopilot_on = false;
        target->is_autodriving = false;
    }
    if( !target->engine_on ) {
        target->start_engines( here, &who, taking );
    }
    return true;
}
