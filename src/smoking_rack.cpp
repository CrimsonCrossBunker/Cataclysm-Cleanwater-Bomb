#include "smoking_rack.h"

#include <algorithm>
#include <cstddef>
#include <set>
#include <utility>

#include "bionics.h"
#include "calendar.h"
#include "character.h"
#include "character_action_guard.h"
#include "flag.h"
#include "game_constants.h"
#include "inventory.h"
#include "item.h"
#include "item_location.h"
#include "item_stack.h"
#include "itype.h"
#include "iuse_actor.h"
#include "json.h"
#include "line.h"
#include "map.h"
#include "map_selector.h"
#include "mapdata.h"
#include "messages.h"
#include "recipe.h"
#include "ret_val.h"
#include "translations.h"
#include "output.h"
#include "units_utility.h"

namespace smoking_rack
{
namespace
{
const furn_str_id fixed_idle( "f_smoking_rack" );
const furn_str_id fixed_active( "f_smoking_rack_active" );
const furn_str_id portable_idle( "f_metal_smoking_rack" );
const furn_str_id portable_active( "f_metal_smoking_rack_active" );
const itype_id smoke_plume( "fake_smoke_plume" );
const itype_id charcoal( "charcoal" );
const bionic_id lighter( "bio_lighter" );
constexpr time_duration smoke_duration = 6_hours;
constexpr size_t max_portions = 4096;

int64_t live_batch( const map_stack &items )
{
    for( const item &it : items ) {
        if( is_embers( it ) && it.active ) {
            return it.uid().get_value();
        }
    }
    return 0;
}

bool stop( map &here, const tripoint_bub_ms &pos )
{
    const furn_id rack = here.furn( pos );
    if( !is_active( rack ) || here.has_flag_ter( ter_furn_flag::TFLAG_NO_FLOOR, pos ) ) {
        return false;
    }
    if( !here.furn_set( pos, is_portable( rack ) ? portable_idle : fixed_idle ) ) {
        return false;
    }
    map_stack items = here.i_at( pos );
    for( auto it = items.begin(); it != items.end(); ) {
        if( is_embers( *it ) ) {
            it = items.erase( it );
        } else {
            it->unset_flag( flag_PROCESSING );
            ++it;
        }
    }
    return true;
}

bool removable( const item &it, operation action )
{
    return action == operation::remove_food ? it.is_food() : it.typeId() == charcoal;
}

bool available_to_load( Character &who, map &here, const item_location &source,
                        const tripoint_abs_ms &target )
{
    if( !source || !source->is_owned_by( who, true ) ) {
        return false;
    }
    if( source.held_by( who ) ) {
        return who.can_drop( *source ).success() &&
               ( !who.is_worn( *source ) || who.can_takeoff( *source ).success() );
    }
    const tripoint_bub_ms pos = source.pos_bub( here );
    const tripoint_bub_ms origin = who.pos_bub( here );
    return source.pos_abs() != target && pos.z() == origin.z() && here.inbounds( pos ) &&
           here.accessible_items( pos ) &&
           ( pos == origin || here.clear_path( origin, pos, pickup_range, 1, 100 ) );
}

bool move_portions( Character &who, map &here, const tripoint_bub_ms &pos,
                    const command &request, std::vector<tripoint_abs_ms> *changed_tiles )
{
    const bool loading_food = request.action == operation::load_food;
    const bool loading_fuel = request.action == operation::load_fuel;
    const bool loading = loading_food || loading_fuel;
    const tripoint_abs_ms destination = who.pos_abs();
    const furn_id rack = here.furn( pos );
    if( is_active( rack ) && request.action != operation::remove_fuel ) {
        return false;
    }
    units::volume remaining_food = 0_ml;
    int remaining_fuel = 0;
    if( loading_food ) {
        remaining_food = food_capacity( rack );
        for( const item &it : here.i_at( pos ) ) {
            if( it.is_food() ) {
                remaining_food -= it.volume();
            }
        }
    } else if( loading_fuel ) {
        remaining_fuel = fuel_capacity( rack ) -
                         count_charges_in_list( item::find_type( charcoal ), here.i_at( pos ) );
    }

    const auto context = here.get_context_reference();
    const character_action_guard lifetime( who );
    std::set<int64_t> handled;
    bool changed = false;
    for( const portion &selected : request.items ) {
        if( !lifetime || !context || who.pos_abs() != destination || !request.target.matches( here ) ||
            ( is_active( rack ) && live_batch( here.i_at( pos ) ) != request.batch ) ) {
            break;
        }
        if( selected.quantity <= 0 || selected.source.path.empty() ||
            !handled.insert( selected.source.path.back() ).second ) {
            continue;
        }
        item_location source;
        if( !loading ) {
            // A rack is sealed to the ordinary item selectors. Resolve only
            // top-level items on this exact rack, never arbitrary sources.
            if( selected.source.kind != "map" || selected.source.position != request.target.position ||
                selected.source.path.size() != 1 ) {
                continue;
            }
            for( item &it : here.i_at( pos ) ) {
                if( it.uid().get_value() == selected.source.path.front() ) {
                    if( source ) {
                        source = item_location();
                        break;
                    }
                    source = item_location( map_cursor( request.target.position ), &it );
                }
            }
            if( !source || source->count() != selected.quantity || !removable( *source, request.action ) ) {
                continue;
            }
        } else {
            if( selected.source.kind != "carried" && selected.source.kind != "map" &&
                selected.source.kind != "vehicle" ) {
                continue;
            }
            source = resolve_item_source( who, here, selected.source, pickup_range );
            if( !available_to_load( who, here, source, request.target.position ) ||
                source->count() < selected.quantity ||
                ( loading_food && ( !source->is_smokable() || source->rotten() ) ) ||
                ( loading_fuel && source->typeId() != charcoal ) ) {
                continue;
            }
        }

        if( loading ) {
            item moved( *source );
            const tripoint_abs_ms source_pos = source.pos_abs();
            if( moved.count_by_charges() ) {
                const int fits = loading_food ? moved.charges_per_volume( std::max( remaining_food, 0_ml ) ) :
                                 remaining_fuel;
                moved.charges = std::min( selected.quantity, fits );
            }
            const int quantity = moved.count();
            const units::volume volume = moved.volume();
            if( quantity <= 0 || ( loading_food && volume > remaining_food ) ) {
                who.add_msg_if_player( m_info, _( "The %s doesn't fit in the rack." ), moved.tname() );
                continue;
            }
            const int cost = who.item_handling_cost( moved );
            const std::string name = moved.tname( quantity );
            // Stage in the sealed rack before debiting the original. Food is
            // checked for rot again when the rack actually starts smoking.
            item &placed = here.add_item_unprocessed( pos, std::move( moved ) );
            if( placed.is_null() ) {
                continue;
            }
            if( source->count_by_charges() && source->charges > quantity ) {
                source->charges -= quantity;
                source.on_contents_changed();
            } else {
                source.remove_item();
            }
            changed = true;
            if( changed_tiles ) {
                changed_tiles->push_back( source_pos );
            }
            if( !lifetime || !context ) {
                break;
            }
            if( loading_food ) {
                remaining_food -= volume;
            } else {
                remaining_fuel -= quantity;
            }
            who.mod_moves( -cost );
            who.add_msg_if_player( m_info, _( "You carefully place %1$d %2$s in the rack." ), quantity,
                                   name );
        } else {
            const int cost = who.item_handling_cost( *source );
            const std::string name = source->tname();
            item_location placed;
            if( here.unload_furniture_item( source, who, &placed ) == 0 ) {
                continue;
            }
            changed = true;
            if( changed_tiles ) {
                changed_tiles->push_back( destination );
                if( placed && placed.pos_abs() != destination ) {
                    changed_tiles->push_back( placed.pos_abs() );
                }
            }
            if( !lifetime || !context ) {
                break;
            }
            who.mod_moves( -cost );
            who.add_msg_if_player( _( "You remove %s from the rack." ), name );
        }
    }
    if( changed && lifetime ) {
        who.invalidate_crafting_inventory();
    }
    return changed;
}
} // namespace

bool is_idle( const furn_id &furniture )
{
    return furniture == fixed_idle || furniture == portable_idle;
}

bool is_active( const furn_id &furniture )
{
    return furniture == fixed_active || furniture == portable_active;
}

bool is_portable( const furn_id &furniture )
{
    return furniture == portable_idle || furniture == portable_active;
}

bool is_embers( const item &it )
{
    return it.typeId() == smoke_plume;
}

units::volume food_capacity( const furn_id &furniture )
{
    return is_portable( furniture ) ? 15_liter : 20_liter;
}

int fuel_capacity( const furn_id &furniture )
{
    const itype *pseudo = furniture->crafting_pseudo_item_type();
    const itype *fuel = item::find_type( charcoal );
    return pseudo && fuel->ammo ? item( pseudo ).ammo_capacity( fuel->ammo->type ) : 0;
}

int fuel_required( units::volume food )
{
    const int required = to_liter( food ) * fuel_per_liter;
    return std::max( required, minimum_fuel );
}

preparation prepare( Character &who, map &here, const tripoint_bub_ms &pos, bool eject_invalid )
{
    if( !here.inbounds( pos ) || !is_idle( here.furn( pos ) ) ||
        here.has_flag_ter( ter_furn_flag::TFLAG_NO_FLOOR, pos ) ) {
        return preparation::unready;
    }
    const units::volume capacity = food_capacity( here.furn( pos ) );
    units::volume food = 0_ml;
    int fuel = 0;
    for( item &it : here.i_at( pos ) ) {
        if( it.typeId() == charcoal ) {
            fuel += std::max( it.charges, 0 );
        } else if( it.is_smokable() ) {
            food += it.volume();
            if( eject_invalid && it.has_flag( flag_SMOKED ) ) {
                who.add_msg_if_player(
                    _( "This rack has some smoked food that might be dehydrated by smoking it again." ) );
            }
        } else if( it.has_flag( flag_SMOKED ) ) {
            who.add_msg_if_player( _( "This rack already contains smoked food." ) );
            who.add_msg_if_player( _( "Remove it before firing the smoking rack again." ) );
            return preparation::unready;
        } else {
            const std::string name = it.tname( 1, false );
            who.add_msg_if_player( m_bad, _( "This rack contains %s, which can't be smoked!" ), name );
            if( !eject_invalid ) {
                return preparation::unready;
            }
            const int cost = who.item_handling_cost( it );
            const character_action_guard lifetime( who );
            item_location source( map_cursor( here.get_abs( pos ) ), &it );
            if( here.unload_furniture_item( source, who ) == 0 ) {
                return preparation::unready;
            }
            if( lifetime ) {
                who.add_msg_if_player( _( "You remove %s from the rack." ), name );
                who.mod_moves( -cost );
            }
            return preparation::ejected;
        }
    }
    if( food == 0_ml ) {
        who.add_msg_if_player(
            _( "This rack is empty.  Fill it with raw meat, fish or sausages and try again." ) );
    } else if( fuel <= 0 ) {
        who.add_msg_if_player( _( "There is no charcoal in the rack." ) );
    } else if( food > capacity ) {
        who.add_msg_if_player(
            _( "This rack is overloaded with food, and it blocks the flow of smoke.  Remove some and try again." ) );
        who.add_msg_if_player( _( "You think that you can load about %s %s in it." ),
                               format_volume( capacity ), volume_units_long() );
    } else if( fuel < fuel_required( food ) ) {
        who.add_msg_if_player( _( "There is not enough charcoal in the rack to smoke this much food." ) );
        who.add_msg_if_player(
            _( "You need at least %1$s pieces of charcoal, and the smoking rack has %2$s inside." ),
            fuel_required( food ), fuel );
    } else {
        return preparation::ready;
    }
    return preparation::unready;
}

bool ignite( Character &who, map &here, const tripoint_bub_ms &pos )
{
    if( prepare( who, here, pos ) != preparation::ready ) {
        return false;
    }
    const furn_str_id &next = is_portable( here.furn( pos ) ) ? portable_active : fixed_active;
    item embers( smoke_plume, calendar::turn );
    embers.item_counter = to_turns<int>( smoke_duration );
    embers.activate();
    item &timer = here.add_item_unprocessed( pos, std::move( embers ) );
    if( timer.is_null() ) {
        return false;
    }
    if( !here.furn_set( pos, next ) ) {
        here.i_rem( pos, &timer );
        return false;
    }

    map_stack items = here.i_at( pos );
    units::volume food = 0_ml;
    for( item &it : items ) {
        if( it.is_smokable() ) {
            it.process_temperature_rot( 1, pos, here, nullptr );
            it.set_flag( flag_PROCESSING );
            food += it.volume();
        }
    }
    int fuel = fuel_required( food );
    for( auto it = items.begin(); it != items.end() && fuel > 0; ) {
        if( it->typeId() != charcoal ) {
            ++it;
            continue;
        }
        const int used = std::min( fuel, std::max( it->charges, 0 ) );
        it->charges -= used;
        fuel -= used;
        if( it->charges <= 0 ) {
            it = items.erase( it );
        } else {
            ++it;
        }
    }
    return true;
}

bool needs_recovery( map &here, const tripoint_bub_ms &pos )
{
    if( !is_active( here.furn( pos ) ) ) {
        return false;
    }
    const map_stack items = here.i_at( pos );
    return live_batch( items ) == 0 || ( items.size() == 1 && is_embers( *items.begin() ) );
}

void reconcile( map &here, const tripoint_bub_ms &pos )
{
    if( needs_recovery( here, pos ) ) {
        stop( here, pos );
    }
}

void finish( map &here, const tripoint_bub_ms &examp,
             const time_point &start_time )
{
    const furn_id rack = here.furn( examp );
    if( !is_active( rack ) ) {
        return;
    }
    const furn_str_id &next_smoker_type = is_portable( rack ) ? portable_idle : fixed_idle;

    map_stack items = here.i_at( examp );
    if( items.empty() ) {
        here.furn_set( examp, next_smoker_type );
        return;
    }

    for( item &it : items ) {
        if( it.is_smokable() && it.has_flag( flag_PROCESSING ) ) {
            if( it.get_comestible()->smoking_result == itype_id::NULL_ID() ) {
                it.unset_flag( flag_PROCESSING );
            } else {
                it.calc_rot_while_processing( 6_hours );

                item result( it.get_comestible()->smoking_result, start_time + 6_hours );
                if( it.count_by_charges() ) {
                    result.charges = it.charges;
                }

                // Set flag to tell set_relative_rot() to calc from bday not now
                result.set_flag( flag_PROCESSING_RESULT );
                result.set_relative_rot( it.get_relative_rot() );
                result.unset_flag( flag_PROCESSING_RESULT );

                recipe rec;
                result.inherit_flags( it, rec );
                if( !result.has_flag( flag_NUTRIENT_OVERRIDE ) ) {
                    // If the item has "cooks_like" it will be replaced by that item as a component.
                    if( !it.get_comestible()->cooks_like.is_empty() ) {
                        // Set charges to 1 for stacking purposes.
                        it = item( it.get_comestible()->cooks_like, it.birthday(), 1 );
                    }
                    result.components.add( it );
                    // Smoking is always 1:1, so these must be equal for correct kcal/vitamin calculation.
                    result.recipe_charges = it.count();
                    result.set_flag_recursive( flag_COOKED );
                }

                it = result;
            }
        }
    }
    here.furn_set( examp, next_smoker_type );
}

void portion::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "source", source );
    out.member( "quantity", quantity );
    out.end_object();
}

