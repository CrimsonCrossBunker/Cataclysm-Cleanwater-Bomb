#include "martial_style_selection.h"

#include <algorithm>
#include <set>

#include "bionics.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "character_action_guard.h"
#include "character_martial_arts.h"
#include "color.h"
#include "input_context.h"
#include "json.h"
#include "martialarts.h"
#include "mp_client_conn.h"
#include "mp_inventory_activity.h"
#include "output.h"
#include "player_activity.h"
#include "string_formatter.h"
#include "translations.h"
#include "uilist.h"
#include "localized_comparator.h"

void martial_style_choice::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "action", static_cast<int>( action ) );
    out.member( "style", style );
    out.end_object();
}

void martial_style_choice::deserialize( const JsonObject &data )
{
    const int kind = data.get_int( "action" );
    if( kind < 0 || kind > static_cast<int>( martial_style_action::cancel ) ) {
        data.throw_error_at( "action", "Unknown martial style choice" );
    }
    action = static_cast<martial_style_action>( kind );
    data.read( "style", style, true );
}

std::vector<matype_id> available_martial_styles( const Character &who,
        std::optional<unsigned int> activating_bionic )
{
    std::set<matype_id> bio_styles;
    for( const bionic &bio : *who.my_bionics ) {
        if( who.has_active_bionic( bio.id ) || activating_bionic == bio.get_uid() ) {
            bio_styles.insert( bio.info().ma_styles.begin(), bio.info().ma_styles.end() );
        }
    }
    return bio_styles.empty() ? who.martial_arts_data->get_known_styles( false ) :
           std::vector<matype_id>( bio_styles.begin(), bio_styles.end() );
}

bool valid_martial_style_choice( const Character &who, const martial_style_choice &choice,
                                 std::optional<unsigned int> activating_bionic )
{
    if( activating_bionic && !who.find_bionic_by_uid( *activating_bionic ) ) {
        return false;
    }
    switch( choice.action ) {
        case martial_style_action::select: {
            const auto styles = available_martial_styles( who, activating_bionic );
            return choice.style.is_valid() &&
                   std::find( styles.begin(), styles.end(), choice.style ) != styles.end();
        }
        case martial_style_action::toggle_hands_free:
        case martial_style_action::toggle_auto:
            return choice.style.str().empty();
        case martial_style_action::cancel:
            // Cancelling CQB after powering it has native activation costs.
            return activating_bionic && choice.style.str().empty();
    }
    return false;
}

bool execute_martial_style_choice( Character &who, const martial_style_choice &choice )
{
    const character_action_guard lifetime( who );
    if( !lifetime || !valid_martial_style_choice( who, choice ) ) {
        return false;
    }
    const activity_execution previous = who.activity.execution();
    who.activity.set_execution( activity_execution::authoritative );
    const on_out_of_scope restore_role( [&]() {
        if( lifetime ) {
            who.activity.set_execution( who.activity ? activity_execution::authoritative : previous );
        }
    } );
    auto &arts = *who.martial_arts_data;
    switch( choice.action ) {
        case martial_style_action::select:
            arts.clear_all_effects( who );
            if( !lifetime ) {
                return false;
            }
            arts.set_style( choice.style, true );
            if( arts.auto_style ) {
                arts.remember_weapon_style( who );
            }
            arts.ma_static_effects( who );
            if( !lifetime ) {
                return false;
            }
            arts.martialart_use_message( who );
            break;
        case martial_style_action::toggle_auto:
            arts.auto_style = !arts.auto_style;
            arts.auto_select_style( who );
            break;
        case martial_style_action::toggle_hands_free:
            arts.keep_hands_free = !arts.keep_hands_free;
            break;
        case martial_style_action::cancel:
            return false;
    }
    return static_cast<bool>( lifetime );
}

