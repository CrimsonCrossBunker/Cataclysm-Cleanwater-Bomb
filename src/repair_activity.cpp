#include "repair_activity.h"

#include <algorithm>
#include <cmath>
#include <set>
#include <utility>

#include "activity_handlers.h"
#include "cached_options.h"
#include "calendar.h"
#include "line.h"
#include "units.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "character_action_guard.h"
#include "flag.h"
#include "game.h"
#include "game_constants.h"
#include "game_inventory.h"
#include "item.h"
#include "item_location.h"
#include "itype.h"
#include "iuse_actor.h"
#include "json.h"
#include "map.h"
#include "mp_inventory_activity.h"
#include "mp_client_conn.h"
#include "player_activity.h"
#include "rng.h"
#include "skill.h"
#include "string_formatter.h"
#include "temp_crafting_inventory.h"
#include "translations.h"
#include "uilist.h"
#include "vehicle.h"
#include "vehicle_control.h"
#include "veh_type.h"
#include "vpart_range.h"
#include "vpart_position.h"

namespace
{
bool repeating( int value )
{
    return value == static_cast<int>( repair_repeat::ONCE ) ||
           value == static_cast<int>( repair_repeat::FULL ) ||
           value == static_cast<int>( repair_repeat::EVENT ) ||
           value == static_cast<int>( repair_repeat::REFIT_ONCE ) ||
           value == static_cast<int>( repair_repeat::REFIT_FULL );
}

bool refitting( int value )
{
    return value == static_cast<int>( repair_repeat::REFIT_ONCE ) ||
           value == static_cast<int>( repair_repeat::REFIT_FULL );
}

const repair_item_actor *repair_method( const item &tool, const std::string &method )
{
    const use_function *use = tool.get_use( method );
    return use ? dynamic_cast<const repair_item_actor *>( use->get_actor_ptr() ) : nullptr;
}

bool supplies( const vehicle &target, const vehicle_part &part, const repair_tool_source &source )
{
    if( part.removed || !part.is_available() || part.get_base().uid().get_value() != source.part ) {
        return false;
    }
    if( source.installed_tool ) {
        const auto &tools = target.get_tools( part );
        return std::any_of( tools.begin(), tools.end(), [&]( const item & tool ) {
            return tool.uid().get_value() == source.installed_tool && tool.typeId().str() == source.tool;
        } );
    }
    const auto tools = part.info().get_pseudo_tools();
    return std::any_of( tools.begin(), tools.end(), [&]( const auto & tool ) {
        return tool.first.str() == source.tool;
    } );
}

bool hardware_present( const vehicle &target, const repair_tool_source &source )
{
    for( const vpart_reference &part : target.get_all_parts() ) {
        if( part.pos_abs() == source.position && supplies( target, part.part(), source ) ) {
            return true;
        }
    }
    return false;
}

struct prepared_tool {
    item_location portable;
    std::unique_ptr<item> proxy;
    item *tool = nullptr;
    const repair_item_actor *action = nullptr;
    int initial_ammo = 0;
    itype_id fuel;
    std::map<std::string, multimag_pocket_state> bindings;
};

std::optional<prepared_tool> prepare_tool( Character &who, const repair_tool_source &source )
{
    if( who.is_dead_state() || source.method.empty() ) {
        return std::nullopt;
    }
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    map &here = get_map();
    prepared_tool result;
    if( source.vehicle_id ) {
        vehicle *target = vehicle::find_vehicle_by_uid( here, source.vehicle_id );
        const itype_id type( source.tool );
        if( !target || !type.is_valid() || who.pos_abs().z() != source.position.z() ||
            rl_dist( who.pos_abs(), source.position ) > 1 || !hardware_present( *target, source ) ) {
            return std::nullopt;
        }
        result.proxy = std::make_unique<item>( type, calendar::turn );
        result.tool = result.proxy.get();
        if( result.tool->uses_firing_requirements() ) {
            result.tool->set_flag( flag_PSEUDO );
            result.bindings = vehicle::prepare_multimag_pockets( *target, here, *result.tool );
            if( target->is_locked && std::any_of( result.bindings.begin(), result.bindings.end(),
            []( const auto & binding ) {
            return binding.second.kind == multimag_pocket_state::source_kind::BATTERY;
        } ) ) {
                return std::nullopt;
            }
        } else {
            result.fuel = target->tool_ammo_available( here, type ).first;
            if( target->is_locked && !result.fuel.is_null() &&
                result.fuel->ammo->type == ammotype( "battery" ) ) {
                return std::nullopt;
            }
            result.initial_ammo = target->prepare_tool( here, *result.tool );
        }
    } else {
        result.portable = resolve_item_source( who, here, source.portable );
        if( !result.portable || result.portable->is_broken() ||
            !result.portable->is_owned_by( who, true ) ||
            result.portable->typeId().str() != source.tool ) {
            return std::nullopt;
        }
        result.tool = result.portable->get_usable_item( source.method );
    }
    result.action = result.tool ? repair_method( *result.tool, source.method ) : nullptr;
    if( !result.action || !result.action->can_use_tool( who, *result.tool, false ) ) {
        return std::nullopt;
    }
    return result;
}

item_location repair_target( Character &who, const repair_activity_choice &choice,
                             const prepared_tool &tool )
{
    item_location target = resolve_item_source( who, get_map(), choice.target );
    if( !repeating( choice.repeat ) || !target || !target->is_owned_by( who, true ) ||
        target.get_item() == tool.tool ||
        !tool.action->can_repair_target( who, *target, false, true ) ||
        !tool.action->handle_components( who, *target, false, true, true, &choice.material ) ||
        ( refitting( choice.repeat ) &&
          ( !target->has_flag( flag_VARSIZE ) || target->has_flag( flag_FIT ) ) ) ) {
        return item_location::nowhere;
    }
    return target;
}

std::optional<repair_tool_source> mounted_source( vehicle &target, const tripoint_abs_ms &position,
        const itype_id &type, const std::string &method )
{
    repair_tool_source result;
    result.vehicle_id = target.uid().get_value();
    result.position = position;
    result.tool = type.str();
    result.method = method;
    for( const vpart_reference &part : target.get_all_parts() ) {
        if( part.pos_abs() != position || !part.part().is_available() ) {
            continue;
        }
        result.part = part.part().get_base().uid().get_value();
        result.installed_tool = 0;
        if( supplies( target, part.part(), result ) ) {
            return result;
        }
        for( const item &installed : target.get_tools( part.part() ) ) {
            if( installed.typeId() == type ) {
                result.installed_tool = installed.uid().get_value();
                return result;
            }
        }
    }
    return std::nullopt;
}
} // namespace

