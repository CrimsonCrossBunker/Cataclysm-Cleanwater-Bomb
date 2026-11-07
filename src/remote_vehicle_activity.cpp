#include "remote_vehicle_activity.h"

#include <cmath>
#include <algorithm>
#include <climits>
#include <utility>
#include <vector>

#include "activity_actor_definitions.h"
#include "avatar.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "bionics.h"
#include "units.h"
#include "character_action_guard.h"
#include "game.h"
#include "flag.h"
#include "item.h"
#include "item_activation.h"
#include "itype.h"
#include "json.h"
#include "line.h"
#include "map.h"
#include "player_activity.h"
#include "rng.h"
#include "skill.h"
#include "translations.h"
#include "uilist.h"
#include "veh_utils.h"
#include "vehicle.h"
#include "vehicle_control.h"

namespace
{
bool reachable_vehicle( Character &who, map &here, const vehicle &target, bool one_action )
{
    return here.inbounds( target.pos_abs() ) && rl_dist( who.pos_abs(), target.pos_abs() ) < 40 &&
           target.fuel_left( here, itype_id( "battery" ) ) > 0 &&
           ( !empty( target.get_avail_parts( "REMOTE_CONTROLS" ) ) ||
             ( one_action && !empty( target.get_avail_parts( "CTRL_ELECTRONIC" ) ) ) );
}

bool settle_security( Character &who, item &controller, vehicle &target, int roll, bool advanced )
{
    const character_action_guard lifetime( who );
    const auto generation = who.activity.identity_generation();
    const int64_t target_id = target.uid().get_value();
    const bool carried = who.has_item( controller );
    const item_location source = carried ? item_location( who, &controller ) : item_location();
    int effort = 0;
    bool success = false;
    if( roll < -20 ) {
        effort = 1;
        who.add_msg_if_player( m_bad, _( "You trigger the alarm!" ) );
        target.is_alarm_on = true;
    } else if( roll >= 20 ) {
        effort = 1;
        who.add_msg_if_player( m_good, _( "You quickly bypass the security system!" ) );
        success = true;
    }
    who.practice( skill_id( "computer" ), advanced ? 10 : 3 );
    if( !lifetime || who.activity.identity_generation() != generation ||
        vehicle::find_vehicle_by_uid( get_map(), target_id ) != &target ||
        ( carried && ( !source || source.get_item() != &controller ) ) ) {
        return false;
    }
    if( roll < -10 ) {
        effort = rng( 4, 8 );
        who.add_msg_if_player( m_bad, _( "You waste some time, but fail to affect the security system." ) );
    } else if( roll < 0 ) {
        effort = 1;
        who.add_msg_if_player( m_bad, _( "You fail to affect the security system." ) );
    } else if( roll < 20 ) {
        effort = rng( 2, 8 );
        who.add_msg_if_player( m_mixed,
                               _( "You take some time, but manage to bypass the security system!" ) );
        success = true;
    }
    who.mod_moves( -to_moves<int>( time_duration::from_seconds( effort ) ) );
    controller.charges -= effort;
    if( success && advanced ) {
        target.is_locked = false;
    }
    return success;
}

struct security_scan {
    bool authorized = false;
    bool advanced = false;
    std::optional<int> roll;
};

security_scan scan_security( Character &who, item &controller, vehicle &target )
{
    security_scan result;
    result.advanced = !empty( target.get_avail_parts( "REMOTE_CONTROLS" ) );
    if( !target.is_locked || !target.has_security_working( get_map() ) ) {
        result.authorized = true;
        return result;
    }
    if( result.advanced && target.is_alarm_on ) {
        who.add_msg_if_player( m_bad, _( "This vehicle's security system has locked you out!" ) );
        return result;
    }
    const int roll = dice( std::round( who.get_skill_level( skill_id( "computer" ) ) ) + 2,
                           who.get_int() ) - ( result.advanced ? 50 : 25 );
    if( roll >= -20 && roll < 20 ) {
        result.roll = roll;
    } else {
        result.authorized = settle_security( who, controller, target, roll, result.advanced );
    }
    return result;
}

void take_remote_control( Character &who, item &controller, vehicle &target )
{
    if( who.has_trait( trait_id( "WAYFARER" ) ) ) {
        who.add_msg_if_player( m_info,
                               _( "Despite using a controller, you still refuse to take control of this vehicle." ) );
        return;
    }
    controller.active = true;
    if( !set_remote_vehicle( who, get_map(), &target ) ) {
        controller.active = false;
        return;
    }
    who.add_msg_if_player( m_good, _( "You take control of the vehicle." ) );
    if( !target.engine_on ) {
        target.start_engines( get_map(), &who );
    }
}

void local_vehicle_action( Character &who, item &controller, vehicle &target )
{
    map &here = get_map();
    const auto controls = target.get_avail_parts( "REMOTE_CONTROLS" );
    const auto electronics = target.get_avail_parts( "CTRL_ELECTRONIC" );
    if( empty( controls ) && empty( electronics ) ) {
        return;
    }
    avatar &view = get_avatar();
    const restore_on_out_of_scope restore_view( view.view_offset );
    const tripoint_bub_ms position = empty( controls ) ? electronics.begin()->pos_bub( here ) :
                                     controls.begin()->pos_bub( here );
    if( !who.has_item( controller ) ) {
        // The CBM's temporary controller must not become a saved item handle.
        target.interact_with( &here, position );
        return;
    }
    const character_action_guard lifetime( who );
    const int64_t id = target.uid().get_value();
    const item_location source( who, &controller );
    veh_menu menu( target, _( "Select an action" ) );
    menu.remote_controller = &source;
    while( lifetime && vehicle::find_vehicle_by_uid( here, id ) == &target &&
           remote_vehicle_accessible( who, here, target, source ) ) {
        menu.reset();
        target.build_interact_menu( menu, &here, position, false );
        if( !menu.query() ) {
            break;
        }
    }
}
} // namespace

