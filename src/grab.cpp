#include "game.h" // IWYU pragma: associated

#include <calendar.h>
#include <coordinates.h>
#include <enums.h>
#include <algorithm>
#include <cstdlib>

#include "avatar.h"
#include "grab.h"
#include "character_action_guard.h"
#include "cata_scope_helpers.h"
#include "flag.h"
#include "item_uid.h"
#include "json.h"
#include "line.h"
#include "mapdata.h"
#include "pathfinding.h"
#include "vehicle_uid.h"
#include "cata_assert.h"
#include "debug.h"
#include "map.h"
#include "messages.h"
#include "monster.h"
#include "point.h"
#include "rng.h"
#include "sounds.h"
#include "tileray.h"
#include "translations.h"
#include "units.h"
#include "units_utility.h"
#include "veh_type.h"
#include "vehicle.h"
#include "vpart_position.h"
#include "vpart_range.h"

namespace
{
grabbed_object capture_grab( const Character &who, const map &here,
                             const tripoint_bub_ms &target )
{
    grabbed_object result;
    result.position = here.get_abs( target );
    if( !here.inbounds( target ) ) {
        return result;
    }
    if( who.get_grab_type() == object_type::FURNITURE ) {
        result.furniture = here.furn( target ).id();
    } else if( const auto vp = here.veh_at( target ) ) {
        result.vehicle_id = vp->vehicle().uid().get_value();
        if( who.get_grab_type() == object_type::FURNITURE_ON_VEHICLE ) {
            if( const auto tiedown = vp->part_with_feature( "FURNITURE_TIEDOWN", true ) ) {
                result.part_id = tiedown->part().get_base().uid().get_value();
                result.furniture = furn_str_id( tiedown->part().get_base().get_var( "tied_down_furniture" ) );
            }
        } else {
            result.part_id = vp->vehicle().part( vp->part_index() ).get_base().uid().get_value();
        }
    }
    return result;
}

std::optional<tripoint_bub_ms> grab_position( const Character &who, map &here,
        tripoint_bub_ms target )
{
    if( !here.inbounds( target ) || target.z() != who.pos_bub().z() ||
        rl_dist( target, who.pos_bub() ) != 1 ) {
        return std::nullopt;
    }
    if( !here.veh_at( target ) && !here.has_furn( target ) ) {
        if( here.has_flag( ter_furn_flag::TFLAG_RAMP_UP, target ) ||
            here.has_flag( ter_furn_flag::TFLAG_RAMP_UP, who.pos_bub() ) ) {
            target.z() += 1;
        } else if( here.has_flag( ter_furn_flag::TFLAG_RAMP_DOWN, target ) ||
                   here.has_flag( ter_furn_flag::TFLAG_RAMP_DOWN, who.pos_bub() ) ) {
            target.z() -= 1;
        }
    }
    return here.inbounds( target ) ? std::make_optional( target ) : std::nullopt;
}

std::optional<vpart_reference> selected_grab_part( map &here, const grab_selection &choice,
        bool after_split = false )
{
    const auto vp = here.veh_at( here.get_bub( choice.position ) );
    if( !vp || ( !after_split && vp->vehicle().uid().get_value() != choice.vehicle_id ) ) {
        return std::nullopt;
    }
    for( const vpart_reference &part : vp->vehicle().get_all_parts() ) {
        if( !part.part().removed && part.part().get_base().uid().get_value() == choice.part_id &&
            part.pos_abs() == choice.position ) {
            return part;
        }
    }
    return std::nullopt;
}
} // namespace

bool grabbed_object::matches( const Character &who, const map &here ) const
{
    const auto target = who.pos_bub( here ) + who.grab_point;
    if( who.get_grab_type() == object_type::NONE || !here.inbounds( target ) ) {
        return false;
    }
    if( who.get_grab_type() == object_type::FURNITURE ) {
        return !furniture.is_null() && furniture.is_valid() && position == here.get_abs( target ) &&
               !here.veh_at( target ) && here.furn( target ).id() == furniture;
    }
    const auto vp = here.veh_at( target );
    if( !vp || vehicle_id == 0 || part_id == 0 ||
        vp->vehicle().uid().get_value() != vehicle_id ) {
        return false;
    }
    for( const vpart_reference &part : vp->vehicle().get_all_parts() ) {
        if( !part.part().removed && part.part().get_base().uid().get_value() == part_id &&
            part.pos_abs() == here.get_abs( target ) ) {
            return who.get_grab_type() == object_type::VEHICLE ||
                   ( who.get_grab_type() == object_type::FURNITURE_ON_VEHICLE &&
                     part.part().info().has_flag( "FURNITURE_TIEDOWN" ) &&
                     !furniture.is_null() && furniture.is_valid() &&
                     part.part().get_base().get_var( "tied_down_furniture" ) == furniture.str() );
        }
    }
    return false;
}

void grabbed_object::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "position", position );
    out.member( "vehicle", vehicle_id );
    out.member( "part", part_id );
    out.member( "furniture", furniture );
    out.end_object();
}