void repair_tool_source::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "portable", portable );
    out.member( "vehicle", vehicle_id );
    out.member( "part", part );
    out.member( "installed", installed_tool );
    out.member( "position", position );
    out.member( "tool", tool );
    out.member( "method", method );
    out.end_object();
}

void repair_tool_source::deserialize( const JsonObject &data )
{
    data.read( "portable", portable, true );
    data.read( "vehicle", vehicle_id, true );
    data.read( "part", part, true );
    data.read( "installed", installed_tool, true );
    data.read( "position", position, true );
    data.read( "tool", tool, true );
    data.read( "method", method, true );
}

void repair_activity_choice::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "target", target );
    out.member( "repeat", repeat );
    out.member( "material", material );
    out.end_object();
}

void repair_activity_choice::deserialize( const JsonObject &data )
{
    data.read( "target", target, true );
    data.read( "repeat", repeat, true );
    data.read( "material", material, true );
}

const activity_id &repair_activity_actor::get_type() const
{
    static const activity_id id( "ACT_REPAIR_ITEM" );
    return id;
}

void repair_activity_actor::start( player_activity &act, Character & )
{
    act.moves_total = act.moves_left = 1;
}

void repair_activity_actor::do_turn( player_activity &act, Character &who )
{
    if( waiting ) {
        act.moves_left = 1;
        if( who.is_avatar() && !cata_mp::is_client_mode() ) {
            run_local( who );
        } else {
            who.set_moves( 0 );
        }
        return;
    }
    // Preserve native vision/exertion-adjusted progress. Resource and target
    // validation happens before choosing and immediately before each attempt.
    activity_handlers::repair_item_do_turn( &act, &who );
}

