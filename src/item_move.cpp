#include "item_move.h"

#include <algorithm>
#include <cstddef>
#include <list>
#include <optional>
#include <set>

#include "activity_actor_definitions.h"
#include "activity_handlers.h"
#include "character.h"
#include "character_action_guard.h"
#include "contents_change_handler.h"
#include "crafting.h"
#include "flag.h"
#include "item.h"
#include "item_pocket.h"
#include "item_stack.h"
#include "json.h"
#include "line.h"
#include "map.h"
#include "messages.h"
#include "mp_client_conn.h"
#include "mp_inventory_activity.h"
#include "pickup.h"
#include "player_activity.h"
#include "ret_val.h"
#include "translations.h"
#include "vehicle.h"
#include "vehicle_selector.h"
#include "vpart_position.h"
#include "vpart_range.h"

namespace
{
constexpr size_t max_selection = 4096;

bool adjacent( const tripoint_abs_ms &origin, const tripoint_abs_ms &target )
{
    const int64_t dx = static_cast<int64_t>( target.x() ) - origin.x();
    const int64_t dy = static_cast<int64_t>( target.y() ) - origin.y();
    return origin.z() == target.z() && dx >= -1 && dx <= 1 && dy >= -1 && dy <= 1;
}

bool usable_cargo( const vpart_reference &cargo )
{
    return cargo.part().is_available() && !cargo.part().is_cleaner_on();
}

bool destination_matches( Character &who, map &here, const item_move_selection &selection )
{
    if( who.pos_abs() != selection.origin ||
        !adjacent( selection.origin, selection.target.position ) ||
        selection.target.tool_source || !selection.target.matches( here ) ) {
        return false;
    }
    const auto pos = here.get_bub( selection.target.position );
    if( selection.cargo == 0 ) {
        return here.can_put_items_ter_furn( pos );
    }
    const auto cargo = here.veh_at( pos ).cargo();
    return cargo && usable_cargo( *cargo ) && cargo->part().get_base().uid().get_value() == selection.cargo;
}

item_location resolve_movable( Character &who, map &here, const item_move_selection &selection,
                               const item_source &identity, int quantity )
{
    if( quantity <= 0 || identity.path.empty() ||
        ( identity.kind != "carried" && identity.kind != "map" && identity.kind != "vehicle" ) ||
        ( identity.kind != "carried" && !adjacent( selection.origin, identity.position ) ) ) {
        return item_location();
    }
    item_location source = resolve_item_source( who, here, identity );
    if( !source || source->count() < quantity || !who.can_drop( *source ).success() ||
        activity_handlers::activity_item_reserved_for_other( *source, who ) ||
        ( !source->is_owned_by( who, true ) &&
          who.get_value( "THIEF_MODE" ).str() != "THIEF_STEAL" ) ||
        ( !selection.dropping && !source->made_of_from_type( phase_id::SOLID ) ) ||
        ( selection.cargo != 0 && source->is_bucket_nonempty() ) ||
        ( who.is_worn( *source ) && ( source->count() != 1 || !who.can_takeoff( *source ).success() ) ) ) {
        return item_location();
    }
    if( !can_remove_from_item_pockets( who, source ) ) {
        return item_location();
    }
    if( !source.held_by( who ) ) {
        const tripoint_bub_ms pos = source.pos_bub( here );
        const tripoint_bub_ms origin = who.pos_bub( here );
        if( !here.inbounds( pos ) || !here.accessible_items( pos ) ||
            ( pos != origin && !here.clear_path( origin, pos, 1, 1, 100 ) ) ||
            ( selection.dropping && !source.has_parent() ) ) {
            return item_location();
        }
        if( identity.kind == "vehicle" ) {
            item_location root = source;
            while( root.has_parent() ) {
                root = root.parent_item();
            }
            const vehicle_cursor *cursor = root.veh_cursor();
            const auto cargo = here.veh_at( pos ).cargo();
            if( !cursor || !cargo || &cursor->veh != &cargo->vehicle() ||
                cursor->part < 0 || static_cast<size_t>( cursor->part ) != cargo->part_index() ||
                !usable_cargo( *cargo ) ) {
                return item_location();
            }
        }
        if( !source.has_parent() && source.pos_abs() == selection.target.position &&
            ( ( identity.kind == "vehicle" ) == ( selection.cargo != 0 ) ) ) {
            return item_location();
        }
    }
    return source;
}

int insert_cargo( map &here, const vpart_reference &cargo, item &portion )
{
    vehicle &veh = cargo.vehicle();
    vehicle_part &part = cargo.part();
    if( portion.made_of( phase_id::LIQUID ) ) {
        return 0;
    }
    const int fits = veh.get_items( part ).amount_can_fit( portion );
    if( fits <= 0 ) {
        return 0;
    }
    const int count = std::min( portion.count(), fits );
    item fitted( portion );
    if( fitted.count_by_charges() ) {
        fitted.charges = count;
    }
    // The source validator excludes open buckets. Cargo insertion for other
    // items only updates the stack and its caches, so debit can follow it.
    const auto added = veh.add_item( here, part, fitted );
    if( !added ) {
        return 0;
    }
    craft_relocated( item_location( vehicle_cursor( veh, cargo.part_index() ), &**added ) );
    if( portion.count_by_charges() ) {
        portion.charges -= count;
    }
    return count;
}

int place_item( Character &who, map &here, const item_move_selection &selection,
                item_location source, item portion )
{
    const tripoint_bub_ms dest = here.get_bub( selection.target.position );
    const auto cargo = selection.cargo != 0 ? here.veh_at( dest ).cargo() : std::nullopt;
    if( who.is_worn( *source ) ) {
        std::list<item> removed;
        const character_action_guard lifetime( who );
        const auto context = here.get_context_reference();
        if( !who.takeoff( source, &removed ) || removed.empty() || !lifetime || !context ) {
            return 0;
        }
        const int count = removed.front().count();
        portion = std::move( removed.front() );
        const bool destination_available = destination_matches( who, here, selection );
        const auto current_cargo = destination_available && selection.cargo != 0 ?
                                   here.veh_at( here.get_bub( selection.target.position ) ).cargo() : std::nullopt;
        const int loaded = current_cargo ? insert_cargo( here, *current_cargo, portion ) : 0;
        if( loaded == count ) {
            return count;
        }
        // Takeoff events already ran. Retain an item whose selected destination
        // was replaced by an event, or which does not fit there.
        if( destination_available ) {
            const item_location placed = here.add_item_or_charges_ret_loc( here.get_bub(
                                             selection.target.position ), portion, true );
            if( placed ) {
                craft_relocated( placed );
                return count;
            }
        }
        who.i_add( portion );
        return loaded;
    }

    const int loaded = cargo ? insert_cargo( here, *cargo, portion ) : 0;
    if( loaded > 0 ) {
        if( source->count_by_charges() && source->charges > loaded ) {
            source->charges -= loaded;
            source.on_contents_changed();
        } else {
            source.remove_item();
            return loaded;
        }
    }
    if( !portion.count_by_charges() || portion.charges > 0 ) {
        item_location placed;
        const int dropped = here.transfer_item_or_charges( dest, source, std::move( portion ),
                            who, 1, true, &placed );
        if( placed ) {
            craft_relocated( placed );
        }
        return loaded + dropped;
    }
    return loaded;
}
} // namespace

