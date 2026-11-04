#include "vehicle_control.h"

#include <algorithm>
#include <set>
#include <charconv>
#include <cstdlib>
#include <string>
#include <system_error>

#include "character.h"
#include "clzones.h"
#include "faction.h"
#include "mp_client_conn.h"
#include "debug.h"
#include "activity_actor_definitions.h"
#include "temp_crafting_inventory.h"
#include "skill.h"
#include "itype.h"
#include "input_context.h"
#include "input_enums.h"
#include "uilist.h"
#include "veh_type.h"
#include "character_action_guard.h"
#include "cata_scope_helpers.h"
#include "game.h"
#include "game_constants.h"
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

bool autopilot_action( const std::string &action )
{
    return action == "autopilot_follow" || action == "autopilot_patrol" ||
           action == "autopilot_stop" || action == "precollision_on" || action == "precollision_off";
}

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

void write_remote_vehicle_binding( const Character &who, map &here, JsonOut &out )
{
    const vehicle *target = resolve_remote_vehicle( who, here );
    out.start_object();
    out.member( "uid", target ? target->uid().get_value() : 0 );
    if( target ) {
        out.member( "position", target->pos_abs() );
    }
    out.end_object();
}

void apply_remote_vehicle_binding( Character &who, const JsonObject &view )
{
    const int64_t uid = view.get_int64( "uid" );
    tripoint_abs_ms position;
    who.remove_value( legacy_position );
    if( uid > 0 && view.read( "position", position ) ) {
        who.set_value( binding_uid, std::to_string( uid ) );
        who.set_value( binding_position, position );
    } else {
        who.remove_value( binding_uid );
        who.remove_value( binding_position );
    }
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

void vehicle_engine_selection::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "part", part_id );
    out.member( "fuel", fuel );
    out.member( "enabled", enabled );
    out.end_object();
}

void vehicle_engine_selection::deserialize( const JsonObject &data )
{
    data.read( "part", part_id, true );
    data.read( "fuel", fuel, true );
    data.read( "enabled", enabled, true );
}

void vehicle_control_selection::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "vehicle", vehicle_id );
    out.member( "position", position );
    out.member( "action", action );
    out.member( "allow_theft", allow_theft );
    out.member( "weapon", weapon_id );
    out.member( "engines", engines );
    if( electronics ) {
        out.member( "electronics", *electronics );
    }
    if( appliance ) {
        out.member( "appliance", *appliance );
    }
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
    data.read( "engines", engines );
    electronics.reset();
    data.read( "electronics", electronics );
    appliance.reset();
    data.read( "appliance", appliance );
    unwield.reset();
    if( data.has_object( "unwield" ) ) {
        const JsonObject choice = data.get_object( "unwield" );
        unwield = item_disposition{ choice.get_string( "action" ), choice.get_int64( "container" ),
                                    choice.get_int64( "pocket" ) };
    }
}

bool remote_vehicle_accessible( const Character &who, map &here, const vehicle &target,
                                const item_location &controller )
{
    if( who.is_dead_state() || !controller || !controller.held_by( who ) || controller->is_broken() ||
        !controller->type->can_use( "REMOTEVEH" ) || !controller->ammo_sufficient( &who, "REMOTEVEH" ) ||
        !here.inbounds( target.pos_abs() ) || rl_dist( who.pos_abs(), target.pos_abs() ) >= 40 ||
        target.fuel_left( here, itype_id( "battery" ) ) <= 0 ||
        ( empty( target.get_avail_parts( "REMOTE_CONTROLS" ) ) &&
          empty( target.get_avail_parts( "CTRL_ELECTRONIC" ) ) ) ) {
        return false;
    }
    return g->get_creatures_if( [&]( const Creature & creature ) {
        const Character *other = creature.as_character();
        return other && other != &who && target.player_in_control( here, *other );
    } ).empty();
}

