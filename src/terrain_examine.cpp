#include "terrain_examine.h"

#include <array>
#include <utility>

#include "calendar.h"
#include "character.h"
#include "character_action_guard.h"
#include "craft_reservation.h"
#include "iexamine.h"
#include "item.h"
#include "item_location.h"
#include "json.h"
#include "line.h"
#include "map.h"
#include "map_selector.h"
#include "mapdata.h"
#include "translations.h"
#include "vpart_position.h"

namespace
{
const itype_id itype_2x4( "2x4" );

ter_str_id pit_transition( const ter_str_id &current, bool covering )
{
    static const std::array<std::pair<ter_str_id, ter_str_id>, 3> pits = {{
            { ter_str_id( "t_pit" ), ter_str_id( "t_pit_covered" ) },
            { ter_str_id( "t_pit_spiked" ), ter_str_id( "t_pit_spiked_covered" ) },
            { ter_str_id( "t_pit_glass" ), ter_str_id( "t_pit_glass_covered" ) }
        }
    };
    for( const auto &[open, covered] : pits ) {
        if( current == ( covering ? open : covered ) ) {
            return covering ? covered : open;
        }
    }
    return ter_str_id::NULL_ID();
}

void drop_curtain_materials( Character &who, map &here, const tripoint_abs_ms &position,
                             std::vector<tripoint_abs_ms> *changed_tiles )
{
    static const std::array<std::pair<itype_id, int>, 5> materials = {{
            { itype_id( "nail" ), 4 }, { itype_id( "sheet" ), 0 }, { itype_id( "sheet" ), 0 },
            { itype_id( "stick" ), 0 }, { itype_id( "string_36" ), 0 }
        }
    };
    const tripoint_bub_ms tile = here.get_bub( position );
    std::vector<item_location> products;
    for( const auto &[type, charges] : materials ) {
        if( auto material = here.prepare_spawn_item( tile, type, charges, calendar::turn ) ) {
            item &stored = here.add_item_unprocessed( tile, std::move( *material ) );
            if( !stored.is_null() ) {
                products.emplace_back( map_cursor( position ), &stored );
            }
        }
    }
    const character_action_guard lifetime( who );
    const auto context = here.get_context_reference();
    for( item_location &product : products ) {
        if( !lifetime || !context || who.pos_abs() != position ) {
            break;
        }
        if( product && product.pos_abs() == position ) {
            item_location placed;
            here.settle_item_on_ground( tile, product, &who, &placed );
            if( changed_tiles && context && placed ) {
                changed_tiles->push_back( placed.pos_abs() );
            }
        }
    }
}
} // namespace

void terrain_examine_selection::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "action", static_cast<int>( action ) );
    out.member( "origin", origin );
    out.member( "target", target );
    out.member( "terrain", terrain );
    out.member( "plank", plank );
    out.end_object();
}

void terrain_examine_selection::deserialize( const JsonObject &data )
{
    const int value = data.get_int( "action" );
    if( value < static_cast<int>( terrain_examine_action::cover_pit ) ||
        value > static_cast<int>( terrain_examine_action::remove_curtains ) ) {
        data.throw_error_at( "action", "Invalid terrain examination action" );
    }
    action = static_cast<terrain_examine_action>( value );
    data.read( "origin", origin, true );
    data.read( "target", target, true );
    data.read( "terrain", terrain, true );
    data.read( "plank", plank );
}

bool can_use_pit_plank( Character &who, map &here, const item_location &plank )
{
    if( !plank || plank->typeId() != itype_2x4 || plank->count() <= 0 ||
        !is_crafting_component( *plank ) || !craft_reservation::usable_by_automation( *plank ) ||
        !plank->is_owned_by( who, true ) || !who.can_drop( *plank ).success() ||
        !can_remove_from_item_pockets( who, plank ) ) {
        return false;
    }
    if( plank.held_by( who ) ) {
        return true;
    }
    if( plank.where_recursive() != item_location::type::map &&
        plank.where_recursive() != item_location::type::vehicle ) {
        return false;
    }
    const tripoint_bub_ms origin = who.pos_bub( here );
    const tripoint_bub_ms tile = plank.pos_bub( here );
    return here.has_loaded_submap( tile ) && tile.z() == origin.z() && here.accessible_items( tile ) &&
           ( tile == origin || here.clear_path( origin, tile, pickup_range, 1, 100 ) );
}

