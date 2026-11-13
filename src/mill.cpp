#include "mill.h"

#include <algorithm>
#include <iterator>
#include <map>
#include <string>
#include <utility>

#include "cached_options.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "character_action_guard.h"
#include "craft_reservation.h"
#include "flag.h"
#include "game.h"
#include "item.h"
#include "item_components.h"
#include "item_factory.h"
#include "item_location.h"
#include "item_uid.h"
#include "itype.h"
#include "json.h"
#include "line.h"
#include "map.h"
#include "map_selector.h"
#include "mapdata.h"
#include "messages.h"
#include "rng.h"
#include "translations.h"
#include "vpart_position.h"

namespace mill
{
const itype_id clock_type( "fake_milling_item" );

namespace
{
const furn_str_id wind_idle( "f_wind_mill" );
const furn_str_id wind_active( "f_wind_mill_active" );
const furn_str_id water_idle( "f_water_mill" );
const furn_str_id water_active( "f_water_mill_active" );

struct milling_recipe {
    const recipe *definition = nullptr;
    int lot_size = 0;
};

milling_recipe recipe_for( const itype &type )
{
    if( !type.milling_data || !type.milling_data->into_.is_valid() ||
        !type.milling_data->recipe_.is_valid() ) {
        return {};
    }
    const recipe &definition = *type.milling_data->recipe_;
    const requirement_data &requirements = definition.simple_requirements();
    for( const auto &group : requirements.get_components() ) {
        for( const item_comp &part : group ) {
            if( part.type == type.get_id() && part.count > 0 ) {
                return { &definition, part.count };
            }
        }
    }
    return {};
}

std::vector<stack_snapshot> snapshot( map &here, const tripoint_bub_ms &tile )
{
    std::vector<stack_snapshot> contents;
    for( const item &entry : here.i_at( tile ) ) {
        contents.push_back( { entry.uid().get_value(), entry.typeId(), entry.count() } );
    }
    std::sort( contents.begin(), contents.end(), []( const stack_snapshot & a,
    const stack_snapshot & b ) {
        return a.uid < b.uid;
    } );
    return contents;
}

void record_tile( std::vector<tripoint_abs_ms> *changed, const tripoint_abs_ms &point )
{
    if( changed ) {
        changed->push_back( point );
    }
}

units::volume contents_volume( map &here, const tripoint_bub_ms &tile )
{
    units::volume volume = 0_ml;
    for( const item &entry : here.i_at( tile ) ) {
        if( entry.typeId() != clock_type ) {
            volume += entry.volume();
        }
    }
    return volume;
}

bool load( Character &who, map &here, const tripoint_bub_ms &tile,
           const comp_selection<item_comp> &selection, std::vector<tripoint_abs_ms> *changed )
{
    const itype_id &type = selection.comp.type;
    const usage_from source = selection.use_from;
    if( selection.comp.count <= 0 || !type.is_valid() || item_is_blacklisted( type ) ||
        ( source != usage_from::player && source != usage_from::map && source != usage_from::both ) ||
        !recipe_for( type.obj() ).definition ) {
        return false;
    }

    const auto filter = [&]( const item & entry ) {
        return is_crafting_component( entry ) && !entry.rotten() &&
               entry.made_of( phase_id::SOLID ) && entry.is_owned_by( who, true ) &&
               !craft_reservation::contains_reserved( entry );
    };
    {
        const restore_on_out_of_scope restore_rng( rng_get_engine() );
        const auto preview = who.preview_crafting_components( { selection }, 1, filter );
        if( !preview ) {
            return false;
        }
        units::volume total = contents_volume( here, tile );
        for( const auto &group : *preview ) {
            for( const item &entry : group.second ) {
                total += entry.volume();
            }
        }
        if( total > capacity ) {
            return false;
        }
    }
    const auto nearby = source == usage_from::player ? std::vector<tripoint_bub_ms>() :
                        here.reachable_item_points( who.pos_bub( here ), pickup_range, 1, 100 );
    auto materials = who.consume_items( here, selection, 1, filter, nearby );
    if( materials.empty() ) {
        return false;
    }
    for( item &entry : materials ) {
        who.mod_moves( -who.item_handling_cost( entry ) );
        who.add_msg_if_player( m_info, _( "You carefully place %1$d %2$s in the mill." ), entry.count(),
                               entry.tname( entry.count() ) );
        here.add_item_unprocessed( tile, std::move( entry ) );
    }
    who.invalidate_crafting_inventory();
    who.invalidate_weight_carried_cache();
    for( const tripoint_bub_ms &point : nearby ) {
        record_tile( changed, here.get_abs( point ) );
    }
    return true;
}

int eject( Character &who, map &here, const tripoint_bub_ms &tile, item &entry, int quantity,
           std::vector<tripoint_abs_ms> *changed )
{
    const character_action_guard lifetime( who );
    const auto context = here.get_context_reference();
    item portion( entry );
    if( portion.count_by_charges() ) {
        portion.charges = quantity;
    }
    portion.unset_flag( flag_PROCESSING );
    const int cost = who.item_handling_cost( portion );
    const std::string name = portion.tname();
    item_location placed;
    const int moved = here.unload_furniture_item( who.pos_bub( here ),
        item_location( map_cursor( here.get_abs( tile ) ), &entry ),
        std::move( portion ), who, &placed );
    if( moved > 0 && context && placed ) {
        record_tile( changed, placed.pos_abs() );
    }
    if( moved > 0 && lifetime && context ) {
        who.mod_moves( -cost );
        who.invalidate_crafting_inventory();
        who.add_msg_if_player( _( "You remove %s from the mill." ), name );
    }
    return moved;
}

void reset( map &here, const tripoint_bub_ms &tile )
{
    here.furn_set( tile, here.furn( tile ) == wind_active ? wind_idle : water_idle );
    for( item &entry : here.i_at( tile ) ) {
        if( entry.typeId() != clock_type ) {
            entry.unset_flag( flag_PROCESSING );
        }
    }
}

bool start( Character &who, map &here, const tripoint_bub_ms &tile, const command &choice,
            std::vector<tripoint_abs_ms> *changed )
{
    const character_action_guard lifetime( who );
    const auto context = here.get_context_reference();
    std::map<itype_id, int> excess;
    for( const stack_snapshot &stack : choice.contents ) {
        excess[stack.type] += stack.count;
    }
    for( auto &[type, count] : excess ) {
        const int lot_size = recipe_for( type.obj() ).lot_size;
        count = lot_size > 0 ? count % lot_size : count;
    }
    bool ejected = false;
    auto remaining_contents = choice.contents;
    for( stack_snapshot &stack : remaining_contents ) {
        int &remaining = excess.at( stack.type );
        if( remaining <= 0 ) {
            continue;
        }
        const int quantity = std::min( remaining, stack.count );
        item_location source = resolve_furniture_item( here, choice.target.position, stack.uid );
        if( !source || source->typeId() != stack.type || source->count() != stack.count ) {
            return ejected;
        }
        const int moved = eject( who, here, tile, *source, quantity, changed );
        ejected |= moved > 0;
        if( moved != quantity || !lifetime || !context || who.pos_abs() != choice.origin ||
            !choice.target.matches( here ) ) {
            return ejected;
        }
        remaining -= moved;
        stack.count -= moved;
    }
    remaining_contents.erase( std::remove_if( remaining_contents.begin(), remaining_contents.end(),
    []( const stack_snapshot & stack ) {
        return stack.count <= 0;
    } ), remaining_contents.end() );
    if( snapshot( here, tile ) != remaining_contents ) {
        return ejected;
    }
    const units::volume volume = contents_volume( here, tile );
    if( here.i_at( tile ).empty() ) {
        who.add_msg_if_player(
            _( "This mill is empty.  Fill it with starchy products such as wheat, barley or oats and try again." ) );
        return ejected;
    }
    if( volume > capacity ) {
        who.add_msg_if_player(
            _( "This mill is overloaded with products, and the millstone can't turn.  Remove some and try again." ) );
        return ejected;
    }

    item clock( clock_type, calendar::turn );
    clock.item_counter = to_turns<int>( duration );
    clock.activate();
    item &placed = here.add_item_unprocessed( tile, std::move( clock ) );
    if( placed.is_null() ) {
        return ejected;
    }
    if( !here.furn_set( tile, here.furn( tile ) == wind_idle ? wind_active : water_active ) ) {
        here.i_rem( tile, &placed );
        return ejected;
    }
    for( item &entry : here.i_at( tile ) ) {
        if( entry.typeId() != clock_type ) {
            entry.process_temperature_rot( 1, tile, here, nullptr );
            entry.set_flag( flag_PROCESSING );
        }
    }
    who.add_msg_if_player( _( "You remove the brake on the millstone and it slowly starts to turn." ) );
    return true;
}

void finish_recipe( map &here, const tripoint_bub_ms &tile, const milling_recipe &milling,
                    const std::vector<item *> &stacks )
{
    if( !milling.definition ) {
        return;
    }
    int count = 0;
    for( const item *entry : stacks ) {
        count += entry->count();
    }
    const int batches = count / milling.lot_size;
    if( batches == 0 ) {
        return;
    }

    // Build outputs before debiting the grain so a failed placement leaves it intact.
    int remaining = batches * milling.lot_size;
    std::vector<std::pair<item *, int>> consumed;
    item_components components;
    for( item *entry : stacks ) {
        const int quantity = std::min( remaining, entry->count() );
        item portion( *entry );
        if( portion.count_by_charges() ) {
            portion.charges = quantity;
        }
        portion.unset_flag( flag_PROCESSING );
        components.add( portion );
        consumed.emplace_back( entry, quantity );
        remaining -= quantity;
        if( remaining == 0 ) {
            break;
        }
    }
    std::vector<item> products = milling.definition->create_results( batches, &components );
    if( products.empty() ) {
        return;
    }
    std::vector<item *> placed;
    for( item &product : products ) {
        item &entry = here.add_item_unprocessed( tile, std::move( product ) );
        if( entry.is_null() ) {
            for( item *rollback : placed ) {
                here.i_rem( tile, rollback );
            }
            return;
        }
        placed.push_back( &entry );
    }
    for( const auto &[entry, quantity] : consumed ) {
        if( entry->count_by_charges() && quantity < entry->charges ) {
            entry->charges -= quantity;
        } else {
            here.i_rem( tile, entry );
        }
    }
}
} // namespace

bool stack_snapshot::operator==( const stack_snapshot &other ) const
{
    return uid == other.uid && type == other.type && count == other.count;
}

void stack_snapshot::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "uid", uid );
    out.member( "type", type );
    out.member( "count", count );
    out.end_object();
}

