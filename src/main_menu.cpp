#include "main_menu.h"

#include <algorithm>
#include <array>
#include <chrono>
#include <cmath>
#include <cstdint>
#include <cstdlib>
#include <cstring>
#include <exception>
#include <functional>
#include <initializer_list>
#include <istream>
#include <locale>
#include <map>
#include <memory>
#include <optional>
#include <string>

#if defined(EMSCRIPTEN)
    #include <emscripten.h>
#endif

#define MP_ENABLED

#include "auto_pickup.h"
#include "avatar.h"
#include "cata_path.h"
#include "cata_scope_helpers.h"
#include "cata_utility.h"
#include "catacharset.h"
#include "character_id.h"
#include "clzones.h"
#include "color.h"
#include "debug.h"
#include "enums.h"
#include "filesystem.h"
#include "game.h"
#include "gamemode.h"
#include "get_version.h"
#include "help.h"
#include "imgui_demo.h"
#include "localized_comparator.h"
#include "mapbuffer.h"
#include "mapsharing.h"
#include "messages.h"
#ifdef MP_ENABLED
#include "mp_client_conn.h"
#include "mp_gamestate.h"
#endif
#include "music.h"
#include "options.h"
#include "output.h"
#include "overmapbuffer.h"
#include "path_info.h"
#include "popup.h"
#include "safemode_ui.h"
#include "save_snapshot.h"
#include "scenario.h"
#include "sdlsound.h"
#include "sounds.h"
#include "string_formatter.h"
#include "text_snippets.h"
#include "translation.h"
#include "translations.h"
#include "type_id.h"
#include "uilist.h"
#include "ui_manager.h"
#include "ui_style_picker.h"
#include "wcwidth.h"
#include "worldfactory.h"

static const mod_id MOD_INFORMATION_dda( "dda" );
static const mod_id MOD_INFORMATION_dda_tutorial( "dda_tutorial" );

namespace
{
enum class main_menu_opts : int {
    MOTD = 0,
    NEWCHAR,
    COOP,
    LOADCHAR,
    WORLD,
    TUTORIAL,
    SETTINGS,
    HELP,
    CREDITS,
    QUIT,
    NUM_MENU_OPTS,
};
} // namespace

std::string main_menu::queued_world_to_load;
std::string main_menu::queued_save_id_to_load;
std::string main_menu::clipboard_personal_zones;

static int getopt( main_menu_opts o )
{
    return static_cast<int>( o );
}

void main_menu::on_move() const
{
    sfx::play_variant_sound( "menu_move", "default", 100 );
}

void main_menu::on_error()
{
    sfx::play_variant_sound( "menu_error", "default", 100 );
}

//CJK characters have a width of 2, etc
static int utf8_width_notags( const char *s )
{
    int len = strlen( s );
    const char *ptr = s;
    int w = 0;
    bool inside_tag = false;
    while( len > 0 ) {
        uint32_t ch = UTF8_getch( &ptr, &len );
        if( ch == UNKNOWN_UNICODE ) {
            continue;
        }
        if( ch == '<' ) {
            inside_tag = true;
        } else if( ch == '>' ) {
            inside_tag = false;
            continue;
        }
        if( inside_tag ) {
            continue;
        }
        w += mk_wcwidth( ch );
    }
    return w;
}

std::vector<int> main_menu::print_menu_items( const catacurses::window &w_in,
        const std::vector<std::string> &vItems,
        size_t iSel, point offset, int spacing, bool main )
{
    const point win_offset( getbegx( w_in ), getbegy( w_in ) );
    std::vector<int> ret;
    std::string text;
    for( size_t i = 0; i < vItems.size(); ++i ) {
        if( i > 0 ) {
            text += std::string( spacing, ' ' );
        }
        ret.push_back( utf8_width_notags( text.c_str() ) );

        std::string temp = shortcut_text( iSel == i ? hilite( c_yellow ) : c_yellow, vItems[i] );
#ifdef MP_ENABLED
        const bool is_coop = main && i == static_cast<size_t>( getopt( main_menu_opts::COOP ) );
        const nc_color color = iSel == i ? hilite( c_white )
                               : ( is_coop ? c_light_green : c_white );
        text += string_format( "[%s]", colorize( temp, color ) );
#else
        text += string_format( "[%s]", colorize( temp, iSel == i ? hilite( c_white ) : c_white ) );
#endif
    }

    int text_width = utf8_width_notags( text.c_str() );
    if( text_width > getmaxx( w_in ) ) {
        offset.y -= std::ceil( text_width / getmaxx( w_in ) );
    }

    std::vector<std::string> menu_txt = foldstring( text, getmaxx( w_in ), ']' );

    int y_off = 0;
    int sel_opt = 0;
    for( const std::string &txt : menu_txt ) {
        trim_and_print( w_in, offset + point( 0, y_off ), getmaxx( w_in ), c_white, txt );
        if( !main ) {
            y_off++;
            continue;
        }
        std::vector<std::string> tmp_chars = utf8_display_split( remove_color_tags( txt ) );
        for( int x = 0; static_cast<size_t>( x ) < tmp_chars.size(); x++ ) {
            if( tmp_chars[x] == "[" ) {
                for( int x2 = x; static_cast<size_t>( x2 ) < tmp_chars.size(); x2++ ) {
                    if( tmp_chars[x2] == "]" ) {
                        inclusive_rectangle<point> rec( win_offset + offset + point( x, y_off ),
                                                        win_offset + offset + point( x2, y_off ) );
                        main_menu_button_map.emplace_back( rec, sel_opt++ );
                        break;
                    }
                }
            }
        }
        y_off++;
    }

    return ret;
}

