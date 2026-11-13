#include "fermentation_vessel.h"

#include <algorithm>
#include <array>
#include <cstddef>
#include <limits>
#include <set>
#include <utility>

#include "calendar.h"
#include "character.h"
#include "character_action_guard.h"
#include "item.h"
#include "item_location.h"
#include "item_stack.h"
#include "itype.h"
#include "json.h"
#include "liquid_transfer.h"
#include "map.h"
#include "mapdata.h"
#include "messages.h"
#include "player_activity.h"
#include "ret_val.h"
#include "translations.h"

namespace fermentation_vessel
{
namespace
{
struct vessel_type {
    furn_str_id open;
    furn_str_id closed;
    units::volume capacity;
    bool compost;
};

const std::array<vessel_type, 3> vessels = { {
        { furn_str_id( "f_fvat_empty" ), furn_str_id( "f_fvat_full" ), 50_liter, false },
        { furn_str_id( "f_fvat_wood_empty" ), furn_str_id( "f_fvat_wood_full" ), 50_liter, false },
        { furn_str_id( "f_compost_empty" ), furn_str_id( "f_compost_full" ), 1000_liter, true }
    }
};
const std::string gas_collection( "compost_last_gas_collection" );
constexpr size_t max_supplies = 4096;

const vessel_type *find_type( const furn_id &furniture )
{
    const auto found = std::find_if( vessels.begin(), vessels.end(), [&]( const vessel_type & type ) {
        return furniture == type.open || furniture == type.closed;
    } );
    return found == vessels.end() ? nullptr : &*found;
}

bool within_reach( const tripoint_abs_ms &origin, const tripoint_abs_ms &position )
{
    const int64_t dx = static_cast<int64_t>( position.x() ) - origin.x();
    const int64_t dy = static_cast<int64_t>( position.y() ) - origin.y();
    return position.z() == origin.z() && dx >= -1 && dx <= 1 && dy >= -1 && dy <= 1;
}

item *find_batch( map &here, const tripoint_bub_ms &pos, int64_t identity )
{
    item *found = nullptr;
    for( item &it : here.i_at( pos ) ) {
        if( it.uid().get_value() == identity ) {
            if( found ) {
                return nullptr;
            }
            found = &it;
        }
    }
    return found;
}

bool seal( Character &who, map &here, const tripoint_bub_ms &pos, const vessel_type &type,
           item &batch, bool full )
{
    if( !here.furn_set( pos, type.closed ) ) {
        return false;
    }
    batch.set_age( 0_turns );
    if( type.compost ) {
        batch.erase_var( gas_collection );
        who.add_msg_if_player( full ?
                               _( "The tank is full, so you close the lid and start anaerobic digestion." ) :
                               _( "You close the lid and start anaerobic digestion." ) );
    } else {
        who.add_msg_if_player( full ?
                               _( "The vat is full, so you close the lid and start the fermenting cycle." ) :
                               _( "You close the lid and start the fermenting cycle." ) );
    }
    return true;
}

bool deposit( Character &who, map &here, const tripoint_bub_ms &pos, const vessel_type &type,
              item *batch, const command &request )
{
    const character_action_guard lifetime( who );
    const auto context = here.get_context_reference();
    std::set<int64_t> used;
    int64_t identity = batch ? batch->uid().get_value() : 0;
    bool changed = false;
    for( const item_source &selected : request.supplies ) {
        if( !lifetime || !context || who.pos_abs() != request.origin || !request.target.matches( here ) ) {
            break;
        }
        batch = identity ? find_batch( here, pos, identity ) : nullptr;
        if( ( identity && !batch ) || here.i_at( pos ).size() != ( batch ? 1u : 0u ) ) {
            break;
        }
        if( selected.kind != "carried" || selected.path.empty() ||
            !used.insert( selected.path.back() ).second ) {
            continue;
        }
        item_location source = resolve_item_source( who, here, selected, 0 );
        if( !source || !source.held_by( who ) || !source->is_owned_by( who, true ) ||
            !source->count_by_charges() || source->charges <= 0 ||
            !accepts( here.furn( pos ), *source ) ||
            ( batch && batch->typeId() != source->typeId() ) ) {
            continue;
        }
        const int limit = source->charges_per_volume( type.capacity );
        const int amount = std::min( source->charges, limit - ( batch ? batch->charges : 0 ) );
        if( amount <= 0 ) {
            break;
        }
        if( batch ) {
            batch->charges += amount;
        } else {
            item input( source->typeId(), calendar::turn_zero, amount );
            item &placed = here.add_item_unprocessed( pos, std::move( input ), true );
            if( placed.is_null() ) {
                break;
            }
            identity = placed.uid().get_value();
        }
        if( source->charges == amount ) {
            source.remove_item();
        } else {
            source->charges -= amount;
            source.on_contents_changed();
        }
        changed = true;
    }
    if( !changed || !lifetime || !context ) {
        return changed;
    }
    who.invalidate_crafting_inventory();
    who.mod_moves( -to_moves<int>( 20_seconds ) );
    batch = request.target.matches( here ) ? find_batch( here, pos, identity ) : nullptr;
    if( !batch ) {
        return true;
    }
    who.add_msg_if_player( type.compost ? _( "The tank now contains %s (%d), %0.f%% full." ) :
                           _( "The keg now contains %s (%d), %0.f%% full." ),
                           batch->tname(), batch->charges, batch->volume() * 100.0 / type.capacity );
    const bool full = batch->charges >= batch->charges_per_volume( type.capacity );
    if( full || request.start_after_deposit ) {
        seal( who, here, pos, type, *batch, full );
    }
    return true;
}

void award_gas( Character &who, item &product, int amount, int charges )
{
    if( amount <= 0 || !who.can_pickVolume_partial( product ) ) {
        who.add_msg_if_player( _( "You released some biogas from the tank." ) );
        return;
    }
    product.charges = charges;
    const character_action_guard lifetime( who );
    who.i_add_or_drop( product, amount );
    if( lifetime ) {
        who.add_msg_if_player( _( "Gathered %s units of biogas." ), amount );
    }
}

bool collect_gas( Character &who, item &batch )
{
    const int days = gas_days_available( batch );
    if( days <= 0 || batch.age() >= batch.composting_time() ) {
        return false;
    }
    const int amount = batch.count() * days * 80 / 30;
    const time_point birthday = batch.birthday();
    const auto &results = batch.composting_results();
    batch.set_var( gas_collection, to_turns<int>( batch.age() ) );
    const character_action_guard lifetime( who );
    for( const auto &[result, multiplier] : results ) {
        if( !lifetime ) {
            break;
        }
        if( result.first->phase == phase_id::GAS ) {
            item product( result.first, birthday );
            product.set_itype_variant( result.second );
            award_gas( who, product, amount, multiplier );
        }
    }
    return true;
}

bool finish_batch( Character &who, map &here, const tripoint_bub_ms &pos, const vessel_type &type,
                   item &batch )
{
    const time_duration needed = duration( here.furn( pos ), batch );
    if( batch.age() < needed ) {
        return false;
    }
    const auto &results = type.compost ? batch.composting_results() : batch.brewing_results();
    const int gas = type.compost ? batch.count() * gas_days_available( batch ) * 80 / 30 : 0;
    std::vector<std::pair<item, int>> outputs;
    std::vector<item *> stored;
    for( const auto &[result, multiplier] : results ) {
        const int64_t quantity = static_cast<int64_t>( multiplier ) * batch.count();
        if( quantity <= 0 || quantity > std::numeric_limits<int>::max() ) {
            continue;
        }
        item product( result.first, batch.birthday() );
        product.set_itype_variant( result.second );
        if( product.made_of_from_type( phase_id::LIQUID ) ) {
            product.charges = static_cast<int>( quantity );
            item &placed = here.add_item_unprocessed( pos, std::move( product ), true );
            if( placed.is_null() ) {
                for( item *staged : stored ) {
                    here.i_rem( pos, staged );
                }
                return false;
            }
            stored.push_back( &placed );
        } else {
            const int amount = type.compost && product.made_of_from_type( phase_id::GAS ) ?
                               multiplier : static_cast<int>( quantity );
            outputs.emplace_back( std::move( product ), amount );
        }
    }
    here.i_rem( pos, &batch );
    if( here.i_at( pos ).empty() ) {
        here.furn_set( pos, type.open );
    }
    who.mod_moves( -to_moves<int>( 5_seconds ) );
    const character_action_guard lifetime( who );
    const auto context = here.get_context_reference();
    for( const item *product : stored ) {
        who.add_msg_if_player( type.compost ? _( "The %s is now ready for use." ) :
                               _( "The %s is now ready for bottling." ), product->tname() );
    }
    for( auto &[product, amount] : outputs ) {
        if( !lifetime || !context ) {
            break;
        }
        if( type.compost && product.made_of_from_type( phase_id::GAS ) ) {
            award_gas( who, product, gas, amount );
        } else {
            const std::string name = product.tname( amount );
            who.i_add_or_drop( product, amount );
            if( lifetime ) {
                who.add_msg_if_player( _( "You remove the %s from the vat." ), name );
            }
        }
    }
    if( lifetime && context ) {
        who.practice( skill_id( type.compost ? "chemistry" : "cooking" ),
                      std::min( to_minutes<int>( needed ) / 10, 100 ) );
    }
    return true;
}

bool resolve_drain( Character &who, const item &batch, const unload_liquid_choice &choice,
                    const tripoint_abs_ms &position, liquid_dest_opt &destination,
                    std::optional<int> &tank )
{
    if( batch.uid().get_value() != choice.source || !batch.made_of( phase_id::LIQUID ) ||
        batch.charges <= 0 ) {
        return false;
    }
    if( choice.kind == LD_CONSUME ) {
        return who.can_eat( batch ).success();
    }
    if( ( choice.kind == LD_GROUND || choice.kind == LD_KEG ) &&
        ( choice.position == position || !within_reach( who.pos_abs(), choice.position ) ) ) {
        return false;
    }
    return resolve_liquid_destination( who, choice, batch, destination, tank );
}
} // namespace

units::volume capacity( const furn_id &vessel )
{
    const vessel_type *type = find_type( vessel );
    return type ? type->capacity : 0_ml;
}

bool accepts( const furn_id &vessel, const item &input )
{
    const vessel_type *type = find_type( vessel );
    return type && ( type->compost ? input.is_compostable() : input.is_brewable() );
}

time_duration duration( const furn_id &vessel, const item &input )
{
    const vessel_type *type = find_type( vessel );
    return type && type->compost ? input.composting_time() : input.brewing_time();
}

int gas_days_available( const item &input )
{
    const double start = to_turns<int>( 30_days );
    const double stored = std::max( start, input.get_var( gas_collection, start ) );
    const int last = static_cast<int>( std::clamp( stored, start,
                                       static_cast<double>( std::numeric_limits<int>::max() ) ) );
    return std::clamp( to_days<int>( input.age() - time_duration::from_turns( last ) ), 0, 5 );
}

void command::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "action", static_cast<int>( action ) );
    out.member( "origin", origin );
    out.member( "target", target );
    out.member( "batch", batch );
    out.member( "charges", charges );
    out.member( "start", start_after_deposit );
    out.member( "supplies", supplies );
    if( destination ) {
        out.member( "destination", *destination );
    }
    out.end_object();
}