void stack_snapshot::deserialize( const JsonObject &data )
{
    uid = data.get_int64( "uid" );
    data.read( "type", type, true );
    count = data.get_int( "count" );
}

void command::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "action", static_cast<int>( action ) );
    out.member( "origin", origin );
    out.member( "target", target );
    out.member( "contents", contents );
    out.member( "input", input );
    out.end_object();
}

void command::deserialize( const JsonObject &data )
{
    const int value = data.get_int( "action" );
    if( value < static_cast<int>( operation::start ) ||
        value > static_cast<int>( operation::recover ) ) {
        data.throw_error_at( "action", "Invalid mill action" );
    }
    action = static_cast<operation>( value );
    data.read( "origin", origin, true );
    data.read( "target", target, true );
    data.read( "contents", contents, true );
    data.read( "input", input );
}

bool is_active( const map &here, const tripoint_bub_ms &tile )
{
    return here.furn( tile ) == wind_active || here.furn( tile ) == water_active;
}

bool needs_recovery( map &here, const tripoint_bub_ms &tile )
{
    if( !is_active( here, tile ) ) {
        return false;
    }
    const map_stack contents = here.i_at( tile );
    const auto clocks = std::count_if( contents.begin(), contents.end(), []( const item & entry ) {
        return entry.typeId() == clock_type;
    } );
    return clocks != 1 || contents.size() == 1;
}