void main_menu::display_sub_menu( int sel, const point &bottom_left, int sel_line )
{
    main_menu_sub_button_map.clear();
    std::vector<std::string> sub_opts;
    int xlen = 0;
    main_menu_opts sel_o = static_cast<main_menu_opts>( sel );
    switch( sel_o ) {
        case main_menu_opts::CREDITS:
            display_text( mmenu_credits, _( "Credits" ), sel_line );
            return;
        case main_menu_opts::MOTD:
            //~ Message Of The Day
            display_text( mmenu_motd, _( "MOTD" ), sel_line );
            return;
        case main_menu_opts::SETTINGS:
            for( int i = 0; static_cast<size_t>( i ) < vSettingsSubItems.size(); ++i ) {
                nc_color clr = i == sel2 ? hilite( c_yellow ) : c_yellow;
                sub_opts.push_back( shortcut_text( clr, vSettingsSubItems[i] ) );
                int len = utf8_width( shortcut_text( clr, vSettingsSubItems[i] ), true );
                if( len > xlen ) {
                    xlen = len;
                }
            }
            break;
        case main_menu_opts::NEWCHAR:
            for( int i = 0; static_cast<size_t>( i ) < vNewGameSubItems.size(); i++ ) {
                nc_color clr = i == sel2 ? hilite( c_yellow ) : c_yellow;
                sub_opts.push_back( shortcut_text( clr, vNewGameSubItems[i] ) );
                int len = utf8_width( shortcut_text( clr, vNewGameSubItems[i] ), true );
                if( len > xlen ) {
                    xlen = len;
                }
            }
            break;
#ifdef MP_ENABLED
        case main_menu_opts::COOP:
            for( int i = 0; static_cast<size_t>( i ) < vCoopSubItems.size(); i++ ) {
                nc_color clr = i == sel2 ? hilite( c_light_green ) : c_light_green;
                sub_opts.push_back( shortcut_text( clr, vCoopSubItems[i] ) );
                int len = utf8_width( shortcut_text( clr, vCoopSubItems[i] ), true );
                if( len > xlen ) {
                    xlen = len;
                }
            }
            break;
#endif
        case main_menu_opts::LOADCHAR:
        case main_menu_opts::WORLD: {
            const bool extra_opt = sel == getopt( main_menu_opts::WORLD );
            if( extra_opt ) {
                sub_opts.emplace_back( colorize( _( "Create World" ), sel2 == 0 ? hilite( c_yellow ) : c_yellow ) );
                xlen = utf8_width( sub_opts.back(), true );
            }
            int i = 0;
            for( const auto& [name, world] : world_generator->get_all_worlds() ) {
                int savegames_count = world->world_saves.size();
                nc_color clr = c_white;
                if( name == "TUTORIAL" || name == "DEFENSE" ) {
                    clr = c_light_cyan;
                }
                sub_opts.push_back( colorize( string_format( "%s (%d)", name, savegames_count ),
                                              ( sel2 == i + ( extra_opt ? 1 : 0 ) ) ? hilite( clr ) : clr )
#ifdef MP_ENABLED
                                    + colorize( cata_mp::mp_world_marker_badge( name ), c_light_green )
#endif
                                  );
                int len = utf8_width( sub_opts.back(), true );
                if( len > xlen ) {
                    xlen = len;
                }
                i++;
            }
        }
        break;
        case main_menu_opts::HELP:
        case main_menu_opts::QUIT:
        default:
            return;
    }

    if( sub_opts.empty() ) {
        return;
    }

    point top_left( bottom_left + point( 0, -( sub_opts.size() + 1 ) ) );

    // If sel2 somehow outgrew the options vector, clamp it back.
    sel2 = std::min<int>( sel2, sub_opts.size() );

    int height = sub_opts.size();
    if( top_left.y < 0 ) {
        // Options don't fit screen. Decrease height till they do.
        height += top_left.y;
        top_left.y = 0;

        // Calculate an offset from which to draw the options
        if( sel2 - 1 < sub_opt_off ) {
            // Trying to go below the showed options, decrease our offset
            sub_opt_off = sel2;
        } else if( sel2 + 1 > sub_opt_off + height ) {
            // We are going over the list the other way around - increase offset
            sub_opt_off = sel2 - height + 1;
        }
    } else {
        // Options fit the screen, no offset required.
        sub_opt_off = 0;
    }

    catacurses::window w_sub = catacurses::newwin( height + 2, xlen + 4, top_left );
    werase( w_sub );
    draw_border( w_sub, c_white );

    // Print as many options as decided previously, starting from the index sub_opt_offset
    for( int y = 0; y < height; y++ ) {
        int opt_index = sub_opt_off + y;
        bool is_selection = sel2 == opt_index;
        std::string opt = ( is_selection ? "» " : "  " ) + sub_opts[opt_index];
        int padding = ( xlen + 2 ) - utf8_width( opt, true );
        opt.append( padding, ' ' );
        nc_color clr = is_selection ? hilite( c_white ) : c_white;
        trim_and_print( w_sub, point( 1, y + 1 ), xlen + 2, clr, opt );
        inclusive_rectangle<point> rec( top_left + point( 1, y  + 1 ),
                                        top_left + point( xlen + 2, y + 1 ) );
        main_menu_sub_button_map.emplace_back( rec, std::pair<int, int> { sel, y } );
    }
    if( static_cast<size_t>( height ) != sub_opts.size() ) {
        draw_scrollbar( w_sub, sel2, height, sub_opts.size(), point::south, c_white,
                        false );
    }
    wnoutrefresh( w_sub );
}

void main_menu::print_menu( const catacurses::window &w_open, int iSel, const point &offset,
                            int sel_line )
{
    main_menu_button_map.clear();

    // Clear Lines
    werase( w_open );

    // Define window size
    int window_width = getmaxx( w_open );
    int window_height = getmaxy( w_open );

    // Draw horizontal line
    mvwhline( w_open, point( 1, window_height - 4 ), c_white, LINE_OXOX, window_width - 2 );

#ifdef MP_ENABLED
    const std::string mp_status = cata_mp::mp_menu_coop_status_text();
    if( !mp_status.empty() ) {
        center_print( w_open, window_height - 2, c_light_green, mp_status );
    } else if( iSel == getopt( main_menu_opts::NEWCHAR ) ) {
        center_print( w_open, window_height - 2, c_yellow, vNewGameHints[sel2] );
    } else {
        center_print( w_open, window_height - 2, c_red,
                      _( "Bugs?  Suggestions?  Use links in MOTD to report them." ) );
    }
#else
    if( iSel == getopt( main_menu_opts::NEWCHAR ) ) {
        center_print( w_open, window_height - 2, c_yellow, vNewGameHints[sel2] );
    } else {
        center_print( w_open, window_height - 2, c_red,
                      _( "Bugs?  Suggestions?  Use links in MOTD to report them." ) );
    }
#endif

    center_print( w_open, window_height - 1, c_light_cyan, string_format( _( "Tip of the day: %s" ),
                  vdaytip ) );

    int iLine = 0;
    const int iOffsetX = ( window_width - FULL_SCREEN_WIDTH ) / 2;

    if( get_option<bool>( "SEASONAL_TITLE" ) ) {
        switch( current_holiday ) {
            case holiday::new_year:
            case holiday::easter:
                break;
            case holiday::halloween:
                fold_and_print_from( w_open, point::zero, 30, 0, c_white, halloween_spider() );
                fold_and_print_from( w_open, point( getmaxx( w_open ) - 25, offset.y - 8 ),
                                     25, 0, c_white, halloween_graves() );
                break;
            case holiday::thanksgiving:
            case holiday::christmas:
            case holiday::none:
            case holiday::num_holiday:
            default:
                break;
        }
    }

    if( mmenu_title.size() > 1 ) {
        for( const std::string &i_title : mmenu_title ) {
            nc_color cur_color = c_white;
            nc_color base_color = c_white;
            print_colored_text( w_open, point( iOffsetX, iLine++ ), cur_color, base_color, i_title );
        }
    } else {
        center_print( w_open, iLine++, c_light_cyan, mmenu_title[0] );
    }

    iLine++;
    center_print( w_open, iLine, c_light_blue, string_format( _( "Version: %s" ),
                  getVersionString() ) );

    int menu_length = 0;
    for( size_t i = 0; i < vMenuItems.size(); ++i ) {
        menu_length += utf8_width_notags( vMenuItems[i].c_str() ) + 2;
        if( !vMenuHotkeys[i].empty() ) {
            menu_length += utf8_width( vMenuHotkeys[i][0] );
        }
    }
    const int free_space = std::max( 0, window_width - menu_length - offset.x );
    const int spacing = free_space / ( static_cast<int>( vMenuItems.size() ) + 1 );
    const int width_of_spacing = spacing * ( vMenuItems.size() + 1 );
    const int adj_offset = std::max( 0, ( free_space - width_of_spacing ) / 2 );
    const int final_offset = offset.x + adj_offset + spacing;

    std::vector<int> offsets =
        print_menu_items( w_open, vMenuItems, iSel, point( final_offset, offset.y ), spacing, true );

    wnoutrefresh( w_open );

    const point p_offset( catacurses::getbegx( w_open ), catacurses::getbegy( w_open ) );

    display_sub_menu( iSel, p_offset + point( offsets[iSel], offset.y - 2 ), sel_line );
}

std::vector<std::string> main_menu::load_file( const std::string &path,
        const std::string &alt_text ) const
{
    std::vector<std::string> result;
    read_from_file_optional( path, [&result]( std::istream & fin ) {
        std::string line;
        while( std::getline( fin, line ) ) {
            if( !line.empty() && line[0] == '#' ) {
                continue;
            }
            result.push_back( line );
        }
    } );
    if( result.empty() ) {
        result.push_back( alt_text );
    }
    return result;
}

holiday main_menu::get_holiday_from_time()
{
    return ::get_holiday_from_time( 0, true );
}

void main_menu::init_windows()
{
    if( LAST_TERM == point( TERMX, TERMY ) ) {
        return;
    }

    // main window should also expand to use available display space.
    // expanding to evenly use up half of extra space, for now.
    extra_w = ( ( TERMX - FULL_SCREEN_WIDTH ) / 2 ) - 1;
    int extra_h = ( ( TERMY - FULL_SCREEN_HEIGHT ) / 2 ) - 1;
    extra_w = ( extra_w > 0 ? extra_w : 0 );
    extra_h = ( extra_h > 0 ? extra_h : 0 );
    const int total_w = FULL_SCREEN_WIDTH + extra_w;
    const int total_h = FULL_SCREEN_HEIGHT + extra_h;

    // position of window within main display
    const point p0( ( TERMX - total_w ) / 2, ( TERMY - total_h ) / 2 );

    w_open = catacurses::newwin( total_h, total_w, p0 );

    menu_offset.y = total_h - 3;
    // note: if iMenuOffset is changed,
    // please update MOTD and credits to indicate how long they can be.

    LAST_TERM = point( TERMX, TERMY );
}