void item_move_selection::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "origin", origin );
    out.member( "target", target );
    out.member( "cargo", cargo );
    out.member( "dropping", dropping );
    out.member( "items", items );
    out.end_object();
}

void item_move_selection::deserialize( const JsonObject &data )
{
    data.read( "origin", origin, true );
    data.read( "target", target, true );
    cargo = data.get_int64( "cargo" );
    dropping = data.get_bool( "dropping" );
    if( data.get_array( "items" ).size() > max_selection ) {
        data.throw_error_at( "items", "Too many items to move" );
    }
    data.read( "items", items, true );
}

bool submit_client_item_move( Character &who, const drop_locations &items,
                              const tripoint_bub_ms &target, item_move_destination mode, bool dropping )
{
    if( !who.is_avatar() || !cata_mp::is_client_mode() ) {
        return false;
    }
    map &here = get_map();
    if( items.empty() || !here.inbounds( target ) ) {
        return true;
    }
    item_move_selection selection;
    selection.origin = who.pos_abs();
    selection.target = tool_activity_target::capture( here, here.get_abs( target ) );
    selection.dropping = dropping;
    if( mode != item_move_destination::ground ) {
        if( const auto cargo = here.veh_at( target ).cargo() ) {
            selection.cargo = cargo->part().get_base().uid().get_value();
        } else if( mode == item_move_destination::cargo ) {
            return true;
        }
    }
    for( const auto &[source, requested] : items ) {
        if( source && source->count() > 0 && requested >= 0 ) {
            if( selection.cargo && source->is_bucket_nonempty() ) {
                who.add_msg_if_player( _( "Empty spillable containers before storing them in multiplayer." ) );
                continue;
            }
            const int quantity = requested > 0 && source->count_by_charges() ? requested : source->count();
            selection.items.emplace_back( capture_item_source( who, source ), quantity );
        }
    }
    if( !selection.items.empty() ) {
        cata_mp::client_start_item_move( selection );
    }
    return true;
}