bool valid_remote_vehicle_choices( const item_activation_choices &choices )
{
    return !choices.lumber && !choices.timer_seconds && !choices.radio && !choices.fire_target &&
           !choices.fire_tinder &&
           choices.salvage_batch.empty() && !choices.salvage &&
           ( ( choices.remote_vehicle_action == "stop" && !choices.remote_vehicle_uid ) ||
             ( ( choices.remote_vehicle_action == "control" || choices.remote_vehicle_action == "action" ) &&
               choices.remote_vehicle_uid && *choices.remote_vehicle_uid > 0 ) );
}

bool query_remote_vehicle_choices( Character &who, const item &controller,
                                   item_activation_choices &choices )
{
    choices = {};
    map &here = get_map();
    const bool controlling = controller.active && resolve_remote_vehicle( who, here );
    const int choice = uilist( _( "What to do with the remote vehicle control:" ), {
        controlling ? _( "Stop controlling the vehicle." ) : _( "Take control of a vehicle." ),
        _( "Execute one vehicle action" )
    } );
    if( choice < 0 || choice > 1 ) {
        return false;
    }
    if( choice == 0 && controlling ) {
        choices.remote_vehicle_action = "stop";
        return true;
    }
    avatar &view = get_avatar();
    const restore_on_out_of_scope restore_view( view.view_offset );
    uilist menu;
    menu.title = _( "Select vehicle to access" );
    std::vector<int64_t> targets;
    std::vector<tripoint_bub_ms> locations;
    for( const wrapped_vehicle &entry : here.get_vehicles() ) {
        const vehicle &target = *entry.v;
        if( reachable_vehicle( who, here, target, choice == 1 ) ) {
            menu.addentry( static_cast<int>( targets.size() ), true, MENU_AUTOASSIGN, target.name );
            targets.push_back( target.uid().get_value() );
            locations.push_back( target.pos_bub( here ) );
        }
    }
    if( targets.empty() ) {
        who.add_msg_if_player( m_bad, _( "No vehicle available." ) );
        return false;
    }
    pointmenu_cb callback( locations );
    menu.callback = &callback;
    if( targets.size() == 1 ) {
        menu.ret = 0;
    } else {
        menu.query();
    }
    if( menu.ret < 0 || static_cast<size_t>( menu.ret ) >= targets.size() ) {
        return false;
    }
    choices.remote_vehicle_action = choice == 0 ? "control" : "action";
    choices.remote_vehicle_uid = targets[menu.ret];
    return true;
}