void main_menu::init_strings()
{
    // ASCII Art
    mmenu_title = load_file( PATH_INFO::title( current_holiday ), _( "Cataclysm: Cleanwater Bomb" ) );
    // MOTD
    auto motd = load_file( PATH_INFO::motd(), _( "No message today." ) );

    mmenu_motd.clear();
    for( const std::string &line : motd ) {
        mmenu_motd += ( line.empty() ? " " : line ) + "\n";
    }
    mmenu_motd = colorize( mmenu_motd, c_light_red );
    mmenu_motd_len = foldstring( mmenu_motd, FULL_SCREEN_WIDTH - 2 ).size();

    // Credits
    mmenu_credits.clear();
    read_from_file_optional( PATH_INFO::credits(), [&]( std::istream & stream ) {
        std::string line;
        while( std::getline( stream, line ) ) {
            if( line[0] != '#' ) {
                mmenu_credits += ( line.empty() ? " " : line ) + "\n";
            }
        }
    } );

    if( mmenu_credits.empty() ) {
        mmenu_credits = _( "No credits information found." );
    }
    mmenu_credits_len = foldstring( mmenu_credits, FULL_SCREEN_WIDTH - 2 ).size();

    // fill menu with translated menu items
    vMenuItems.clear();
    vMenuItems.emplace_back( pgettext( "Main Menu", "<M|m>OTD" ) );
    vMenuItems.emplace_back( pgettext( "Main Menu", "<N|n>ew Game" ) );
#ifdef MP_ENABLED
    vMenuItems.emplace_back( pgettext( "Main Menu", "Co-<O|o>p" ) );
#endif
    vMenuItems.emplace_back( pgettext( "Main Menu", "Lo<a|A>d" ) );
    vMenuItems.emplace_back( pgettext( "Main Menu", "<W|w>orld" ) );
    vMenuItems.emplace_back( pgettext( "Main Menu", "T<u|U>torial" ) );
    vMenuItems.emplace_back( pgettext( "Main Menu", "Se<t|T>tings" ) );
    vMenuItems.emplace_back( pgettext( "Main Menu", "H<e|E|?>lp" ) );
    vMenuItems.emplace_back( pgettext( "Main Menu", "<C|c>redits" ) );
#ifdef MP_ENABLED
#endif
#if !defined(EMSCRIPTEN)
    vMenuItems.emplace_back( pgettext( "Main Menu", "<Q|q>uit" ) );
#endif

    // new game menu items
    vNewGameSubItems.clear();
    vNewGameSubItems.emplace_back( pgettext( "Main Menu|New Game", "C<u|U>stom Character" ) );
    vNewGameSubItems.emplace_back( pgettext( "Main Menu|New Game", "<P|p>reset Character" ) );
    vNewGameSubItems.emplace_back( pgettext( "Main Menu|New Game", "<R|r>andom Character" ) );
    if( !MAP_SHARING::isSharing() ) { // "Play Now" function doesn't play well together with shared maps
        vNewGameSubItems.emplace_back( pgettext( "Main Menu|New Game",
                                       "Play Now!  (<D|d>efault Scenario)" ) );
        vNewGameSubItems.emplace_back( pgettext( "Main Menu|New Game", "Play N<o|O>w!" ) );
    }
    vNewGameHints.clear();
    vNewGameHints.emplace_back(
        _( "Allows you to fully customize scenario, character's profession, stats, traits, skills and other parameters." ) );
    vNewGameHints.emplace_back( _( "Select from one of previously created character templates." ) );
    vNewGameHints.emplace_back(
        _( "Creates random character, but lets you preview the generated character and the scenario and change character and/or scenario if needed." ) );
    vNewGameHints.emplace_back(
        _( "Puts you right in the game, randomly choosing character's traits, profession, skills and other parameters.  Scenario is fixed to Evacuee." ) );
    vNewGameHints.emplace_back(
        _( "Puts you right in the game, randomly choosing scenario and character's traits, profession, skills and other parameters." ) );
    vNewGameHotkeys.clear();
    vNewGameHotkeys.reserve( vNewGameSubItems.size() );
    for( const std::string &item : vNewGameSubItems ) {
        vNewGameHotkeys.push_back( get_hotkeys( item ) );
    }

#ifdef MP_ENABLED
    vCoopSubItems.clear();
    vCoopSubItems.emplace_back( pgettext( "Main Menu|Co-op", "<H|h>ost a session" ) );
    vCoopSubItems.emplace_back( pgettext( "Main Menu|Co-op", "<J|j>oin a session" ) );
    vCoopHotkeys.clear();
    vCoopHotkeys.reserve( vCoopSubItems.size() );
    for( const std::string &item : vCoopSubItems ) {
        vCoopHotkeys.push_back( get_hotkeys( item ) );
    }
#endif

    // determine hotkeys from translated menu item text
    vMenuHotkeys.clear();
    for( const std::string &item : vMenuItems ) {
        vMenuHotkeys.push_back( get_hotkeys( item ) );
    }

    vWorldSubItems.clear();
    vWorldSubItems.emplace_back( pgettext( "Main Menu|World", "Sh<o|O>w World Mods" ) );
    vWorldSubItems.emplace_back( pgettext( "Main Menu|World", "Copy World Sett<i|I>ngs" ) );
    vWorldSubItems.emplace_back( pgettext( "Main Menu|World", "Character to Tem<p|P>late" ) );
    vWorldSubItems.emplace_back( pgettext( "Main Menu|World", "Toggle World <C|c>ompression" ) );
    vWorldSubItems.emplace_back( pgettext( "Main Menu|World", "S<n|N>apshots" ) );
    vWorldSubItems.emplace_back( pgettext( "Main Menu|World", "<D|d>elete World" ) );
    vWorldSubItems.emplace_back( pgettext( "Main Menu|World", "<R|r>eset World" ) );
    vWorldSubItems.emplace_back( pgettext( "Main Menu|World", "Cop<y|Y> Personal Zones" ) );
    vWorldSubItems.emplace_back( pgettext( "Main Menu|World", "Past<e|E> Personal Zones" ) );

    vWorldHotkeys.clear();
    for( const std::string &item : vWorldSubItems ) {
        vWorldHotkeys.push_back( get_hotkeys( item ) );
    }

    vSettingsSubItems.clear();
    vSettingsSubItems.emplace_back( pgettext( "Main Menu|Settings", "<O|o>ptions" ) );
    vSettingsSubItems.emplace_back( pgettext( "Main Menu|Settings", "Ke<y|Y>bindings" ) );
    vSettingsSubItems.emplace_back( pgettext( "Main Menu|Settings", "A<u|U>topickup" ) );
    vSettingsSubItems.emplace_back( pgettext( "Main Menu|Settings", "Sa<f|F>emode" ) );
    vSettingsSubItems.emplace_back( pgettext( "Main Menu|Settings", "Colo<r|R>s" ) );
    vSettingsSubItems.emplace_back( pgettext( "Main Menu|Settings", "ImGui <S|s>tyles" ) );
    vSettingsSubItems.emplace_back( pgettext( "Main Menu|Settings", "<I|i>mGui Demo Screen" ) );

    vSettingsHotkeys.clear();
    for( const std::string &item : vSettingsSubItems ) {
        vSettingsHotkeys.push_back( get_hotkeys( item ) );
    }

    try {
        g->load_core_data();
    } catch( const std::exception &err ) {
        debugmsg( err.what() );
        std::exit( 1 );
    }
    vdaytip = SNIPPET.random_from_category( "tip" ).value_or( translation() ).translated();
}

