#include "fireplace.h"

#include "activity_handlers.h"
#include "bionics.h"
#include "calendar.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "character_action_guard.h"
#include "damage.h"
#include "flag.h"
#include "iexamine.h"
#include "item.h"
#include "item_activation.h"
#include "item_location.h"
#include "itype.h"
#include "iuse_actor.h"
#include "json.h"
#include "line.h"
#include "map.h"
#include "mapdata.h"
#include "messages.h"
#include "player_activity.h"
#include "translations.h"
#include "vpart_position.h"

namespace
{
const bionic_id bio_lighter( "bio_lighter" );
const damage_type_id damage_bash( "bash" );
const field_type_str_id field_fd_fire( "fd_fire" );

const firestarter_actor *firestarter_for( const item_location &tool )
{
    const use_function *use = tool ? tool->type->get_use( "firestarter" ) : nullptr;
    return use ? dynamic_cast<const firestarter_actor *>( use->get_actor_ptr() ) : nullptr;
}

bool available_fireplace_supply( Character &who, const item_location &loc )
{
    return loc && loc->is_owned_by( who, true ) && can_remove_from_item_pockets( who, loc ) &&
           !activity_handlers::activity_item_reserved_for_other( *loc, who );
}

} // namespace

void fireplace_selection::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "action", static_cast<int>( action ) );
    out.member( "origin", origin );
    out.member( "target", target );
    out.member( "tool", tool );
    out.member( "tinder", tinder );
    out.end_object();
}

void fireplace_selection::deserialize( const JsonObject &data )
{
    const int value = data.get_int( "action" );
    if( value < static_cast<int>( fireplace_action::light_with_tool ) ||
        value > static_cast<int>( fireplace_action::extinguish ) ) {
        data.throw_error_at( "action", "Invalid fireplace action" );
    }
    action = static_cast<fireplace_action>( value );
    data.read( "origin", origin, true );
    data.read( "target", target, true );
    data.read( "tool", tool );
    data.read( "tinder", tinder );
}

item_location find_fireplace_firestarter( Character &who, map &here, const tripoint_bub_ms &tile )
{
    if( who.pos_bub( here ) == tile ) {
        return {};
    }
    item_location best;
    const firestarter_actor *best_method = nullptr;
    const auto consider = [&]( const item_location & candidate ) {
        const firestarter_actor *method = firestarter_for( candidate );
        if( method && ( !best_method || method->moves_cost_fast < best_method->moves_cost_fast ) &&
            !candidate->is_broken() && available_fireplace_supply( who, candidate ) &&
            method->can_use( who, *candidate, &here, tile ).success() ) {
            best = candidate;
            best_method = method;
        }
    };
    for( const item_location &candidate : who.all_items_loc() ) {
        consider( candidate );
    }
    for( const tripoint_bub_ms &pos : here.reachable_item_points( who.pos_bub( here ),
            pickup_range, 1, 100 ) ) {
        if( pos != tile && here.has_loaded_submap( pos ) && here.accessible_items( pos ) ) {
            for( const item_location &candidate : here.items_with( pos, []( const item & it ) {
            return it.type->can_use( "firestarter" );
            } ) ) {
                consider( candidate );
            }
        }
    }
    return best;
}

bool can_light_fireplace_with_bionic( const Character &who )
{
    return who.has_bionic( bio_lighter ) && who.enough_power_for( bio_lighter );
}

bool has_fireplace_quencher( Character &who, map &here, const tripoint_bub_ms &tile )
{
    const auto can_bash = []( const item & it ) {
        return !it.has_flag( flag_PSEUDO ) && it.damage_melee( damage_bash ) > 0;
    };
    for( item *candidate : who.items_with( can_bash ) ) {
        const item_location tool = locate_item_with_parents( item_location( who, candidate ) );
        if( available_fireplace_supply( who, tool ) ) {
            return true;
        }
    }
    for( const tripoint_bub_ms &pos : here.reachable_item_points( who.pos_bub( here ),
            pickup_range, 1, 100 ) ) {
        if( pos == tile || !here.has_loaded_submap( pos ) || !here.accessible_items( pos ) ) {
            continue;
        }
        for( const item_location &candidate : here.items_with( pos, can_bash ) ) {
            if( available_fireplace_supply( who, candidate ) ) {
                return true;
            }
        }
    }
    return false;
}