void grabbed_object::deserialize( const JsonObject &data )
{
    data.read( "position", position );
    data.read( "vehicle", vehicle_id );
    data.read( "part", part_id );
    data.read( "furniture", furniture );
}

void Character::grab( object_type type, const tripoint_rel_ms &point )
{
    ++grab_generation_;
    grab_type = type;
    grab_point = type == object_type::NONE ? tripoint_rel_ms::zero : point;
    path_settings->avoid_rough_terrain = type != object_type::NONE;
    grab_target.reset();
    if( type != object_type::NONE ) {
        rebind_grab( get_map(), pos_bub() + point );
    }
}

void Character::rebind_grab( map &here, const tripoint_bub_ms &target )
{
    if( grab_type != object_type::NONE ) {
        grab_target = capture_grab( *this, here, target );
    }
}

bool Character::grab_matches( const map &here ) const
{
    return grab_target ? grab_target->matches( *this, here ) :
           capture_grab( *this, here, pos_bub( here ) + grab_point ).matches( *this, here );
}

bool Character::validate_grab( map &here )
{
    // Old saves did not record an identity. Bind once, when their map is ready.
    if( !grab_target && grab_type != object_type::NONE ) {
        rebind_grab( here, pos_bub( here ) + grab_point );
    }
    return grab_matches( here );
}

int Character::grabbed_vehicle_part( const map &here ) const
{
    if( !grab_target || !grab_target->matches( *this, here ) || grab_target->vehicle_id == 0 ) {
        return -1;
    }
    const auto vp = here.veh_at( pos_bub( here ) + grab_point );
    for( const vpart_reference &part : vp->vehicle().get_all_parts() ) {
        if( part.part().get_base().uid().get_value() == grab_target->part_id ) {
            return part.part_index();
        }
    }
    return -1;
}

void Character::invalidate_grabbed_furniture( const tripoint_abs_ms &position )
{
    if( grab_type == object_type::FURNITURE &&
        ( grab_target ? grab_target->position == position : pos_abs() + grab_point == position ) ) {
        grab_target.emplace();
        grab_target->position = position;
    }
}

void grab_selection::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "release", release );
    out.member( "position", position );
    out.member( "vehicle", vehicle_id );
    out.member( "part", part_id );
    out.member( "furniture", furniture );
    out.member( "separate_grid", separate_grid );
    out.member( "loaded_furniture", loaded_furniture );
    out.member( "allow_theft", allow_theft );
    out.end_object();
}

void grab_selection::deserialize( const JsonObject &data )
{
    data.read( "release", release );
    data.read( "position", position, true );
    data.read( "vehicle", vehicle_id );
    data.read( "part", part_id );
    data.read( "furniture", furniture );
    data.read( "separate_grid", separate_grid );
    data.read( "loaded_furniture", loaded_furniture );
    data.read( "allow_theft", allow_theft );
}

std::optional<grab_selection> query_grab( Character &who, map &here,
        const tripoint_bub_ms &target )
{
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    const character_action_guard lifetime( who );
    grab_selection choice;
    if( who.get_grab_type() != object_type::NONE || target == who.pos_bub() ) {
        choice.release = true;
        choice.position = who.pos_abs();
        return choice;
    }
    const auto position = grab_position( who, here, target );
    if( !position ) {
        return std::nullopt;
    }
    choice.position = here.get_abs( *position );
    if( const auto vp = here.veh_at( *position ) ) {
        vehicle &veh = vp->vehicle();
        choice.vehicle_id = veh.uid().get_value();
        choice.part_id = veh.part( vp->part_index() ).get_base().uid().get_value();
        if( vp.part_with_feature( VPFLAG_WALL_MOUNTED, false ) ) {
            who.add_msg_if_player( m_info, _( "You can't move that, it's attached to the wall." ) );
            return std::nullopt;
        }
        const bool foreign_owner = veh.has_owner() && !veh.is_owned_by( who );
        const std::string owner_name = foreign_owner ? veh.get_owner_name() : std::string();
        const std::string vehicle_name = veh.name;
        const bool needs_split = veh.is_powergrid() && veh.part_count() > 1;
        const auto tiedown = vp->has_loaded_furniture() ?
                             vp->part_with_feature( "FURNITURE_TIEDOWN", true ) : std::nullopt;
        const furn_str_id loaded( tiedown ? tiedown->part().get_base().get_var( "tied_down_furniture" ) :
                                  "" );
        const int64_t tiedown_id = tiedown ? tiedown->part().get_base().uid().get_value() : 0;
        // Keep values across modal UI, never a vehicle/part reference that a
        // network refresh may replace while the player is choosing.
        if( foreign_owner ) {
            choice.allow_theft = who.query_yn(
                                     _( "This vehicle belongs to: %s, there may be consequences if you are observed interacting with it, continue?" ),
                                     owner_name );
            if( !lifetime || !choice.allow_theft ) {
                return std::nullopt;
            }
        }
        if( needs_split ) {
            choice.separate_grid = who.query_yn(
                                       _( "That's part of a power grid.  Separate it from the grid so you can move it?" ) );
            if( !lifetime || !choice.separate_grid ) {
                return std::nullopt;
            }
        }
        if( loaded.is_valid() && who.query_yn( _( "Grab %1$s on %2$s?" ),
                                               loaded->name(), vehicle_name ) ) {
            choice.loaded_furniture = true;
            choice.furniture = loaded;
            choice.part_id = tiedown_id;
        }
        if( !lifetime ) {
            return std::nullopt;
        }
    } else if( here.has_furn( *position ) && here.furn( *position ).obj().is_movable() ) {
        choice.furniture = here.furn( *position ).id();
        const std::string warning = g->local_faction_action_warning( who );
        if( !warning.empty() ) {
            choice.allow_theft = who.query_yn( warning );
            if( !lifetime || !choice.allow_theft ) {
                return std::nullopt;
            }
        }
    } else {
        who.add_msg_if_player( m_info, _( "There's nothing to grab there!" ) );
        return std::nullopt;
    }
    return choice;
}