bool repair_activity_actor::apply_choice( Character &who, const repair_activity_choice &selected )
{
    if( !waiting ) {
        return false;
    }
    const auto tool = prepare_tool( who, source );
    if( !tool || !repair_target( who, selected, *tool ) ) {
        return false;
    }
    choice = selected;
    waiting = false;
    who.activity.moves_total = who.activity.moves_left = tool->action->move_cost;
    return true;
}

void repair_activity_actor::finish( player_activity &act, Character &who )
{
    if( waiting || !choice ) {
        act.moves_left = 1;
        return;
    }
    auto tool = prepare_tool( who, source );
    if( !tool ) {
        act.set_to_null();
        return;
    }
    item_location target = repair_target( who, *choice, *tool );
    if( !target ) {
        choice.reset();
        waiting = true;
        act.moves_left = 1;
        return;
    }
    const repair_tool_source saved_source = source;
    const repair_activity_choice selected = *choice;
    const character_action_guard lifetime( who );
    const auto generation = act.identity_generation();
    const int old_level = who.get_skill_level( tool->action->used_skill );
    const auto attempt = tool->action->repair( who, *tool->tool, target,
                         refitting( selected.repeat ), &selected.material );
    if( !lifetime ) {
        return;
    }
    // The native handler does not bill a tool that may have been destroyed
    // together with the repaired item containing it.
    if( attempt != repair_item_actor::AS_DESTROYED && attempt != repair_item_actor::AS_CANT &&
        ( tool->proxy || tool->portable ) ) {
        tool->tool->consume_tool_uses( 1, get_map(), who.pos_bub(), &who );
        if( !lifetime ) {
            return;
        }
        if( saved_source.vehicle_id ) {
            vehicle *current = vehicle::find_vehicle_by_uid( get_map(), saved_source.vehicle_id );
            if( current && hardware_present( *current, saved_source ) ) {
                if( tool->tool->uses_firing_requirements() ) {
                    vehicle::drain_back_multimag( *current, get_map(), *tool->tool, tool->bindings );
                } else {
                    const int spent = tool->initial_ammo - tool->tool->ammo_remaining_linked( get_map(), nullptr );
                    if( spent > 0 && !tool->fuel.is_null() ) {
                        if( tool->fuel->ammo->type == ammotype( "battery" ) ) {
                            current->discharge_battery( get_map(), spent );
                        } else {
                            current->drain( get_map(), tool->fuel, spent );
                        }
                    }
                }
            }
        } else {
            tool->portable.on_contents_changed();
        }
    }
    if( who.activity.identity_generation() != generation ) {
        return;
    }
    if( attempt == repair_item_actor::AS_DESTROYED || !prepare_tool( who, source ) ) {
        act.set_to_null();
        return;
    }
    const bool cannot_continue = attempt == repair_item_actor::AS_CANT || !target ||
                                 !tool->action->can_repair_target( who, *target, false, true );
    const bool event = attempt == repair_item_actor::AS_SUCCESS ||
                       attempt == repair_item_actor::AS_FAILURE ||
                       old_level != static_cast<int>( who.get_skill_level( tool->action->used_skill ) );
    const bool can_refit = !cannot_continue && target->has_flag( flag_VARSIZE ) &&
                           !target->has_flag( flag_FIT );
    const auto mode = static_cast<repair_repeat>( selected.repeat );
    waiting = cannot_continue || mode == repair_repeat::ONCE || mode == repair_repeat::REFIT_ONCE ||
              ( mode == repair_repeat::EVENT && event ) ||
              ( mode == repair_repeat::REFIT_FULL && !can_refit );
    if( cannot_continue ) {
        choice.reset();
    }
    act.moves_left = waiting ? 1 : tool->action->move_cost;
    if( waiting && who.is_avatar() && !cata_mp::is_client_mode() ) {
        run_local( who );
    }
}