bool query_fireplace_ignition( Character &who, map &here, const item_location &tool,
                               fireplace_selection &choice )
{
    const firestarter_actor *method = firestarter_for( tool );
    if( !method ) {
        return false;
    }
    const character_action_guard lifetime( who );
    const auto context = here.get_context_reference();
    const item_source selected = capture_item_source( who, tool );
    tripoint_bub_ms tile = here.get_bub( choice.target.position );
    item_activation_choices activation;
    if( !method->query_fire_choices( who, *tool, here, tile, activation ) ||
        !lifetime || !context || !tool || who.pos_abs() != choice.origin ||
        here.get_abs( tile ) != choice.target.position || !choice.target.matches( here ) ||
        resolve_item_source( who, here, selected, pickup_range ) != tool ) {
        return false;
    }
    choice.tool = selected;
    choice.tinder = activation.fire_tinder;
    return true;
}

bool execute_fireplace_selection( Character &who, map &here, const fireplace_selection &choice,
                                  activity_execution execution,
                                  std::vector<tripoint_abs_ms> *changed_tiles )
{
    if( who.activity || who.get_moves() <= 0 || who.is_dead_state() || who.cant_do_mounted( false ) ||
        who.has_effect( efftype_id( "incorporeal" ) ) || who.pos_abs() != choice.origin ||
        choice.target.position.z() != choice.origin.z() || !here.inbounds( choice.target.position ) ||
        !here.inbounds( choice.origin ) || square_dist( choice.origin, choice.target.position ) > 1 ) {
        return false;
    }
    const tripoint_bub_ms tile = here.get_bub( choice.target.position );
    if( !here.has_loaded_submap( tile ) || !here.has_loaded_submap( who.pos_bub( here ) ) ||
        here.veh_at( tile ) || !choice.target.matches( here ) ||
        !( here.has_furn( tile ) ? here.furn( tile )->has_examine( iexamine::fireplace ) :
           here.ter( tile )->has_examine( iexamine::fireplace ) ) ) {
        return false;
    }
    if( choice.action != fireplace_action::light_with_tool && ( choice.tool || choice.tinder ) ) {
        return false;
    }
    if( choice.action == fireplace_action::extinguish ) {
        if( !here.get_field( tile, field_fd_fire ) || !has_fireplace_quencher( who, here, tile ) ) {
            return false;
        }
        here.remove_field( tile, field_fd_fire );
        who.mod_moves( -200 );
        who.add_msg_if_player( m_info, _( "With a few determined moves you put out the fire in the %s." ),
                               here.name( tile ) );
        return true;
    }
    if( here.has_nearby_fire( tile, 0 ) ) {
        return false;
    }
    if( choice.action == fireplace_action::light_with_bionic ) {
        const character_action_guard lifetime( who );
        if( !lifetime || !can_light_fireplace_with_bionic( who ) ||
            !here.add_field( tile, field_fd_fire, 1 ) ) {
            return false;
        }
        if( lifetime ) {
            who.mod_power_level( -bio_lighter->power_activate );
            who.mod_moves( -to_moves<int>( 1_seconds ) );
        }
        return true;
    }

    item_location tool = choice.tool ? resolve_item_source( who, here, *choice.tool,
                         pickup_range ) : item_location();
    const firestarter_actor *method = firestarter_for( tool );
    if( !method || tool->is_broken() || !available_fireplace_supply( who, tool ) ||
        ( !tool.held_by( who ) && tool.pos_abs() == choice.target.position ) ) {
        return false;
    }
    if( choice.tinder && !available_fireplace_supply( who,
            resolve_item_source( who, here, *choice.tinder, pickup_range ) ) ) {
        return false;
    }
    const character_action_guard lifetime( who );
    const auto context = here.get_context_reference();
    const activity_execution previous = who.activity.execution();
    who.activity.set_execution( execution );
    const on_out_of_scope restore_execution( [&]() {
        if( lifetime && !who.activity ) {
            who.activity.set_execution( previous );
        }
    } );
    item_activation_choices activation;
    activation.fire_target = choice.target;
    activation.fire_tinder = choice.tinder;
    who.add_msg_if_player( _( "You attempt to start a fire with your %s…" ), tool->tname() );
    const auto spent = method->use_with_tool( who, tool, here, tile, activation );
    if( !spent ) {
        return false;
    }
    if( lifetime && context && tool && *spent > 0 ) {
        tool->activation_consume( *spent, tool.pos_bub( here ), &who );
    }
    if( changed_tiles ) {
        for( const auto *supply : {
                 &choice.tool, &choice.tinder
             } ) {
            if( *supply && ( *supply )->kind != "carried" ) {
                changed_tiles->push_back( ( *supply )->position );
            }
        }
    }
    return true;
}
