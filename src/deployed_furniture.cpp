#include "deployed_furniture.h"

#include <string>
#include <utility>

#include "calendar.h"
#include "character.h"
#include "character_action_guard.h"
#include "iexamine.h"
#include "item.h"
#include "item_location.h"
#include "json.h"
#include "line.h"
#include "map.h"
#include "map_selector.h"
#include "mapdata.h"
#include "messages.h"
#include "smoking_rack.h"
#include "translations.h"
#include "vpart_position.h"

void deployed_furniture_selection::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "origin", origin );
    out.member( "target", target );
    out.member( "furniture", furniture );
    out.member( "allow_burning", allow_burning );
    out.end_object();
}

void deployed_furniture_selection::deserialize( const JsonObject &data )
{
    data.read( "origin", origin, true );
    data.read( "target", target, true );
    data.read( "furniture", furniture, true );
    allow_burning = data.get_bool( "allow_burning", false );
}

bool can_take_down_deployed_furniture( const Character &who, const map &here,
                                       const deployed_furniture_selection &choice )
{
    if( who.pos_abs() != choice.origin || !here.inbounds( choice.target ) ||
        !here.inbounds( choice.origin ) || choice.furniture.is_null() ||
        !choice.furniture.is_valid() ) {
        return false;
    }
    const auto target = here.get_bub( choice.target );
    const auto origin = who.pos_bub( here );
    if( !here.has_loaded_submap( target ) || !here.has_loaded_submap( origin ) ) {
        return false;
    }
    const furn_id id = here.furn( target );
    const auto &furniture = id.obj();
    const bool fireplace = furniture.has_examine( iexamine::fireplace );
    const bool can_disassemble = fireplace || furniture.has_examine( iexamine::deployed_furniture ) ||
                                 ( smoking_rack::is_idle( id ) && smoking_rack::is_portable( id ) );
    if( furniture.id != choice.furniture || !can_disassemble ||
        !item::type_is_defined( furniture.deployed_item ) ||
        square_dist( origin.xy(), target.xy() ) > 1 ) {
        return false;
    }
    if( fireplace ) {
        return target.z() == origin.z() && !here.veh_at( target ) && !who.cant_do_mounted( false ) &&
               ( choice.allow_burning || !here.get_field( target, field_type_str_id( "fd_fire" ) ) );
    }
    if( target.z() == origin.z() ) {
        return true;
    }
    // Reaching below never grants access through a floor or beyond one level.
    const auto above = target + tripoint::above;
    return target.z() == origin.z() - 1 &&
           here.has_flag_furn( "EXAMINE_FROM_ABOVE", target ) &&
           here.is_open_air( above ) &&
           ( above == origin || here.valid_move( origin, above, false, true ) ) &&
           here.valid_move( above, target, false, true );
}

bool take_down_deployed_furniture( Character &who, map &here,
                                   const deployed_furniture_selection &choice,
                                   std::vector<tripoint_abs_ms> *changed_tiles )
{
    if( who.activity || !can_take_down_deployed_furniture( who, here, choice ) ) {
        return false;
    }
    const character_action_guard lifetime( who );
    if( !lifetime ) {
        return false;
    }
    const auto context = here.get_context_reference();
    const auto target = here.get_bub( choice.target );
    const auto &furniture = here.furn( target ).obj();
    const std::string name = furniture.name();
    const bool from_above = choice.origin.z() != choice.target.z();
    const auto drop = from_above ? choice.origin : choice.target;
    const tripoint_bub_ms drop_tile = here.get_bub( drop );
    item recovered( furniture.deployed_item, calendar::turn );
    // Stage the item without callbacks before removing its source. Native drop
    // actions can then re-enter safely, and a failed placement leaves the item staged.
    item &staged = here.add_item_unprocessed( drop_tile, std::move( recovered ) );
    if( staged.is_null() ) {
        return false;
    }
    if( !here.furn_set( target, furn_str_id::NULL_ID() ) ) {
        here.i_rem( drop_tile, &staged );
        return false;
    }
    if( changed_tiles ) {
        changed_tiles->push_back( choice.target );
        if( drop != choice.target ) {
            changed_tiles->push_back( drop );
        }
    }
    item_location placed;
    here.settle_item_on_ground( drop_tile, item_location( map_cursor( drop ), &staged ), &who,
                                &placed );
    if( changed_tiles && context && placed && placed.pos_abs() != drop &&
        placed.pos_abs() != choice.target ) {
        changed_tiles->push_back( placed.pos_abs() );
    }
    if( lifetime && context ) {
        who.add_msg_if_player( m_info, from_above ? _( "You pull up the %s." ) :
                               _( "You take down the %s." ), name );
    }
    return true;
}