void command::deserialize( const JsonObject &data )
{
    const int value = data.get_int( "action" );
    if( value < static_cast<int>( operation::deposit ) || value > static_cast<int>( operation::recover ) ) {
        data.throw_error_at( "action", "Invalid fermentation vessel operation" );
    }
    action = static_cast<operation>( value );
    data.read( "origin", origin, true );
    data.read( "target", target, true );
    batch = data.get_int64( "batch" );
    charges = data.get_int( "charges" );
    start_after_deposit = data.get_bool( "start" );
    if( data.get_array( "supplies" ).size() > max_supplies ) {
        data.throw_error_at( "supplies", "Too many fermentation vessel supplies" );
    }
    data.read( "supplies", supplies, true );
    data.read( "destination", destination );
}

command capture( const Character &who, map &here, const tripoint_bub_ms &pos, operation action,
                 const item *batch )
{
    command result;
    result.action = action;
    result.origin = who.pos_abs();
    result.target = tool_activity_target::capture( here, here.get_abs( pos ) );
    if( batch ) {
        result.batch = batch->uid().get_value();
        result.charges = batch->charges;
    }
    return result;
}

bool execute( Character &who, map &here, const command &request )
{
    const tripoint_abs_ms position = request.target.position;
    if( who.activity || who.get_moves() <= 0 || who.is_dead_state() ||
        who.pos_abs() != request.origin || !within_reach( request.origin, position ) ||
        request.target.tool_source || !request.target.matches( here ) ||
        request.supplies.size() > max_supplies ) {
        return false;
    }
    const tripoint_bub_ms pos = here.get_bub( position );
    const furn_id vessel = here.furn( pos );
    const vessel_type *type = find_type( vessel );
    if( !type || here.has_flag_ter( ter_furn_flag::TFLAG_NO_FLOOR, pos ) ) {
        return false;
    }
    const bool open = vessel == type->open;
    item *batch = request.batch > 0 ? find_batch( here, pos, request.batch ) : nullptr;
    if( ( request.batch != 0 && ( !batch || batch->charges != request.charges ) ) ||
        ( request.action != operation::deposit && !request.supplies.empty() ) ||
        ( request.action != operation::drain && request.destination ) ) {
        return false;
    }
    switch( request.action ) {
        case operation::deposit:
            return open && ( !batch || accepts( vessel, *batch ) ) &&
                   deposit( who, here, pos, *type, batch, request );
        case operation::start:
            return open && batch && batch->charges > 0 && accepts( vessel, *batch ) &&
                   here.i_at( pos ).size() == 1 && seal( who, here, pos, *type, *batch, false );
        case operation::finish:
            return !open && batch && batch->charges > 0 && accepts( vessel, *batch ) &&
                   finish_batch( who, here, pos, *type, *batch );
        case operation::gather_gas:
            return !open && type->compost && batch && batch->charges > 0 &&
                   batch->is_compostable() && collect_gas( who, *batch );
        case operation::recover:
            if( batch && !batch->made_of_from_type( phase_id::LIQUID ) && !accepts( vessel, *batch ) ) {
                return here.unload_furniture_item( item_location( map_cursor( position ), batch ), who ) > 0;
            }
            return !open && !batch && here.i_at( pos ).empty() && here.furn_set( pos, type->open );
        case operation::drain: {
            liquid_dest_opt destination;
            std::optional<int> tank;
            if( !batch || ( !open && accepts( vessel, *batch ) ) || !request.destination ||
                !resolve_drain( who, *batch, *request.destination, position, destination, tank ) ) {
                return false;
            }
            start_owned_liquid_transfer( who,
                                         { "fermentation_vessel", position, { request.batch } }, *request.destination );
            return static_cast<bool>( who.activity );
        }
    }
    return false;
}

