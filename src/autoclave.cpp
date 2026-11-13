#include "autoclave.h"

#include <algorithm>

#include "calendar.h"
#include "cached_options.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "character_action_guard.h"
#include "craft_reservation.h"
#include "flag.h"
#include "item.h"
#include "item_uid.h"
#include "json.h"
#include "line.h"
#include "map.h"
#include "mapdata.h"
#include "messages.h"
#include "output.h"
#include "rng.h"
#include "temp_crafting_inventory.h"
#include "translations.h"
#include "vpart_position.h"

namespace autoclave
{
namespace
{
const furn_str_id idle( "f_autoclave" );
const furn_str_id running( "f_autoclave_full" );
const requirement_id sterilization( "autoclave" );
const trait_id trait_DEBUG_HS( "DEBUG_HS" );
constexpr time_duration cycle_time = 90_minutes;

std::optional<std::vector<item *>> read_batch( Character &who, map &here,
        const tripoint_bub_ms &tile, operation action )
{
    std::vector<item *> batch;
    for( item &entry : here.i_at( tile ) ) {
        if( !entry.is_bionic() ) {
            who.add_msg_if_player( m_bad, action == operation::start ?
                                   _( "You need to remove all non-CBM items from the autoclave to start the program." ) :
                                   _( "ERROR Autoclave can't process non CBM items." ) );
            return std::nullopt;
        }
        if( action == operation::start && entry.has_flag( flag_FILTHY ) ) {
            who.add_msg_if_player( m_bad,
                                   _( "Some of those CBMs are filthy, you should wash them first for the sterilization process to work properly." ) );
            return std::nullopt;
        }
        batch.push_back( &entry );
    }
    if( action == operation::start && batch.empty() ) {
        who.add_msg_if_player( _( "This autoclave is empty…" ) );
        return std::nullopt;
    }
    return batch;
}

std::vector<std::pair<int64_t, itype_id>> snapshot( const std::vector<item *> &batch )
{
    std::vector<std::pair<int64_t, itype_id>> result;
    result.reserve( batch.size() );
    for( const item *entry : batch ) {
        result.emplace_back( entry->uid().get_value(), entry->typeId() );
    }
    std::sort( result.begin(), result.end() );
    return result;
}

time_duration time_remaining( const std::vector<item *> &batch )
{
    time_duration remaining = 0_turns;
    for( const item *entry : batch ) {
        remaining = std::max( remaining, cycle_time - entry->age() );
    }
    return remaining;
}

bool uses_map( usage_from source )
{
    return source == usage_from::map || source == usage_from::both;
}

bool pay_requirements( Character &who, map &here, const command &choice,
                       std::vector<tripoint_abs_ms> *changed_tiles )
{
    if( who.has_trait( trait_DEBUG_HS ) ) {
        return choice.components.empty() && choice.tools.empty();
    }
    auto components = choice.components;
    auto tools = choice.tools;
    {
        const restore_on_out_of_scope restore_rng( rng_get_engine() );
        if( !validate_requirement_selection( who, *sterilization, components, tools ) ) {
            return false;
        }
    }
    std::vector<tripoint_bub_ms> reachable;
    if( std::any_of( components.begin(), components.end(), []( const auto & selected ) {
    return uses_map( selected.use_from );
    } ) || std::any_of( tools.begin(), tools.end(), []( const auto & selected ) {
        return uses_map( selected.use_from );
    } ) ) {
        reachable = here.reachable_item_points( who.pos_bub( here ), pickup_range, 1, 100 );
    }
    for( const auto &selected : components ) {
        who.consume_items( here, selected, 1, is_crafting_component, reachable );
    }
    for( const auto &selected : tools ) {
        who.consume_tools( here, selected, 1, reachable );
    }
    who.invalidate_crafting_inventory();
    who.invalidate_weight_carried_cache();
    if( changed_tiles ) {
        for( const tripoint_bub_ms &point : reachable ) {
            changed_tiles->push_back( here.get_abs( point ) );
        }
    }
    return true;
}
} // namespace

void command::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "action", static_cast<int>( action ) );
    out.member( "origin", origin );
    out.member( "target", target );
    out.member( "batch", batch );
    out.member( "components", components );
    out.member( "tools", tools );
    out.end_object();
}

void command::deserialize( const JsonObject &data )
{
    const int value = data.get_int( "action" );
    if( value != static_cast<int>( operation::start ) &&
        value != static_cast<int>( operation::finish ) ) {
        data.throw_error_at( "action", "Invalid autoclave action" );
    }
    action = static_cast<operation>( value );
    data.read( "origin", origin, true );
    data.read( "target", target, true );
    data.read( "batch", batch, true );
    data.read( "components", components, true );
    data.read( "tools", tools, true );
}