bool execute_grab( Character &who, map &here, const grab_selection &choice )
{
    if( who.activity ) {
        return false;
    }
    if( choice.release ) {
        const auto position = who.pos_bub() + who.grab_point;
        if( who.get_grab_type() == object_type::NONE ) {
            who.add_msg_if_player( _( "You get a hold of yourself." ) );
        } else if( const auto vp = here.veh_at( position ) ) {
            who.add_msg_if_player( _( "You release the %s." ), vp->vehicle().name );
        } else if( here.has_furn( position ) ) {
            who.add_msg_if_player( _( "You release the %s." ), here.furnname( position ) );
        }
        who.grab( object_type::NONE );
        return true;
    }
    if( who.get_moves() <= 0 || who.get_grab_type() != object_type::NONE || who.is_mounted() ||
        who.has_active_mutation( trait_id( "SHELL2" ) ) ||
        who.has_active_mutation( trait_id( "SHELL3" ) ) ||
        who.has_flag( json_character_flag( "TEMPORARY_SHAPESHIFT_NO_HANDS" ) ) ||
        !here.inbounds( choice.position ) ) {
        return false;
    }
    const tripoint_bub_ms position = here.get_bub( choice.position );
    const auto reachable = grab_position( who, here, tripoint_bub_ms( position.xy(),
                                          who.pos_bub().z() ) );
    if( !reachable || *reachable != position ) {
        return false;
    }
    const character_action_guard lifetime( who );
    const auto operator_position = who.pos_abs();
    if( choice.vehicle_id != 0 ) {
        auto part = selected_grab_part( here, choice );
        if( !part || part->part_with_feature( VPFLAG_WALL_MOUNTED, false ) ||
            ( part->vehicle().has_owner() && !part->vehicle().is_owned_by( who ) && !choice.allow_theft ) ||
            ( part->vehicle().is_powergrid() && part->vehicle().part_count() > 1 && !choice.separate_grid ) ) {
            return false;
        }
        if( choice.loaded_furniture &&
            ( !part->part().info().has_flag( "FURNITURE_TIEDOWN" ) || !choice.furniture.is_valid() ||
              part->part().get_base().get_var( "tied_down_furniture" ) != choice.furniture.str() ) ) {
            return false;
        }
        if( !part->vehicle().handle_potential_theft( who, false, false ) || !lifetime ) {
            return false;
        }
        part = selected_grab_part( here, choice );
        if( !part || who.activity || who.pos_abs() != operator_position ) {
            return false;
        }
        if( part->vehicle().is_powergrid() && part->vehicle().part_count() > 1 ) {
            who.pause();
            if( !lifetime ) {
                return false;
            }
            part = selected_grab_part( here, choice );
            if( !part || who.activity || who.pos_abs() != operator_position ) {
                return false;
            }
            part->vehicle().separate_from_grid( here, part->mount_pos(), who );
            part = selected_grab_part( here, choice, true );
            if( !part ) {
                return false;
            }
        }
        if( !lifetime || who.activity || who.pos_abs() != operator_position ||
            ( choice.loaded_furniture &&
              part->part().get_base().get_var( "tied_down_furniture" ) != choice.furniture.str() ) ) {
            return false;
        }
        const auto boarded = here.veh_at( who.pos_bub() );
        if( !choice.loaded_furniture && boarded && &boarded->vehicle() == &part->vehicle() &&
            !empty( part->vehicle().get_avail_parts( VPFLAG_OBSTACLE ) ) ) {
            who.add_msg_if_player( m_info, _( "You can't move the %s while you're boarding it." ),
                                   part->vehicle().name );
            return false;
        }
        who.grab( choice.loaded_furniture ? object_type::FURNITURE_ON_VEHICLE : object_type::VEHICLE,
                  position - who.pos_bub() );
        who.add_msg_if_player( _( "You grab the %s." ),
                               choice.loaded_furniture ? choice.furniture->name() : part->vehicle().name );
    } else {
        if( choice.part_id != 0 || choice.loaded_furniture || choice.separate_grid ||
            here.veh_at( position ) || here.furn( position ).id() != choice.furniture ||
            !here.furn( position ).obj().is_movable() ||
            !g->warn_character_maybe_anger_local_faction( who, true, false, choice.allow_theft ) ) {
            return false;
        }
        who.grab( object_type::FURNITURE, position - who.pos_bub() );
        who.add_msg_if_player( here.can_move_furniture( position, &who ) ?
                               _( "You grab the %s." ) : _( "You grab the %s. It feels really heavy." ),
                               here.furnname( position ) );
    }
    return true;
}