std::optional<repair_activity_choice> repair_activity_actor::query_choice( Character &who ) const
{
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    auto tool = prepare_tool( who, source );
    if( !tool ) {
        return std::nullopt;
    }
    item_location target = choice ? resolve_item_source( who, get_map(), choice->target ) :
                           item_location::nowhere;
    if( target && !tool->action->can_repair_target( who, *target, false, true ) ) {
        target = item_location::nowhere;
    }
    repair_repeat previous = choice ? static_cast<repair_repeat>( choice->repeat ) :
                             repair_repeat::INIT;
    while( true ) {
        if( !target ) {
            target = game_menus::inv::repair( who, tool->action, tool->tool );
        }
        if( !target ) {
            return std::nullopt;
        }
        if( !tool->action->can_repair_target( who, *target, true, true ) ) {
            return std::nullopt;
        }
        const repair_repeat repeat = query_repair_repeat( who, *tool->tool, *target, *tool->action,
                                     previous );
        if( repeat == repair_repeat::CANCEL ) {
            return std::nullopt;
        }
        if( repeat == repair_repeat::INIT ) {
            target = item_location::nowhere;
            continue;
        }
        const int count = std::max<int>( 1, std::ceil( target->base_volume() *
                                         tool->action->cost_scaling / 250_ml ) );
        std::vector<item_comp> alternatives;
        for( const itype_id &type : tool->action->get_valid_repair_materials( *target ) ) {
            alternatives.emplace_back( type, count );
        }
        temp_crafting_inventory nearby;
        nearby.form_from_map( who.pos_bub(), pickup_range, &who );
        const bool filthy = target->is_filthy();
        const auto filter = [filthy]( const item & candidate ) {
            return filthy ? candidate.allow_crafting_component() : is_crafting_component( candidate );
        };
        const auto material = who.select_item_component( alternatives, 1, nearby, true, filter );
        if( material.use_from == usage_from::cancel ) {
            return std::nullopt;
        }
        return repair_activity_choice{ capture_item_source( who, target ), static_cast<int>( repeat ), material };
    }
}

void repair_activity_actor::run_local( Character &who )
{
    const character_action_guard lifetime( who );
    const auto generation = who.activity.identity_generation();
    const auto selected = query_choice( who );
    if( !lifetime || who.activity.identity_generation() != generation ) {
        return;
    }
    if( !selected || !apply_choice( who, *selected ) ) {
        who.cancel_activity();
    }
}

std::unique_ptr<activity_actor> repair_activity_actor::clone() const
{
    return std::make_unique<repair_activity_actor>( *this );
}

void repair_activity_actor::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "source", source );
    out.member( "choice", choice );
    out.member( "waiting", waiting );
    out.end_object();
}

void repair_activity_actor::read( const JsonObject &data )
{
    data.read( "source", source, true );
    data.read( "choice", choice, true );
    data.read( "waiting", waiting, true );
}

std::unique_ptr<activity_actor> repair_activity_actor::deserialize( JsonValue &data )
{
    auto result = std::make_unique<repair_activity_actor>();
    result->read( data.get_object() );
    return result;
}

