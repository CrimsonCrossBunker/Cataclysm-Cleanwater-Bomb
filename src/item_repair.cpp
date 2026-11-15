#include "item_repair.h"

#include <algorithm>
#include <cstdlib>
#include <set>
#include <utility>

#include "activity_actor_definitions.h"
#include "calendar.h"
#include "character.h"
#include "character_action_guard.h"
#include "fault.h"
#include "item.h"
#include "item_consumption.h"
#include "itype.h"
#include "iuse_actor.h"
#include "json.h"
#include "map.h"
#ifdef MP_ENABLED
    #include "mp_client_conn.h"
    #include "mp_inventory_activity.h"
#endif
#include "player_activity.h"
#include "repair_activity.h"
#include "requirements.h"
#include "translations.h"
#include "type_id.h"
#include "veh_interact.h"
#include "vehicle.h"
#include "vehicle_selector.h"

namespace item_repair
{
namespace
{
const trait_id trait_DEBUG_HS( "DEBUG_HS" );

bool mending_choice_available( Character &who, const item &target, const mending_selection &choice )
{
    if( !choice.fault.is_valid() ) {
        return false;
    }
    if( choice.debug_toggle ) {
        return who.has_trait( trait_DEBUG_HS ) && target.faults_potential().count( choice.fault ) &&
               target.has_fault( choice.fault ) == choice.expected_fault;
    }
    return target.has_fault( choice.fault ) && choice.fix.is_valid() &&
           choice.fault->get_fixes().count( choice.fix ) && can_mend_fault( who, *choice.fix );
}
} // namespace

bool repair_target::matches( const item_source &candidate ) const
{
    return candidate.kind == source.kind && candidate.position == source.position &&
           candidate.path == source.path && candidate.vehicle == source.vehicle &&
           candidate.cargo == source.cargo;
}

void repair_target::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "source", source );
    out.member( "origin", origin );
    out.member( "vehicle_owner", vehicle_owner );
    out.member( "allow_theft", allow_theft );
    out.end_object();
}

void repair_target::deserialize( const JsonObject &data )
{
    data.read( "source", source, true );
    data.read( "origin", origin, true );
    data.read( "vehicle_owner", vehicle_owner, true );
    allow_theft = data.get_bool( "allow_theft", false );
}

void mending_selection::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "target", target );
    out.member( "fault", fault );
    out.member( "fix", fix );
    out.member( "debug_toggle", debug_toggle );
    out.member( "expected_fault", expected_fault );
    out.end_object();
}

void mending_selection::deserialize( const JsonObject &data )
{
    data.read( "target", target, true );
    data.read( "fault", fault, true );
    data.read( "fix", fix, true );
    debug_toggle = data.get_bool( "debug_toggle", false );
    expected_fault = data.get_bool( "expected_fault", false );
}

bool can_mend_fault( Character &who, const fault_fix &fix )
{
    return std::all_of( fix.skills.begin(), fix.skills.end(), [&]( const auto & skill ) {
        return who.get_greater_skill_or_knowledge_level( skill.first ) >= skill.second;
    } ) &&fix.get_requirements().can_make_with_inventory( &who, who.crafting_inventory(),
            is_crafting_component );
}

time_duration fault_repair_time( const Character &who, const item &target, const fault_fix &fix )
{
    time_duration duration = fix.time;
    for( const auto &[flag, multiplier] : fix.time_save_flags ) {
        if( target.has_flag( flag ) ) {
            duration *= multiplier;
        }
    }
    for( const auto &[proficiency, multiplier] : fix.time_save_profs ) {
        if( who.has_proficiency( proficiency ) ) {
            duration *= multiplier;
        }
    }
    return duration;
}

repair_target capture_target( Character &who, const item_location &target )
{
    repair_target selection;
    selection.origin = who.pos_abs();
    if( !target ) {
        return selection;
    }
    const vehicle_cursor *cursor = target.veh_cursor();
    if( cursor && target.get_item() == &cursor->veh.part( cursor->part ).get_base() ) {
        const vehicle &veh = cursor->veh;
        // Installed bases are only resolvable by this operation. They never
        // become ordinary cargo items that an inventory request can remove.
        selection.source.kind = "vehicle_part";
        selection.source.position = veh.abs_part_pos( cursor->part );
        selection.source.vehicle = veh.uid().get_value();
        selection.source.path = { target->uid().get_value() };
        selection.vehicle_owner = veh.get_owner();
    } else {
        selection.source = capture_item_source( who, target );
    }
    return selection;
}

item_location resolve_target( Character &who, map &here, const repair_target &selection )
{
    if( who.is_dead_state() || who.pos_abs() != selection.origin ||
        !here.inbounds( selection.origin ) ||
        who.fine_detail_vision_mod() > 4 ) {
        return {};
    }

    const item_source &source = selection.source;
    if( source.kind != "vehicle_part" ) {
        const bool cargo = source.kind == "vehicle" && source.vehicle > 0 && source.cargo > 0;
        if( source.kind != "carried" && source.kind != "map" && !cargo ) {
            return {};
        }
        const item_location target = resolve_item_source( who, here, source );
        return target && ( target->is_owned_by( who, true ) || selection.allow_theft ) ?
               target : item_location();
    }

    vehicle *veh = source.vehicle > 0 ? vehicle::find_vehicle_by_uid( here, source.vehicle ) : nullptr;
    if( !veh || source.path.size() != 1 || source.path.front() <= 0 ||
        !here.inbounds( source.position ) || source.position.z() != selection.origin.z() ||
        veh->magic || std::abs( veh->velocity ) > 100 || who.controlling_vehicle ||
        !who.has_morale_to_craft() || veh->get_owner() != selection.vehicle_owner ||
        ( veh->has_owner() && !veh->is_owned_by( who ) && !selection.allow_theft ) ||
        !vehicle_work_in_reach( who, here, *veh ) ) {
        return {};
    }
    int part_index = -1;
    for( int index = 0; index < veh->part_count(); ++index ) {
        const vehicle_part &part = veh->part( index );
        if( !part.removed && !part.is_fake && part.get_base().uid().get_value() == source.path.front() &&
            veh->abs_part_pos( index ) == source.position ) {
            if( part_index != -1 ) {
                return {};
            }
            part_index = index;
        }
    }
    return part_index != -1 ? veh->part_base( part_index ) : item_location();
}

