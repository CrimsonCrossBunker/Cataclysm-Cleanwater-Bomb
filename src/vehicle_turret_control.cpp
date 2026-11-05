#include "vehicle_turret_control.h"

#include <algorithm>
#include <set>
#include <utility>

#include "avatar.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "character_action_guard.h"
#include "creature_tracker.h"
#include "game.h"
#include "gun_mode.h"
#include "item.h"
#include "item_location.h"
#include "json.h"
#include "line.h"
#include "map.h"
#include "messages.h"
#include "mp_inventory_activity.h"
#include "npc.h"
#include "output.h"
#include "ranged.h"
#include "ranged_actions.h"
#include "rng.h"
#include "string_formatter.h"
#include "translations.h"
#include "uilist.h"
#include "veh_type.h"
#include "vehicle.h"
#include "vehicle_control.h"
#include "vpart_range.h"

namespace
{
bool aiming( const std::string &operation )
{
    return operation == "aim_manual" || operation == "aim_auto" ||
           operation == "aim_single" || operation == "fire_direct";
}

vehicle_part *find_turret( vehicle &target, const vehicle_turret_choice &choice )
{
    for( const vpart_reference &part : target.get_all_parts() ) {
        if( !part.part().removed && part.part().is_turret() &&
            part.part().get_base().uid().get_value() == choice.part &&
            part.pos_abs() == choice.position ) {
            return &part.part();
        }
    }
    return nullptr;
}

// A preview borrows only the vehicle's resource queries. Its gun and ammo
// preference are owned copies; no fake gunner, callbacks or live parts change.
vehicle_part preview_part( const vehicle_part &source )
{
    // Keep rotated coordinates without copying cargo, tools or a targeting NPC.
    vehicle_part result( source.info().id, item( source.get_base() ) );
    result.mount = source.mount;
    result.precalc = source.precalc;
    result.enabled = source.enabled;
    return result;
}

item &preview_gun( vehicle_part &part )
{
    // get_base exposes a const reference to protect mounted hardware. This
    // part is an owned, unmounted preview, so editing its gun is intentional.
    return const_cast<item &>( part.get_base() );
}

bool set_preview_choice( vehicle &target, vehicle_part &preview,
                         const vehicle_turret_choice &choice )
{
    item &gun = preview_gun( preview );
    const auto modes = gun.gun_all_modes();
    const auto mode = modes.find( choice.mode );
    if( mode == modes.end() || mode->second.melee() ) {
        return false;
    }
    gun.gun_set_mode( choice.mode );
    auto data = target.turret_query( preview );
    if( !data ) {
        return false;
    }
    return choice.ammo.is_null() ? data.ammo_current().is_null() : data.ammo_select( choice.ammo );
}

bool can_aim( const Character &who, bool direct )
{
    return !who.has_trait( trait_id( "BRAWLER" ) ) &&
           ( direct || !who.has_trait( trait_id( "GUNSHY" ) ) ) &&
           !who.has_flag( json_character_flag( "CANNOT_ATTACK" ) );
}

std::vector<vehicle_part *> aim_options( vehicle &target, const std::string &operation,
        const tripoint_abs_ms &position )
{
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    std::vector<vehicle_part *> result;
    for( vehicle_part *part : target.turrets() ) {
        if( ( operation == "aim_manual" && part->enabled ) ||
            ( operation == "aim_auto" && !part->enabled ) ||
            ( operation == "fire_direct" && target.abs_part_pos( *part ) != position ) ) {
            continue;
        }
        if( target.turret_query( *part ).query() == turret_data::status::ready ) {
            result.push_back( part );
        }
    }
    return result;
}
} // namespace

void vehicle_turret_choice::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "part", part );
    out.member( "position", position );
    out.member( "mode", mode );
    out.member( "ammo", ammo );
    out.member( "automatic", automatic );
    out.end_object();
}

void vehicle_turret_choice::deserialize( const JsonObject &data )
{
    data.read( "part", part, true );
    data.read( "position", position, true );
    data.read( "mode", mode, true );
    data.read( "ammo", ammo, true );
    data.read( "automatic", automatic, true );
}

