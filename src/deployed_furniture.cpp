#include "deployed_furniture.h"

#include <string>
#include <utility>

#include "calendar.h"
#include "character.h"
#include "character_action_guard.h"
#include "iexamine.h"
#include "item.h"
#include "json.h"
#include "line.h"
#include "map.h"
#include "mapdata.h"
#include "messages.h"
#include "translations.h"

void deployed_furniture_selection::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "origin", origin );
    out.member( "target", target );
    out.member( "furniture", furniture );
    out.end_object();
}

void deployed_furniture_selection::deserialize( const JsonObject &data )
{
    data.read( "origin", origin, true );
    data.read( "target", target, true );
    data.read( "furniture", furniture, true );
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
    const auto &furniture = here.furn( target ).obj();
    if( furniture.id != choice.furniture || !furniture.has_examine( iexamine::deployed_furniture ) ||
        !item::type_is_defined( furniture.deployed_item ) ||
        square_dist( origin.xy(), target.xy() ) > 1 ) {
        return false;
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
                                   const deployed_furniture_selection &choice )
{
    if( who.activity || !can_take_down_deployed_furniture( who, here, choice ) ) {
        return false;
    }
    const character_action_guard lifetime( who );
    if( !lifetime ) {
        return false;
    }
    const auto map_origin = here.get_abs_sub();
    const auto target = here.get_bub( choice.target );
    const auto &furniture = here.furn( target ).obj();
    const std::string name = furniture.name();
    const bool from_above = choice.origin.z() != choice.target.z();
    const auto drop = from_above ? choice.origin : choice.target;
    item recovered( furniture.deployed_item, calendar::turn );
    // Remove the source before native drop callbacks can re-enter examination.
    // Drop placement and item actions retain the normal single-player semantics.
    if( !here.furn_set( target, furn_str_id::NULL_ID() ) ) {
        return false;
    }
    here.add_item_or_charges( here.get_bub( drop ), std::move( recovered ), true, &who );
    if( lifetime && here.get_abs_sub() == map_origin ) {
        who.add_msg_if_player( m_info, from_above ? _( "You pull up the %s." ) :
                               _( "You take down the %s." ), name );
    }
    return true;
}