void main_menu::display_text( const std::string &text, const std::string &title, int &selected )
{
    const int w_open_height = getmaxy( w_open );
    const int b_height = FULL_SCREEN_HEIGHT - clamp( ( FULL_SCREEN_HEIGHT - w_open_height ) + 4, 0, 4 );
    const int vert_off = clamp( ( w_open_height - FULL_SCREEN_HEIGHT ) / 2, getbegy( w_open ), TERMY );

    catacurses::window w_border = catacurses::newwin( b_height, FULL_SCREEN_WIDTH,
                                  point( clamp( ( TERMX - FULL_SCREEN_WIDTH ) / 2, 0, TERMX ), vert_off ) );

    catacurses::window w_text = catacurses::newwin( b_height - 2, FULL_SCREEN_WIDTH - 2,
                                point( 1 + clamp( ( TERMX - FULL_SCREEN_WIDTH ) / 2, 0, TERMX ), 1 + vert_off ) );

    draw_border( w_border, BORDER_COLOR, title );

    int width = FULL_SCREEN_WIDTH - 2;
    int height = b_height - 2;
    const auto vFolded = foldstring( text, width );
    int iLines = vFolded.size();

    fold_and_print_from( w_text, point::zero, width, selected, c_light_gray, text );

    draw_scrollbar( w_border, selected, height, iLines, point::south, BORDER_COLOR, true );
    wnoutrefresh( w_border );
    wnoutrefresh( w_text );
}

void main_menu::load_char_templates()
{
    templates.clear();

    for( std::string path : get_files_from_path( ".template", PATH_INFO::templatedir(), false,
            true ) ) {
        path.erase( path.find( ".template" ), std::string::npos );
        path.erase( 0, path.find_last_of( "\\/" ) + 1 );
        templates.push_back( path );
    }
    std::sort( templates.begin(), templates.end(), localized_compare );
}