void vehicle_turret_selection::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "operation", operation );
    out.member( "operator_position", operator_position );
    out.member( "turrets", turrets );
    out.member( "target", target );
    out.end_object();
}

void vehicle_turret_selection::deserialize( const JsonObject &data )
{
    data.read( "operation", operation, true );
    data.read( "operator_position", operator_position, true );
    data.read( "turrets", turrets, true );
    target.reset();
    data.read( "target", target );
}

vehicle_turret_choice capture_vehicle_turret( vehicle &target, vehicle_part &part )
{
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    const auto data = target.turret_query( part );
    return { part.get_base().uid().get_value(), target.abs_part_pos( part ),
             part.get_base().gun_get_mode_id(), data ? data.ammo_current() : itype_id::NULL_ID(), part.enabled };
}

bool valid_vehicle_turret_control( Character &who, map &here, vehicle &target,
                                   const vehicle_turret_selection &choice )
{
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    const bool aim = aiming( choice.operation );
    const bool direct = choice.operation == "fire_direct";
    if( who.is_dead_state() || who.has_effect( efftype_id( "incorporeal" ) ) ||
        who.pos_abs() != choice.operator_position || choice.turrets.empty() ||
        ( !aim && choice.operation != "targeting" && choice.operation != "mode" ) ||
        ( aim != choice.target.has_value() ) ||
        ( ( direct || choice.operation == "aim_single" ) && choice.turrets.size() != 1 ) ||
        ( aim && ( !can_aim( who, direct ) || !here.inbounds( *choice.target ) ||
                   *choice.target == who.pos_abs() ) ) ) {
        return false;
    }
    std::set<int64_t> identities;
    bool in_range = false;
    for( const auto &selected : choice.turrets ) {
        vehicle_part *part = find_turret( target, selected );
        if( !part || !identities.insert( selected.part ).second ) {
            return false;
        }
        if( choice.operation == "targeting" ) {
            if( selected.automatic && !target.has_part( selected.position, "TURRET_CONTROLS" ) ) {
                return false;
            }
            continue;
        }
        if( choice.operation == "mode" ) {
            const auto modes = part->get_base().gun_all_modes();
            if( modes.count( selected.mode ) == 0 ) {
                return false;
            }
            continue;
        }
        auto preview = preview_part( *part );
        if( !set_preview_choice( target, preview, selected ) ) {
            return false;
        }
        if( !aim ) {
            continue;
        }
        auto data = target.turret_query( preview );
        if( !data || data.query() != turret_data::status::ready ||
            ( direct && selected.position != who.pos_abs() ) ||
            ( choice.operation == "aim_manual" && part->enabled ) ||
            ( choice.operation == "aim_auto" && !part->enabled ) ) {
            return false;
        }
        if( direct ) {
            std::vector<std::string> messages;
            if( !gunmode_checks_common( who, here, messages, preview.get_base().gun_current_mode() ) ) {
                return false;
            }
        }
        in_range = in_range || data.in_range( *choice.target );
    }
    return !aim || in_range;
}