std::optional<command> inspect( Character &who, map &here, const tripoint_bub_ms &tile,
                                operation action )
{
    if( !here.has_loaded_submap( tile ) ||
        here.furn( tile ) != ( action == operation::start ? idle : running ) ) {
        return std::nullopt;
    }
    const auto batch = read_batch( who, here, tile, action );
    if( !batch ) {
        return std::nullopt;
    }
    if( action == operation::finish ) {
        const time_duration remaining = time_remaining( *batch );
        if( remaining > 0_turns ) {
            who.add_msg_if_player( _( "The autoclave is running." ) );
            who.add_msg_if_player( _( "The cycle will be complete in %s." ), to_string( remaining ) );
            return std::nullopt;
        }
    }
    return command{ action, who.pos_abs(), tool_activity_target::capture( here, here.get_abs( tile ) ),
                    snapshot( *batch ), {}, {} };
}

bool confirm_start( Character &who, command &choice )
{
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    const character_action_guard lifetime( who );
    const auto context = get_map().get_context_reference();
    const requirement_data &requirements = *sterilization;
    if( !requirements.can_make_with_inventory( &who, who.crafting_inventory(),
            is_crafting_component ) ) {
        popup( "%s", requirements.list_missing() );
        return false;
    }
    if( !who.query_yn( _( "Start the autoclave?" ) ) || !lifetime || !context ||
        who.pos_abs() != choice.origin ) {
        return false;
    }
    if( who.has_trait( trait_DEBUG_HS ) ) {
        return true;
    }
    temp_crafting_inventory nearby;
    nearby.form_from_map( who.pos_bub(), pickup_range, &who );
    for( const auto &group : requirements.get_components() ) {
        const auto selected = who.select_item_component( group, 1, nearby, true, is_crafting_component );
        if( selected.use_from == usage_from::cancel || !lifetime || !context ||
            who.pos_abs() != choice.origin ) {
            return false;
        }
        choice.components.push_back( selected );
    }
    for( const auto &group : requirements.get_tools() ) {
        const auto selected = who.select_tool_component( group, 1, nearby, true );
        if( selected.use_from == usage_from::cancel || !lifetime || !context ||
            who.pos_abs() != choice.origin ) {
            return false;
        }
        choice.tools.push_back( selected );
    }
    return true;
}

bool execute( Character &who, map &here, const command &choice,
              std::vector<tripoint_abs_ms> *changed_tiles )
{
    const tripoint_abs_ms origin = who.pos_abs();
    const tripoint_abs_ms position = choice.target.position;
    if( who.activity || who.get_moves() <= 0 || who.is_dead_state() || who.cant_do_mounted( false ) ||
        who.has_effect( efftype_id( "incorporeal" ) ) || origin != choice.origin ||
        origin.z() != position.z() || !here.inbounds( position ) || square_dist( origin, position ) > 1 ||
        get_craft_reservations().provider_tile_reserved( position ) ||
        get_craft_reservations().craft_site_reserved( position ) ) {
        return false;
    }
    const tripoint_bub_ms tile = here.get_bub( position );
    const bool starting = choice.action == operation::start;
    if( !here.has_loaded_submap( tile ) || here.furn( tile ) != ( starting ? idle : running ) ||
        here.veh_at( tile ) || here.is_open_air( tile ) || !choice.target.matches( here ) ) {
        return false;
    }
    const auto batch = read_batch( who, here, tile, choice.action );
    if( !batch || snapshot( *batch ) != choice.batch ||
    std::any_of( batch->begin(), batch->end(), [&]( const item * entry ) {
    return !entry->is_owned_by( who, true ) || craft_reservation::contains_reserved( *entry );
    } ) ) {
        return false;
    }
    if( starting ) {
        if( !pay_requirements( who, here, choice, changed_tiles ) || !here.furn_set( tile, running ) ) {
            return false;
        }
        for( item *entry : *batch ) {
            entry->set_birthday( calendar::turn );
        }
        who.add_msg_if_player( _( "You start the autoclave." ) );
    } else {
        if( !choice.components.empty() || !choice.tools.empty() || time_remaining( *batch ) > 0_turns ||
            !here.furn_set( tile, idle ) ) {
            return false;
        }
        bool unpacked = false;
        bool filthy = false;
        for( item *entry : *batch ) {
            unpacked |= entry->has_flag( flag_NO_PACKED );
            filthy |= entry->has_flag( flag_FILTHY );
            if( !entry->has_flag( flag_NO_PACKED ) && !entry->has_flag( flag_FILTHY ) ) {
                entry->unset_flag( flag_NO_STERILE );
            }
        }
        if( batch->empty() ) {
            who.add_msg_if_player( _( "This autoclave is empty…" ) );
        } else if( !unpacked && !filthy ) {
            who.add_msg_if_player( m_good, _( "The cycle is complete, the CBMs are now sterile." ) );
        } else {
            who.add_msg_if_player( _( "The autoclave cycle is complete." ) );
            if( unpacked ) {
                who.add_msg_if_player( m_info,
                                       _( "CBMs in direct contact with the environment will almost immediately become contaminated." ) );
            }
            if( filthy ) {
                who.add_msg_if_player( m_bad, _( "Filthy CBMs were not sterilized." ) );
            }
        }
    }
    if( changed_tiles ) {
        changed_tiles->push_back( position );
    }
    return true;
}
} // namespace autoclave