bool main_menu::opening_screen()
{
    // set holiday based on local system time
    current_holiday = get_holiday_from_time();

    if( music::get_music_id() != music::music_id::title ) {
        music::deactivate_music_id_all();
    } else {
        play_music( music::get_music_id_string() );
    }

    world_generator->set_active_world( nullptr );
    world_generator->init();

    init_strings();

    load_char_templates();

    ctxt.register_cardinal();
    ctxt.register_action( "NEXT_TAB" );
    ctxt.register_action( "PREV_TAB" );
    ctxt.register_action( "PAGE_UP" );
    ctxt.register_action( "PAGE_DOWN" );
    ctxt.register_action( "CONFIRM" );
    ctxt.register_action( "QUIT" );

    // for mouse selection
    ctxt.register_action( "SELECT" );
    ctxt.register_action( "MOUSE_MOVE" );
    ctxt.register_action( "SCROLL_UP" );
    ctxt.register_action( "SCROLL_DOWN" );

    // for the menu shortcuts
    ctxt.register_action( "ANY_INPUT" );
    bool start = false;
    bool load_game = false;

    avatar &player_character = get_avatar();
    player_character = avatar();

    int sel_line = 0;

    // Make [Load Game] the default cursor position if there's game save available
    if( !world_generator->get_all_worlds().empty() ) {
        std::vector<std::string> worlds = world_generator->all_worldnames();
        last_world_pos = world_generator->get_world_index( world_generator->last_world_name );
        if( last_world_pos >= worlds.size() ) {
            last_world_pos = 0;
        }
        sel1 = getopt( main_menu_opts::LOADCHAR );
        sel2 = last_world_pos;
    }

    background_pane background;

    ui_adaptor ui;
    ui.on_redraw( [&]( const ui_adaptor & ) {
        print_menu( w_open, sel1, menu_offset, sel_line );
    } );
    ui.on_screen_resize( [this]( ui_adaptor & ui ) {
        init_windows();
        ui.position_from_window( w_open );
    } );
    ui.mark_resize();

    if( !queued_world_to_load.empty() ) {
        WORLD *world_to_load{};
        try {
            save_t const &save_to_load = [&]() {
                if( queued_save_id_to_load.empty() ) {
                    world_to_load = world_generator->get_world( queued_world_to_load );
                    const std::vector<save_t> &world_saves = world_to_load->world_saves;
                    if( world_saves.empty() ) {
                        throw false;
                    }
                    return world_saves.front();
                }
                return save_t::from_save_id( queued_save_id_to_load );
            }
            ();
            start = main_menu::load_game( queued_world_to_load, save_to_load );
            queued_world_to_load.clear();
            queued_save_id_to_load.clear();
            if( start ) {
                load_game = true;
            }
        } catch( bool has_save ) {
            load_game = has_save;
            if( world_to_load ) {
                popup( _( "%s has no characters to load!" ), world_to_load->world_name );
            }
        }
    }

#if defined(EMSCRIPTEN)
    EM_ASM( window.dispatchEvent( new Event( 'menuready' ) ); );
#endif

    while( !start ) {
        ui_manager::redraw();
        std::string action = ctxt.handle_input();
        input_event sInput = ctxt.get_raw_input();

        // check automatic menu shortcuts
        bool match = false;
        for( int i = 0; static_cast<size_t>( i ) < vMenuHotkeys.size() && !match; ++i ) {
            for( const std::string &hotkey : vMenuHotkeys[i] ) {
                if( sInput.text == hotkey && sel1 != i ) {
                    sel1 = i;
                    sel2 = i == getopt( main_menu_opts::LOADCHAR ) ? last_world_pos : 0;
                    sel_line = 0;
                    if( i == getopt( main_menu_opts::HELP ) ) {
                        action = "CONFIRM";
                    } else if( i == getopt( main_menu_opts::QUIT ) ) {
                        action = "QUIT";
                    }
                    match = true;
                    break;
                }
            }
        }
        if( sel1 == getopt( main_menu_opts::SETTINGS ) ) {
            for( int i = 0; !match && static_cast<size_t>( i ) < vSettingsSubItems.size(); ++i ) {
                for( const std::string &hotkey : vSettingsHotkeys[i] ) {
                    if( sInput.text == hotkey ) {
                        sel2 = i;
                        action = "CONFIRM";
                        match = true;
                        break;
                    }
                }
            }
        }
        if( sel1 == getopt( main_menu_opts::NEWCHAR ) ) {
            for( int i = 0; !match && static_cast<size_t>( i ) < vNewGameSubItems.size(); ++i ) {
                for( const std::string &hotkey : vNewGameHotkeys[i] ) {
                    if( sInput.text == hotkey ) {
                        sel2 = i;
                        action = "CONFIRM";
                        match = true;
                        break;
                    }
                }
            }
        }
#ifdef MP_ENABLED
        if( sel1 == getopt( main_menu_opts::COOP ) ) {
            for( int i = 0; !match && static_cast<size_t>( i ) < vCoopSubItems.size(); ++i ) {
                for( const std::string &hotkey : vCoopHotkeys[i] ) {
                    if( sInput.text == hotkey ) {
                        sel2 = i;
                        action = "CONFIRM";
                        match = true;
                        break;
                    }
                }
            }
        }
#endif

        // handle mouse click
        if( action == "SELECT" || action == "MOUSE_MOVE" ) {
            std::optional<point> coord = ctxt.get_coordinates_text( catacurses::stdscr );
            for( const auto &it : main_menu_button_map ) {
                if( coord.has_value() && it.first.contains( coord.value() ) ) {
                    if( sel1 != it.second ) {
                        sel1 = it.second;
                        sel2 = sel1 == getopt( main_menu_opts::LOADCHAR ) ? last_world_pos : 0;
                        sel_line = 0;
                        on_move();
                    }
                    if( action == "SELECT" &&
                        ( sel1 == getopt( main_menu_opts::HELP )
                          || sel1 == getopt( main_menu_opts::QUIT ) ) ) {
                        action = "CONFIRM";
                    }
                    ui_manager::redraw();
                    match = true;
                    break;
                }
            }
            if( !match ) {
                for( const auto &it : main_menu_sub_button_map ) {
                    if( coord.has_value() && it.first.contains( coord.value() ) ) {
                        if( sel1 != it.second.first || sel2 != it.second.second ) {
                            on_move();
                        }
                        sel1 = it.second.first;
                        sel2 = it.second.second;
                        sel_line = 0;
                        if( action == "SELECT" ) {
                            action = "CONFIRM";
                        }
                        ui_manager::redraw();
                        break;
                    }
                }
            }
        }

        // also check special keys
        if( action == "QUIT" ) {
#if !defined(EMSCRIPTEN)
            if( query_yn( _( "Really quit?" ) ) ) {
                return false;
            }
#endif
        } else if( action == "LEFT" || action == "PREV_TAB" || action == "RIGHT" || action == "NEXT_TAB" ) {
            sel_line = 0;
            sel1 = inc_clamp_wrap( sel1, action == "RIGHT" || action == "NEXT_TAB",
                                   static_cast<int>( main_menu_opts::NUM_MENU_OPTS ) );
            sel2 = sel1 == getopt( main_menu_opts::LOADCHAR ) ? last_world_pos : 0;
            on_move();
        } else if( action == "UP" || action == "DOWN" ||
                   action == "PAGE_UP" || action == "PAGE_DOWN" ||
                   action == "SCROLL_UP" || action == "SCROLL_DOWN" ) {
            int max_item_count = 0;
            int min_item_val = 0;
            main_menu_opts opt = static_cast<main_menu_opts>( sel1 );
            switch( opt ) {
                case main_menu_opts::MOTD:
                case main_menu_opts::CREDITS:
                    if( action == "UP" || action == "PAGE_UP" || action == "SCROLL_UP" ) {
                        if( sel_line > 0 ) {
                            sel_line--;
                        }
                    } else if( action == "DOWN" || action == "PAGE_DOWN" || action == "SCROLL_DOWN" ) {
                        int effective_height = sel_line + FULL_SCREEN_HEIGHT - 2;
                        if( ( opt == main_menu_opts::CREDITS && effective_height < mmenu_credits_len ) ||
                            ( opt == main_menu_opts::MOTD && effective_height < mmenu_motd_len ) ) {
                            sel_line++;
                        }
                    }
                    break;
                case main_menu_opts::LOADCHAR:
                    max_item_count = world_generator->get_all_worlds().size();
                    break;
                case main_menu_opts::WORLD:
                    // extra 1 = "Create New World"
                    max_item_count = world_generator->get_all_worlds().size() + 1;
                    break;
                case main_menu_opts::NEWCHAR:
                    max_item_count = vNewGameSubItems.size();
                    break;
#ifdef MP_ENABLED
                case main_menu_opts::COOP:
                    max_item_count = vCoopSubItems.size();
                    break;
#endif
                case main_menu_opts::SETTINGS:
                    max_item_count = vSettingsSubItems.size();
                    break;
                case main_menu_opts::TUTORIAL:
                case main_menu_opts::HELP:
                case main_menu_opts::QUIT:
                default:
                    break;
            }
            if( max_item_count > 0 ) {
                if( action == "UP" || action == "PAGE_UP" || action == "SCROLL_UP" ) {
                    sel2--;
                    if( sel2 < min_item_val ) {
                        sel2 = max_item_count - 1;
                    }
                } else if( action == "DOWN" || action == "PAGE_DOWN" || action == "SCROLL_DOWN" ) {
                    sel2++;
                    if( sel2 >= max_item_count ) {
                        sel2 = min_item_val;
                    }
                }
                on_move();
            }
        } else if( action == "CONFIRM" ) {
            switch( static_cast<main_menu_opts>( sel1 ) ) {
                case main_menu_opts::HELP:
                    get_help().display_help();
                    break;
                case main_menu_opts::QUIT:
                    return false;
                case main_menu_opts::TUTORIAL:
                    if( MAP_SHARING::isSharing() ) {
                        on_error();
                        popup( _( "Tutorial doesn't work with shared maps." ) );
                    } else {
                        on_out_of_scope cleanup( [&player_character]() {
                            g->gamemode.reset();
                            player_character = avatar();
                            world_generator->set_active_world( nullptr );
                        } );
                        g->gamemode = get_special_game( special_game_type::TUTORIAL );
                        // check world
                        WORLD *world = world_generator->make_new_world( special_game_type::TUTORIAL );
                        if( world == nullptr ) {
                            break;
                        }
                        world->active_mod_order.clear();
                        world->active_mod_order.emplace_back( MOD_INFORMATION_dda );
                        world->active_mod_order.emplace_back( MOD_INFORMATION_dda_tutorial );
                        world_generator->set_active_world( world );
                        try {
                            g->setup();
                        } catch( const std::exception &err ) {
                            debugmsg( "Error: %s", err.what() );
                            break;
                        }
                        if( !g->gamemode->init() ) {
                            break;
                        }
                        cleanup.cancel();
                        start = true;
                        if( g->gametype() == special_game_type::TUTORIAL ) {
                            load_game = true;
                        }
                    }
                    break;
                case main_menu_opts::SETTINGS:
                    if( sel2 == 0 ) {        /// Options
                        get_options().show( false );
                        // The language may have changed- gracefully handle this.
                        init_strings();
                    } else if( sel2 == 1 ) { /// Keybindings
                        input_context ctxt_default = get_default_mode_input_context();
                        ctxt_default.display_menu();
                    } else if( sel2 == 2 ) { /// Autopickup
                        get_auto_pickup().show();
                    } else if( sel2 == 3 ) { /// Safemode
                        get_safemode().show();
                    } else if( sel2 == 4 ) { /// Colors
                        all_colors.show_gui();
                    } else if( sel2 == 5 ) {
                        style_picker picker;
                        picker.show();
                    } else if( sel2 == 6 ) { /// ImGui demo
                        imgui_demo_ui demo;
                        demo.run();
                    }
                    break;
                case main_menu_opts::WORLD:
                    sel2 = std::min<int>( sel2, world_generator->get_all_worlds().size() );
                    world_tab( sel2 > 0 ? world_generator->get_world_name( sel2 - 1 ) : "" );
                    break;
                case main_menu_opts::LOADCHAR:
                    if( static_cast<std::size_t>( sel2 ) < world_generator->get_all_worlds().size() ) {
                        const std::string wn = world_generator->get_world_name( sel2 );
#ifdef MP_ENABLED
                        if( !cata_mp::mp_load_promote_prompt( wn ) ) {
                            break;
                        }
#endif
                        start = load_character_tab( wn );
                        if( start ) {
                            load_game = true;
                        }
                    } else {
                        popup( _( "No world to load." ) );
                    }
                    break;
                case main_menu_opts::NEWCHAR:
                    start = new_character_tab();
                    break;
#ifdef MP_ENABLED
                case main_menu_opts::COOP: {
                    auto pick_char_type = []() -> int {
                        constexpr int RET_CUSTOM = 10;
                        constexpr int RET_PRESET = 11;
                        constexpr int RET_RANDOM = 12;
                        constexpr int RET_CANCEL = 19;
                        uilist cpick;
                        cpick.title = _( "Co-op: choose character" );
                        cpick.entries.emplace_back( RET_CUSTOM, true, 'c', _( "Custom Character" ) );
                        cpick.entries.emplace_back( RET_PRESET, true, 'p', _( "Preset Character" ) );
                        cpick.entries.emplace_back( RET_RANDOM, true, 'r', _( "Random Character" ) );
                        cpick.entries.emplace_back( RET_CANCEL, true, 'q', _( "Cancel" ) );
                        cpick.query();
                        switch( cpick.ret ) {
                            case RET_CUSTOM:
                                return 0;
                            case RET_PRESET:
                                return 1;
                            case RET_RANDOM:
                                return 2;
                            default:
                                return -1;
                        }
                    };
                    if( sel2 == 0 ) {
                        if( !cata_mp::mp_menu_start_host_session() ) {
                            break;
                        }
                        const bool any_worlds = !world_generator->get_all_worlds().empty();
                        uilist hflow;
                        hflow.title = _( "Co-op: host a session" );
                        hflow.entries.emplace_back( 0, true, 'n', _( "New character" ) );
                        hflow.entries.emplace_back( 1, any_worlds, 'l', _( "Load saved world" ) );
                        hflow.entries.emplace_back( -1, true, 'q', _( "Cancel co-op" ) );
                        hflow.query();
                        if( hflow.ret == 0 ) {
                            uilist wflow;
                            wflow.title = _( "Co-op: world for new character" );
                            if( !any_worlds ) {
                                wflow.text = _( "No existing worlds yet — create a new one." );
                            }
                            wflow.entries.emplace_back( 0, any_worlds, 'e', _( "Use existing world" ) );
                            wflow.entries.emplace_back( 1, true, 'n', _( "Create new world" ) );
                            wflow.entries.emplace_back( -1, true, 'q', _( "Cancel" ) );
                            wflow.query();
                            if( wflow.ret < 0 ) {
                                cata_mp::mp_menu_cancel_host();
                                break;
                            }
                            if( wflow.ret == 1 ) {
                                WORLD *neww = world_generator->make_new_world();
                                if( neww == nullptr ) {
                                    cata_mp::mp_menu_cancel_host();
                                    break;
                                }
                                if( !query_yn(
                                        _( "World '%s' created.\n\nContinue to character creation?" ),
                                        neww->world_name.c_str() ) ) {
                                    cata_mp::mp_menu_cancel_host();
                                    break;
                                }
                            }
                            const int ct = pick_char_type();
                            if( ct < 0 ) {
                                cata_mp::mp_menu_cancel_host();
                                break;
                            }
                            sel2 = ct;
                            start = new_character_tab();
                            if( !start ) {
                                cata_mp::mp_menu_cancel_host();
                                sel2 = 0;
                            }
                        } else if( hflow.ret == 1 ) {
                            std::vector<std::string> coop_w;
                            std::vector<std::string> solo_w;
                            for( const auto &kv : world_generator->get_all_worlds() ) {
                                ( cata_mp::mp_world_has_history( kv.first ) ? coop_w : solo_w )
                                .push_back( kv.first );
                            }
                            if( coop_w.empty() && solo_w.empty() ) {
                                popup( _( "No worlds to load.\n\nCreate one from Host > New character, or from the main menu under World." ) );
                                break;
                            }
                            std::vector<std::string> wnames;
                            wnames.reserve( coop_w.size() + solo_w.size() );
                            wnames.insert( wnames.end(), coop_w.begin(), coop_w.end() );
                            wnames.insert( wnames.end(), solo_w.begin(), solo_w.end() );

                            uilist wpick;
                            wpick.title = _( "Co-op: load saved world" );
                            int idx = 0;
                            for( const std::string &name : wnames ) {
                                const bool has_coop = cata_mp::mp_world_has_history( name );
                                const std::string display = name +
                                                            ( has_coop ? colorize( cata_mp::mp_world_marker_badge( name ), c_light_green )
                                                              : "  " + colorize( "(solo)", c_dark_gray ) );
                                wpick.entries.emplace_back( idx++, true, MENU_AUTOASSIGN, display );
                            }
                            wpick.entries.emplace_back( -1, true, 'q', _( "Cancel" ) );
                            wpick.query();
                            if( wpick.ret < 0 || static_cast<size_t>( wpick.ret ) >= wnames.size() ) {
                                break;
                            }
                            const std::string chosen_w = wnames[wpick.ret];
                            {
                                std::vector<std::string> block_reasons;
                                std::vector<std::string> warn_reasons;
                                if( cata_mp::mp_world_coop_block( chosen_w, block_reasons,
                                                                  warn_reasons ) ) {
                                    std::string msg = _( "This world can't be hosted in co-op:" );
                                    for( const std::string &r : block_reasons ) {
                                        msg += "\n  - " + r;
                                    }
                                    msg += _( "\n\nPick a different world or create a new one." );
                                    popup( "%s", msg );
                                    break;
                                }
                                if( !warn_reasons.empty() ) {
                                    std::string msg = _( "This world may not work fully in co-op:" );
                                    for( const std::string &r : warn_reasons ) {
                                        msg += "\n  - " + r;
                                    }
                                    msg += _( "\n\nHost it anyway?" );
                                    if( !query_yn( "%s", msg ) ) {
                                        break;
                                    }
                                }
                            }
                            start = load_character_tab( chosen_w );
                            if( start ) {
                                load_game = true;
                            }
                        } else {
                            cata_mp::mp_menu_cancel_host();
                        }
                    } else if( sel2 == 1 ) {
                        if( !cata_mp::mp_menu_join_session() ) {
                            break;
                        }
                        const bool any_worlds_with_saves = [] {
                            for( const auto &kv : world_generator->get_all_worlds() ) {
                                if( !kv.second->world_saves.empty() ) {
                                    return true;
                                }
                            }
                            return false;
                        }();
                        const std::string host_world = cata_mp::mp_client_host_world_name();
                        const std::string host_player = cata_mp::mp_client_host_player_name();
                        if( !host_world.empty() ) {
                            static std::string s_announced_host;
                            const std::string host_key = host_player + "@" + host_world;
                            if( host_key != s_announced_host ) {
                                s_announced_host = host_key;
                                if( host_player.empty() ) {
                                    popup( _( "Joining world \"%s\"." ), host_world );
                                } else {
                                    popup( _( "Joining %s's game.\nWorld: \"%s\"" ),
                                           host_player, host_world );
                                }
                            }
                        }
                        std::string join_title;
                        if( host_world.empty() ) {
                            join_title = _( "Co-op: join a session" );
                        } else if( host_player.empty() ) {
                            join_title = string_format( _( "Joining \"%s\"" ), host_world );
                        } else {
                            join_title = string_format( _( "Joining \"%s\" — %s's game" ),
                                                        host_world, host_player );
                        }
                        uilist jflow;
                        jflow.title = join_title;
                        jflow.entries.emplace_back( 0, true, 'n', _( "New character" ) );
                        jflow.entries.emplace_back( 1, any_worlds_with_saves, 'l',
                                                    _( "Load existing character" ) );
                        jflow.entries.emplace_back( -1, true, 'q', _( "Cancel" ) );
                        jflow.query();
                        if( jflow.ret < 0 ) {
                            break;
                        }
                        if( jflow.ret == 1 ) {
                            std::vector<std::string> wnames;
                            for( const auto &kv : world_generator->get_all_worlds() ) {
                                if( !kv.second->world_saves.empty() ) {
                                    wnames.push_back( kv.first );
                                }
                            }
                            std::string chosen_world;
                            if( wnames.size() == 1 ) {
                                chosen_world = wnames[0];
                            } else {
                                uilist wpick;
                                wpick.title = join_title;
                                int idx = 0;
                                for( const std::string &name : wnames ) {
                                    const bool has_coop = cata_mp::mp_world_has_history( name );
                                    const std::string display = name +
                                                                ( has_coop ? colorize( cata_mp::mp_world_marker_badge( name ),
                                                                        c_light_green )
                                                                  : "  " + colorize( "(solo)", c_dark_gray ) );
                                    wpick.entries.emplace_back( idx++, true, MENU_AUTOASSIGN, display );
                                }
                                wpick.entries.emplace_back( -1, true, 'q', _( "Cancel" ) );
                                wpick.query();
                                if( wpick.ret < 0 || static_cast<size_t>( wpick.ret ) >= wnames.size() ) {
                                    break;
                                }
                                chosen_world = wnames[wpick.ret];
                            }
                            start = load_character_tab( chosen_world );
                            if( start ) {
                                load_game = true;
                            }
                        } else {
                            const int ct = pick_char_type();
                            if( ct < 0 ) {
                                break;
                            }
                            if( !cata_mp::mp_ensure_client_scratch_world() ) {
                                popup( _( "Couldn't prepare a client scratch world." ) );
                                break;
                            }
                            sel2 = ct;
                            start = new_character_tab();
                        }
                    }
                    break;
                }
#endif
                case main_menu_opts::MOTD:
                case main_menu_opts::CREDITS:
                default:
                    break;
            }
        }
    }
    if( start && !load_game && get_scenario() ) {
        add_msg( get_scenario()->description( player_character.male ) );

        if( get_option<std::string>( "ETERNAL_WEATHER" ) != "normal" ) {
            if( player_character.posz() >= 0 ) {
                add_msg( _( "You feel as if this %1$s will last forever…" ),
                         get_options().get_option( "ETERNAL_WEATHER" ).getValueName() );
            }
        }
    }
    return true;
}