namespace
{
void settle_bionic_controller( Character &who, unsigned int uid, bool used, bool active )
{
    const auto bio = who.find_bionic_by_uid( uid );
    if( !who.is_dead_state() && bio && ( *bio )->id == bionic_id( "bio_remote" ) ) {
        // A successful controller operation costs one charge. Security effort
        // drains the temporary controller only, not the operator's CBM power.
        if( used ) {
            who.mod_power_level( -1_kJ );
        }
        ( *bio )->powered = active;
    }
}
} // namespace

remote_vehicle_activity_actor remote_vehicle_activity_actor::use_bionic(
    const Character &who, unsigned int uid, int64_t vehicle_id, bool one_action )
{
    remote_vehicle_activity_actor result( {}, vehicle_id, one_action );
    result.bionic_uid = uid;
    result.bionic_controller.emplace( itype_id( "remotevehcontrol" ), calendar::turn_zero );
    result.bionic_controller->set_flag( flag_USES_BIONIC_POWER );
    result.bionic_controller->charges = static_cast<int>( std::clamp<int64_t>(
                                            units::to_kilojoule( who.get_power_level() ), 0, INT_MAX ) );
    return result;
}

remote_vehicle_activity_actor::remote_vehicle_activity_actor( item_source source,
        int64_t uid, bool single ) : controller( std::move( source ) ), vehicle_id( uid ),
    one_action( single ) {}

const activity_id &remote_vehicle_activity_actor::get_type() const
{
    static const activity_id id( "ACT_REMOTE_VEHICLE" );
    return id;
}

vehicle *remote_vehicle_activity_actor::target( Character &who ) const
{
    map &here = get_map();
    vehicle *candidate = vehicle::find_vehicle_by_uid( here, vehicle_id );
    if( !candidate || !reachable_vehicle( who, here, *candidate, one_action ) ) {
        return nullptr;
    }
    Character *other = vehicle_operator( *candidate, here );
    return other && other != &who ? nullptr : candidate;
}

bool remote_vehicle_activity_actor::prepare( Character &who )
{
    const item_location current = source( who );
    vehicle *candidate = target( who );
    if( who.is_dead_state() || !current || !current.held_by( who ) || current->is_broken() ||
        !current->type->can_use( "REMOTEVEH" ) || !current->ammo_sufficient( &who, "REMOTEVEH" ) ||
        !candidate || ( authorized && one_action && candidate->is_locked != access_locked ) ||
        ( ( security_roll || authorized ) &&
          ( advanced_security != !empty( candidate->get_avail_parts( "REMOTE_CONTROLS" ) ) ||
            ( security_roll && advanced_security && candidate->is_alarm_on ) ) ) ) {
        who.cancel_activity();
        return false;
    }
    return true;
}

void remote_vehicle_activity_actor::start( player_activity &act, Character &who )
{
    act.moves_total = act.moves_left = 1;
    if( !prepare( who ) ) {
        return;
    }
    const character_action_guard lifetime( who );
    const auto generation = act.identity_generation();
    // Practice hooks may cancel/replace the activity; its virtual controller
    // must survive that callback without borrowing storage from this actor.
    std::optional<item> facade = bionic_controller;
    const security_scan scanned = scan_security( who, facade ? *facade : *source( who ),
                                  *target( who ) );
    if( !lifetime || who.activity.identity_generation() != generation ) {
        return;
    }
    if( facade ) {
        bionic_controller = std::move( facade );
    }
    authorized = scanned.authorized;
    advanced_security = scanned.advanced;
    security_roll = scanned.roll;
    vehicle *candidate = target( who );
    if( !candidate ) {
        who.cancel_activity();
        return;
    }
    access_locked = candidate->is_locked;
    if( security_roll ) {
        return;
    }
    if( !authorized ) {
        who.cancel_activity();
    } else if( !one_action ) {
        complete_control( who );
    }
}

bool remote_vehicle_activity_actor::waiting_for_security() const
{
    return security_roll.has_value();
}

bool remote_vehicle_activity_actor::waiting_for_action() const
{
    return authorized && one_action;
}

int64_t remote_vehicle_activity_actor::target_id() const
{
    return vehicle_id;
}