bool vehicle_control_accessible( const Character &who, map &here, const vehicle &target,
                                 const tripoint_abs_ms &position, const std::string &action,
                                 const item_location *remote_source )
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
    const bool hotwire = action == "hotwire";
    const bool alarm = action == "alarm";
    const bool smash_alarm = action == "smash_alarm";
    const bool security = hotwire || alarm || smash_alarm;
    const bool electronics = action == "electronics";
    const bool appliance = action == "appliance";
    if( remote_source &&
        ( !remote_vehicle_accessible( who, here, target, *remote_source ) || security ||
          taking || releasing || appliance || action == "stop_driving" ) ) {
        return false;
    }
    if( !releasing && !stopping && !taking && action != "start" &&
        action != "engines" && !security && !electronics && !appliance && !autopilot_action( action ) ) {
        return false;
    }
    if( releasing ) {
        return target.player_in_control( here, who );
    }
    if( ( target.is_locked && !security ) ||
        ( action == "stop_driving" && !target.player_in_control( here, who ) ) ) {
        return false;
    }
    if( appliance ) {
        // Operating a nearby machine does not acquire or require driving control.
        // A radio connection cannot supply detergent or reach the machine's cargo.
        return who.pos_abs().z() == position.z() && rl_dist( who.pos_abs(), position ) <= 1 &&
               has_vehicle_appliance( target, position );
    }
    if( autopilot_action( action ) && action != "autopilot_stop" &&
        ( empty( target.get_avail_parts( "AUTOPILOT" ) ) ||
          empty( target.get_avail_parts( "CTRL_ELECTRONIC" ) ) ) ) {
        return false;
    }
    if( security || ( !remote_source && resolve_remote_vehicle( who, here ) != &target ) ) {
        if( rl_dist( who.pos_abs(), position ) > 1 || who.pos_abs().z() != position.z() ||
            ( taking && who.pos_abs() != position ) ) {
            return false;
        }
        const bool controls = target.avail_part_with_feature( at->mount_pos(), "CONTROLS" ) >= 0;
        const bool reins = target.avail_part_with_feature( at->mount_pos(), "CONTROL_ANIMAL" ) >= 0 &&
                           target.has_engine_type( itype_id( "animal" ), false ) && target.get_harnessed_animal( here );
        if( electronics ? ( !target.is_appliance() &&
                            target.avail_part_with_feature( at->mount_pos(), "CTRL_ELECTRONIC" ) < 0 &&
                            target.avail_part_with_feature( at->mount_pos(), "REMOTE_CONTROLS" ) < 0 ) :
            ( !controls && ( security || !reins ) ) ) {
            return false;
        }
        if( autopilot_action( action ) && action != "autopilot_stop" &&
            target.avail_part_with_feature( at->mount_pos(), "CTRL_ELECTRONIC" ) < 0 ) {
            return false;
        }
    }
    if( security ) {
        const optional_vpart_position inside = here.veh_at( who.pos_bub() );
        if( ( hotwire || smash_alarm ) && ( !inside || &inside->vehicle() != &target ||
                                            target.is_moving() ) ) {
            return false;
        }
        if( hotwire || alarm ) {
            bool immobilizer = false;
            for( const vpart_reference &part : target.get_all_parts() ) {
                if( part.pos_abs() == position && part.part().is_available() &&
                    part.part().has_fault_flag( "IMMOBILIZER" ) ) {
                    immobilizer = true;
                }
            }
            if( ( !target.is_locked && !immobilizer ) ||
                ( hotwire && !who.crafting_inventory( &here ).has_quality( quality_id( "SCREW" ) ) ) ) {
                return false;
            }
        }
        if( !hotwire && ( !target.has_security_working( here ) ||
                          ( alarm ? target.is_alarm_on : !target.is_alarm_on ) ) ) {
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
        vehicle &target, const tripoint_abs_ms &position, const std::string &action,
        const item_location *remote_source )
{
    if( !vehicle_control_accessible( who, here, target, position, action, remote_source ) ) {
        who.add_msg_if_player( _( "You cannot operate these vehicle controls right now." ) );
        return std::nullopt;
    }
    vehicle_control_selection selection;
    selection.vehicle_id = target.uid().get_value();
    selection.position = position;
    selection.action = action;
    const bool theft_check = action == "take" || action == "engines" || action == "hotwire" ||
                             action == "alarm" || action == "smash_alarm" || action == "electronics" || action == "appliance" ||
                             autopilot_action( action );
    if( theft_check && target.has_owner() && !target.is_owned_by( who ) ) {
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

std::optional<vehicle_control_selection> query_vehicle_engines( Character &who, map &here,
        vehicle &target, const tripoint_abs_ms &position, const item_location *remote_source )
{
    auto selection = query_vehicle_control( who, here, target, position, "engines", remote_source );
    if( !selection ) {
        return std::nullopt;
    }
    std::vector<vehicle_engine_selection> choices;
    for( const int index : target.engines ) {
        const vehicle_part &part = target.part( index );
        choices.push_back( { part.get_base().uid().get_value(), part.fuel_current().str(), part.enabled } );
    }
    bool changed = false;
    while( true ) {
        uilist menu;
        menu.title = _( "Toggle which?" );
        menu.addentry( 0, true, 'q', _( "Finish engine configuration" ) );
        std::vector<std::pair<size_t, itype_id>> options;
        for( size_t i = 0; i < choices.size(); ++i ) {
            const vehicle_part &part = target.part( target.engines[i] );
            for( const itype_id &fuel : part.info().engine_info->fuel_opts ) {
                const bool active = choices[i].enabled && choices[i].fuel == fuel.str();
                options.emplace_back( i, fuel );
                menu.addentry( options.size(), part.is_available() &&
                               ( active || target.is_perpetual_type( part ) || target.fuel_left( here, fuel ) ),
                               MENU_AUTOASSIGN, string_format( "[%s] %s %s", active ? "x" : " ",
                                       part.name(), fuel->nname( 1 ) ) );
            }
        }
        menu.query();
        if( menu.ret <= 0 || static_cast<size_t>( menu.ret ) > options.size() ) {
            break;
        }
        const auto &option = options[menu.ret - 1];
        vehicle_engine_selection &choice = choices[option.first];
        if( choice.fuel == option.second.str() ) {
            choice.enabled = !choice.enabled;
        } else {
            choice.fuel = option.second.str();
        }
        changed = true;
    }
    if( !changed ) {
        return std::nullopt;
    }
    // Send only changed parts. No preview mutates the vehicle or starts engines.
    for( size_t i = 0; i < choices.size(); ++i ) {
        const vehicle_part &part = target.part( target.engines[i] );
        if( choices[i].enabled != part.enabled || choices[i].fuel != part.fuel_current().str() ) {
            selection->engines.push_back( choices[i] );
        }
    }
    return selection;
}

std::optional<vehicle_control_selection> query_owned_vehicle_menu( Character &who, map &here,
        vehicle &target, const tripoint_abs_ms &position, const item_location *remote_source )
{
    uilist menu;
    menu.title = _( "Vehicle controls" );
    const std::vector<std::pair<std::string, std::string>> options = {
        { "take", _( "Take control" ) },
        { "release", _( "Let go of controls" ) },
        { "stop_driving", _( "Stop driving" ) },
        {
            target.engine_on ? "stop" : "start", target.engine_on ?
            _( "Turn off the engine" ) : _( "Turn on the engine" )
        },
        { "engines", _( "Control individual engines" ) },
        { "hotwire", _( "Hotwire" ) },
        { "alarm", _( "Trigger the alarm" ) },
        { "smash_alarm", _( "Try to smash alarm" ) },
        { "autopilot", _( "Control autopilot" ) },
        { "electronics", _( "Vehicle electronics" ) },
        { "appliance", _( "Use installed appliance" ) }
    };
    for( size_t i = 0; i < options.size(); ++i ) {
        const auto &action = options[i].first;
        const bool autopilot = action == "autopilot";
        menu.addentry( i, ( !autopilot || target.has_part( "AUTOPILOT" ) || target.autopilot_on ) &&
                       vehicle_control_accessible( who, here, target, position,
                               autopilot ? "autopilot_stop" : action, remote_source ),
                       MENU_AUTOASSIGN, options[i].second );
    }
    menu.query();
    if( menu.ret < 0 || static_cast<size_t>( menu.ret ) >= options.size() ) {
        return std::nullopt;
    }
    const std::string &action = options[menu.ret].first;
    return action == "autopilot" ? query_vehicle_autopilot( who, here, target,
            position, remote_source ) :
           action == "engines" ? query_vehicle_engines( who, here, target, position, remote_source ) :
           action == "electronics" ? query_vehicle_electronics( who, here, target, position, remote_source ) :
           action == "appliance" ? query_vehicle_appliance( who, here, target, position ) :
           query_vehicle_control( who, here, target, position, action, remote_source );
}

std::optional<vehicle_control_selection> query_vehicle_autopilot( Character &who, map &here,
        vehicle &target, const tripoint_abs_ms &position, const item_location *remote_source )
{
    uilist menu;
    menu.title = _( "Choose action for the autopilot" );
    menu.input_category = "VEHICLE";
    menu.hilight_disabled = true;
    menu.desc_enabled = true;
    const auto add_choice = [&]( const std::string & binding, const std::string & label,
    const std::string & description ) {
        const auto keys = input_context( "VEHICLE" ).keys_bound_to( binding, 1 );
        menu.additional_actions.emplace_back( binding, translation() );
        menu.entries.emplace_back( static_cast<int>( menu.entries.size() ), !target.is_locked,
                                   keys.empty() ? input_event() : keys.front(), label, description );
        if( target.is_locked ) {
            menu.entries.back().desc += "\n" + std::string( _( "Vehicle is locked." ) );
        }
    };
    add_choice( "CONTROL_AUTOPILOT_PATROL", _( "Patrol…" ),
                _( "Program the autopilot to patrol a nearby vehicle patrol zone.  If no zones are nearby, you will be prompted to create one." ) );
    add_choice( "CONTROL_AUTOPILOT_FOLLOW", _( "Follow…" ),
                _( "Program the autopilot to follow you.  It might be a good idea to have a remote control available to tell it to stop, too." ) );
    add_choice( "CONTROL_AUTOPILOT_STOP", _( "Stop…" ),
                _( "Stop all autopilot related activities." ) );
    add_choice( "CONTROL_AUTOPILOT_CAS", target.precollision_on ?
                _( "Disable pre-collision system" ) : _( "Enable pre-collision system" ),
                _( "Toggle pre-collision system" ) );
    menu.query();
    const int selected = menu.ret;
    if( selected < 0 ) {
        return std::nullopt;
    }
    if( selected == 0 && !cata_mp::is_client_mode() &&
        !zone_manager::get_manager().has_near( zone_type_id( "VEHICLE_PATROL" ), target.pos_abs(),
                MAX_VIEW_DISTANCE, who.get_faction()->id ) ) {
        // Preserve the local zone editor. A remote request uses server zones;
        // it must never open the host's editor while processing an action.
        zone_manager_ui::display_zone_manager();
        return std::nullopt;
    }
    const std::string action = selected == 0 ? "autopilot_patrol" :
                               selected == 1 ? "autopilot_follow" : selected == 2 ? "autopilot_stop" :
                               target.precollision_on ? "precollision_off" : "precollision_on";
    return query_vehicle_control( who, here, target, position, action, remote_source );
}

namespace
{
void smash_vehicle_alarm( Character &player_character, map &here, vehicle &target )
{
    int idx_security = -1;
    int idx_controls = -1;
    for( const int p : target.speciality ) { //get security and controls location
        const vehicle_part &vp = target.part( p );
        if( vp.info().has_flag( "SECURITY" ) && !vp.is_broken() ) {
            idx_security = p;
            idx_controls = target.part_with_feature( vp.mount, "CONTROLS", true );
            break;
        }
    }
    if( idx_controls < 0 || idx_security < 0 ) {
        debugmsg( "No security system found on vehicle." );
        return; // both must be valid parts
    }
    vehicle_part &vp_controls = target.part( idx_controls );
    vehicle_part &vp_security = target.part( idx_security );
    ///\EFFECT_MECHANICS reduces chance of damaging controls when smashing security system
    const float skill = player_character.get_skill_level( skill_id( "mechanics" ) );
    const int percent_controls = 70 / ( 1 + skill );
    const int percent_alarm = ( skill + 3 ) * 10;
    const int rand = rng( 1, 100 );

    if( percent_controls > rand ) {
        target.damage_direct( here, vp_controls, vp_controls.info().durability / 4 );

        if( vp_controls.removed || vp_controls.is_broken() ) {
            player_character.controlling_vehicle = false;
            target.is_alarm_on = false;
            player_character.add_msg_if_player( _( "You destroy the controls…" ) );
        } else {
            player_character.add_msg_if_player( _( "You damage the controls." ) );
        }
    }
    if( percent_alarm > rand ) {
        target.damage_direct( here, vp_security, vp_security.info().durability / 5 );
        // chance to disable alarm immediately, or disable on destruction
        if( percent_alarm / 4 > rand || vp_security.is_broken() ) {
            target.is_alarm_on = false;
        }
    }
    player_character.add_msg_if_player( target.is_alarm_on ? _( "The alarm keeps going." ) :
                                        _( "The alarm stops." ) );
}
} // namespace

bool execute_vehicle_control( Character &who, map &here,
                              const vehicle_control_selection &selection, const item_location *remote_source )
{
    vehicle *target = vehicle::find_vehicle_by_uid( here, selection.vehicle_id );
    if( !target || who.activity || who.get_moves() <= 0 ||
        !vehicle_control_accessible( who, here, *target, selection.position, selection.action,
                                     remote_source ) ) {
        return false;
    }
    if( ( selection.action == "electronics" ) != selection.electronics.has_value() ||
        ( selection.electronics &&
          !valid_vehicle_electronics_selection( who, here, *target, *selection.electronics ) ) ) {
        return false;
    }
    if( ( selection.action == "appliance" ) != selection.appliance.has_value() ||
        ( selection.appliance && !valid_vehicle_appliance_selection( who, here, *target,
                selection.position, *selection.appliance ) ) ) {
        return false;
    }
    const bool taking = selection.action == "take";
    const bool theft_check = taking || selection.action == "engines" || selection.action == "hotwire" ||
                             selection.action == "alarm" || selection.action == "smash_alarm" ||
                             selection.action == "electronics" ||
                             selection.action == "appliance" ||
                             autopilot_action( selection.action );
    if( theft_check && target->has_owner() && !target->is_owned_by( who ) && !selection.allow_theft ) {
        return false;
    }
    const character_action_guard lifetime( who );
    const on_out_of_scope retain_remote_start( [&]() {
        if( lifetime && remote_source ) {
            auto *startup = dynamic_cast<start_engines_activity_actor *>( who.activity.actor.get() );
            if( startup ) {
                startup->allow_remote_start( who, *remote_source, selection.vehicle_id );
            }
        }
    } );
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
                !vehicle_control_accessible( who, here, *target, selection.position, selection.action,
                                             remote_source ) ) {
                return false;
            }
        }
    }
    if( theft_check ) {
        // Native theft consequences run once, after a real owner choice.
        if( !target->handle_potential_theft( who, false, false ) || !lifetime ) {
            return false;
        }
        target = vehicle::find_vehicle_by_uid( here, selection.vehicle_id );
        if( !target || who.activity ||
            !vehicle_control_accessible( who, here, *target, selection.position, selection.action,
                                         remote_source ) ) {
            return false;
        }
    }
    if( selection.electronics ) {
        return execute_vehicle_electronics( who, here, *target, *selection.electronics );
    }
    if( selection.appliance ) {
        return execute_vehicle_appliance( who, here, *target, selection.position, *selection.appliance );
    }
    if( selection.action == "autopilot_patrol" ) {
        if( !zone_manager::get_manager().has_near( zone_type_id( "VEHICLE_PATROL" ), target->pos_abs(),
                MAX_VIEW_DISTANCE, who.get_faction()->id ) ) {
            who.add_msg_if_player( _( "No vehicle patrol zone nearby." ) );
            return false;
        }
        target->enable_patrol( here, who );
        return true;
    }
    if( selection.action == "autopilot_follow" ) {
        target->stop_autodriving( false );
        target->autopilot_on = true;
        target->is_following = true;
        target->following_character = who.getID();
        target->is_patrolling = false;
        if( !target->engine_on ) {
            target->start_engines( here, &who );
        }
        return true;
    }
    if( selection.action == "autopilot_stop" ) {
        target->stop_autodriving();
        target->autopilot_on = false;
        target->following_character.reset();
        target->stop_engines( here );
        who.add_msg_if_player( _( "You turn the engine off." ) );
        return true;
    }
    if( selection.action == "precollision_on" || selection.action == "precollision_off" ) {
        target->precollision_on = selection.action == "precollision_on";
        who.add_msg_if_player( target->precollision_on ? _( "You turn on pre-collision system." ) :
                               _( "You turn off pre-collision system." ) );
        return true;
    }
    if( selection.action == "hotwire" ) {
        const float skill = std::max( 1.0f, who.get_skill_level( skill_id( "mechanics" ) ) );
        who.assign_activity( hotwire_car_activity_actor( to_moves<int>( 6000_seconds / skill ),
                             selection.position, selection.vehicle_id ) );
        return true;
    }
    if( selection.action == "alarm" ) {
        target->is_alarm_on = true;
        who.add_msg_if_player( _( "You trigger the alarm!" ) );
        return true;
    }
    if( selection.action == "smash_alarm" ) {
        smash_vehicle_alarm( who, here, *target );
        return true;
    }
    if( selection.action == "engines" ) {
        std::set<int64_t> seen;
        std::vector<std::pair<int, const vehicle_engine_selection *>> changes;
        for( const vehicle_engine_selection &choice : selection.engines ) {
            if( choice.part_id <= 0 || !seen.insert( choice.part_id ).second ) {
                return false;
            }
            const auto found = std::find_if( target->engines.begin(), target->engines.end(),
            [&]( int index ) {
                return target->part( index ).get_base().uid().get_value() == choice.part_id;
            } );
            if( found == target->engines.end() ) {
                return false;
            }
            const vehicle_part &part = target->part( *found );
            const itype_id fuel( choice.fuel );
            const auto &fuels = part.info().engine_info->fuel_opts;
            if( !part.is_available() || std::find( fuels.begin(), fuels.end(), fuel ) == fuels.end() ||
                ( choice.enabled && !target->is_perpetual_type( part ) && !target->fuel_left( here, fuel ) ) ) {
                return false;
            }
            if( part.enabled != choice.enabled || part.fuel_current() != fuel ) {
                changes.emplace_back( *found, &choice );
            }
        }
        if( changes.empty() ) {
            return true;
        }
        const bool was_running = target->engine_on;
        for( const auto &change : changes ) {
            vehicle_part &part = target->part( change.first );
            part.fuel_set( itype_id( change.second->fuel ) );
            part.enabled = change.second->enabled;
        }
        target->invalidate_mass();
        target->stop_engines( here );
        const int safe_speed = target->safe_velocity( here );
        if( target->velocity > safe_speed ) {
            target->cruise_velocity = safe_speed;
        }
        who.add_msg_if_player( was_running ?
                               _( "You turn off the %s's engines to change their configurations." ) :
                               _( "You change the %s's engine configuration." ), target->name );
        if( std::any_of( target->engines.begin(), target->engines.end(),
        [&]( int index ) {
        return target->part( index ).enabled;
        } ) ) {
            target->start_engines( here, &who );
        }
        return true;
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
        target->following_character.reset();
        target->is_patrolling = false;
        target->autopilot_on = false;
        target->is_autodriving = false;
    }
    if( !target->engine_on ) {
        target->start_engines( here, &who, taking );
    }
    return true;
}