void drain_turn( player_activity &act, Character &who, const item_source &source,
                 const unload_liquid_choice &choice )
{
    map &here = get_map();
    if( source.path.size() != 1 || !within_reach( who.pos_abs(), source.position ) ||
        !here.inbounds( source.position ) ) {
        act.set_to_null();
        return;
    }
    const tripoint_bub_ms pos = here.get_bub( source.position );
    const furn_id vessel = here.furn( pos );
    const vessel_type *type = find_type( vessel );
    const int64_t identity = source.path.front();
    item *batch = type ? find_batch( here, pos, identity ) : nullptr;
    liquid_dest_opt destination;
    std::optional<int> tank;
    if( !batch || ( vessel == type->closed && accepts( vessel, *batch ) ) ||
        !resolve_drain( who, *batch, choice, source.position, destination, tank ) ) {
        act.set_to_null();
        return;
    }
    const character_action_guard lifetime( who );
    const auto context = here.get_context_reference();
    const uint64_t generation = act.identity_generation();
    const tripoint_abs_ms position = source.position;
    const bool drink = choice.kind == LD_CONSUME;
    const int amount = drink ? 1 : std::min( batch->charges,
                       std::max( 1, batch->charges_per_volume( units::from_liter( 4.0F / 6.0F ) ) ) );
    item portion( *batch );
    portion.charges = amount;
    // Debit first so a destination callback cannot draw the same charges.
    batch->charges -= amount;
    if( drink ) {
        const int moves = to_moves<int>( who.get_consume_time( portion ) );
        if( who.consume( portion, true, true ) != trinary::NONE && lifetime ) {
            who.mod_moves( -moves );
        }
    } else {
        liquid_handler::transfer_liquid( who, portion, destination, tank, true, false );
    }
    const int unpoured = std::clamp( portion.charges, 0, amount );
    bool can_continue = false;
    if( context && here.inbounds( position ) ) {
        const tripoint_bub_ms current = here.get_bub( position );
        if( item *remaining = find_batch( here, current, identity ) ) {
            remaining->charges += unpoured;
            const bool same_vessel = here.furn( current ) == vessel;
            if( remaining->charges <= 0 ) {
                here.i_rem( current, remaining );
                if( same_vessel && vessel == type->closed && here.i_at( current ).empty() ) {
                    here.furn_set( current, type->open );
                }
            } else {
                can_continue = same_vessel && unpoured == 0;
            }
        }
    }
    if( !lifetime || act.identity_generation() != generation ) {
        return;
    }
    if( !drink && unpoured < amount ) {
        who.set_moves( 0 );
    }
    if( drink || !can_continue ) {
        act.set_to_null();
    }
}
} // namespace fermentation_vessel