bool main_menu::new_character_tab()
{
    avatar &pc = get_avatar();
    // Preset character templates
    if( sel2 == 1 ) {
        if( templates.empty() ) {
            on_error();
            popup( _( "No templates found!" ) );
            return false;
        }
        while( true ) {
            uilist mmenu( _( "Choose a preset character template" ), {} );
            mmenu.border_color = c_white;
            int opt_val = 0;
            for( const std::string &tmpl : templates ) {
                mmenu.entries.emplace_back( opt_val++, true, MENU_AUTOASSIGN, tmpl );
            }
            mmenu.entries.emplace_back( opt_val, true, 'q', _( "<- Back to Main Menu" ), c_yellow, c_yellow );
            mmenu.query();
            opt_val = mmenu.ret;
            if( opt_val < 0 || static_cast<size_t>( opt_val ) >= templates.size() ) {
                return false;
            }

            std::string res = query_popup()
                              .context( "LOAD_DELETE_CANCEL" ).default_color( c_white )
                              .message( _( "What to do with template \"%s\"?" ), templates[opt_val] )
                              .option( "LOAD" ).option( "DELETE" ).option( "CANCEL" ).cursor( 0 )
                              .query().action;
            if( res == "DELETE" &&
                query_yn( _( "Are you sure you want to delete %s?" ), templates[opt_val] ) ) {
                const auto path = PATH_INFO::templatedir() + templates[opt_val] + ".template";
                if( !remove_file( path ) ) {
                    popup( _( "Sorry, something went wrong." ) );
                } else {
                    templates.erase( templates.begin() + opt_val );
                }
            } else if( res == "LOAD" ) {
                on_out_of_scope cleanup( [&pc]() {
                    pc = avatar();
                    world_generator->set_active_world( nullptr );
                } );
                g->gamemode = nullptr;
                WORLD *world = world_generator->pick_world();
                if( world == nullptr ) {
                    continue;
                }
                if( !world->world_saves.empty() ) {
                    // One character per world is enforced (snapshot save system +
                    // avoiding shared-world-state contamination). Block instead of
                    // warning-and-allowing.
                    popup( _( "This world already has a character.  Create a new world "
                              "for a new character." ) );
                    return false;
                }

                world_generator->set_active_world( world );
                try {
                    g->setup();
                } catch( const std::exception &err ) {
                    debugmsg( "Error: %s", err.what() );
                    continue;
                }
                if( !pc.create( character_type::TEMPLATE, templates[opt_val] ) ) {
                    load_char_templates();
                    MAPBUFFER.clear();
                    overmap_buffer.clear();
                    return false;
                }
                if( !g->start_game() ) {
                    return false;
                }
                cleanup.cancel();
                return true;
            }

            if( templates.empty() ) {
                return false;
            }
        }
    } else { ///Non-template options
        on_out_of_scope cleanup( [&pc]() {
            pc = avatar();
            world_generator->set_active_world( nullptr );
        } );
        g->gamemode = nullptr;
        // First load the mods, this is done by
        // loading the world.
        // Pick a world, suppressing prompts if it's "play now" mode.
        const bool is_play_now = sel2 == 3 || sel2 == 4;
        WORLD *world = world_generator->pick_world( !is_play_now, is_play_now );
        if( world == nullptr ) {
            return false;
        }
        if( !world->world_saves.empty() ) {
            // One character per world is enforced (snapshot save system +
            // avoiding shared-world-state contamination). Block instead of
            // warning-and-allowing.
            popup( _( "This world already has a character.  Create a new world "
                      "for a new character." ) );
            return false;
        }
        world_generator->set_active_world( world );
        try {
            g->setup();
        } catch( const std::exception &err ) {
            debugmsg( "Error: %s", err.what() );
            return false;
        }
        character_type play_type = character_type::CUSTOM;
        switch( sel2 ) {
            case 0:
                play_type = character_type::CUSTOM;
                break;
            case 2:
                play_type = character_type::RANDOM;
                break;
            case 3:
                play_type = character_type::NOW;
                break;
            case 4:
                play_type = character_type::FULL_RANDOM;
                break;
        }
        if( !pc.create( play_type ) ) {
            load_char_templates();
            MAPBUFFER.clear();
            overmap_buffer.clear();
            return false;
        }

        if( !g->start_game() ) {
            return false;
        }
        cleanup.cancel();
        return true;
    }
    return false;
}

