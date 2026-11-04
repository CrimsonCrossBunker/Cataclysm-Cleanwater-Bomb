#include "item_activation.h"

#include "cata_scope_helpers.h"
#include "character.h"
#include "character_action_guard.h"
#include "flag.h"
#include "game_constants.h"
#include "item.h"
#include "item_location.h"
#include "item_pocket.h"
#include "item_source.h"
#include "itype.h"
#include "iuse.h"
#include "line.h"
#include "lua_platform_runtime.h"
#include "map.h"
#include "player_activity.h"
#include "ret_val.h"

bool supports_owned_item_activation( const item &source, const std::string &method )
{
    if( method.empty() ) {
        return cata::lua_platform::has_platform_item_use_handler( source.typeId().str() );
    }
    const item *used = source.get_usable_item( method );
    const use_function *use = used ? used->type->get_use( method ) : nullptr;
    return use && use->get_actor_ptr() && use->get_actor_ptr()->supports_owned_activation();
}

bool execute_owned_item_activation( Character &who, item_location source,
                                    const std::string &method, const tripoint_abs_ms &target,
                                    bool allow_theft, bool allow_wet )
{
    map &here = get_map();
    const character_action_guard lifetime( who );
    if( !lifetime || who.activity || who.get_moves() <= 0 || !source ||
        resolve_item_source( who, here, capture_item_source( who, source ) ) != source ||
        !supports_owned_item_activation( *source, method ) || source->is_broken() ||
        who.has_effect( efftype_id( "incorporeal" ) ) || !here.inbounds( target ) ||
        rl_dist( who.pos_abs(), target ) > 1 ||
        ( !source->is_owned_by( who, true ) && !allow_theft ) ) {
        return false;
    }
    const bool wet = source->wetness && source->has_flag( flag_WATER_BREAK_ACTIVE );
    if( wet && !allow_wet ) {
        return false;
    }
    // Opening a spilling pocket requires a separate owner destination choice.
    // Never let an NPC proxy silently choose where the player's liquids go.
    for( item_location parent = source; parent.has_parent(); ) {
        const item_pocket *pocket = parent.parent_pocket();
        parent = parent.parent_item();
        if( pocket && pocket->will_spill_if_unsealed() && !pocket->empty() &&
            parent.where() != item_location::type::map && !who.is_wielding( *parent ) ) {
            return false;
        }
    }
    const tripoint_bub_ms position = here.get_bub( target );
    if( !method.empty() ) {
        const item *used = source->get_usable_item( method );
        const use_function *use = used ? used->type->get_use( method ) : nullptr;
        if( !use || !source->ammo_sufficient( &who, method ) ||
            !use->can_call( who, *used, &here, position ).success() ) {
            return false;
        }
    }

    const activity_execution previous_execution = who.activity.execution();
    who.activity.set_execution( activity_execution::authoritative );
    const on_out_of_scope continue_authority( [&]() {
        if( lifetime ) {
            who.activity.set_execution( who.activity ? activity_execution::authoritative :
                                        previous_execution );
        }
    } );
    source.overflow( here );
    if( !lifetime || !source ) {
        return false;
    }
    source->handle_pickup_ownership( who );
    if( !lifetime || !source ) {
        return false;
    }
    if( wet ) {
        source->deactivate();
        source->set_random_fault_of_type( "wet", true );
        if( source->has_flag( flag_ELECTRONIC ) ) {
            source->set_random_fault_of_type( "shorted", true );
        }
    }
    const bool in_place = source->has_flag( flag_ALLOWS_REMOTE_USE ) || who.is_worn( *source );
    int pre_obtain_moves = who.get_moves();
    if( !in_place ) {
        const bool carried = source.held_by( who );
        source = source.obtain( who, 1 );
        if( !lifetime || !source ) {
            return false;
        }
        if( !carried ) {
            pre_obtain_moves = who.get_moves();
        }
    }
    const bool map_light = in_place && source.where() == item_location::type::map;
    if( map_light ) {
        here.update_lum( source, false );
    }
    who.last_item = source->typeId();
    if( method.empty() ) {
        who.Character::invoke_item( source.get_item(), position, pre_obtain_moves );
    } else {
        who.invoke_item( source.get_item(), method, position, pre_obtain_moves );
    }
    if( !lifetime ) {
        return true;
    }
    if( source ) {
        if( map_light ) {
            here.update_lum( source, true );
        }
        if( in_place ) {
            source.make_active();
        }
        source.on_contents_changed();
    }
    who.recoil = MAX_RECOIL;
    return true;
}