item_location remote_vehicle_activity_actor::source( Character &who ) const
{
    if( bionic_uid ) {
        const auto bio = who.find_bionic_by_uid( bionic_uid );
        if( !bio || ( *bio )->id != bionic_id( "bio_remote" ) ||
            ( *bio )->incapacitated_time > 0_turns || !bionic_controller ) {
            return item_location();
        }
        bionic_controller->charges = static_cast<int>( std::min<int64_t>( bionic_controller->charges,
                                     std::clamp<int64_t>( units::to_kilojoule( who.get_power_level() ), 0, INT_MAX ) ) );
        return item_location( who, &*bionic_controller );
    }
    return resolve_item_source( who, get_map(), controller );
}

void remote_vehicle_activity_actor::answer_security( Character &who, bool consent )
{
    if( !prepare( who ) || !security_roll ) {
        return;
    }
    if( !consent ) {
        who.cancel_activity();
        return;
    }
    const int roll = *security_roll;
    security_roll.reset();
    const character_action_guard lifetime( who );
    const auto generation = who.activity.identity_generation();
    std::optional<item> facade = bionic_controller;
    const bool granted = settle_security( who, facade ? *facade : *source( who ), *target( who ),
                                          roll, advanced_security );
    if( !lifetime || who.activity.identity_generation() != generation ) {
        return;
    }
    if( facade ) {
        bionic_controller = std::move( facade );
    }
    authorized = granted;
    if( vehicle *candidate = target( who ) ) {
        access_locked = candidate->is_locked;
    } else {
        authorized = false;
    }
    if( !authorized ) {
        who.cancel_activity();
    } else if( !one_action ) {
        complete_control( who );
    }
}

void remote_vehicle_activity_actor::complete_control( Character &who )
{
    // Native startup can replace this activity. Keep no borrowed actor members
    // across the handoff, and charge the completed access exactly once.
    item_location source = this->source( who );
    const unsigned int uid = bionic_uid;
    std::optional<item> facade;
    if( uid && source ) {
        facade = *source;
        source = item_location( who, &*facade );
    }
    vehicle *candidate = target( who );
    const int64_t target_id = vehicle_id;
    const character_action_guard lifetime( who );
    const activity_execution execution = who.activity.execution();
    who.activity.set_to_null();
    who.activity.set_execution( execution );
    const on_out_of_scope clear_execution( [&]() {
        if( lifetime && !who.activity ) {
            who.activity.set_execution( activity_execution::local );
        }
    } );
    if( !source || !candidate ) {
        return;
    }
    if( uid ) {
        settle_bionic_controller( who, uid, true, true );
    } else {
        source->activation_consume( 1, who.pos_bub(), &who );
    }
    if( !lifetime || !source ) {
        return;
    }
    candidate = vehicle::find_vehicle_by_uid( get_map(), target_id );
    if( !candidate || !reachable_vehicle( who, get_map(), *candidate, false ) ) {
        if( uid ) {
            settle_bionic_controller( who, uid, false, false );
        }
        return;
    }
    take_remote_control( who, *source, *candidate );
    if( uid && lifetime ) {
        settle_bionic_controller( who, uid, false, source->active );
    }
}

bool remote_vehicle_activity_actor::apply_action( Character &who,
        const vehicle_control_selection &selection )
{
    item_location source = this->source( who );
    if( !prepare( who ) || !waiting_for_action() || selection.vehicle_id != vehicle_id ||
        !vehicle_control_accessible( who, get_map(), *target( who ), selection.position,
                                     selection.action, &source ) ) {
        return false;
    }
    const unsigned int uid = bionic_uid;
    std::optional<item> facade;
    if( uid ) {
        facade = *source;
        source = item_location( who, &*facade );
    }
    const character_action_guard lifetime( who );
    const activity_execution execution = who.activity.execution();
    authorized = false;
    who.activity.set_to_null();
    who.activity.set_execution( execution );
    const on_out_of_scope clear_execution( [&]() {
        if( lifetime && !who.activity ) {
            who.activity.set_execution( activity_execution::local );
        }
    } );
    const bool result = execute_vehicle_control( who, get_map(), selection, &source );
    if( lifetime && uid ) {
        if( auto *startup = dynamic_cast<start_engines_activity_actor *>( who.activity.actor.get() ) ) {
            startup->allow_bionic_remote_start( uid, selection.vehicle_id );
        }
        settle_bionic_controller( who, uid, true, false );
    } else if( lifetime && source ) {
        source->activation_consume( 1, who.pos_bub(), &who );
    }
    return result;
}