bool confirm_target_ownership( Character &who, const item_location &target,
                               repair_target &selection )
{
    if( !target ) {
        return false;
    }
    const character_action_guard lifetime( who );
    const auto context = get_map().get_context_reference();
    if( selection.source.kind == "vehicle_part" ) {
        const vehicle_cursor *cursor = target.veh_cursor();
        if( !cursor ) {
            return false;
        }
        const vehicle &veh = cursor->veh;
        if( veh.has_owner() && !veh.is_owned_by( who ) ) {
            if( !who.query_yn(
                    _( "This vehicle belongs to: %s, there may be consequences if you are observed interacting with it, continue?" ),
                    veh.get_owner_name() ) ) {
                return false;
            }
            selection.allow_theft = true;
        }
    } else if( !target->is_owned_by( who, true ) ) {
        if( !query_consumption_ownership( *target, who ) ) {
            return false;
        }
        selection.allow_theft = true;
    }
    return lifetime && context && target && who.pos_abs() == selection.origin;
}

bool authorize_vehicle_work( Character &who, map &here, repair_target &selection )
{
    if( selection.source.kind != "vehicle_part" ) {
        return true;
    }
    const item_location target = resolve_target( who, here, selection );
    if( !target ) {
        return false;
    }
    vehicle &veh = target.veh_cursor()->veh;
    const auto vehicle_ref = veh.get_safe_reference();
    const auto context = here.get_context_reference();
    const character_action_guard lifetime( who );
    const auto generation = who.activity.identity_generation();
    if( !veh.handle_potential_theft( who, false, false ) || !lifetime || !context ||
        !vehicle_ref || who.activity.identity_generation() != generation ) {
        return false;
    }
    selection.vehicle_owner = vehicle_ref->get_owner();
    who.invalidate_crafting_inventory();
    return true;
}

bool start_owned_mending( Character &who, map &here, mending_selection selection )
{
    if( who.activity || who.get_moves() <= 0 ) {
        return false;
    }
    who.invalidate_crafting_inventory();
    item_location target = resolve_target( who, here, selection.target );
    if( !target || !mending_choice_available( who, *target, selection ) ) {
        return false;
    }

    if( selection.target.source.kind == "vehicle_part" ) {
        if( !authorize_vehicle_work( who, here, selection.target ) ) {
            return false;
        }
        target = resolve_target( who, here, selection.target );
        if( !target || !mending_choice_available( who, *target, selection ) ) {
            return false;
        }
    }

    if( selection.debug_toggle ) {
        if( selection.expected_fault ) {
            target->remove_fault( selection.fault );
        } else {
            target->set_fault( selection.fault, true, nullptr, true );
        }
        target.on_contents_changed();
        who.set_moves( 0 );
        return true;
    }
    const time_duration duration = fault_repair_time( who, *target, *selection.fix );
    player_activity activity{ mend_item_activity_actor( duration, std::move( selection ), who.getID() ) };
    activity.set_execution( activity_execution::authoritative );
    who.assign_activity( activity );
    return true;
}

std::vector<tool_option> tools_for( Character &you, const item_location &target )
{
    std::vector<tool_option> result;
    if( !target || target->damage() <= target->degradation() ) {
        return result;
    }
    const std::set<itype_id> &supported = target->repaired_with();
    const std::vector<item_location> tools = you.nearby( [&supported, &target]( const item * it,
    const item * ) {
        return it != target.get_item() && supported.count( it->typeId() ) > 0;
    } );
    for( const item_location &candidate : tools ) {
        const item_location tool = locate_item_with_parents( candidate );
        // Furniture pseudo tools visited by nearby() do not persist as items.
        if( !tool ) {
            continue;
        }
        for( const auto &[method, use] : tool->type->use_methods ) {
            const repair_item_actor *actor = dynamic_cast<const repair_item_actor *>( use.get_actor_ptr() );
            if( actor && actor->can_repair_target( you, *target, false, false ) ) {
                const bool available = actor->can_use_tool( you, *tool, false ) &&
                                       actor->can_repair_target( you, *target, false, true );
                result.push_back( { tool, method, actor, available } );
            }
        }
    }
    return result;
}

bool start( Character &you, const item_location &target, const tool_option &option )
{
    if( !target || !option.tool || target.get_item() == option.tool.get_item() ) {
        return false;
    }
    const use_function *use = option.tool->get_use( option.method );
    const repair_item_actor *actor = use ? dynamic_cast<const repair_item_actor *>(
                                         use->get_actor_ptr() ) : nullptr;
    if( !actor || target->damage() <= target->degradation() ||
        !actor->can_use_tool( you, *option.tool, true ) ||
        !actor->can_repair_target( you, *target, true, true ) ) {
        return false;
    }
    repair_target selected = capture_target( you, target );
    if( !confirm_target_ownership( you, target, selected ) || !option.tool ) {
        return false;
    }
#ifdef MP_ENABLED
    if( you.is_avatar() && cata_mp::is_client_mode() ) {
        return cata_mp::client_start_selected_repair( option.tool, option.method, selected );
    }
#endif
    return start_owned_repair( you, option.tool, option.method, std::move( selected ) );
}
} // namespace item_repair
