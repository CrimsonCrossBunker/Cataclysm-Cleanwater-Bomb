#include "calendar_ui.h"

#include <algorithm>
#include <array>
#include <limits>
#include <string>
#include <utility>
#include <vector>

#include "color.h"
#include "input_context.h"
#include "input_popup.h"
#include "string_formatter.h"
#include "translation.h"
#include "translations.h"
#include "uilist.h"

namespace
{
int year_days()
{
    return to_days<int>( calendar::year_length() );
}

int month_start( int month_index )
{
    static constexpr std::array<int, 13> days{ 0, 31, 61, 91, 122, 152, 182, 213,
            243, 273, 304, 334, 364 };
    return ( days[month_index] * year_days() + 363 ) / 364;
}

std::pair<int, int> civil_month_day( time_point date )
{
    const int day = to_days<int>( ( time_past_new_year( date ) + calendar::year_length() ) %
                                  calendar::year_length() );
    int month_index = 0;
    while( month_index < 11 && day >= month_start( month_index + 1 ) ) {
        ++month_index;
    }
    return { month_index, day - month_start( month_index ) + 1 };
}
} // namespace

time_point calendar_ui::select_time_point( time_point initial_value, std::string_view title,
        calendar_ui::granularity granularity_level, bool ignore_eternal_season )
{
    time_point return_value = initial_value;
    auto set_turn = [&]( const int initial, const time_duration & factor, const char *const msg,
    int auto_value = 0 ) {
        int new_value = initial + auto_value;
        if( new_value == initial ) {
            number_input_popup<int> time_query( 0, new_value, msg );
            int result_time = time_query.query();
            if( new_value == result_time ) {
                return;
            }
            new_value = result_time;
        }
        const time_duration offset = ( new_value - initial ) * factor;
        // Arbitrary maximal value.
        const time_point max = calendar::turn_zero + time_duration::from_turns(
                                   std::numeric_limits<int>::max() / 2 );
        return_value = std::max( std::min( max, return_value + offset ), calendar::turn_zero );
    };

    const auto set_month = [&]( int step ) {
        const auto [month_index, day] = civil_month_day( return_value );
        int selected = month_index + 1 + step;
        if( step == 0 ) {
            number_input_popup<int> query( 1, selected, _( "Set month (1–12) to?" ) );
            selected = std::clamp( query.query(), 1, 12 );
        }
        const int target = ( selected + 11 ) % 12;
        const int limit = std::max( 1, month_start( target + 1 ) - month_start( target ) );
        const int wrap_year = selected == 0 ? -year_days() : selected == 13 ? year_days() : 0;
        const int delta = wrap_year + month_start( target ) - month_start( month_index ) +
                          std::min( day, limit ) - day;
        if( delta != 0 ) {
            set_turn( 0, 1_days, "", delta );
        }
    };

    uilist smenu;
    static const auto years = []( const time_point & p ) {
        return calendar::years_since_cataclysm( p );
    };
    int iSel = smenu.ret;
    do {
        smenu.reset();
        smenu.title = title;
        smenu.text += string_format( _( "Old date: %1$s\nNew date: %2$s" ),
                                     colorize( to_string( initial_value, ignore_eternal_season ), c_light_red ),
                                     colorize( to_string( return_value, ignore_eternal_season ), c_light_cyan ) );
        smenu.desc_enabled = true;
        smenu.allow_additional = true;
        smenu.input_category = "CALENDAR_UI";
        smenu.additional_actions = {
            { "LEFT", to_translation( "Decrease value" ) },
            { "RIGHT", to_translation( "Increase value" ) },
            { "RESET", to_translation( "Reset value" ) }
        };
        smenu.footer_text += string_format( _( "Press <color_light_green>%s</color> to decrease value.\n" ),
                                            input_context( smenu.input_category ).get_desc( "LEFT" ) );
        smenu.footer_text += string_format( _( "Press <color_light_green>%s</color> to increase value.\n" ),
                                            input_context( smenu.input_category ).get_desc( "RIGHT" ) );
        smenu.footer_text += string_format( _( "Press <color_light_green>%s</color> to reset value.\n" ),
                                            input_context( smenu.input_category ).get_desc( "RESET" ) );
        smenu.footer_text += string_format(
                                 _( "Press <color_light_green>%s</color> when done selecting time point." ),
                                 input_context( smenu.input_category ).get_desc( "UILIST.QUIT" ) );

        smenu.addentry( static_cast<int>( calendar_ui::granularity::year ), true,
                        'y', "%s: %d", _( "year" ), years( return_value ) + 1 );
        const auto [month_index, day] = civil_month_day( return_value );
        smenu.addentry( static_cast<int>( calendar_ui::granularity::month ), true,
                        'o', "%s: %s", _( "month" ), to_string( static_cast<month>( month_index ) ) );
        smenu.addentry( static_cast<int>( calendar_ui::granularity::day ), true,
                        'd', "%s: %d", _( "day" ), day );
        smenu.addentry( static_cast<int>( calendar_ui::granularity::hour ), true,
                        'h', "%s: %d", _( "hour" ), hour_of_day<int>( return_value ) );
        smenu.addentry( static_cast<int>( calendar_ui::granularity::minute ), true,
                        'm', "%s: %d", _( "minute" ), minute_of_hour<int>( return_value ) );
        smenu.addentry( static_cast<int>( calendar_ui::granularity::turn ), true,
                        't', "%s: %d", _( "turn" ), to_turns<int>( return_value - calendar::turn_zero ) );

        for( uilist_entry &entry : smenu.entries ) {
            if( entry.retval > static_cast<int>( granularity_level ) ) {
                entry.enabled = false;
            }
        }
        smenu.selected = iSel;
        smenu.query();

        int auto_value = 0;
        switch( smenu.ret ) {
            case static_cast<int>( calendar_ui::granularity::year ):
                set_turn( years( return_value ) + 1, calendar::year_length(), _( "Set year to?" ) );
                break;
            case static_cast<int>( calendar_ui::granularity::month ):
                set_month( 0 );
                break;
            case static_cast<int>( calendar_ui::granularity::day ): {
                int selected = day;
                number_input_popup<int> query( 1, selected, _( "Set day of month to?" ) );
                selected = std::clamp( query.query(), 1,
                                       std::max( 1, month_start( month_index + 1 ) - month_start( month_index ) ) );
                if( selected != day ) {
                    set_turn( day, 1_days, "", selected - day );
                }
                break;
            }
            case static_cast<int>( calendar_ui::granularity::hour ):
                set_turn( hour_of_day<int>( return_value ), 1_hours, _( "Set hour to?" ) );
                break;
            case static_cast<int>( calendar_ui::granularity::minute ):
                set_turn( minute_of_hour<int>( return_value ), 1_minutes, _( "Set minute to?" ) );
                break;
            case static_cast<int>( calendar_ui::granularity::turn ):
                set_turn( to_turns<int>( return_value - calendar::turn_zero ), 1_turns,
                          string_format( _( "Set turn to?  (One day is %i turns)" ), to_turns<int>( 1_days ) ).c_str() );
                break;
            case UILIST_ADDITIONAL:
                if( smenu.ret_act == "LEFT" ) {
                    auto_value = -1;
                } else if( smenu.ret_act == "RIGHT" ) {
                    auto_value = 1;
                } else if( smenu.ret_act == "RESET" ) {
                    auto_value = 0;
                    return_value = initial_value;
                }
                if( auto_value != 0 ) {
                    switch( smenu.selected ) {
                        case static_cast<int>( calendar_ui::granularity::year ):
                            set_turn( years( return_value ) + 1, calendar::year_length(), "", auto_value );
                            break;
                        case static_cast<int>( calendar_ui::granularity::month ):
                            set_month( auto_value );
                            break;
                        case static_cast<int>( calendar_ui::granularity::day ):
                            set_turn( day, 1_days, "", auto_value );
                            break;
                        case static_cast<int>( calendar_ui::granularity::hour ):
                            set_turn( hour_of_day<int>( return_value ), 1_hours, "", auto_value );
                            break;
                        case static_cast<int>( calendar_ui::granularity::minute ):
                            set_turn( minute_of_hour<int>( return_value ), 1_minutes, "", auto_value );
                            break;
                        case static_cast<int>( calendar_ui::granularity::turn ):
                            set_turn( to_turns<int>( return_value - calendar::turn_zero ), 1_turns, "", auto_value );
                            break;
                        default:
                            break;
                    }
                }
                break;
            default:
                break;
        }
        iSel = smenu.selected;
    } while( smenu.ret != UILIST_CANCEL );
    return return_value;
}
