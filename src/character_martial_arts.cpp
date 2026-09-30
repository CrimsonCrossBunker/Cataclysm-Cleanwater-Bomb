#include "character_martial_arts.h"

#include <algorithm>

#include "action.h"
#include "bionics.h"
#include "character.h"
#include "color.h"
#include "enums.h"
#include "flexbuffer_json.h"
#include "item.h"
#include "item_location.h"
#include "json.h"
#include "martialarts.h"
#include "messages.h"
#include "output.h"
#include "translation.h"
#include "translations.h"

static const matype_id style_kicks( "style_kicks" );
static const matype_id style_none( "style_none" );

character_martial_arts::character_martial_arts()
{

    keep_hands_free = false;

    style_selected = style_none;

    ma_styles = { {
            style_none, style_kicks
        }
    };
}

bool character_martial_arts::selected_allow_all_weapons() const
{
    return style_selected->allow_all_weapons;
}

bool character_martial_arts::selected_strictly_melee() const
{
    return style_selected->strictly_melee;
}

bool character_martial_arts::selected_has_weapon( const itype_id &weap ) const
{
    return style_selected->has_weapon( weap );
}

bool character_martial_arts::selected_force_unarmed() const
{
    return style_selected->force_unarmed;
}

bool character_martial_arts::selected_prevent_weapon_blocking() const
{
    return style_selected->prevent_weapon_blocking;
}

bool character_martial_arts::knows_selected_style() const
{
    return has_martialart( style_selected );
}

bool character_martial_arts::selected_is_none() const
{
    return style_selected == style_none;
}

void character_martial_arts::learn_current_style_CQB( bool is_avatar )
{
    add_martialart( style_selected );
    if( is_avatar ) {
        add_msg( m_good, _( "You have learned %s from extensive practice with the CQB Bionic." ),
                 style_selected->name );
    }
}

void character_martial_arts::learn_style( const matype_id &mastyle, bool is_avatar )
{
    add_martialart( mastyle );

    if( is_avatar ) {
        add_msg( m_good, _( "You learn %s." ),
                 mastyle->name );
        add_msg( m_info, _( "%s to select martial arts style." ),
                 press_x( ACTION_PICK_STYLE ) );
    }
}

void character_martial_arts::set_style( const matype_id &mastyle, bool force )
{
    if( force || has_martialart( mastyle ) ) {
        style_selected = mastyle;
    }
}

void character_martial_arts::remember_weapon_style( const Character &owner )
{
    const item_location weapon = owner.get_wielded_item();
    preferred_weapon_styles[weapon ? weapon->typeId() : itype_id::NULL_ID()] = style_selected;
}

void character_martial_arts::auto_select_style( Character &owner )
{
    if( !auto_style ) {
        return;
    }
    // Active combat implants supply their own restricted style list.
    for( const bionic_id &bio : owner.get_bionics() ) {
        if( !bio->ma_styles.empty() && owner.has_active_bionic( bio ) ) {
            return;
        }
    }
    const item_location weapon = owner.get_wielded_item();
    const auto usable = [&]( const matype_id & style ) {
        return style.is_valid() && has_martialart( style ) &&
               ( style == style_none || style->force_unarmed || style->weapon_valid( weapon ) );
    };
    matype_id chosen = style_none;
    const auto preferred = preferred_weapon_styles.find( weapon ? weapon->typeId() :
        itype_id::NULL_ID() );
    if( preferred != preferred_weapon_styles.end() && usable( preferred->second ) ) {
        chosen = preferred->second;
    } else if( style_selected != style_none && usable( style_selected ) ) {
        chosen = style_selected;
    } else {
        const auto found = std::find_if( ma_styles.begin(), ma_styles.end(),
        [&]( const matype_id & style ) {
            return style != style_none && style != style_kicks && usable( style );
        } );
        if( found != ma_styles.end() ) {
            chosen = *found;
        }
    }
    if( chosen != style_selected ) {
        clear_all_effects( owner );
        set_style( chosen );
    }
}

void character_martial_arts::reset_style()
{
    style_selected = style_none;
}

void character_martial_arts::clear_style( const matype_id &id )
{
    ma_styles.erase( std::remove( ma_styles.begin(), ma_styles.end(), id ), ma_styles.end() );
    selected_style_check();
}

void character_martial_arts::clear_styles()
{
    auto_style = false;
    preferred_weapon_styles.clear();
    keep_hands_free = false;

    ma_styles = { {
            style_none, style_kicks
        }
    };
    reset_style();
}

void character_martial_arts::selected_style_check()
{
    // check if player knows current style naturally, otherwise drop them back to style_none
    if( style_selected != style_none && style_selected != style_kicks ) {
        bool has_style = false;
        for( const matype_id &elem : ma_styles ) {
            if( elem == style_selected ) {
                has_style = true;
            }
        }
        if( !has_style ) {
            reset_style();
        }
    }
}

std::string character_martial_arts::enumerate_known_styles( const itype_id &weap ) const
{
    return enumerate_as_string( ma_styles.begin(), ma_styles.end(),
    [weap]( const matype_id & mid ) {
        return mid->has_weapon( weap ) ? colorize( mid->name.translated(), c_cyan ) : std::string();
    } );
}

std::string character_martial_arts::selected_style_name( const Character &owner ) const
{
    if( style_selected->force_unarmed || style_selected->weapon_valid( owner.get_wielded_item() ) ) {
        return style_selected->name.translated();
    } else if( owner.is_armed() ) {
        return _( "Normal" );
    } else {
        return _( "No Style" );
    }
}

std::vector<matype_id> character_martial_arts::get_unknown_styles( const character_martial_arts
        &from, bool teachable_only ) const
{
    std::vector<matype_id> ret;
    for( const matype_id &i : from.ma_styles ) {
        if( ( !teachable_only || i->teachable ) && !has_martialart( i ) ) {
            ret.push_back( i );
        }
    }
    return ret;
}

std::vector<matype_id> character_martial_arts::get_known_styles( bool teachable_only ) const
{
    if( !teachable_only ) {
        return ma_styles;
    }
    std::vector<matype_id> ret;
    for( const matype_id &i : ma_styles ) {
        if( i->teachable ) {
            ret.push_back( i );
        }
    }
    return ret;
}

void character_martial_arts::serialize( JsonOut &json ) const
{
    json.start_object();
    json.member( "ma_styles", ma_styles );
    json.member( "keep_hands_free", keep_hands_free );
    json.member( "style_selected", style_selected );
    json.member( "auto_style", auto_style );
    json.member( "preferred_weapon_styles", preferred_weapon_styles );
    json.end_object();
}

void character_martial_arts::deserialize( const JsonObject &data )
{
    data.read( "ma_styles", ma_styles );
    data.read( "keep_hands_free", keep_hands_free );
    data.read( "style_selected", style_selected );
    auto_style = false;
    preferred_weapon_styles.clear();
    data.read( "auto_style", auto_style );
    data.read( "preferred_weapon_styles", preferred_weapon_styles );
}