bool game::grabbed_veh_move_helper( const tripoint_rel_ms &dp, bool stairs_move )
{
    return grabbed_veh_move_helper( get_avatar(), dp, stairs_move );
}

bool game::grabbed_veh_move_stairs( const tripoint_rel_ms &dp )
{
    return grabbed_veh_move_stairs( get_avatar(), dp );
}

bool game::grabbed_veh_move( const tripoint_rel_ms &dp )
{
    return grabbed_veh_move( get_avatar(), dp );
}

bool game::grabbed_veh_move_helper( Character &who, const tripoint_rel_ms &dp, bool stairs_move )
{
    if( stairs_move ) {
        return grabbed_veh_move_stairs( who, dp );
    }
    return grabbed_veh_move( who, dp );
}

bool game::grabbed_veh_move_stairs( Character &who, const tripoint_rel_ms &dp )
{
    map &here = get_map();
    if( who.get_grab_type() != object_type::VEHICLE || !who.validate_grab( here ) ) {
        who.grab( object_type::NONE );
        return false;
    }
    const character_action_guard lifetime( who );
    tripoint_rel_ms new_dp = dp; // FIXME. We should be passed a copy not a reference.
    const optional_vpart_position grabbed_vehicle_vp = here.veh_at( who.pos_bub(
                here ) + who.grab_point );
    if( !grabbed_vehicle_vp ) {
        // The vehicle may have been unloaded while changing z-levels.  Clear
        // the grab state so the next movement does not use a stale grab point.
        who.add_msg_if_player( m_info, _( "No vehicle at grabbed point." ) );
        who.grab( object_type::NONE );
        return false;
    }
    vehicle *grabbed_vehicle = &grabbed_vehicle_vp->vehicle();
    if( !grabbed_vehicle ) {
        who.grab( object_type::NONE );
        return false;
    }

    grabbed_vehicle->invalidate_mass();
    const int max_str_req = grabbed_vehicle->total_mass( here ) / 10_kilogram;
    int str = who.get_arm_str();
    const bool going_up_stairs = dp.z() > 0;
    if( str < max_str_req && going_up_stairs ) {
        who.grab( object_type::NONE );
        who.add_msg_if_player( _( "You fail to lift the %s up the stairs." ),
                               grabbed_vehicle->disp_name() );
        return false;
    }

    // We need to adjust dp so that the vehicle is fully placed away from us, but also we need to check the tiles.
    // So first let's see what area our vehicle even covers...
    std::set<point_rel_ms> part_positions;
    for( const vpart_reference &some_part : grabbed_vehicle->get_all_parts() ) {
        part_positions.insert( some_part.mount_pos() );
    }

    // Dumb iteration for checking width. I feel like we've got better code for this...
    bool width_greater_than_0 = false;
    bool length_greater_than_0 = false;
    // horrible. don't do this.
    point maximums;
    point minimums;

    for( const point_rel_ms &checked_pos : part_positions ) {
        maximums.x = std::max( maximums.x, checked_pos.x() );
        maximums.y = std::max( maximums.y, checked_pos.y() );
        minimums.x = std::min( minimums.x, checked_pos.x() );
        minimums.y = std::min( minimums.y, checked_pos.y() );

        if( checked_pos.x() != 0 ) {
            width_greater_than_0 = true;
        }
        if( checked_pos.y() != 0 ) {
            length_greater_than_0 = true;
        }
        if( width_greater_than_0 && length_greater_than_0 ) {
            who.grab( object_type::NONE );
            who.add_msg_if_player( _( "The %s is too wide to get through the stairs." ),
                                   grabbed_vehicle->disp_name() );
            return false;
        }
    }

    // double horrible. help, I am being written by an incompetent. You're not supposed to stuff x values into the y value!!
    const point x_bounds = {minimums.x, maximums.x};
    const point y_bounds = {minimums.y, maximums.y};
    // Let's get safe: Blow the game the hell up if we've put the wrong value somewhere that matters.
    cata_assert( maximums.x >= 0 && maximums.y >= 0 && x_bounds.y >= 0 && y_bounds.y >= 0 );
    cata_assert( minimums.x <= 0 && minimums.y <= 0 && x_bounds.x <= 0 && y_bounds.x <= 0 );

    // I **think** we can just use y for moving dp? since we're going to always orientate the vehicle facing away from the player,
    // width will never touch us and never need us to move the center point.
    // In fact, we can just use the minimum value. The maximum values will stick out, but can't touch us (by definition)
    if( y_bounds.x < 0 ) {
        point_rel_ms diff_from_player_pos = dp.xy() - who.grab_point.xy();
        if( diff_from_player_pos.x() > 0 ) {
            diff_from_player_pos.x() = diff_from_player_pos.x() + std::abs( y_bounds.x );
        } else if( diff_from_player_pos.x() < 0 ) {
            diff_from_player_pos.x() = diff_from_player_pos.x() - std::abs( y_bounds.x );
        } else if( diff_from_player_pos.y() > 0 ) {
            diff_from_player_pos.y() = diff_from_player_pos.y() + std::abs( y_bounds.x );
        } else if( diff_from_player_pos.y() < 0 ) {
            diff_from_player_pos.y() = diff_from_player_pos.y() - std::abs( y_bounds.x );
        }

        new_dp = dp + diff_from_player_pos;
    }





    // Needs to adjust dp to account for vehicle size. e.g. we don't want to put a 1x3 bike right next to us, it'll clip through us!
    // Also we need to change rotation of the vehicle so it always faces away from our current pos. (allowing a degree of choice in how you push/pull something up stairs
    // But we can't turn it while down there, and we can't turn it after putting it up? (I think??)
    const std::string vehicle_name = grabbed_vehicle->disp_name();
    here.displace_vehicle( *grabbed_vehicle, new_dp );
    // TODO: Vehicle should angle away.
    here.rebuild_vehicle_level_caches();

    // FIXME? Update our grab position instead?
    if( !lifetime ) {
        return true;
    }
    who.grab( object_type::NONE );
    who.add_msg_if_player( _( "You finish dragging the %s past the stairs." ), vehicle_name );

    return true;
}

