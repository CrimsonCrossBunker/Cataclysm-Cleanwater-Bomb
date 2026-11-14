#include "item_activation.h"
#include "avatar.h"
#include "game.h"
#include "remote_vehicle_activity.h"
#include "tool_activity_target.h"

#include "cata_scope_helpers.h"
#include "character.h"
#include "chopping_activity.h"
#include "character_action_guard.h"
#include "flag.h"
#include "game_constants.h"
#include "item.h"
#include "item_location.h"
#include "item_pocket.h"
#include "item_source.h"
#include "itype.h"
#include "iuse.h"
#include "iuse_actor.h"
#include "line.h"
#include "lua_platform_runtime.h"
#include "map.h"
#include "player_activity.h"
#include "ret_val.h"
#include "json.h"

void salvage_selection::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "target", target );
    out.member( "type", type );
    out.member( "allow_equipped", allow_equipped );
    out.member( "allow_theft", allow_theft );
    out.end_object();
}

void salvage_selection::deserialize( const JsonObject &data )
{
    data.read( "target", target, true );
    data.read( "type", type, true );
    data.read( "allow_equipped", allow_equipped );
    data.read( "allow_theft", allow_theft );
}

void lumber_selection::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "log", log );
    out.member( "allow_theft", allow_theft );
    out.end_object();
}

void lumber_selection::deserialize( const JsonObject &data )
{
    data.read( "log", log, true );
    data.read( "allow_theft", allow_theft );
}

bool supports_owned_item_activation( const item &source, const std::string &method )
{
    if( method.empty() ) {
        return cata::lua_platform::has_platform_item_use_handler( source.typeId().str() );
    }
    const item *used = source.get_usable_item( method );
    const use_function *use = used ? used->type->get_use( method ) : nullptr;
    return use && use->get_actor_ptr() && use->get_actor_ptr()->supports_owned_activation();
}

bool query_item_activation_choices( const item &source, const std::string &method,
                                    item_activation_choices &choices )
{
    choices = {};
    if( method.empty() ) {
        return supports_owned_item_activation( source, method );
    }
    if( method == "LUMBER" ) {
        return query_lumber_choices( get_avatar(), choices );
    }
    if( method == "REMOTEVEH" ) {
        return query_remote_vehicle_choices( get_avatar(), source, choices );
    }
    if( method == "RADIOCONTROL" ) {
        const int choice = iuse::query_radiocontrol( source );
        if( choice < 0 ) {
            return false;
        }
        choices.radio = choice;
        return valid_item_activation_choices( source, method, choices );
    }
    const item *used = source.get_usable_item( method );
    const use_function *use = used ? used->type->get_use( method ) : nullptr;
    if( method == "salvage" ) {
        const auto *actor = use ? dynamic_cast<const salvage_actor *>( use->get_actor_ptr() ) : nullptr;
        return actor && actor->query_salvage_choices( get_avatar(), source, choices );
    }
    return use && use->get_actor_ptr() && use->get_actor_ptr()->query_activation_choices( choices );
}

bool valid_item_activation_choices( const item &source, const std::string &method,
                                    const item_activation_choices &choices )
{
    if( method.empty() ) {
        return choices.empty() && supports_owned_item_activation( source, method );
    }
    const item *used = source.get_usable_item( method );
    const use_function *use = used ? used->type->get_use( method ) : nullptr;
    return use && use->get_actor_ptr() && use->get_actor_ptr()->valid_activation_choices( choices );
}

static bool activate_owned_item( Character &who, item_location source,
                                 const std::string &method, const tripoint_abs_ms &target,
                                 bool allow_theft, bool allow_wet,
                                 const item_activation_choices &choices, bool examine_pry )
{
    map &here = get_map();
    const character_action_guard lifetime( who );
    if( !lifetime || who.activity || who.get_moves() <= 0 || !source ||
        resolve_item_source( who, here, capture_item_source( who, source ) ) != source ||
        ( examine_pry ? source->get_quality( quality_id( "PRY" ) ) < 1 :
          !valid_item_activation_choices( *source, method, choices ) ) || source->is_broken() ||
        who.has_effect( efftype_id( "incorporeal" ) ) || !here.inbounds( target ) ||
        rl_dist( who.pos_abs(), target ) > 1 ||
        ( !source->is_owned_by( who, true ) && !allow_theft ) ) {
        return false;
    }
    const adjacent_tool_action action = adjacent_tool_method( method );
    if( action != adjacent_tool_action::none ) {
        const item *tool = examine_pry ? source.get_item() : source->get_usable_item( method );
        if( !tool || !valid_adjacent_tool_target( action, who, here, *tool, target ) ) {
            return false;
        }
    }
    if( action == adjacent_tool_action::tree && !allow_theft &&
        !g->local_faction_action_warning( who ).empty() ) {
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
    if( !examine_pry && !method.empty() ) {
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
    if( action == adjacent_tool_action::tree &&
        !g->warn_character_maybe_anger_local_faction( who, true, false, allow_theft ) ) {
        return false;
    }
    const bool map_light = in_place && source.where() == item_location::type::map;
    if( map_light ) {
        here.update_lum( source, false );
    }
    who.last_item = source->typeId();
    if( examine_pry ) {
        iuse::crowbar( &who, source.get_item(), position );
    } else if( method.empty() ) {
        who.Character::invoke_item( source.get_item(), position, pre_obtain_moves );
    } else {
        who.invoke_item( source.get_item(), method, position, pre_obtain_moves, &choices );
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

bool execute_owned_item_activation( Character &who, item_location source,
                                    const std::string &method, const tripoint_abs_ms &target,
                                    bool allow_theft, bool allow_wet,
                                    const item_activation_choices &choices )
{
    return activate_owned_item( who, source, method, target, allow_theft, allow_wet, choices, false );
}

bool execute_owned_prying( Character &who, item_location tool, const tripoint_abs_ms &target,
                           bool allow_theft, bool allow_wet )
{
    return activate_owned_item( who, tool, "CROWBAR", target, allow_theft, allow_wet, {}, true );
}