bool start_owned_item_move( Character &who, map &here, item_move_selection selection )
{
    if( who.activity || who.get_moves() <= 0 || who.is_dead_state() || selection.cargo < 0 ||
        selection.items.empty() || selection.items.size() > max_selection ||
        !destination_matches( who, here, selection ) ) {
        return false;
    }
    std::set<int64_t> seen;
    for( const auto &[source, quantity] : selection.items ) {
        if( source.path.empty() || !seen.insert( source.path.back() ).second || quantity <= 0 ) {
            return false;
        }
    }
    const auto available = [&]( const auto &entry ) {
        return static_cast<bool>( resolve_movable( who, here, selection, entry.first, entry.second ) );
    };
    if( std::none_of( selection.items.begin(), selection.items.end(), available ) ) {
        return false;
    }
    if( selection.dropping ) {
        std::reverse( selection.items.begin(), selection.items.end() );
    }
    player_activity activity{ move_items_activity_actor( std::move( selection ), who.getID() ) };
    activity.set_execution( activity_execution::authoritative );
    who.assign_activity( activity );
    return static_cast<bool>( who.activity );
}

void do_owned_item_move( Character &who, player_activity &activity, item_move_selection &selection )
{
    map &here = get_map();
    const character_action_guard lifetime( who );
    const auto context = here.get_context_reference();
    const uint64_t generation = activity.identity_generation();
    const auto active = [&]() {
        return lifetime && context && who.activity.identity_generation() == generation;
    };
    // Snapshot the endpoint independently of the queue. A drop effect may
    // cancel or replace the activity while the transfer is in progress.
    item_move_selection endpoint;
    endpoint.origin = selection.origin;
    endpoint.target = selection.target;
    endpoint.cargo = selection.cargo;
    endpoint.dropping = selection.dropping;
    contents_change_handler containers;
    while( active() && who.get_moves() > 0 && !selection.items.empty() ) {
        if( !destination_matches( who, here, endpoint ) ) {
            break;
        }
        auto [identity, quantity] = std::move( selection.items.back() );
        selection.items.pop_back();
        item_location source = resolve_movable( who, here, endpoint, identity, quantity );
        if( !source ) {
            continue;
        }
        item portion( *source );
        if( portion.count_by_charges() ) {
            portion.charges = quantity;
        }
        const int distance = std::max( 1, static_cast<int>( trig_dist( source.pos_bub( here ),
                                       here.get_bub( endpoint.target.position ) ) ) );
        const int cost = endpoint.dropping ? source.obtain_cost( who, quantity ) :
                         Pickup::cost_to_move_item( who, portion ) * distance /
                         who.exertion_adjusted_move_multiplier( activity.exertion_level() );
        portion.handle_pickup_ownership( who );
        if( !active() || !destination_matches( who, here, endpoint ) ) {
            break;
        }
        source = resolve_movable( who, here, endpoint, identity, quantity );
        if( !source ) {
            continue;
        }
        containers.unseal_pocket_containing( source );
        if( !active() ) {
            break;
        }
        source = resolve_movable( who, here, endpoint, identity, quantity );
        if( !source ) {
            continue;
        }
        // Re-read the item after ownership and pocket handling, which can
        // replace its contents even when the selected UID is still live.
        const faction_id owner = portion.get_owner();
        item moving( *source );
        if( moving.get_owner() != owner ) {
            moving.set_owner( owner );
        }
        if( moving.count_by_charges() ) {
            moving.charges = quantity;
        }
        const std::string name = moving.tname();
        const int placed = place_item( who, here, endpoint, source, std::move( moving ) );
        if( !active() ) {
            break;
        }
        if( placed > 0 ) {
            who.mod_moves( -std::max( 1, cost ) );
            who.invalidate_weight_carried_cache();
            who.invalidate_crafting_inventory();
            who.set_check_encumbrance( true );
            who.add_msg_if_player( _( "You move %s." ), name );
        }
    }
    if( lifetime && context ) {
        containers.handle_by( who );
    }
    if( active() && ( selection.items.empty() || !destination_matches( who, here, endpoint ) ) ) {
        activity.set_to_null();
    }
}

void append_item_move_tiles( const item_move_selection &selection,
                             std::vector<tripoint_abs_ms> &changed_tiles )
{
    std::set<tripoint_abs_ms> affected{ selection.target.position };
    for( const auto &entry : selection.items ) {
        if( entry.first.kind != "carried" && adjacent( selection.origin, entry.first.position ) ) {
            affected.insert( entry.first.position );
        }
    }
    changed_tiles.insert( changed_tiles.end(), affected.begin(), affected.end() );
}