bool execute_vehicle_turret_control( Character &who, map &here, vehicle &target,
                                     const vehicle_turret_selection &choice )
{
    if( !valid_vehicle_turret_control( who, here, target, choice ) ) {
        return false;
    }
    const bool aim = aiming( choice.operation );
    const bool direct = choice.operation == "fire_direct";
    const int64_t vehicle_id = target.uid().get_value();
    const character_action_guard lifetime( who );
    if( aim ) {
        who.last_target_pos = *choice.target;
        Creature *victim = get_creature_tracker().creature_at( here.get_bub( *choice.target ), true );
        who.last_target = victim ? g->shared_from( *victim ) : shared_ptr_fast<Creature>();
        mark_ranged_target( who, true );
        if( !lifetime ) {
            return false;
        }
        if( !direct ) {
            // Same native control-console aiming cost, charged to its operator.
            who.set_moves( std::min( 0, who.get_moves() - 100 + 5 * who.get_int() ) );
        }
    }
    for( const auto &selected : choice.turrets ) {
        vehicle *live = vehicle::find_vehicle_by_uid( here, vehicle_id );
        if( !lifetime || !live ) {
            break;
        }
        vehicle_part *part = find_turret( *live, selected );
        if( !part ) {
            continue;
        }
        if( choice.operation == "targeting" ) {
            part->enabled = selected.automatic;
            for( const vpart_reference &control : live->get_avail_parts( "TURRET_CONTROLS" ) ) {
                if( control.part().mount == part->mount ) {
                    control.part().enabled = selected.automatic;
                }
            }
            part->reset_target( selected.position );
            continue;
        }
        // The access-checked command is the mutation boundary for mounted guns.
        const_cast<item &>( part->get_base() ).gun_set_mode( selected.mode );
        if( !aim ) {
            continue;
        }
        auto data = live->turret_query( *part );
        if( !data ) {
            continue;
        }
        data.ammo_select( selected.ammo );
        part->reset_target( selected.position );
        if( data.query() != turret_data::status::ready || !data.in_range( *choice.target ) ) {
            continue;
        }
        part->target.second = *choice.target;
        if( choice.operation == "aim_auto" ) {
            continue;
        }
        // Native grouped fire treats a turret's own mount as an empty target.
        if( part->target.first == part->target.second ) {
            continue;
        }
        if( direct ) {
            data.fire( who, &here, here.get_bub( *choice.target ) );
        } else {
            npc &gunner = part->get_targeting_npc( *live );
            data.fire( gunner, &here, here.get_bub( *choice.target ) );
        }
        // Shooting can run gameplay callbacks. Reacquire mounted identities
        // before touching targets or proceeding to another turret.
        live = vehicle::find_vehicle_by_uid( here, vehicle_id );
        if( live ) {
            if( vehicle_part *remaining = find_turret( *live, selected ) ) {
                remaining->reset_target( live->abs_part_pos( *remaining ) );
            }
        }
    }
    return true;
}

