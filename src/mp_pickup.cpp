#include "mp_pickup.h"

#include <iterator>
#include <limits>
#include <map>
#include <set>
#include <sstream>
#include <unordered_map>
#include <utility>
#include <vector>

#include "avatar.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "character_action_guard.h"
#include "coordinates.h"
#include "item.h"
#include "item_location.h"
#include "item_pocket.h"
#include "item_source.h"
#include "item_uid.h"
#include "json.h"
#include "map.h"
#include "map_selector.h"
#include "pickup.h"
#include "player_identity.h"
#include "rng.h"
#include <stdexcept>

namespace cata_mp
{
namespace
{
constexpr size_t max_pickup_targets = 4096;

int64_t required_counter( const JsonObject &data, const std::string &name )
{
    int64_t result = 0;
    if( !data.read( name, result ) || result < 0 || result == std::numeric_limits<int64_t>::max() ) {
        data.throw_error_at( name, "Invalid pickup counter" );
    }
    return result;
}
std::string record_inventory_result( const Character &who, int64_t sequence, bool accepted,
                                     pickup_host_state &state )
{
    std::ostringstream text;
    JsonOut out( text );
    out.start_object();
    out.member( "type", "pickup_result" );
    out.member( "request", sequence );
    out.member( "inventory_revision", state.revision + 1 );
    out.member( "complete", accepted );
    out.member( "recoil", who.recoil );
    out.member( "last_item", who.last_item.str() );
    out.member( "carried" );
    who.store_carried_items( out );
    out.end_object();
    state.last_request = sequence;
    ++state.revision;
    state.last_result = text.str();
    return state.last_result;
}
} // namespace

std::optional<std::string> make_pickup_request( const Pickup::selection &selection,
        const map &here, pickup_client_state &state )
{
    if( state.pending_request != 0 || selection.targets.empty() ||
        selection.targets.size() > max_pickup_targets ||
        selection.targets.size() != selection.quantities.size() ||
        state.next_request >= std::numeric_limits<int64_t>::max() - 1 ) {
        return std::nullopt;
    }
    for( size_t i = 0; i < selection.targets.size(); ++i ) {
        const item_location &target = selection.targets[i];
        if( !target || ( target.where_recursive() != item_location::type::map &&
                         target.where_recursive() != item_location::type::vehicle ) ||
            !target->uid().is_valid() || selection.quantities[i] < 0 ) {
            return std::nullopt;
        }
    }
    std::ostringstream text;
    JsonOut out( text );
    out.start_object();
    out.member( "type", "action" );
    out.member( "action", "pickup" );
    out.member( "request", state.next_request + 1 );
    out.member( "inventory_revision", state.revision );
    out.member( "autopickup", selection.autopickup );
    out.member( "items" );
    out.start_array();
    for( size_t i = 0; i < selection.targets.size(); ++i ) {
        const item_location &target = selection.targets[i];
        out.start_object();
        out.member( "uid", target->uid().get_value() );
        out.member( "pos", here.get_abs( target.pos_bub( here ) ) );
        const bool exact = target.has_parent() || target.where() == item_location::type::vehicle;
        const int selected_quantity = selection.quantities[i];
        out.member( "quantity", exact && selected_quantity == 0 ? target->count() : selected_quantity );
        if( exact ) {
            const item_source source = capture_item_source( get_avatar(), target );
            if( source.kind != "map" && ( source.kind != "vehicle" || source.vehicle <= 0 || source.cargo <= 0 ) ) {
                return std::nullopt;
            }
            out.member( "source", source );
        }
        out.end_object();
    }
    out.end_array();
    out.end_object();
    state.pending_request = ++state.next_request;
    return text.str();
}

bool pickup_inventory_revision_matches( const JsonObject &message, const pickup_host_state &state )
{
    int64_t revision = 0;
    return ( !message.has_member( "inventory_revision" ) ||
             message.read( "inventory_revision", revision ) ) &&
           revision == state.revision;
}

std::string execute_pickup_request( Character &who, map &here, const JsonObject &request,
                                    pickup_host_state &state )
{
    const int64_t sequence = required_counter( request, "request" );
    if( sequence == state.last_request && sequence > 0 ) {
        return state.last_result;
    }
    if( sequence != state.last_request + 1 ||
        state.revision >= std::numeric_limits<int64_t>::max() - 1 ) {
        request.throw_error_at( "request", "Out-of-sequence pickup request" );
    }
    const bool autopickup = request.get_bool( "autopickup" );
    JsonArray items = request.get_array( "items" );
    if( items.empty() || items.size() > max_pickup_targets ) {
        request.throw_error_at( "items", "Invalid pickup target count" );
    }

    std::vector<item_location> targets;
    std::vector<int> quantities;
    std::set<int64_t> selected;
    std::set<int64_t> selected_ancestors;
    std::map<tripoint_abs_ms, std::unordered_map<int64_t, item *>> sources;
    bool accepted = pickup_inventory_revision_matches( request, state );
    bool all_targets_present = true;
    const tripoint_abs_ms actor_pos = who.pos_abs();
    for( const JsonValue &value : items ) {
        const JsonObject entry = value.get_object();
        const int64_t uid = required_counter( entry, "uid" );
        tripoint_abs_ms pos;
        const int quantity = entry.get_int( "quantity" );
        if( uid == 0 || quantity < 0 || !entry.read( "pos", pos ) ||
            !selected.insert( uid ).second || selected_ancestors.count( uid ) ) {
            entry.throw_error( "Invalid or duplicate pickup target" );
        }
        item_source identity;
        const bool exact = entry.has_member( "source" );
        if( exact ) {
            entry.read( "source", identity, true );
            if( identity.position != pos || identity.path.empty() || identity.path.size() > 64 ||
                identity.path.back() != uid ||
                ( identity.kind == "map" && ( identity.vehicle != 0 || identity.cargo != 0 ) ) ||
                ( identity.kind != "map" &&
                  ( identity.kind != "vehicle" || identity.vehicle <= 0 || identity.cargo <= 0 ) ) ) {
                entry.throw_error_at( "source", "Invalid pickup source identity" );
            }
            for( auto it = identity.path.begin(); it != std::prev( identity.path.end() ); ++it ) {
                if( *it <= 0 || selected.count( *it ) ) {
                    entry.throw_error_at( "source", "Cannot pick up a container and its contents together" );
                }
                selected_ancestors.insert( *it );
            }
        }
        const int64_t dx = static_cast<int64_t>( pos.x() ) - actor_pos.x();
        const int64_t dy = static_cast<int64_t>( pos.y() ) - actor_pos.y();
        // Check in wide coordinates before converting an untrusted position
        // into bubble coordinates. Item UIDs are resolved only on this tile.
        if( dx < -1 || dx > 1 || dy < -1 || dy > 1 || pos.z() != actor_pos.z() ) {
            accepted = false;
            continue;
        }
        const tripoint_bub_ms bub = here.get_bub( pos );
        if( !here.inbounds( bub ) || !here.accessible_items( bub ) ||
            ( bub != who.pos_bub( here ) && !who.sees( here, bub ) ) ) {
            accepted = false;
            continue;
        }
        if( exact ) {
            item_location target = resolve_item_source( who, here, identity );
            if( target && !can_remove_from_item_pockets( who, target ) ) {
                target = item_location();
            }
            all_targets_present = all_targets_present && static_cast<bool>( target );
            targets.emplace_back( std::move( target ) );
            quantities.push_back( quantity );
            continue;
        }
        auto source = sources.try_emplace( pos );
        auto &index = source.first->second;
        if( source.second ) {
            for( item &it : here.i_at( bub ) ) {
                const auto inserted = index.emplace( it.uid().get_value(), &it );
                if( !inserted.second ) {
                    inserted.first->second = nullptr; // Ambiguous legacy identity, never pick arbitrarily.
                }
            }
        }
        const auto found = index.find( uid );
        all_targets_present = all_targets_present && found != index.end() && found->second;
        targets.emplace_back( found != index.end() && found->second ?
                              item_location( map_cursor( bub ), found->second ) : item_location() );
        quantities.push_back( quantity );
    }
    if( accepted ) {
        if( !targets.empty() && targets.back() ) {
            who.last_item = targets.back()->typeId();
        }
        const int saved_moves = who.get_moves();
        const character_action_guard lifetime( who );
        const auto context = here.get_context_reference();
        const on_out_of_scope restore_moves( [&]() {
            if( lifetime ) {
                who.set_moves( saved_moves );
            }
        } );
        Pickup::pick_info info;
        bool stashed = true;
        // Keep the existing one-grant pickup timing in the network adapter;
        // the shared operation still charges its real actor normally. Reset
        // the local budget between chunks instead of spinning with no moves.
        while( lifetime && context && !targets.empty() ) {
            who.set_moves( 0 );
            if( !Pickup::do_pickup( who, targets, quantities, autopickup, stashed, info,
                                    Pickup::interaction::unattended ) ) {
                accepted = false;
                break;
            }
        }
        if( !lifetime ) {
            return {};
        }
        accepted = accepted && context && stashed && all_targets_present;
    }

    return record_inventory_result( who, sequence, accepted, state );
}

std::optional<std::string> make_give_request( const item_location &source, const player_id &target,
        pickup_client_state &state )
{
    if( !source || !source->uid().is_valid() || !target.valid() || state.pending_request != 0 ||
        state.next_request >= std::numeric_limits<int64_t>::max() - 1 ) {
        return std::nullopt;
    }
    std::ostringstream text;
    JsonOut out( text );
    out.start_object();
    out.member( "type", "action" );
    out.member( "action", "give_item" );
    out.member( "request", state.next_request + 1 );
    out.member( "inventory_revision", state.revision );
    out.member( "target_player", target.str() );
    out.member( "uid", source->uid().get_value() );
    out.end_object();
    state.pending_request = ++state.next_request;
    return text.str();
}

give_result execute_give_request( Character &giver, Character *receiver, const JsonObject &request,
                                  pickup_host_state &state )
{
    const int64_t sequence = required_counter( request, "request" );
    if( sequence == state.last_request && sequence > 0 ) {
        return { state.last_result, false };
    }
    if( sequence != state.last_request + 1 ||
        state.revision >= std::numeric_limits<int64_t>::max() - 1 ) {
        request.throw_error_at( "request", "Out-of-sequence inventory request" );
    }
    const int64_t uid = required_counter( request, "uid" );
    bool transferred = false;
    if( receiver && uid > 0 && pickup_inventory_revision_matches( request, state ) ) {
        const auto matches = giver.items_with( [uid]( const item & candidate ) {
            return candidate.uid().get_value() == uid;
        } );
        if( matches.size() == 1 ) {
            transferred = Pickup::give_item( giver, *receiver, item_location( giver, matches.front() ) );
        }
    }
    return { record_inventory_result( giver, sequence, transferred, state ), transferred };
}

std::string make_inventory_update( const Character &who, pickup_host_state &state )
{
    if( state.revision >= std::numeric_limits<int64_t>::max() - 1 ) {
        throw std::overflow_error( "Inventory revision exhausted" );
    }
    std::ostringstream text;
    JsonOut out( text );
    out.start_object();
    out.member( "type", "inventory_update" );
    out.member( "inventory_revision", state.revision + 1 );
    out.member( "carried" );
    who.store_carried_items( out );
    out.end_object();
    ++state.revision;
    return text.str();
}

bool apply_pickup_result( Character &who, const JsonObject &result, pickup_client_state &state )
{
    const int64_t sequence = required_counter( result, "request" );
    const int64_t revision = required_counter( result, "inventory_revision" );
    if( state.pending_request == 0 || sequence != state.pending_request ) {
        return false;
    }
    if( revision <= state.revision ) {
        // A subsequent gift/update may already include this pickup. A matching
        // acknowledgement still completes the request without restoring stale items.
        state.pending_request = 0;
        return true;
    }
    const double recoil = result.get_float( "recoil" );
    const itype_id last_item( result.get_string( "last_item" ) );
    if( !last_item.is_empty() && !last_item.is_valid() ) {
        result.throw_error_at( "last_item", "Unknown last picked item" );
    }
    who.load_carried_items( result.get_object( "carried" ) );
    who.recoil = recoil;
    who.last_item = last_item;
    state.revision = revision;
    state.pending_request = 0;
    return true;
}

bool apply_inventory_update( Character &who, const JsonObject &result, pickup_client_state &state )
{
    const int64_t revision = required_counter( result, "inventory_revision" );
    if( revision <= state.revision ) {
        return false;
    }
    who.load_carried_items( result.get_object( "carried" ) );
    state.revision = revision;
    // A pending pickup retains its request number until its own ACK arrives.
    return true;
}

namespace
{
struct carried_turn_node {
    item *value;
    int64_t parent;
    int pocket;
    int position;
};

std::vector<carried_turn_node> carried_turn_nodes( Character &who )
{
    std::vector<carried_turn_node> nodes;
    const auto visit = [&]( const auto & self, item & current, int64_t parent,
    int pocket, int position ) -> void {
        nodes.push_back( { &current, parent, pocket, position } );
        int index = 0;
        for( item_pocket *child_pocket : current.get_pockets( []( const item_pocket & )
    {
        return true;
    } ) )
        {
            int child_position = 0;
            for( item *child : child_pocket->all_items_top() ) {
                self( self, *child, current.uid().get_value(), index, child_position++ );
            }
            ++index;
        }
    };
    if( item_location weapon = who.get_wielded_item() ) {
        visit( visit, *weapon, 0, -1, 0 );
    }
    int position = 0;
    for( item_location root : who.top_items_loc() ) {
        visit( visit, *root, 0, -2, position++ );
    }
    return nodes;
}

std::string scalar_item_state( const item &value )
{
    std::ostringstream text;
    JsonOut out( text );
    value.store_current_state( out );
    return text.str();
}
}

inventory_turn_snapshot capture_inventory_turn( Character &who )
{
    inventory_turn_snapshot result;
    for( const carried_turn_node &node : carried_turn_nodes( who ) ) {
        const item &value = *node.value;
        auto &entry = result.items[value.uid().get_value()];
        entry.parent = node.parent;
        entry.pocket = node.pocket;
        entry.position = node.position;
        entry.charges = value.charges;
        entry.type = value.typeId().str();
        if( value.needs_processing() || value.is_battery() ) {
            entry.state = scalar_item_state( value );
        }
    }
    return result;
}

std::optional<std::string> make_inventory_turn_update( Character &who,
        const inventory_turn_snapshot &before, pickup_host_state &state )
{
    const auto nodes = carried_turn_nodes( who );
    std::vector<std::pair<int64_t, std::string>> changed;
    // Structural changes are uncommon. Reconcile a complete graph in that case;
    // ordinary charge/timer/rot updates never serialize unrelated carried items.
    if( nodes.size() != before.items.size() ) {
        return make_inventory_update( who, state );
    }
    for( const carried_turn_node &node : nodes ) {
        const item &value = *node.value;
        const int64_t uid = value.uid().get_value();
        const auto old = before.items.find( uid );
        if( old == before.items.end() || old->second.parent != node.parent ||
            old->second.pocket != node.pocket || old->second.position != node.position ||
            old->second.type != value.typeId().str() ) {
            return make_inventory_update( who, state );
        }
        if( !old->second.state.empty() || value.needs_processing() || value.is_battery() ||
            old->second.charges != value.charges ) {
            std::string current = scalar_item_state( value );
            if( current != old->second.state ) {
                changed.emplace_back( uid, std::move( current ) );
            }
        }
    }
    if( changed.empty() ) {
        return std::nullopt;
    }
    if( state.revision >= std::numeric_limits<int64_t>::max() - 1 ) {
        throw std::overflow_error( "Inventory revision exhausted" );
    }
    std::ostringstream text;
    JsonOut out( text );
    out.start_object();
    out.member( "type", "inventory_delta" );
    out.member( "base_revision", state.revision );
    out.member( "inventory_revision", state.revision + 1 );
    out.member( "items" );
    out.start_array();
    for( const auto &entry : changed ) {
        out.start_object();
        out.member( "uid", entry.first );
        out.member( "state" );
        *out.get_stream() << entry.second;
        out.set_need_separator();
        out.end_object();
    }
    out.end_array();
    out.end_object();
    ++state.revision;
    return text.str();
}

bool apply_inventory_turn_update( Character &who, const JsonObject &message,
                                  pickup_client_state &state )
{
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    const int64_t revision = required_counter( message, "inventory_revision" );
    if( revision <= state.revision ) {
        return false;
    }
    if( required_counter( message, "base_revision" ) != state.revision ||
        revision != state.revision + 1 ) {
        message.throw_error_at( "base_revision", "Missing inventory update; reconnect required" );
    }
    std::unordered_map<int64_t, item *> owned;
    std::unordered_map<int64_t, int64_t> parents;
    for( const carried_turn_node &node : carried_turn_nodes( who ) ) {
        owned.emplace( node.value->uid().get_value(), node.value );
        parents.emplace( node.value->uid().get_value(), node.parent );
    }
    std::set<int64_t> seen;
    std::vector<std::pair<item *, item>> restored;
    // Decode and validate the entire message before changing any live item.
    for( JsonObject entry : message.get_array( "items" ) ) {
        const int64_t uid = entry.get_int64( "uid" );
        const auto target = owned.find( uid );
        const JsonObject data = entry.get_object( "state" );
        item value = item::from_current_state( data );
        if( target == owned.end() || !seen.insert( uid ).second ||
            value.uid().get_value() != uid || value.typeId() != target->second->typeId() ||
            data.has_member( "contents" ) ) {
            entry.throw_error_at( "uid", "Item delta does not match the owned item graph" );
        }
        restored.emplace_back( target->second, std::move( value ) );
    }
    for( auto &entry : restored ) {
        entry.first->apply_current_state( std::move( entry.second ), false );
    }
    std::set<int64_t> invalidated;
    for( const auto &entry : restored ) {
        int64_t parent = parents.at( entry.first->uid().get_value() );
        while( parent != 0 && invalidated.insert( parent ).second ) {
            owned.at( parent )->on_contents_changed();
            parent = parents.at( parent );
        }
    }
    who.refresh_carried_item_caches();
    state.revision = revision;
    return true;
}
} // namespace cata_mp