void remote_vehicle_activity_actor::run_local( Character &who )
{
    if( !prepare( who ) ) {
        return;
    }
    if( security_roll ) {
        const character_action_guard lifetime( who );
        const auto generation = who.activity.identity_generation();
        const bool consent = who.query_yn( _( "Try to hack this car's security system?" ) );
        if( lifetime && who.activity.identity_generation() == generation ) {
            auto *current = dynamic_cast<remote_vehicle_activity_actor *>( who.activity.actor.get() );
            if( current ) {
                current->answer_security( who, consent );
            }
        }
        return;
    }
    if( waiting_for_action() ) {
        vehicle *candidate = target( who );
        item_location source = this->source( who );
        const character_action_guard lifetime( who );
        who.activity.set_to_null();
        local_vehicle_action( who, *source, *candidate );
        if( lifetime && source ) {
            source->activation_consume( 1, who.pos_bub(), &who );
        }
    }
}

void remote_vehicle_activity_actor::do_turn( player_activity &act, Character &who )
{
    if( act.execution() == activity_execution::authoritative ) {
        if( prepare( who ) ) {
            who.set_moves( 0 );
        }
    } else {
        run_local( who );
    }
}

void remote_vehicle_activity_actor::finish( player_activity &, Character &who )
{
    who.cancel_activity();
}

void remote_vehicle_activity_actor::canceled( player_activity &, Character &who )
{
    item_location source = this->source( who );
    if( security_roll ) {
        security_roll.reset();
        who.mod_moves( -to_moves<int>( 1_seconds ) );
        if( source && source.held_by( who ) ) {
            source->charges -= 1;
        }
    }
    const bool used = authorized && one_action;
    authorized = false;
    if( bionic_uid ) {
        settle_bionic_controller( who, bionic_uid, used, false );
    } else if( used && source && source.held_by( who ) ) {
        source->activation_consume( 1, who.pos_bub(), &who );
    }
}

std::unique_ptr<activity_actor> remote_vehicle_activity_actor::clone() const
{
    return std::make_unique<remote_vehicle_activity_actor>( *this );
}

void remote_vehicle_activity_actor::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "controller", controller );
    out.member( "bionic_uid", bionic_uid );
    out.member( "bionic_controller", bionic_controller );
    out.member( "vehicle_id", vehicle_id );
    out.member( "one_action", one_action );
    out.member( "advanced_security", advanced_security );
    out.member( "security_roll", security_roll );
    out.member( "authorized", authorized );
    out.member( "access_locked", access_locked );
    out.end_object();
}

std::unique_ptr<activity_actor> remote_vehicle_activity_actor::deserialize( JsonValue &input )
{
    const JsonObject data = input.get_object();
    remote_vehicle_activity_actor actor( {}, 0, false );
    data.read( "controller", actor.controller, true );
    data.read( "bionic_uid", actor.bionic_uid );
    data.read( "bionic_controller", actor.bionic_controller );
    data.read( "vehicle_id", actor.vehicle_id, true );
    data.read( "one_action", actor.one_action, true );
    data.read( "advanced_security", actor.advanced_security, true );
    data.read( "security_roll", actor.security_roll );
    data.read( "authorized", actor.authorized, true );
    data.read( "access_locked", actor.access_locked, true );
    return actor.clone();
}

