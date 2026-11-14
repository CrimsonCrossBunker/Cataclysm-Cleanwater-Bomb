#include "disassembly.h"
#include "mp_client_conn.h"

#include <algorithm>
#include <set>
#include <string>
#include <utility>

#include "activity_actor_definitions.h"
#include "activity_handlers.h"
#include "character.h"
#include "cata_utility.h"
#include "crafting.h"
#include "game_constants.h"
#include "input_popup.h"
#include "item.h"
#include "item_location.h"
#include "json.h"
#include "map.h"
#include "mp_gamestate.h"
#include "options.h"
#include "output.h"
#include "player_activity.h"
#include "recipe.h"
#include "recipe_dictionary.h"
#include "rng.h"
#include "string_formatter.h"
#include "temp_crafting_inventory.h"
#include "translations.h"

namespace
{
const itype_id itype_disassembly( "disassembly" );

const recipe &uncraft_recipe( const item &value )
{
    return value.typeId() == itype_disassembly ? value.get_making() :
           recipe_dictionary::get_uncraft( value.typeId() );
}

item preview_disassembly( const item &target, int quantity )
{
    if( target.typeId() == itype_disassembly ) {
        return item( target );
    }
    item original( target );
    return item( &uncraft_recipe( target ), quantity, original );
}
}

void disassembly_selection::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "source", source );
    out.member( "type", type );
    out.member( "recipe", recipe );
    out.member( "quantity", quantity );
    out.member( "allow_favorite", allow_favorite );
    out.member( "allow_worn", allow_worn );
    out.member( "allow_theft", allow_theft );
    out.end_object();
}

void disassembly_selection::deserialize( const JsonObject &data )
{
    data.read( "source", source, true );
    data.read( "type", type, true );
    data.read( "recipe", recipe, true );
    data.read( "quantity", quantity, true );
    data.read( "allow_favorite", allow_favorite );
    data.read( "allow_worn", allow_worn );
    data.read( "allow_theft", allow_theft );
}

void disassembly_preparation::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "source", source );
    out.member( "placement", static_cast<int>( placement ) );
    out.member( "weapon", weapon );
    out.member( "tools", tools );
    if( disposition ) {
        out.member( "disposition" );
        out.start_object();
        out.member( "action", disposition->action );
        out.member( "container", disposition->container );
        out.member( "pocket", disposition->pocket );
        out.end_object();
    }
    out.end_object();
}

void disassembly_preparation::deserialize( const JsonObject &data )
{
    data.read( "source", source, true );
    placement = static_cast<craft_placement>( data.get_int( "placement" ) );
    data.read( "weapon", weapon, true );
    data.read( "tools", tools, true );
    disposition.reset();
    if( data.has_object( "disposition" ) ) {
        const JsonObject choice = data.get_object( "disposition" );
        disposition = item_disposition{ choice.get_string( "action" ),
                                        choice.get_int64( "container" ), choice.get_int64( "pocket" ) };
    }
}

bool accessible_disassembly( Character &who, const item_location &target )
{
    if( !target || activity_handlers::activity_item_reserved_for_other( *target, who ) ||
        ( target.carrier() && !target.held_by( who ) ) ) {
        return false;
    }
    map &here = get_map();
    return resolve_item_source( who, here, capture_item_source( who, target ) ) == target &&
           ( target.held_by( who ) || here.clear_path( who.pos_bub(), target.pos_bub( here ), 1, 1, 100 ) );
}

disassembly_selection capture_disassembly( Character &who, const item_location &target,
        int quantity )
{
    disassembly_selection selected;
    selected.source = capture_item_source( who, target );
    selected.type = target->typeId();
    selected.recipe = uncraft_recipe( *target ).ident();
    selected.quantity = target->typeId() == itype_disassembly ? target->get_making_batch_size() :
                        quantity;
    return selected;
}

item_location resolve_disassembly( Character &who, const disassembly_selection &selected )
{
    item_location target = resolve_item_source( who, get_map(), selected.source );
    if( !accessible_disassembly( who, target ) || target->typeId() != selected.type ||
        !target->is_disassemblable() || uncraft_recipe( *target ).ident() != selected.recipe ||
        selected.quantity <= 0 ||
        ( target->typeId() == itype_disassembly ? selected.quantity != target->get_making_batch_size() :
          selected.quantity > ( target->count_by_charges() ? target->charges : 1 ) ) ||
        ( target->is_favorite && !selected.allow_favorite ) ||
        ( who.is_worn( *target ) && !selected.allow_worn ) ||
        ( !target->is_owned_by( who, true ) && !selected.allow_theft ) ) {
        return item_location::nowhere;
    }
    return target;
}