void portion::deserialize( const JsonObject &data )
{
    data.read( "source", source, true );
    quantity = data.get_int( "quantity" );
}

void command::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "action", static_cast<int>( action ) );
    out.member( "origin", origin );
    out.member( "target", target );
    out.member( "batch", batch );
    out.member( "items", items );
    out.end_object();
}

void command::deserialize( const JsonObject &data )
{
    const int value = data.get_int( "action" );
    if( value < static_cast<int>( operation::fire_bionic ) ||
        value > static_cast<int>( operation::recover ) ) {
        data.throw_error_at( "action", "Invalid smoking rack operation" );
    }
    action = static_cast<operation>( value );
    data.read( "origin", origin, true );
    data.read( "target", target, true );
    batch = data.get_int64( "batch" );
    if( data.get_array( "items" ).size() > max_portions ) {
        data.throw_error_at( "items", "Too many smoking rack items" );
    }
    data.read( "items", items, true );
}

command capture( const Character &who, map &here, const tripoint_bub_ms &pos, operation action )
{
    const tripoint_abs_ms absolute = here.get_abs( pos );
    command request{ action, who.pos_abs(), tool_activity_target::capture( here, absolute ),
                     is_active( here.furn( pos ) ) ? live_batch( here.i_at( pos ) ) : 0, {} };
    if( action == operation::remove_food || action == operation::remove_fuel ) {
        for( const item &it : here.i_at( pos ) ) {
            if( removable( it, action ) ) {
                request.items.push_back( { { "map", absolute, { it.uid().get_value() } }, it.count() } );
            }
        }
    }
    return request;
}

