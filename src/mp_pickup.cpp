#include "mp_pickup.h"

#include <limits>
#include <map>
#include <set>
#include <sstream>
#include <unordered_map>
#include <utility>
#include <vector>

#include "cata_scope_helpers.h"
#include "character.h"
#include "coordinates.h"
#include "item.h"
#include "item_location.h"
#include "json.h"
#include "map.h"
#include "map_selector.h"
#include "pickup.h"

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
        if( !target || target.where() != item_location::type::map || target.has_parent() ||
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
        out.member( "quantity", selection.quantities[i] );
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
    std::set<std::pair<tripoint_abs_ms, int64_t>> selected;
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
            !selected.emplace( pos, uid ).second ) {
            entry.throw_error( "Invalid or duplicate pickup target" );
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
        const on_out_of_scope restore_moves( [&]() {
            who.set_moves( saved_moves );
        } );
        Pickup::pick_info info;
        bool stashed = true;
        // Keep the existing one-grant pickup timing in the network adapter;
        // the shared operation still charges its real actor normally. Reset
        // the local budget between chunks instead of spinning with no moves.
        while( !targets.empty() ) {
            who.set_moves( 0 );
            if( !Pickup::do_pickup( who, targets, quantities, autopickup, stashed, info,
                                    Pickup::interaction::unattended ) ) {
                accepted = false;
                break;
            }
        }
        accepted = accepted && stashed && all_targets_present;
    }

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

bool apply_pickup_result( Character &who, const JsonObject &result, pickup_client_state &state )
{
    const int64_t sequence = required_counter( result, "request" );
    const int64_t revision = required_counter( result, "inventory_revision" );
    if( state.pending_request == 0 || sequence != state.pending_request ||
        revision <= state.revision ) {
        return false;
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
} // namespace cata_mp