std::optional<int> begin_remote_vehicle_access( Character &who, item &controller,
        const item_activation_choices &choices )
{
    const character_action_guard lifetime( who );
    if( who.activity || !valid_remote_vehicle_choices( choices ) ) {
        return std::nullopt;
    }
    vehicle *candidate = choices.remote_vehicle_uid ?
                         vehicle::find_vehicle_by_uid( get_map(), *choices.remote_vehicle_uid ) : nullptr;
    Character *other = candidate ? vehicle_operator( *candidate, get_map() ) : nullptr;
    if( choices.remote_vehicle_action != "stop" &&
        ( !candidate || !reachable_vehicle( who, get_map(), *candidate,
                                            choices.remote_vehicle_action == "action" ) ||
          ( other && other != &who ) ) ) {
        return std::nullopt;
    }
    if( !controller.activation_success() ) {
        who.add_msg_if_player( m_bad,
                               _( "Your %s doesn't seem to respond to your actions." ), controller.tname() );
        return std::nullopt;
    }
    if( choices.remote_vehicle_action == "stop" ) {
        controller.active = false;
        set_remote_vehicle( who, get_map(), nullptr );
        return 0;
    }
    if( who.activity.execution() != activity_execution::authoritative ) {
        // Local invocation stays synchronous and returns its native use count.
        // This also covers a CBM's stack-local controller without saving it.
        const security_scan scanned = scan_security( who, controller, *candidate );
        if( !lifetime ) {
            return 0;
        }
        candidate = vehicle::find_vehicle_by_uid( get_map(), *choices.remote_vehicle_uid );
        if( !candidate ) {
            return 0;
        }
        bool granted = scanned.authorized;
        if( scanned.roll ) {
            const bool consent = who.query_yn( _( "Try to hack this car's security system?" ) );
            if( !lifetime ) {
                return 0;
            }
            candidate = vehicle::find_vehicle_by_uid( get_map(), *choices.remote_vehicle_uid );
            if( !candidate ) {
                return 0;
            }
            if( !consent ) {
                who.mod_moves( -to_moves<int>( 1_seconds ) );
                controller.charges -= 1;
                return 0;
            }
            granted = settle_security( who, controller, *candidate, *scanned.roll, scanned.advanced );
        }
        if( !lifetime || !granted ) {
            return 0;
        }
        candidate = vehicle::find_vehicle_by_uid( get_map(), *choices.remote_vehicle_uid );
        if( !candidate ) {
            return 0;
        }
        if( choices.remote_vehicle_action == "control" ) {
            take_remote_control( who, controller, *candidate );
        } else {
            local_vehicle_action( who, controller, *candidate );
        }
        return 1;
    }
    if( !who.has_item( controller ) ) {
        return std::nullopt;
    }
    who.assign_activity( remote_vehicle_activity_actor( capture_item_source( who,
                         item_location( who, &controller ) ),
                         *choices.remote_vehicle_uid, choices.remote_vehicle_action == "action" ) );
    return 0;
}

bool valid_bionic_remote_vehicle_access( Character &who, unsigned int uid,
        const item_activation_choices &choices )
{
    const auto bio = who.find_bionic_by_uid( uid );
    if( who.activity || !bio || ( *bio )->id != bionic_id( "bio_remote" ) ||
        who.get_power_level() < 1_kJ || !valid_remote_vehicle_choices( choices ) ) {
        return false;
    }
    if( choices.remote_vehicle_action == "stop" ) {
        return true;
    }
    vehicle *candidate = vehicle::find_vehicle_by_uid( get_map(), *choices.remote_vehicle_uid );
    const bool single = choices.remote_vehicle_action == "action";
    Character *other = candidate ? vehicle_operator( *candidate, get_map() ) : nullptr;
    if( !candidate || !reachable_vehicle( who, get_map(), *candidate, single ) ||
        ( other && other != &who ) ) {
        return false;
    }
    return true;
}

bool begin_bionic_remote_vehicle_access( Character &who, unsigned int uid,
        const item_activation_choices &choices )
{
    if( !valid_bionic_remote_vehicle_access( who, uid, choices ) ) {
        return false;
    }
    if( choices.remote_vehicle_action == "stop" ) {
        set_remote_vehicle( who, get_map(), nullptr );
        settle_bionic_controller( who, uid, false, false );
        return true;
    }
    auto actor = remote_vehicle_activity_actor::use_bionic(
                     who, uid, *choices.remote_vehicle_uid, choices.remote_vehicle_action == "action" );
    if( !actor.source( who )->activation_success() ) {
        settle_bionic_controller( who, uid, false, false );
        return false;
    }
    // While a prompt is pending there is no active radio link to maintain.
    settle_bionic_controller( who, uid, false, false );
    who.assign_activity( actor );
    return true;
}