bool game::grabbed_veh_move( Character &who, const tripoint_rel_ms &dp )
{
    map &here = get_map();
    if( who.get_grab_type() != object_type::VEHICLE || !who.validate_grab( here ) ) {
        who.grab( object_type::NONE );
        return false;
    }
    const character_action_guard lifetime( who );
    const auto operator_position = who.pos_abs();
    const auto generation = who.grab_generation();

    const optional_vpart_position grabbed_vehicle_vp = here.veh_at( who.pos_bub(
                here ) + who.grab_point );
    if( !grabbed_vehicle_vp ) {
        who.add_msg_if_player( m_info, _( "No vehicle at grabbed point." ) );
        who.grab( object_type::NONE );
        return false;
    }
    vehicle *grabbed_vehicle = &grabbed_vehicle_vp->vehicle();
    const int64_t vehicle_id = grabbed_vehicle->uid().get_value();
    const int grabbed_part = who.grabbed_vehicle_part( here );
    const int64_t part_id = grabbed_vehicle->part( grabbed_part ).get_base().uid().get_value();
    if( !grabbed_vehicle->handle_potential_theft( who, false,
            !who.is_player_controlled() || who.is_avatar() ) || !lifetime ) {
        return true;
    }
    if( who.pos_abs() != operator_position || who.grab_generation() != generation ) {
        return true;
    }
    grabbed_vehicle = vehicle::find_vehicle_by_uid( here, vehicle_id );
    const auto part_at_grab = here.veh_at( who.pos_bub() + who.grab_point );
    if( !grabbed_vehicle || !part_at_grab || &part_at_grab->vehicle() != grabbed_vehicle ||
        !who.grab_matches( here ) || who.grabbed_vehicle_part( here ) != grabbed_part ) {
        who.grab( object_type::NONE );
        return true;
    }
    if( monster *mon = grabbed_vehicle->get_harnessed_animal( here ) ) {
        who.add_msg_if_player( m_info, _( "You cannot move this vehicle whilst your %s is harnessed!" ),
                               mon->get_name() );
        who.grab( object_type::NONE );
        return false;
    }
    const vehicle *veh_under_player = veh_pointer_or_null( here.veh_at( who.pos_bub( here ) ) );
    if( grabbed_vehicle == veh_under_player ) {
        // Walking across the vehicle deliberately transfers the handhold to
        // the tile being left, rather than implicitly accepting a new part.
        who.rebind_grab( here, who.pos_bub( here ) );
        who.grab_point = - dp;
        return false;
    }

    tripoint_rel_ms dp_veh = - who.grab_point;
    const tripoint_rel_ms prev_grab = who.grab_point;
    tripoint_rel_ms next_grab = who.grab_point;
    const tileray initial_veh_face = grabbed_vehicle->face;

    const bool veh_has_solid = !empty( grabbed_vehicle->get_avail_parts( VPFLAG_OBSTACLE ) );
    const bool veh_single_tile = grabbed_vehicle->get_points().size() == 1;
    bool zigzag = false;
    bool pushing = false;
    bool pulling = false;

    if( dp == prev_grab ) {
        // We are pushing in the direction of vehicle
        dp_veh = dp;
        pushing = true;
    } else if( std::abs( dp.x() + dp_veh.x() ) != 2 && std::abs( dp.y() + dp_veh.y() ) != 2 ) {
        // Not actually moving the vehicle, don't do the checks
        add_msg_debug( debugmode::DF_ACTIVITY,
                       "grabbed_veh_move: SIDEWAYS dp=(%d,%d) grab=(%d,%d)->(%d,%d)",
                       dp.x(), dp.y(), prev_grab.x(), prev_grab.y(),
                       -( dp.x() + dp_veh.x() ), -( dp.y() + dp_veh.y() ) );
        who.grab_point = - ( dp + dp_veh );
        return false;
    } else if( ( dp.x() == prev_grab.x() || dp.y() == prev_grab.y() ) &&
               next_grab.x() != 0 && next_grab.y() != 0 ) {
        // Zig-zag (or semi-zig-zag) pull: player is diagonal to vehicle
        // and moves away from it, but not directly away
        dp_veh.x() = dp.x() == -dp_veh.x() ? 0 : dp_veh.x();
        dp_veh.y() = dp.y() == -dp_veh.y() ? 0 : dp_veh.y();

        next_grab = - dp_veh;
        zigzag = true;
    } else {
        // We are pulling the vehicle
        next_grab = - dp;
        pulling = true;
    }

    add_msg_debug( debugmode::DF_ACTIVITY,
                   "grabbed_veh_move: %s dp=(%d,%d) grab=(%d,%d) dp_veh=(%d,%d) next_grab=(%d,%d)",
                   pushing ? "PUSH" : pulling ? "PULL" : zigzag ? "ZIGZAG" : "???",
                   dp.x(), dp.y(), prev_grab.x(), prev_grab.y(),
                   dp_veh.x(), dp_veh.y(), next_grab.x(), next_grab.y() );

    // Make sure the mass and pivot point are correct
    grabbed_vehicle->invalidate_mass();

    //vehicle movement: strength check. very strong humans can move about 2,000 kg in a wheelbarrow.
    // worst case scenario strength required to move vehicle.
    const int max_str_req = grabbed_vehicle->total_mass( here ) / 10_kilogram;
    // actual strength required to move vehicle.
    int str_req = 0;
    // ARM_STR governs dragging heavy things
    int str = who.get_arm_str();

    bool bad_veh_angle = false;
    bool invalid_veh_turndir = false;
    bool invalid_veh_face = false;
    bool back_of_vehicle = false;
    bool valid_wheels = false;

    //if vehicle is rollable we modify str_req based on a function of movecost per wheel.
    valid_wheels = grabbed_vehicle->valid_wheel_config( here );
    if( valid_wheels ) {
        //check for bad push/pull angle
        if( veh_has_solid && !veh_single_tile && grabbed_vehicle->steering_effectiveness( here ) > 0 ) {
            tileray my_dir;
            my_dir.init( dp.xy() );
            units::angle face_delta = angle_delta( grabbed_vehicle->face.dir(), my_dir.dir() );

            tileray my_pos_dir;
            tripoint_rel_ms my_angle = who.pos_bub( here ) - grabbed_vehicle->pos_bub( here );
            my_pos_dir.init( my_angle.xy() );
            back_of_vehicle = ( angle_delta( grabbed_vehicle->face.dir(), my_pos_dir.dir() ) > 90_degrees );
            invalid_veh_face = ( face_delta > vehicles::steer_increment * 2 - 1_degrees &&
                                 face_delta < 180_degrees - vehicles::steer_increment * 2 + 1_degrees );
            invalid_veh_turndir = ( normalize( angle_delta( grabbed_vehicle->turn_dir,
                                               grabbed_vehicle->face.dir() ), 180_degrees ) > vehicles::steer_increment * 4 - 1_degrees );
            bad_veh_angle = invalid_veh_face || invalid_veh_turndir;
            if( bad_veh_angle ) {
                str_req = max_str_req;
            } else {
                str_req = grabbed_vehicle->drag_str_req_at( here,
                          grabbed_vehicle->pos_bub( here ) );
            }
        } else {
            str_req = grabbed_vehicle->drag_str_req_at( here,
                      grabbed_vehicle->pos_bub( here ) );
        }
    } else {
        str_req = max_str_req;
    }

    //final strength check and outcomes
    ///\ARM_STR determines ability to drag vehicles
    if( str_req <= str ) {
        if( str_req == max_str_req ) {
            //if vehicle has no wheels, make a noise.
            sounds::sound( grabbed_vehicle->pos_bub( here ), str_req * 2, sounds::sound_t::movement,
                           _( "a scraping noise." ), true, "misc", "scraping" );
        }
        //calculate exertion factor and movement penalty
        ///\EFFECT_STR increases speed of dragging vehicles
        who.mod_moves( -to_moves<int>( 4_seconds )  * str_req / std::max( 1, str ) );
        ///\EFFECT_STR decreases stamina cost of dragging vehicles
        who.burn_energy_all( -200 * str_req / std::max( 1, str ) );
        const int ex = dice( 1, 6 ) - 1 + str_req;
        if( ex > str + 1 ) {
            // Pain and movement penalty if exertion exceeds character strength
            who.add_msg_if_player( m_bad, _( "You strain yourself to move the %s!" ), grabbed_vehicle->name );
            who.mod_moves( -to_moves<int>( 2_seconds ) );
            who.mod_pain( 1 );
            if( !lifetime || !vehicle::find_vehicle_by_uid( here, vehicle_id ) ) {
                return true;
            }
        } else if( ex >= str ) {
            // Movement is slow if exertion nearly equals character strength
            who.add_msg_if_player( _( "It takes some time to move the %s." ), grabbed_vehicle->name );
            who.mod_moves( -to_moves<int>( 2_seconds ) );
        }
    } else {
        if( invalid_veh_face ) {
            who.add_msg_if_player( m_bad, _( "The %s is at too sharp an angle to move like this!" ),
                                   grabbed_vehicle->name );
        }
        if( invalid_veh_turndir ) {
            who.add_msg_if_player( m_bad, _( "The %s is steered too far to move like this!" ),
                                   grabbed_vehicle->name );
        }
        if( !bad_veh_angle ) {
            who.add_msg_if_player( m_bad, _( "You lack the strength to move the %s." ), grabbed_vehicle->name );
        }
        add_msg_debug( debugmode::DF_ACTIVITY,
                       "grabbed_veh_move: STR FAIL str_req=%d str=%d angle=%d",
                       str_req, str, bad_veh_angle ? 1 : 0 );
        who.mod_moves( -to_moves<int>( 1_seconds ) );
        return true;
    }

    if( !lifetime || who.pos_abs() != operator_position || who.grab_generation() != generation ||
        who.get_grab_type() != object_type::VEHICLE ) {
        return true;
    }
    grabbed_vehicle = vehicle::find_vehicle_by_uid( here, vehicle_id );
    if( !grabbed_vehicle || grabbed_part >= grabbed_vehicle->part_count() ||
        grabbed_vehicle->part( grabbed_part ).removed ||
        grabbed_vehicle->part( grabbed_part ).get_base().uid().get_value() != part_id ) {
        who.grab( object_type::NONE );
        return true;
    }
    std::string blocker_name = _( "errors in movement code" );
    const auto get_move_dir = [&]( const tripoint_rel_ms & md_dp_veh,
    const tripoint_rel_ms & md_next_grab ) {
        tileray mdir;

        mdir.init( md_dp_veh.xy() );
        units::angle turn = normalize( mdir.dir() - grabbed_vehicle->face.dir() );
        if( grabbed_vehicle->is_on_ramp && turn == 180_degrees ) {
            who.add_msg_if_player( m_bad, _( "The %s can't be turned around while on a ramp." ),
                                   grabbed_vehicle->name );
            return tripoint_rel_ms::zero;
        }
        units::angle precalc_dir = grabbed_vehicle->face.dir();
        if( veh_has_solid && !bad_veh_angle && !veh_single_tile ) {
            //get rotation direction
            units::angle abs_turn_delta = angle_delta( grabbed_vehicle->face.dir(), grabbed_vehicle->turn_dir );
            if( abs_turn_delta != 0_degrees ) {
                //angle values lose exact precision during calculation
                int clockwise = std::abs( normalize( grabbed_vehicle->face.dir() + abs_turn_delta ).value() -
                                          normalize( grabbed_vehicle->turn_dir ).value() ) < 0.1 ? 1 : -1;
                units::angle turn_delta = abs_turn_delta * clockwise;
                // mirror turn for given cases
                if( ( pushing && !back_of_vehicle ) || ( pulling && back_of_vehicle ) ) {
                    turn_delta *= -1;
                }
                grabbed_vehicle->turn_dir = normalize( grabbed_vehicle->face.dir() + turn_delta );
                grabbed_vehicle->face = tileray( grabbed_vehicle->turn_dir );
                precalc_dir = grabbed_vehicle->face.dir();
            }
        }
        //bad angle only applies to solid vehicles
        else if( !veh_has_solid || veh_single_tile ) {
            grabbed_vehicle->turn( turn );
            grabbed_vehicle->face = tileray( grabbed_vehicle->turn_dir );
            precalc_dir = mdir.dir();
        }
        grabbed_vehicle->precalc_mounts( 1, precalc_dir, grabbed_vehicle->pivot_point( here ) );
        grabbed_vehicle->pos -= grabbed_vehicle->pivot_displacement().raw();

        // Grabbed part has to stay at distance 1 to the player
        // and in roughly the same direction.
        const tripoint_bub_ms new_part_pos = grabbed_vehicle->pos_bub( here ) +
                                             grabbed_vehicle->part( grabbed_part ).precalc[1];
        const tripoint_bub_ms expected_pos = who.pos_bub( here ) + dp + md_next_grab;
        tripoint_rel_ms actual_dir = tripoint_rel_ms( ( expected_pos - new_part_pos ).xy(), 0 );

        bool failed = false;
        bool actual_diff = false;
        tripoint_rel_ms skip = pushing ? who.grab_point : dp;
        if( veh_has_solid ) {
            //avoid player collision from vehicle turning
            bool no_player_collision = false;
            while( !no_player_collision ) {
                no_player_collision = true;
                for( const vpart_reference &vp : grabbed_vehicle->get_all_parts() ) {
                    if( grabbed_vehicle->pos_bub( here ) +
                        vp.part().precalc[1] + actual_dir == who.pos_bub( here ) + skip ) {
                        no_player_collision = false;
                        break;
                    }
                }
                if( !no_player_collision ) {
                    actual_dir += who.grab_point;
                    no_player_collision = false;
                    actual_diff = true;
                }
            }
            if( actual_diff ) {
                who.add_msg_if_player( _( "You let go of the %s as it turns." ), grabbed_vehicle->disp_name() );
                who.grab( object_type::NONE );
                who.grab_point = tripoint_rel_ms::zero;
            }
        }
        // Set player location to illegal value so it can't collide with vehicle.
        const tripoint_abs_ms player_prev = who.pos_abs( );
        who.setpos( here, tripoint_bub_ms::zero, false );
        std::vector<veh_collision> colls;
        failed = grabbed_vehicle->collision( here, colls, actual_dir, true );
        who.setpos( player_prev );
        if( !colls.empty() ) {
            blocker_name = colls.front().target_name;
        }

        return failed ? tripoint_rel_ms::invalid : actual_dir;
    };

    // First try the move as intended
    // But if that fails and the move is a zig-zag, try to recover:
    // Try to place the vehicle in the position player just left rather than "flattening" the zig-zag
    tripoint_rel_ms final_dp_veh = get_move_dir( dp_veh, next_grab );
    if( final_dp_veh == tripoint_rel_ms::invalid && zigzag ) {
        final_dp_veh = get_move_dir( - prev_grab, - dp );
        next_grab = - dp;
    }

    if( final_dp_veh == tripoint_rel_ms::invalid ) {
        who.add_msg_if_player( _( "The %s collides with %s." ), grabbed_vehicle->name, blocker_name );
        add_msg_debug( debugmode::DF_ACTIVITY,
                       "grabbed_veh_move: COLLISION with '%s' dp_veh=(%d,%d)",
                       blocker_name, dp_veh.x(), dp_veh.y() );
        who.grab_point = prev_grab;
        grabbed_vehicle->face = initial_veh_face;
        return true;
    }

    //if grab was already released, do not set grab again
    if( who.grab_point != tripoint_rel_ms::zero ) {
        who.grab_point = next_grab;
    }

    add_msg_debug( debugmode::DF_ACTIVITY,
                   "grabbed_veh_move: SUCCESS displacing veh by (%d,%d) new_grab=(%d,%d)",
                   final_dp_veh.x(), final_dp_veh.y(), next_grab.x(), next_grab.y() );

    here.displace_vehicle( *grabbed_vehicle, final_dp_veh );
    here.rebuild_vehicle_level_caches();
    if( !lifetime ) {
        return true;
    }
    grabbed_vehicle = vehicle::find_vehicle_by_uid( here, vehicle_id );
    if( grabbed_vehicle ) {
        here.level_vehicle( *grabbed_vehicle );
        grabbed_vehicle = vehicle::find_vehicle_by_uid( here, vehicle_id );
        if( !lifetime || !grabbed_vehicle ) {
            return true;
        }
        grabbed_vehicle->check_falling_or_floating();
        if( grabbed_vehicle->is_falling ) {
            who.add_msg_if_player( _( "You let go of the %1$s as it starts to fall." ),
                                   grabbed_vehicle->disp_name() );
            who.grab( object_type::NONE );
            who.grab_point = tripoint_rel_ms::zero;
            here.set_seen_cache_dirty( grabbed_vehicle->pos_bub( here ) );
            return true;
        }
    } else {
        debugmsg( "Grabbed vehicle disappeared" );
        return false;
    }

    std::vector<int64_t> wheels;
    for( int index : grabbed_vehicle->wheelcache ) {
        wheels.push_back( grabbed_vehicle->part( index ).get_base().uid().get_value() );
    }
    for( int64_t wheel : wheels ) {
        if( one_in( 2 ) ) {
            for( const vpart_reference &part : grabbed_vehicle->get_all_parts() ) {
                if( part.part().get_base().uid().get_value() == wheel ) {
                    const auto position = part.pos_bub( here );
                    grabbed_vehicle->handle_trap( &here, position, part.part() );
                    break;
                }
            }
            if( !lifetime ) {
                return true;
            }
            grabbed_vehicle = vehicle::find_vehicle_by_uid( here, vehicle_id );
            if( !grabbed_vehicle ) {
                who.grab( object_type::NONE );
                return true;
            }
        }
    }

    return false;

}