bool main_menu::load_game( std::string const &worldname, save_t const &savegame )
{
    avatar &pc = get_avatar();
    on_out_of_scope cleanup( [&pc]() {
        pc = avatar();
        world_generator->set_active_world( nullptr );
    } );

    g->gamemode = nullptr;
    WORLD *world = world_generator->get_world( worldname );
    world_generator->last_world_name = world->world_name;
    world_generator->last_character_name = savegame.decoded_name();
    world_generator->save_last_world_info();
    world_generator->set_active_world( world );

    try {
        g->setup();
    } catch( const std::exception &err ) {
        debugmsg( "Error: %s", err.what() );
        return false;
    }

    if( g->load( savegame ) ) {
        cleanup.cancel();
        return true;
    }

    return false;
}

static std::optional<std::chrono::seconds> get_playtime_from_save( const WORLD *world,
        const save_t &save )
{
    cata_path playtime_file = world->folder_path() / ( save.base_path() + ".pt" );
    std::optional<std::chrono::seconds> pt_seconds;
    if( file_exist( playtime_file ) ) {
        read_from_file( playtime_file, [&pt_seconds]( std::istream & fin ) {
            if( fin.eof() ) {
                return;
            }
            std::chrono::seconds::rep dur_seconds = 0;
            fin.imbue( std::locale::classic() );
            fin >> dur_seconds;
            pt_seconds = std::chrono::seconds( dur_seconds );
        } );
    }
    return pt_seconds;
}

bool main_menu::load_character_tab( const std::string &worldname )
{
    WORLD *cur_world = world_generator->get_world( worldname );
    savegames = cur_world->world_saves;
    if( MAP_SHARING::isSharing() ) {
        auto new_end = std::remove_if( savegames.begin(), savegames.end(), []( const save_t &str ) {
            return str.decoded_name() != MAP_SHARING::getUsername();
        } );
        savegames.erase( new_end, savegames.end() );
    }

    if( savegames.empty() ) {
        on_error();
        //~ %s = world name
        popup( _( "%s has no characters to load!" ), worldname );
        return false;
    }

    uilist mmenu;
    mmenu.title = string_format( _( "Load character from \"%s\"" ), worldname );
    mmenu.border_color = c_white;
    int opt_val = 0;
    for( const save_t &s : savegames ) {
        std::optional<std::chrono::seconds> playtime = get_playtime_from_save( cur_world, s );
        std::string save_str = s.decoded_name();
        std::string playtime_str;
        if( playtime ) {
            std::chrono::seconds::rep tmp_sec = playtime->count();
            int pt_sec = static_cast<int>( tmp_sec % 60 );
            int pt_min = static_cast<int>( tmp_sec % 3600 ) / 60;
            int pt_hrs = static_cast<int>( tmp_sec / 3600 );
            playtime_str = string_format( "<color_c_light_blue>[%02d:%02d:%02d]</color>",
                                          pt_hrs, pt_min, static_cast<int>( pt_sec ) );
        }
        // TODO: Replace this API to allow adding context without an empty description.
        mmenu.entries.emplace_back( opt_val++, true, MENU_AUTOASSIGN, save_str, "", playtime_str );
    }
    mmenu.entries.emplace_back( opt_val, true, 'q', _( "<- Back to Main Menu" ), c_yellow, c_yellow );
    mmenu.query();
    opt_val = mmenu.ret;
    if( opt_val < 0 || static_cast<size_t>( opt_val ) >= savegames.size() ) {
        return false;
    }

    return main_menu::load_game( worldname, savegames[opt_val] );
}