std::optional<vehicle_control_selection> query_vehicle_turrets( Character &who, map &here,
        vehicle &target, const tripoint_abs_ms &position, const std::string &operation,
        const item_location *remote_source )
{
    if( !who.is_avatar() ) {
        return std::nullopt;
    }
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    std::string selected_operation = operation;
    if( selected_operation.empty() ) {
        const std::vector<std::pair<std::string, std::string>> options = {
            { "targeting", _( "Set turret targeting modes" ) },
            { "mode", _( "Set turret firing modes" ) },
            { "aim_manual", _( "Aim turrets manually" ) },
            { "aim_auto", _( "Aim automatic turrets" ) },
            { "aim_single", _( "Aim individual turret" ) }
        };
        uilist menu;
        menu.title = _( "Turret controls" );
        for( size_t i = 0; i < options.size(); ++i ) {
            menu.addentry( i, true, MENU_AUTOASSIGN, options[i].second );
        }
        menu.query();
        if( menu.ret < 0 || static_cast<size_t>( menu.ret ) >= options.size() ) {
            return std::nullopt;
        }
        selected_operation = options[menu.ret].first;
    }
    auto selection = query_vehicle_control( who, here, target, position,
                                            selected_operation == "fire_direct" ? "turret_direct" : "turret", remote_source );
    if( !selection ) {
        return std::nullopt;
    }
    vehicle_turret_selection choice;
    choice.operation = selected_operation;
    choice.operator_position = who.pos_abs();
    if( !aiming( selected_operation ) ) {
        std::vector<vehicle_turret_choice> original;
        std::vector<tripoint_bub_ms> locations;
        for( const vpart_reference &part : target.get_all_parts() ) {
            if( !part.part().removed && part.part().is_turret() ) {
                original.push_back( capture_vehicle_turret( target, part.part() ) );
                locations.push_back( here.get_bub( original.back().position ) );
            }
        }
        auto desired = original;
        pointmenu_cb callback( locations );
        int current = 0;
        while( !desired.empty() ) {
            uilist menu;
            menu.text = selected_operation == "targeting" ? _( "Set turret targeting" ) :
                        _( "Set turret firing modes" );
            menu.callback = &callback;
            menu.selected = current;
            menu.fselected = current;
            for( size_t i = 0; i < desired.size(); ++i ) {
                vehicle_part *part = find_turret( target, desired[i] );
                if( !part ) {
                    return std::nullopt;
                }
                if( selected_operation == "targeting" ) {
                    const bool controls = target.has_part( desired[i].position, "TURRET_CONTROLS" );
                    menu.addentry( i, desired[i].automatic || controls, MENU_AUTOASSIGN,
                                   "%s [%s]", part->name(), desired[i].automatic ? _( "auto -> manual" ) :
                                   controls ? _( "manual -> auto" ) :
                                   _( "manual (turret control unit required for auto mode)" ) );
                } else {
                    auto preview = preview_part( *part );
                    preview_gun( preview ).gun_set_mode( desired[i].mode );
                    menu.addentry( i, true, MENU_AUTOASSIGN, "%s [%s]", part->name(),
                                   preview.get_base().gun_current_mode().tname() );
                }
            }
            menu.query();
            if( menu.ret < 0 || static_cast<size_t>( menu.ret ) >= desired.size() ) {
                break;
            }
            current = menu.ret;
            if( selected_operation == "targeting" ) {
                desired[current].automatic = !desired[current].automatic;
            } else {
                auto preview = preview_part( *find_turret( target, desired[current] ) );
                item &gun = preview_gun( preview );
                gun.gun_set_mode( desired[current].mode );
                gun.gun_cycle_mode();
                desired[current].mode = gun.gun_get_mode_id();
            }
        }
        for( size_t i = 0; i < desired.size(); ++i ) {
            if( desired[i].automatic != original[i].automatic || desired[i].mode != original[i].mode ) {
                choice.turrets.push_back( desired[i] );
            }
        }
    } else {
        if( !can_aim( who, selected_operation == "fire_direct" ) ) {
            who.add_msg_if_player( _( "You refuse to use a firearm even when it's mounted." ) );
            return std::nullopt;
        }
        auto options = aim_options( target, selected_operation, position );
        if( options.empty() ) {
            who.add_msg_if_player( m_warning, _( "None of the turrets are ready to fire." ) );
            return std::nullopt;
        }
        if( selected_operation == "aim_single" ) {
            std::vector<std::string> names;
            for( const vehicle_part *part : options ) {
                names.push_back( part->name() );
            }
            const int index = uilist( _( "Aim which turret?" ), names );
            if( index < 0 || static_cast<size_t>( index ) >= options.size() ) {
                return std::nullopt;
            }
            options = { options[index] };
        }
        for( vehicle_part *part : options ) {
            choice.turrets.push_back( capture_vehicle_turret( target, *part ) );
        }
        avatar &viewer = static_cast<avatar &>( who );
        const restore_on_out_of_scope last_target( who.last_target );
        const restore_on_out_of_scope last_position( who.last_target_pos );
        const restore_on_out_of_scope recoil( who.recoil );
        target_handler::trajectory trajectory;
        if( selected_operation == "fire_direct" ) {
            auto preview = preview_part( *options.front() );
            auto data = target.turret_query( preview );
            data.ammo_select( choice.turrets.front().ammo );
            g->temp_exit_fullscreen();
            trajectory = target_handler::mode_turret_manual( viewer, data, preview_gun( preview ) );
            g->reenter_fullscreen();
            choice.turrets.front().mode = preview.get_base().gun_get_mode_id();
            choice.turrets.front().ammo = data.ammo_current();
        } else {
            trajectory = target_handler::mode_turrets( viewer, target, options );
        }
        if( trajectory.empty() ) {
            return std::nullopt;
        }
        choice.target = here.get_abs( trajectory.back() );
    }
    if( !valid_vehicle_turret_control( who, here, target, choice ) ) {
        return std::nullopt;
    }
    selection->turret = std::move( choice );
    return selection;
}

bool use_vehicle_turrets( Character &who, map &here, vehicle &target,
                          const tripoint_abs_ms &position, const std::string &operation, bool show_message )
{
    if( aiming( operation ) && aim_options( target, operation, position ).empty() ) {
        if( show_message ) {
            who.add_msg_if_player( m_warning, _( "None of the turrets are ready to fire." ) );
        }
        return false;
    }
    if( auto choice = query_vehicle_turrets( who, here, target, position, operation ) ) {
        if( !cata_mp::client_vehicle_control( *choice ) ) {
            execute_vehicle_control( who, here, *choice );
        }
    }
    return true;
}