std::optional<disassembly_selection> query_disassembly_selection( Character &who,
        item_location target, bool interactive, bool all_charges )
{
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    if( !accessible_disassembly( who, target ) ) {
        return std::nullopt;
    }
    const auto can = who.can_disassemble( *target, who.crafting_inventory() );
    if( !can.success() ) {
        who.add_msg_if_player( m_info, "%s", can.c_str() );
        return std::nullopt;
    }
    disassembly_selection selected = capture_disassembly( who, target,
                                     target->count_by_charges() ? target->charges : 1 );
    const bool player = who.is_avatar();
    if( target->is_favorite && ( !player ||
                                 !who.query_yn( _( "You're going to disassemble favorited item.\nAre you sure?" ) ) ) ) {
        return std::nullopt;
    }
    if( who.is_worn( *target ) && ( !player ||
                                    !who.query_yn( _( "You're going to disassemble worn item.\nAre you sure?" ) ) ) ) {
        return std::nullopt;
    }
    if( !target->is_owned_by( who, true ) && ( !player ||
            !who.query_yn( _( "Disassembling the %s may anger the people who own it, continue?" ),
                           target->tname() ) ) ) {
        return std::nullopt;
    }
    selected.allow_favorite = target->is_favorite;
    selected.allow_worn = who.is_worn( *target );
    selected.allow_theft = !target->is_owned_by( who, true );
    const recipe &rec = uncraft_recipe( *target );
    if( player && interactive && get_option<bool>( "QUERY_DISASSEMBLE" ) &&
        target->typeId() != itype_disassembly ) {
        std::string list;
        for( const item_comp &component : target->get_uncraft_components() ) {
            list += "- " + component.to_string() + "\n";
        }
        if( !rec.learn_by_disassembly.empty() && !who.knows_recipe( &rec ) &&
            who.can_decomp_learn( rec ) ) {
            list += _( "You feel you may be able to understand this object's construction.\n" );
        }
        if( !who.query_yn( _( "Disassembling the %s may yield:\n%s\nReally disassemble?" ),
                           target->tname(), list ) ) {
            return std::nullopt;
        }
    }
    if( player && target->typeId() != itype_disassembly && target->count_by_charges() &&
        !all_charges && target->charges > 1 ) {
        number_input_popup<int> count( 0, target->charges );
        count.set_label( string_format( _( "Disassemble how many %s [MAX: %d]: " ),
                                        target->type_name( 1 ), target->charges ) );
        selected.quantity = count.query();
        if( count.cancelled() ) {
            return std::nullopt;
        }
    }
    return resolve_disassembly( who, selected ) ? std::make_optional( selected ) : std::nullopt;
}

std::optional<disassembly_preparation> query_disassembly_preparation( Character &who,
        const disassembly_selection &selected )
{
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    const item_location target = resolve_disassembly( who, selected );
    if( !target ) {
        return std::nullopt;
    }
    disassembly_preparation choice;
    choice.source = target->uid().get_value();
    const item preview = preview_disassembly( *target, selected.quantity );
    if( who.is_avatar() ) {
        const auto placement = query_craft_placement( who, preview, std::nullopt, false );
        if( !placement ) {
            return std::nullopt;
        }
        choice.placement = *placement;
    } else if( !can_place_selected_craft( who, preview, std::nullopt, false, choice.placement ) ) {
        choice.placement = craft_placement::work_on_ground;
    }
    if( choice.placement == craft_placement::wield && who.has_wield_conflicts( preview ) &&
        target != who.get_wielded_item() ) {
        choice.weapon = capture_item_source( who, who.get_wielded_item() );
        choice.disposition = query_item_disposition( who, who.get_wielded_item() );
        if( !choice.disposition ) {
            return std::nullopt;
        }
    }
    temp_crafting_inventory nearby;
    nearby.form_from_map( who.pos_bub(), pickup_range, &who );
    const requirement_data requirements = uncraft_recipe( *target ).disassembly_requirements();
    for( const auto &group : requirements.get_tools() ) {
        choice.tools.push_back( who.select_tool_component( group, 1, nearby, true, true,
                                who.is_avatar() ) );
    }
    return validate_disassembly_preparation( who, selected, choice ) ?
           std::make_optional( choice ) : std::nullopt;
}

bool validate_disassembly_preparation( Character &who, const disassembly_selection &selected,
                                       disassembly_preparation &preparation )
{
    const item_location target = resolve_disassembly( who, selected );
    if( !target || target->uid().get_value() != preparation.source ||
        preparation.placement < craft_placement::automatic ||
        preparation.placement > craft_placement::drop ||
        !who.can_disassemble( *target, who.crafting_inventory() ).success() ) {
        return false;
    }
    const item preview = preview_disassembly( *target, selected.quantity );
    if( !can_place_selected_craft( who, preview, std::nullopt, false, preparation.placement ) ) {
        return false;
    }
    const bool puts_weapon_away = preparation.placement == craft_placement::wield &&
                                  who.has_wield_conflicts( preview ) && target != who.get_wielded_item();
    if( puts_weapon_away ) {
        const item_location weapon = resolve_item_source( who, get_map(), preparation.weapon );
        if( !weapon || weapon != who.get_wielded_item() || !preparation.disposition ||
            !valid_item_disposition( who, weapon, *preparation.disposition ) ) {
            return false;
        }
    } else if( preparation.disposition ) {
        return false;
    }
    const requirement_data &native = uncraft_recipe( *target ).disassembly_requirements();
    const requirement_data tools_only( native.get_tools(), native.get_qualities(), {} );
    std::vector<comp_selection<item_comp>> no_materials;
    return validate_requirement_selection( who, tools_only, no_materials, preparation.tools );
}

bool start_owned_disassembly( Character &who, const std::vector<disassembly_selection> &selected,
                              bool recursive )
{
    if( cata_mp::is_client_mode() || who.activity || who.is_dead_state() || who.get_moves() <= 0 ||
        !who.has_morale_to_craft() || selected.empty() ) {
        return false;
    }
    std::set<int64_t> originals;
    for( const disassembly_selection &selection : selected ) {
        const item_location target = resolve_disassembly( who, selection );
        if( !target || !originals.insert( target->uid().get_value() ).second ||
            !who.can_disassemble( *target, who.crafting_inventory() ).success() ) {
            return false;
        }
    }
    who.assign_activity( disassemble_activity_actor( selected, recursive ) );
    return true;
}