void main_menu::world_tab( const std::string &worldname )
{
    // Create world
    if( sel2 == 0 ) {
        WORLD *world = world_generator->make_new_world();
        // NOLINTNEXTLINE(cata-use-localized-sorting)
        if( world != nullptr && world->world_name < world_generator->all_worldnames()[last_world_pos] ) {
            last_world_pos++;
        }
        return;
    }

    uilist mmenu( string_format( _( "Manage world \"%s\"" ), worldname ), {} );
    mmenu.border_color = c_white;
    int opt_val = 0;
    std::array<char, 9> hotkeys = { 'm', 's', 't', 'c', 'n', 'd', 'r', 'y', 'e' };
    for( const std::string &it : vWorldSubItems ) {
        mmenu.entries.emplace_back( opt_val, true, hotkeys[opt_val],
                                    remove_color_tags( shortcut_text( c_white, it ) ) );
        ++opt_val;
    }
    mmenu.entries.emplace_back( opt_val, true, 'q', _( "<- Back to Main Menu" ), c_yellow, c_yellow );
    mmenu.query();
    opt_val = mmenu.ret;
    if( opt_val < 0 || static_cast<size_t>( opt_val ) >= vWorldSubItems.size() ) {
        return;
    }

    auto clear_world = [this, &worldname]( bool do_delete ) {
        // NOLINTNEXTLINE(cata-use-localized-sorting)
        if( last_world_pos > 0 && worldname <= world_generator->all_worldnames()[last_world_pos] ) {
            last_world_pos--;
        }
        world_generator->delete_world( worldname, do_delete );
        savegames.clear();
        MAPBUFFER.clear();
        overmap_buffer.clear();
        if( do_delete ) {
            sel2 = 0; // reset to create world selection
        }
    };

    switch( opt_val ) {
        case 0: // Active World Mods
            world_generator->show_active_world_mods(
                world_generator->get_world( worldname )->active_mod_order );
            break;
        case 1: // Copy World settings
            world_generator->make_new_world( true, worldname );
            break;
        case 2: // Character to Template
            if( load_character_tab( worldname ) ) {
                avatar &pc = get_avatar();
                pc.setID( character_id(), true );
                pc.reset_all_missions();
                pc.character_to_template( pc.name );
                pc = avatar();
                MAPBUFFER.clear();
                overmap_buffer.clear();
                load_char_templates();
            }
            break;
        case 3: // Toggle save compression
            if( world_generator->get_world( worldname )->has_compression_enabled() ) {
                if( query_yn( _( "Disable save compression?" ) ) ) {
                    world_generator->get_world( worldname )->set_compression_enabled( false );
                }
            } else {
                if( query_yn( _( "Enable save compression?" ) ) ) {
                    world_generator->get_world( worldname )->set_compression_enabled( true );
                }
            }
            break;
        case 4: // Snapshots
            snapshots_tab( worldname );
            break;
        case 5: // Delete World
            if( query_yn( _( "Delete the world and all saves within?" ) ) ) {
                clear_world( true );
            }
            break;
        case 6: // Reset World
            if( query_yn( _( "Remove all saves and regenerate world?" ) ) ) {
                clear_world( false );
            }
            break;
        case 7: { // Copy Personal Zones
            WORLD *cur_world = world_generator->get_world( worldname );
            const std::vector<save_t> &saves = cur_world->world_saves;
            if( saves.empty() ) {
                popup( _( "No characters in this world!" ) );
                break;
            }
            uilist char_menu;
            char_menu.title = _( "Copy personal zones from which character?" );
            char_menu.border_color = c_white;
            int char_opt = 0;
            for( const save_t &s : saves ) {
                char_menu.entries.emplace_back( char_opt++, true, MENU_AUTOASSIGN,
                                                s.decoded_name() );
            }
            char_menu.entries.emplace_back( char_opt, true, 'q', _( "<- Back" ),
                                            c_yellow, c_yellow );
            char_menu.query();
            if( char_menu.ret < 0 ||
                static_cast<size_t>( char_menu.ret ) >= saves.size() ) {
                break;
            }
            cata_path zones_file = cur_world->folder_path() /
                                   ( saves[char_menu.ret].base_path() + ".zones.json" );
            int zone_count = 0;
            clipboard_personal_zones = zone_manager::copy_personal_zones( zones_file,
                                       zone_count );
            if( zone_count > 0 ) {
                popup( n_gettext( "Copied %d personal zone.",
                                  "Copied %d personal zones.", zone_count ), zone_count );
            } else {
                popup( _( "No personal zones found for this character." ) );
            }
            break;
        }
        case 8: { // Paste Personal Zones
            if( clipboard_personal_zones.empty() ) {
                popup( _( "No personal zones in clipboard. Copy personal zones first." ) );
                break;
            }
            WORLD *cur_world = world_generator->get_world( worldname );
            const std::vector<save_t> &saves = cur_world->world_saves;
            if( saves.empty() ) {
                popup( _( "No characters in this world!" ) );
                break;
            }
            uilist char_menu;
            char_menu.title = _( "Paste personal zones to which character?" );
            char_menu.border_color = c_white;
            int char_opt = 0;
            for( const save_t &s : saves ) {
                char_menu.entries.emplace_back( char_opt++, true, MENU_AUTOASSIGN,
                                                s.decoded_name() );
            }
            char_menu.entries.emplace_back( char_opt, true, 'q', _( "<- Back" ),
                                            c_yellow, c_yellow );
            char_menu.query();
            if( char_menu.ret < 0 ||
                static_cast<size_t>( char_menu.ret ) >= saves.size() ) {
                break;
            }
            cata_path zones_file = cur_world->folder_path() /
                                   ( saves[char_menu.ret].base_path() + ".zones.json" );
            if( zone_manager::paste_personal_zones( zones_file,
                                                    clipboard_personal_zones ) ) {
                popup( _( "Personal zones pasted successfully." ) );
            } else {
                popup( _( "Failed to write zones data." ) );
            }
            break;
        }
        default:
            break;
    }
}

void main_menu::snapshots_tab( const std::string &worldname )
{
    WORLD *world = world_generator->get_world( worldname );
    if( world == nullptr ) {
        return;
    }
    const cata_path world_dir = world->folder_path();

    while( true ) {
        const save_snapshot::menu_selection sel =
            save_snapshot::query_snapshot_menu(
                world_dir, string_format( _( "Snapshots of \"%s\"" ), worldname ),
                _( "Restore this snapshot" ) );

        if( sel.action == save_snapshot::menu_action::none ) {
            return;
        }

        if( sel.action == save_snapshot::menu_action::create ) {
            // No live game here: the on-disk world files already are the saved
            // state, so snapshot the directory directly. Character name / turn
            // are unknown from the menu, so leave them blank/0.
            if( save_snapshot::make_snapshot( world_dir, sel.new_name, std::string(), 0 ) ) {
                popup_getkey( _( "Snapshot \"%s\" saved." ), sel.new_name );
            } else {
                popup_getkey( _( "Failed to create the snapshot." ) );
            }
            continue;
        }

        if( sel.action == save_snapshot::menu_action::remove ) {
            if( query_yn( _( "Permanently delete snapshot \"%s\"?" ), sel.chosen.name ) ) {
                save_snapshot::delete_snapshot( world_dir, sel.chosen.dir_name );
            }
            continue;
        }

        // menu_action::load (restore)
        if( !query_yn( _( "Restore snapshot \"%s\"?  This overwrites the world's "
                          "current save." ), sel.chosen.name ) ) {
            continue;
        }
        if( save_snapshot::restore_snapshot( world_dir, sel.chosen.dir_name ) ) {
            // Drop any cached map/overmap so a later load reads the restored
            // files rather than stale buffers, and re-probe compression state.
            MAPBUFFER.clear();
            overmap_buffer.clear();
            world->invalidate_compression_cache();
            savegames.clear();
            popup_getkey( _( "Snapshot \"%s\" restored." ), sel.chosen.name );
        } else {
            popup_getkey( _( "Failed to restore the snapshot." ) );
        }
    }
}

std::string main_menu::halloween_spider()
{
    static const std::string spider =
        "\\ \\ \\/ / / / / / / /\n"
        " \\ \\/\\/ / / / / / /\n"
        "\\ \\/__\\/ / / / / /\n"
        " \\/____\\/ / / / /\n"
        "\\/______\\/ / / /\n"
        "/________\\/ / /\n"
        "__________\\/ /\n"
        "___________\\/\n"
        "        |\n"
        "        |\n"
        "        |\n"
        "        |\n"
        "        |\n"
        "        |\n"
        "        |\n"
        "        |\n"
        "        |\n"
        "        |\n"
        "  , .   |  . ,\n" // NOLINT(cata-text-style)
        "  { | ,--, | }\n" // NOLINT(cata-text-style)
        "   \\\\{~~~~}//\n"
        "  /_/ {<color_c_red>..</color>} \\_\\\n"
        "  { {      } }\n"
        "  , ,      , ."; // NOLINT(cata-text-style)

    return spider;
}

std::string main_menu::halloween_graves()
{
    static const std::string graves =
        "                    _\n"
        "        -q       __(\")_\n"
        "         (\\      \\_  _/\n"
        " .-.   .-''\"'.     |/\n" // NOLINT(cata-text-style)
        "|RIP|  | RIP |   .-.\n"
        "|   |  |     |  |RIP|\n"
        ";   ;  |     | ,'---',"; // NOLINT(cata-text-style)

    return graves;
}