bool start_owned_repair( Character &who, item_location tool, const std::string &method )
{
    if( !tool ) {
        return false;
    }
    repair_activity_actor actor;
    actor.source.portable = capture_item_source( who, tool );
    actor.source.tool = tool->typeId().str();
    actor.source.method = method;
    if( !prepare_tool( who, actor.source ) ) {
        return false;
    }
    const character_action_guard lifetime( who );
    who.assign_activity( actor );
    if( lifetime ) {
        who.activity.set_execution( activity_execution::authoritative );
    }
    return true;
}

bool valid_vehicle_repair( Character &who, map &, vehicle &target,
                           const tripoint_abs_ms &position, const repair_tool_source &source )
{
    return source.vehicle_id == target.uid().get_value() && source.position == position &&
           prepare_tool( who, source ).has_value();
}

bool execute_vehicle_repair( Character &who, const repair_tool_source &source )
{
    if( !source.vehicle_id || !prepare_tool( who, source ) ) {
        return false;
    }
    repair_activity_actor actor;
    actor.source = source;
    const character_action_guard lifetime( who );
    who.assign_activity( actor );
    if( lifetime ) {
        who.activity.set_execution( activity_execution::authoritative );
    }
    return true;
}

namespace
{
std::set<std::pair<itype_id, std::string>> repair_tools( const vehicle &target,
                                        const tripoint_abs_ms &position )
{
    std::set<std::pair<itype_id, std::string>> result;
    const auto add = [&]( const itype_id & type ) {
        for( const auto &method : type->use_methods ) {
            if( dynamic_cast<const repair_item_actor *>( method.second.get_actor_ptr() ) ) {
                result.emplace( type, method.first );
            }
        }
    };
    for( const vpart_reference &part : target.get_all_parts() ) {
        if( part.pos_abs() != position || !part.part().is_available() ) {
            continue;
        }
        for( const auto &tool : part.part().info().get_pseudo_tools() ) {
            add( tool.first );
        }
        for( const item &tool : target.get_tools( part.part() ) ) {
            add( tool.typeId() );
        }
    }
    return result;
}
} // namespace

bool has_vehicle_repair_tool( const vehicle &target, const tripoint_abs_ms &position )
{
    return !repair_tools( target, position ).empty();
}

std::optional<vehicle_control_selection> query_vehicle_repair( Character &who, map &here,
        vehicle &target, const tripoint_abs_ms &position )
{
    const auto found = repair_tools( target, position );
    const std::vector<std::pair<itype_id, std::string>> options( found.begin(), found.end() );
    if( options.empty() ) {
        return std::nullopt;
    }
    int selected = 0;
    if( options.size() > 1 ) {
        uilist menu;
        menu.title = _( "Select a repair tool" );
        for( size_t i = 0; i < options.size(); ++i ) {
            menu.addentry( i, true, MENU_AUTOASSIGN, string_format( "%s: %s",
                           options[i].first->nname( 1 ), options[i].first->get_use( options[i].second )->get_name() ) );
        }
        menu.query();
        selected = menu.ret;
    }
    if( selected < 0 || static_cast<size_t>( selected ) >= options.size() ) {
        return std::nullopt;
    }
    auto request = query_vehicle_control( who, here, target, position, "repair" );
    if( request ) {
        request->repair = mounted_source( target, position, options[selected].first,
                                          options[selected].second );
    }
    return request;
}

bool query_mounted_repair( Character &who, const item &tool, const tripoint_bub_ms &position,
                           const std::string &method )
{
    if( !who.is_avatar() ) {
        return false;
    }
    map &here = get_map();
    const optional_vpart_position part = here.veh_at( position );
    if( !part ) {
        return false;
    }
    auto request = query_vehicle_control( who, here, part->vehicle(), here.get_abs( position ),
                                          "repair" );
    if( !request ) {
        return false;
    }
    request->repair = mounted_source( part->vehicle(), request->position, tool.typeId(), method );
    return request->repair && ( cata_mp::client_vehicle_control( *request ) ||
                                execute_vehicle_control( who, here, *request ) );
}