std::optional<martial_style_choice> query_martial_style_choice( const Character &you,
        std::optional<unsigned int> activating_bionic )
{
    enum style_selection {
        KEEP_HANDS_FREE = 0,
        AUTO_STYLE,
        STYLE_OFFSET
    };
    const auto &arts = *you.martial_arts_data;
    auto selectable_styles = available_martial_styles( you, activating_bionic );
    // If there are style already, cursor starts there
    // if no selected styles, cursor starts from no-style

    // Any other keys quit the menu
    input_context ctxt( "MELEE_STYLE_PICKER", keyboard_mode::keycode );
    ctxt.register_action( "SHOW_DESCRIPTION" );

    uilist kmenu;
    kmenu.title = _( "Select a style.\n" );
    kmenu.text = string_format( _( "STR: <color_white>%d</color>, DEX: <color_white>%d</color>, "
                                   "PER: <color_white>%d</color>, INT: <color_white>%d</color>\n"
                                   "Press [<color_yellow>%s</color>] for technique details and compatible weapons.\n" ),
                                you.get_str(), you.get_dex(), you.get_per(), you.get_int(),
                                ctxt.get_desc( "SHOW_DESCRIPTION" ) );
    ma_style_callback callback( static_cast<size_t>( STYLE_OFFSET ), selectable_styles );
    kmenu.callback = &callback;
    kmenu.input_category = "MELEE_STYLE_PICKER";
    kmenu.additional_actions.emplace_back( "SHOW_DESCRIPTION", translation() );
    kmenu.desc_enabled = true;
    kmenu.addentry_desc( KEEP_HANDS_FREE, true, 'h',
                         arts.keep_hands_free ? _( "Keep hands free (on)" ) : _( "Keep hands free (off)" ),
                         wrap60( _( "When this is enabled, player won't wield things unless explicitly told to." ) ) );

    kmenu.addentry_desc( AUTO_STYLE, true, 'a',
                         arts.auto_style ? _( "Switch style with weapon (on)" ) :
                         _( "Switch style with weapon (off)" ),
                         wrap60( _( "Automatically select a learned style for your weapon.  While enabled, selecting a style remembers it as the preference for this weapon type (or for empty hands)." ) ) );

    kmenu.selected = STYLE_OFFSET;

    // +1 to keep "No Style" at top
    if( selectable_styles.size() > 1 ) {
        std::sort( selectable_styles.begin() + 1, selectable_styles.end(),
        []( const matype_id & a, const matype_id & b ) {
            return localized_compare( a->name.translated(), b->name.translated() );
        } );
    }

    for( size_t i = 0; i < selectable_styles.size(); i++ ) {
        const martialart &style = selectable_styles[i].obj();
        //Check if this style is currently selected
        const bool selected = selectable_styles[i] == arts.selected_style();
        std::string entry_text = style.name.translated();
        if( selected ) {
            kmenu.selected = i + STYLE_OFFSET;
            entry_text = colorize( entry_text, c_pink );
        }
        kmenu.addentry_desc( i + STYLE_OFFSET, true, -1, entry_text,
                             wrap60( style.description.translated() ) );
    }

    kmenu.query();
    int selection = kmenu.ret;


    if( selection >= STYLE_OFFSET &&
        static_cast<size_t>( selection - STYLE_OFFSET ) < selectable_styles.size() ) {
        return martial_style_choice{ martial_style_action::select, selectable_styles[selection - STYLE_OFFSET] };
    }
    if( selection == AUTO_STYLE ) {
        return martial_style_choice{ martial_style_action::toggle_auto, matype_id() };
    }
    if( selection == KEEP_HANDS_FREE ) {
        return martial_style_choice{ martial_style_action::toggle_hands_free, matype_id() };
    }
    return std::nullopt;
}

bool character_martial_arts::pick_style( Character &you )
{
    const character_action_guard lifetime( you );
    const auto choice = query_martial_style_choice( you );
    if( !lifetime || !choice || !valid_martial_style_choice( you, *choice ) ) {
        return false;
    }
    if( you.is_avatar() && cata_mp::is_client_mode() ) {
        return cata_mp::client_select_martial_style( *choice );
    }
    return execute_martial_style_choice( you, *choice );
}