bool can_operate( Character &who, map &here, const tripoint_bub_ms &tile )
{
    const furn_id furniture = here.furn( tile );
    if( furniture == water_idle && !here.is_water_shallow_current( tile ) ) {
        who.add_msg_if_player( _( "The water mill needs to be over shallow flowing water to work." ) );
        return false;
    }
    if( furniture == wind_idle && g->is_sheltered( &here, tile ) ) {
        who.add_msg_if_player( _( "The wind mill needs to be outside in the wind to work." ) );
        return false;
    }
    return furniture == wind_idle || furniture == water_idle || is_active( here, tile );
}

bool accepts( const item &entry )
{
    return entry.count() > 0 && entry.made_of( phase_id::SOLID ) && !entry.rotten() &&
           is_crafting_component( entry ) && recipe_for( *entry.type ).definition;
}

command inspect( Character &who, map &here, const tripoint_bub_ms &tile )
{
    return command{ operation::start, who.pos_abs(),
                    tool_activity_target::capture( here, here.get_abs( tile ) ), snapshot( here, tile ), {} };
}

bool execute( Character &who, map &here, const command &choice,
              std::vector<tripoint_abs_ms> *changed_tiles )
{
    const tripoint_abs_ms origin = who.pos_abs();
    const tripoint_abs_ms target = choice.target.position;
    if( who.activity || who.is_dead_state() || who.get_moves() <= 0 || who.cant_do_mounted( false ) ||
        who.has_effect( efftype_id( "incorporeal" ) ) || origin != choice.origin ||
        origin.z() != target.z() || !here.inbounds( target ) || square_dist( origin, target ) > 1 ||
        get_craft_reservations().provider_tile_reserved( target ) ||
        get_craft_reservations().craft_site_reserved( target ) ||
        ( choice.action == operation::load ) != choice.input.has_value() ) {
        return false;
    }
    const tripoint_bub_ms tile = here.get_bub( target );
    if( !here.has_loaded_submap( tile ) || here.veh_at( tile ) || here.is_open_air( tile ) ||
        here.has_flag( ter_furn_flag::TFLAG_DESTROY_ITEM, tile ) || !choice.target.matches( here ) ||
        !can_operate( who, here, tile ) || snapshot( here, tile ) != choice.contents ) {
        return false;
    }
    const bool active = is_active( here, tile );
    const bool stopping = choice.action == operation::stop || choice.action == operation::recover;
    if( active != stopping || ( choice.action == operation::recover &&
                                !needs_recovery( here, tile ) ) ) {
        return false;
    }
    for( const item &entry : here.i_at( tile ) ) {
        if( entry.typeId() != clock_type &&
            ( !entry.is_owned_by( who, true ) || craft_reservation::contains_reserved( entry ) ) ) {
            return false;
        }
    }

    bool changed = false;
    switch( choice.action ) {
        case operation::start:
            changed = start( who, here, tile, choice, changed_tiles );
            break;
        case operation::load:
            changed = load( who, here, tile, *choice.input, changed_tiles );
            break;
        case operation::unload: {
            const character_action_guard lifetime( who );
            const auto context = here.get_context_reference();
            for( const stack_snapshot &stack : choice.contents ) {
                item_location source = resolve_furniture_item( here, target, stack.uid );
                if( !source || source->typeId() != stack.type || source->count() != stack.count ) {
                    break;
                }
                changed |= eject( who, here, tile, *source, stack.count, changed_tiles ) > 0;
                if( !lifetime || !context || who.pos_abs() != origin || !choice.target.matches( here ) ) {
                    break;
                }
            }
            break;
        }
        case operation::stop:
        case operation::recover: {
            reset( here, tile );
            map_stack contents = here.i_at( tile );
            for( auto it = contents.begin(); it != contents.end(); ) {
                it = it->typeId() == clock_type ? contents.erase( it ) : std::next( it );
            }
            who.add_msg_if_player( m_info, _( "You stop the milling process." ) );
            changed = true;
            break;
        }
    }
    if( changed ) {
        record_tile( changed_tiles, target );
    }
    return changed;
}

void finish( map &here, const tripoint_bub_ms &tile )
{
    if( !is_active( here, tile ) ) {
        return;
    }
    std::map<itype_id, std::vector<item *>> by_type;
    for( item &entry : here.i_at( tile ) ) {
        if( entry.typeId() != clock_type && entry.count() > 0 ) {
            by_type[entry.typeId()].push_back( &entry );
        }
    }
    for( const auto &[type, stacks] : by_type ) {
        finish_recipe( here, tile, recipe_for( type.obj() ), stacks );
    }
    reset( here, tile );
}
} // namespace mill
