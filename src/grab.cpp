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
#include "creature_tracker.h"
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
#include "walking.h"
#include "world_position.h"

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

bool game::grabbed_veh_move( Character &who, const tripoint_rel_ms &dp,
                             const walk_move_choices *choices, const fractional_walk *step )
{
    map &here = get_map();
    if( who.get_grab_type() != object_type::VEHICLE || !who.validate_grab( here ) ) {
        who.grab( object_type::NONE );
        return step != nullptr;
    }
    const character_action_guard lifetime( who );
    const world_position operator_position = who.pos_world();
    const auto context = here.get_context_reference();
    const tripoint_abs_sm map_origin = here.get_abs_sub();
    const auto generation = who.grab_generation();
    const auto still_holding = [&]() {
        return lifetime && context && &get_map() == &here && here.get_abs_sub() == map_origin &&
               who.pos_world() == operator_position && who.grab_generation() == generation;
    };

    const optional_vpart_position grabbed_vehicle_vp = here.veh_at( who.pos_bub(
                here ) + who.grab_point );
    if( !grabbed_vehicle_vp ) {
        who.add_msg_if_player( m_info, _( "No vehicle at grabbed point." ) );
        who.grab( object_type::NONE );
        return step != nullptr;
    }
    vehicle *grabbed_vehicle = &grabbed_vehicle_vp->vehicle();
    const int64_t vehicle_id = grabbed_vehicle->uid().get_value();
    const int grabbed_part = who.grabbed_vehicle_part( here );
    if( grabbed_part < 0 ) {
        who.grab( object_type::NONE );
        return step != nullptr;
    }
    const int64_t part_id = grabbed_vehicle->part( grabbed_part ).get_base().uid().get_value();
    if( choices && grabbed_vehicle->has_owner() && !grabbed_vehicle->is_owned_by( who ) &&
        !choices->permits_theft( *grabbed_vehicle ) ) {
        return true;
    }
    if( !grabbed_vehicle->handle_potential_theft( who, false,
            !choices && ( !who.is_player_controlled() || who.is_avatar() ) ) || !still_holding() ) {
        return true;
    }
    grabbed_vehicle = vehicle::find_vehicle_by_uid( here, vehicle_id );
    const auto part_at_grab = here.veh_at( who.pos_bub( here ) + who.grab_point );
    if( !grabbed_vehicle || !part_at_grab || &part_at_grab->vehicle() != grabbed_vehicle ||
        !who.grab_matches( here ) || who.grabbed_vehicle_part( here ) != grabbed_part ) {
        who.grab( object_type::NONE );
        return true;
    }
    if( monster *mon = grabbed_vehicle->get_harnessed_animal( here ) ) {
        who.add_msg_if_player( m_info, _( "You cannot move this vehicle whilst your %s is harnessed!" ),
                               mon->get_name() );
        who.grab( object_type::NONE );
        return step != nullptr;
    }
    const tripoint_rel_ms motion = step ?
                                   tripoint_rel_ms( sgn( step->displacement.x ), sgn( step->displacement.y ), 0 ) : dp;
    if( step && ( !step->drags_vehicle( who ) ||
                  !grabbed_vehicle->supports_fractional_drag( here, motion.raw().xy() ) ) ) {
        return true;
    }
    const bool within_cell = step && dp == tripoint_rel_ms::zero;
    const auto move_cost = [&]( int grid_cost ) {
        return step && grid_cost > 0 ? step->scale_cost( grid_cost ) : grid_cost;
    };
    const vehicle *veh_under_player = veh_pointer_or_null( here.veh_at( who.pos_bub( here ) ) );
    if( grabbed_vehicle == veh_under_player ) {
        // Walking across the vehicle deliberately transfers the handhold to
        // the tile being left, rather than implicitly accepting a new part.
        if( step ) {
            return true;
        }
        who.rebind_grab( here, who.pos_bub( here ) );
        who.grab_point = - dp;
        return false;
    }

    tripoint_rel_ms dp_veh = - who.grab_point;
    const tripoint_rel_ms prev_grab = who.grab_point;
    tripoint_rel_ms next_grab = who.grab_point;

    const bool veh_has_solid = !empty( grabbed_vehicle->get_avail_parts( VPFLAG_OBSTACLE ) );
    const bool veh_single_tile = grabbed_vehicle->get_points().size() == 1;
    bool zigzag = false;
    bool pushing = false;
    bool pulling = false;

    if( motion == prev_grab ) {
        // We are pushing in the direction of vehicle
        dp_veh = motion;
        pushing = true;
    } else if( std::abs( motion.x() + dp_veh.x() ) != 2 && std::abs( motion.y() + dp_veh.y() ) != 2 ) {
        // Not actually moving the vehicle, don't do the checks
        add_msg_debug( debugmode::DF_ACTIVITY,
                       "grabbed_veh_move: SIDEWAYS dp=(%d,%d) grab=(%d,%d)->(%d,%d)",
                       dp.x(), dp.y(), prev_grab.x(), prev_grab.y(),
                       -( dp.x() + dp_veh.x() ), -( dp.y() + dp_veh.y() ) );
        who.grab_point = - ( dp + dp_veh );
        return false;
    } else if( ( motion.x() == prev_grab.x() || motion.y() == prev_grab.y() ) &&
               next_grab.x() != 0 && next_grab.y() != 0 ) {
        // Zig-zag (or semi-zig-zag) pull: player is diagonal to vehicle
        // and moves away from it, but not directly away
        dp_veh.x() = dp.x() == -dp_veh.x() ? 0 : dp_veh.x();
        dp_veh.y() = dp.y() == -dp_veh.y() ? 0 : dp_veh.y();

        next_grab = - dp_veh;
        zigzag = true;
    } else {
        // We are pulling the vehicle
        next_grab = - motion;
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
            my_dir.init( motion.xy() );
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
        if( !within_cell && str_req == max_str_req ) {
            //if vehicle has no wheels, make a noise.
            sounds::sound( grabbed_vehicle->pos_bub( here ), str_req * 2, sounds::sound_t::movement,
                           _( "a scraping noise." ), true, "misc", "scraping" );
        }
        //calculate exertion factor and movement penalty
        ///\EFFECT_STR increases speed of dragging vehicles
        who.mod_moves( -move_cost( to_moves<int>( 4_seconds ) * str_req / std::max( 1, str ) ) );
        ///\EFFECT_STR decreases stamina cost of dragging vehicles
        who.burn_energy_all( -move_cost( 200 * str_req / std::max( 1, str ) ) );
        const int ex = within_cell ? 0 : dice( 1, 6 ) - 1 + str_req;
        if( !within_cell && ex > str + 1 ) {
            // Pain and movement penalty if exertion exceeds character strength
            who.add_msg_if_player( m_bad, _( "You strain yourself to move the %s!" ), grabbed_vehicle->name );
            who.mod_moves( -move_cost( to_moves<int>( 2_seconds ) ) );
            who.mod_pain( 1 );
            if( !still_holding() || !vehicle::find_vehicle_by_uid( here, vehicle_id ) ) {
                return true;
            }
        } else if( !within_cell && ex >= str ) {
            // Movement is slow if exertion nearly equals character strength
            who.add_msg_if_player( _( "It takes some time to move the %s." ), grabbed_vehicle->name );
            who.mod_moves( -move_cost( to_moves<int>( 2_seconds ) ) );
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
        who.mod_moves( -move_cost( to_moves<int>( 1_seconds ) ) );
        return true;
    }

    if( !still_holding() || who.get_grab_type() != object_type::VEHICLE ) {
        return true;
    }
    grabbed_vehicle = vehicle::find_vehicle_by_uid( here, vehicle_id );
    if( !grabbed_vehicle || grabbed_part >= grabbed_vehicle->part_count() ||
        grabbed_vehicle->part( grabbed_part ).removed ||
        grabbed_vehicle->part( grabbed_part ).get_base().uid().get_value() != part_id ) {
        who.grab( object_type::NONE );
        return true;
    }
    const auto translate_held_vehicle = [&]() {
        constexpr int stride = world_position::units_per_tile;
        const point settled = grabbed_vehicle->fractional_offset() + step->displacement -
                              dp.xy().raw() * stride;
        if( std::abs( settled.x ) >= stride || std::abs( settled.y ) >= stride ||
            !grabbed_vehicle->can_drag_fractionally( here, step->displacement, who ) ) {
            who.add_msg_if_player( _( "The %s is blocked." ), grabbed_vehicle->name );
            return false;
        }
        if( !within_cell ) {
            const tripoint_bub_ms destination = who.pos_bub( here ) + dp;
            const Creature *occupant = get_creature_tracker().creature_at( here.get_abs( destination ), true );
            const auto vehicle_at_destination = here.veh_at( destination );
            if( ( occupant && occupant != &who ) || !here.passable_ter_furn( destination ) ||
                ( vehicle_at_destination && &vehicle_at_destination->vehicle() != grabbed_vehicle ) ) {
                return false;
            }
            // Indexing still uses the entire native cell. A destination cell
            // cannot be assigned to both the operator and their held vehicle.
            for( const vpart_reference &part : grabbed_vehicle->get_all_parts_with_fakes() ) {
                if( !part.part().removed && part.pos_bub( here ) + dp == destination ) {
                    return false;
                }
            }
            const auto old_rotation = grabbed_vehicle->pivot_rotation[1];
            const auto old_anchor = grabbed_vehicle->pivot_anchor[1];
            const auto vehicle_ref = grabbed_vehicle->get_safe_reference();
            grabbed_vehicle->precalc_mounts( 1, grabbed_vehicle->pivot_rotation[0],
                                             grabbed_vehicle->pivot_anchor[0] );
            if( !here.displace_vehicle( *grabbed_vehicle, dp, true, {}, settled ) ) {
                grabbed_vehicle->precalc_mounts( 1, old_rotation, old_anchor );
                return false;
            }
            return vehicle_ref && still_holding();
        }
        grabbed_vehicle->set_fractional_offset( settled, vehicle::offset_kind::parked );
        return true;
    };

    std::string blocker_name = _( "errors in movement code" );
    bool releases_grab = false;
    const auto try_displace = [&]( const tripoint_rel_ms & md_dp_veh,
    const tripoint_rel_ms & md_next_grab ) {
        const tileray previous_face = grabbed_vehicle->face;
        const units::angle previous_turn = grabbed_vehicle->turn_dir;
        const units::angle previous_last_turn = grabbed_vehicle->last_turn;
        const auto previous_arc = grabbed_vehicle->turning_arc;
        const units::angle previous_rotation = grabbed_vehicle->pivot_rotation[1];
        const point_rel_ms previous_pivot = grabbed_vehicle->pivot_anchor[1];
        tileray mdir;

        mdir.init( md_dp_veh.xy() );
        units::angle turn = normalize( mdir.dir() - grabbed_vehicle->face.dir() );
        if( grabbed_vehicle->is_on_ramp && turn == 180_degrees ) {
            who.add_msg_if_player( m_bad, _( "The %s can't be turned around while on a ramp." ),
                                   grabbed_vehicle->name );
            blocker_name = _( "the ramp" );
            return tripoint_rel_ms::invalid;
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
        on_out_of_scope restore_pose( [&]() {
            grabbed_vehicle->face = previous_face;
            grabbed_vehicle->turn_dir = previous_turn;
            grabbed_vehicle->last_turn = previous_last_turn;
            grabbed_vehicle->turning_arc = previous_arc;
            grabbed_vehicle->precalc_mounts( 1, previous_rotation, previous_pivot );
        } );

        // Solve for the new pivot position from the held part's intended
        // landing. The current origin still owns the live parts and cache.
        const tripoint_bub_ms vehicle_origin = grabbed_vehicle->pos_bub( here );
        const tripoint_bub_ms new_part_pos = vehicle_origin +
                                             grabbed_vehicle->part( grabbed_part ).precalc[1];
        const tripoint_bub_ms expected_pos = who.pos_bub( here ) + dp + md_next_grab;
        tripoint_rel_ms actual_dir( ( expected_pos - new_part_pos ).xy(), 0 );

        bool shifted_away_from_operator = false;
        if( veh_has_solid ) {
            const tripoint_bub_ms operator_landing = who.pos_bub( here ) +
                ( pushing ? prev_grab : dp );
            const auto overlaps_landing = [&]() {
                for( const vpart_reference &part : grabbed_vehicle->get_all_parts() ) {
                    if( vehicle_origin + part.part().precalc[1] + actual_dir == operator_landing ) {
                        return true;
                    }
                }
                return false;
            };
            while( overlaps_landing() ) {
                // A handhold without a horizontal direction cannot clear this cell.
                if( prev_grab.xy() == point_rel_ms::zero ) {
                    blocker_name = who.disp_name();
                    return tripoint_rel_ms::invalid;
                }
                actual_dir += prev_grab.xy().raw();
                shifted_away_from_operator = true;
            }
        }
        const tripoint_bub_ms proposed_origin = vehicle_origin + actual_dir;
        const tripoint_bub_ms landing = here.ramp_landing( proposed_origin );
        if( !here.has_loaded_submap( proposed_origin ) || !here.has_loaded_submap( landing ) ) {
            blocker_name = _( "the edge of the loaded map" );
            return tripoint_rel_ms::invalid;
        }
        // During a pull the vehicle can enter the operator's old cell.
        // Keep the operator in the creature tracker at their exact position.
        std::vector<veh_collision> colls;
        if( grabbed_vehicle->collision( here, colls, actual_dir, true, false, &who ) ) {
            if( !colls.empty() ) {
                blocker_name = colls.front().target_name;
            }
            return tripoint_rel_ms::invalid;
        }

        if( !grabbed_vehicle->clears_horizontal_sweep( here, actual_dir, &who ) ) {
            blocker_name = _( "an obstacle in the turning path" );
            return tripoint_rel_ms::invalid;
        }
        if( !here.displace_vehicle( *grabbed_vehicle, actual_dir ) ) {
            return tripoint_rel_ms::invalid;
        }
        restore_pose.cancel();
        releases_grab = shifted_away_from_operator;
        return actual_dir;
    };

    // First try the move as intended
    // But if that fails and the move is a zig-zag, try to recover:
    // Try to place the vehicle in the position player just left rather than "flattening" the zig-zag
    tripoint_rel_ms final_dp_veh;
    if( step ) {
        if( !translate_held_vehicle() ) {
            return true;
        }
        if( within_cell ) {
            return false;
        }
        final_dp_veh = dp;
    } else {
        final_dp_veh = try_displace( dp_veh, next_grab );
        if( final_dp_veh == tripoint_rel_ms::invalid && zigzag ) {
            final_dp_veh = try_displace( - prev_grab, - dp );
            next_grab = - dp;
        }
    }

    if( final_dp_veh == tripoint_rel_ms::invalid ) {
        who.add_msg_if_player( _( "The %s collides with %s." ), grabbed_vehicle->name, blocker_name );
        add_msg_debug( debugmode::DF_ACTIVITY,
                       "grabbed_veh_move: COLLISION with '%s' dp_veh=(%d,%d)",
                       blocker_name, dp_veh.x(), dp_veh.y() );
        return true;
    }

    add_msg_debug( debugmode::DF_ACTIVITY,
                   "grabbed_veh_move: SUCCESS displacing veh by (%d,%d) new_grab=(%d,%d)",
                   final_dp_veh.x(), final_dp_veh.y(), next_grab.x(), next_grab.y() );

    if( !context || &get_map() != &here ) {
        return true;
    }
    if( !step ) {
        here.rebuild_vehicle_level_caches();
    }
    if( !still_holding() ) {
        return true;
    }
    grabbed_vehicle = vehicle::find_vehicle_by_uid( here, vehicle_id );
    if( releases_grab ) {
        if( grabbed_vehicle ) {
            who.add_msg_if_player( _( "You let go of the %s as it turns." ), grabbed_vehicle->disp_name() );
        }
        who.grab( object_type::NONE );
    } else {
        who.grab_point = next_grab;
    }
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
    // Fractional movement completes the operator's placement before wheel
    // effects can damage parts or cause a scripted change to either body.
    return step ? false : dragged_vehicle_wheel_traps( who, here, vehicle_id );
}

bool game::dragged_vehicle_wheel_traps( Character &who, map &here, int64_t vehicle_id )
{
    const character_action_guard lifetime( who );
    const auto context = here.get_context_reference();
    vehicle *grabbed_vehicle = vehicle::find_vehicle_by_uid( here, vehicle_id );
    if( !grabbed_vehicle ) {
        return true;
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
            if( !lifetime || !context || &get_map() != &here ) {
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