bool execute( Character &who, map &here, const command &request,
              std::vector<tripoint_abs_ms> *changed_tiles )
{
    const tripoint_abs_ms origin = who.pos_abs();
    const tripoint_abs_ms position = request.target.position;
    const int64_t dx = static_cast<int64_t>( position.x() ) - origin.x();
    const int64_t dy = static_cast<int64_t>( position.y() ) - origin.y();
    if( who.activity || who.get_moves() <= 0 || who.is_dead_state() || request.origin != origin ||
        position.z() != origin.z() || dx < -1 || dx > 1 || dy < -1 || dy > 1 ||
        request.target.tool_source || !request.target.matches( here ) ||
        request.items.size() > max_portions ) {
        return false;
    }
    const tripoint_bub_ms pos = here.get_bub( position );
    const furn_id rack = here.furn( pos );
    const bool active = is_active( rack );
    if( ( !is_idle( rack ) && !active ) ||
        ( active ? live_batch( here.i_at( pos ) ) : 0 ) != request.batch ) {
        return false;
    }

    switch( request.action ) {
        case operation::load_food:
        case operation::load_fuel:
        case operation::remove_food:
        case operation::remove_fuel:
            return move_portions( who, here, pos, request, changed_tiles );
        case operation::recover:
            return request.items.empty() && needs_recovery( here, pos ) && stop( here, pos );
        case operation::quench:
            if( !request.items.empty() || !stop( here, pos ) ) {
                return false;
            }
            who.add_msg_if_player( m_info, _( "You stop the smoking process." ) );
            return true;
        case operation::fire_bionic: {
            if( !request.items.empty() || !is_idle( rack ) ||
                !who.has_bionic( lighter ) || !who.enough_power_for( lighter ) ) {
                return false;
            }
            const preparation ready = prepare( who, here, pos, true );
            if( ready == preparation::ejected && changed_tiles ) {
                changed_tiles->push_back( origin );
            }
            if( ready != preparation::ready ) {
                return ready == preparation::ejected;
            }
            const character_action_guard lifetime( who );
            const units::energy power = lighter->power_activate;
            const int moves = to_moves<int>( 1_seconds );
            who.mod_power_level( -power );
            who.mod_moves( -moves );
            const bool started = firestarter_actor::resolve_firestarter_use( &who, &here, pos,
                                 firestarter_actor::start_type::SMOKER );
            if( !started && lifetime ) {
                who.mod_power_level( power );
                who.mod_moves( moves );
            }
            return started;
        }
    }
    return false;
}
} // namespace smoking_rack