bool can_access_curtains( const Character &who, map &here, const tripoint_bub_ms &tile )
{
    return !here.is_outside( who.pos_bub( here ) ) ||
           ( !here.has_flag( ter_furn_flag::TFLAG_WALL, tile ) &&
             !here.has_flag( ter_furn_flag::TFLAG_BARRICADABLE_WINDOW_CURTAINS, tile ) );
}

bool execute_terrain_examine( Character &who, map &here, const terrain_examine_selection &choice,
                              std::vector<tripoint_abs_ms> *changed_tiles )
{
    if( who.activity || who.get_moves() <= 0 || who.is_dead_state() || who.is_mounted() ||
        who.has_effect( efftype_id( "incorporeal" ) ) || who.pos_abs() != choice.origin ||
        !here.inbounds( choice.origin ) || !here.inbounds( choice.target ) ||
        choice.origin.z() != choice.target.z() || square_dist( choice.origin, choice.target ) > 1 ) {
        return false;
    }
    const tripoint_bub_ms tile = here.get_bub( choice.target );
    if( !here.has_loaded_submap( tile ) || !here.has_loaded_submap( who.pos_bub( here ) ) ||
        here.has_furn( tile ) || here.veh_at( tile ) || here.ter( tile ).id() != choice.terrain ) {
        return false;
    }
    const bool covering = choice.action == terrain_examine_action::cover_pit;
    const bool curtains = choice.action == terrain_examine_action::remove_curtains;
    if( covering != choice.plank.has_value() ) {
        return false;
    }

    ter_str_id next;
    if( curtains ) {
        const ter_t &terrain = here.ter( tile ).obj();
        if( !terrain.has_examine( iexamine::curtains ) || !terrain.has_curtains() ||
            !can_access_curtains( who, here, tile ) ) {
            return false;
        }
        next = terrain.curtain_transform;
    } else {
        next = pit_transition( choice.terrain, covering );
    }
    if( next.is_null() || !next.is_valid() ) {
        return false;
    }

    item_location plank;
    if( covering ) {
        plank = resolve_item_source( who, here, *choice.plank, pickup_range );
        if( !can_use_pit_plank( who, here, plank ) ) {
            return false;
        }
    }
    if( !here.ter_set( tile, next ) ) {
        return false;
    }
    if( changed_tiles ) {
        changed_tiles->push_back( choice.target );
    }
    who.mod_moves( -to_moves<int>( curtains ? 10_seconds : 1_seconds ) );
    if( covering ) {
        if( changed_tiles && !plank.held_by( who ) ) {
            changed_tiles->push_back( plank.pos_abs() );
        }
        if( plank->count() > 1 ) {
            --plank->charges;
            plank.on_contents_changed();
        } else {
            plank.remove_item();
        }
        who.invalidate_crafting_inventory();
        who.add_msg_if_player( _( "You place a plank of wood over the pit." ) );
    } else if( curtains ) {
        who.add_msg_if_player( _( "You tear the curtains and curtain rod off the windowframe." ) );
        if( changed_tiles ) {
            changed_tiles->push_back( choice.origin );
        }
        drop_curtain_materials( who, here, choice.origin, changed_tiles );
    } else {
        who.add_msg_if_player( _( "You remove the plank." ) );
        if( changed_tiles ) {
            changed_tiles->push_back( choice.origin );
        }
        here.add_item_or_charges( who.pos_bub( here ), item( itype_2x4, calendar::turn ), true, &who );
    }
    return true;
}
