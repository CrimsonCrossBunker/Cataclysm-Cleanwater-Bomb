#include "help.h"

#include <algorithm>
#include <array>
#include <cstddef>
#include <cmath>
#include <functional>
#include <iterator>
#include <numeric>
#include <optional>
#include <string>
#include <unordered_map>
#include <vector>

#if defined(__ANDROID__)
    #include "cata_imgui.h"
    #include "imgui/imgui.h"
#endif

#include "action.h"
#include "cata_path.h"
#include "cata_utility.h"
#include "catacharset.h"
#include "color.h"
#include "cursesdef.h"
#include "debug.h"
#include "flexbuffer_json.h"
#include "input_context.h"
#include "input_enums.h"
#include "output.h"
#include "path_info.h"
#include "point.h"
#include "string_formatter.h"
#include "text_snippets.h"
#include "translations.h"
#include "ui_helpers.h"
#include "ui_manager.h"

#if defined(__ANDROID__)
namespace
{
struct android_help_topic {
    std::string title;
    std::string body;
};

struct android_vertical_drag_state {
    bool active = false;
    ImVec2 start;
};

class android_help_viewer : public cataimgui::window
{
    public:
        explicit android_help_viewer( std::vector<android_help_topic> topics ) :
            cataimgui::window( "Android help viewer",
                               ImGuiWindowFlags_NoTitleBar | ImGuiWindowFlags_NoCollapse |
                               ImGuiWindowFlags_NoResize | ImGuiWindowFlags_NoMove |
                               ImGuiWindowFlags_NoSavedSettings ),
            topics( std::move( topics ) ) {}

        bool take_close_request() {
            const bool result = close_requested;
            close_requested = false;
            return result;
        }

    protected:
        cataimgui::bounds get_bounds() override {
            return { 0.0F, 0.0F, 1.0F, 1.0F };
        }

        void draw_controls() override {
            const ImVec2 window_pos = ImGui::GetWindowPos();
            const ImVec2 window_size = ImGui::GetWindowSize();
            const float edge_padding = std::clamp( window_size.x * 0.018F, 14.0F, 30.0F );
            constexpr float footer_height = 66.0F;

            ImGui::GetWindowDrawList()->AddRectFilled(
                window_pos, ImVec2( window_pos.x + window_size.x, window_pos.y + window_size.y ),
                IM_COL32( 6, 9, 12, 255 ) );
            cataimgui::PushGuiFont1_5x();
            ImGui::PushStyleVar( ImGuiStyleVar_FrameRounding, 8.0F );
            ImGui::PushStyleVar( ImGuiStyleVar_FramePadding, ImVec2( 12.0F, 9.0F ) );
            ImGui::PushStyleVar( ImGuiStyleVar_ItemSpacing, ImVec2( 8.0F, 7.0F ) );
            ImGui::PushStyleVar( ImGuiStyleVar_WindowPadding, ImVec2( edge_padding, 12.0F ) );
            ImGui::PushStyleColor( ImGuiCol_ChildBg, ImVec4( 0.035F, 0.050F, 0.062F, 1.0F ) );
            ImGui::PushStyleColor( ImGuiCol_Border, ImVec4( 0.22F, 0.36F, 0.40F, 0.78F ) );
            ImGui::PushStyleColor( ImGuiCol_Button, ImVec4( 0.065F, 0.085F, 0.105F, 1.0F ) );
            ImGui::PushStyleColor( ImGuiCol_ButtonHovered, ImVec4( 0.10F, 0.28F, 0.31F, 1.0F ) );
            ImGui::PushStyleColor( ImGuiCol_ButtonActive, ImVec4( 0.13F, 0.39F, 0.42F, 1.0F ) );
            ImGui::PushStyleColor( ImGuiCol_Text, ImVec4( 0.90F, 0.94F, 0.95F, 1.0F ) );

            ImGui::TextUnformatted( _( "Help" ) );
            ImGui::Separator();
            const float topic_width = std::clamp( window_size.x * 0.32F, 300.0F, 520.0F );
            if( ImGui::BeginChild( "##android_help_topics", ImVec2( topic_width, -footer_height ),
                                   ImGuiChildFlags_Borders,
                                   ImGuiWindowFlags_AlwaysVerticalScrollbar ) ) {
                const bool suppress_click = handle_vertical_drag( topic_drag );
                for( size_t index = 0; index < topics.size(); ++index ) {
                    const bool selected = static_cast<int>( index ) == selected_topic;
                    if( selected ) {
                        ImGui::PushStyleColor( ImGuiCol_Button,
                                               ImVec4( 0.08F, 0.30F, 0.34F, 1.0F ) );
                        ImGui::PushStyleColor( ImGuiCol_Border,
                                               ImVec4( 0.32F, 0.72F, 0.75F, 1.0F ) );
                        ImGui::PushStyleColor( ImGuiCol_Text,
                                               ImVec4( 0.90F, 1.0F, 1.0F, 1.0F ) );
                    }
                    const std::string label = topics[index].title + "###android_help_topic_" +
                                              std::to_string( index );
                    if( ImGui::Button( label.c_str(), ImVec2( -1.0F, 48.0F ) ) &&
                        !suppress_click ) {
                        selected_topic = static_cast<int>( index );
                        reset_body_scroll = true;
                    }
                    if( selected ) {
                        ImGui::PopStyleColor( 3 );
                    }
                }
            }
            ImGui::EndChild();

            ImGui::SameLine();
            if( ImGui::BeginChild( "##android_help_body", ImVec2( 0.0F, -footer_height ),
                                   ImGuiChildFlags_Borders,
                                   ImGuiWindowFlags_AlwaysVerticalScrollbar ) ) {
                handle_vertical_drag( body_drag );
                if( reset_body_scroll ) {
                    ImGui::SetScrollY( 0.0F );
                    reset_body_scroll = false;
                }
                if( selected_topic >= 0 && selected_topic < static_cast<int>( topics.size() ) ) {
                    ImGui::TextUnformatted( topics[selected_topic].title.c_str() );
                    ImGui::Separator();
                    const float wrap_width = std::max( 1.0F,
                                                       ImGui::GetContentRegionAvail().x - 10.0F );
                    cataimgui::draw_colored_text( topics[selected_topic].body, c_light_gray,
                                                  wrap_width );
                }
            }
            ImGui::EndChild();

            ImGui::Separator();
            const float button_width = std::clamp( window_size.x * 0.20F, 220.0F, 360.0F );
            ImGui::SetCursorPosX( std::max( edge_padding,
                                            window_size.x - edge_padding - button_width ) );
            if( ImGui::Button( _( "Back" ), ImVec2( button_width, 50.0F ) ) ) {
                close_requested = true;
            }

            ImGui::PopStyleColor( 6 );
            ImGui::PopStyleVar( 4 );
            cataimgui::PopGuiFont1_5x();
        }

    private:
        std::vector<android_help_topic> topics;
        int selected_topic = 0;
        bool close_requested = false;
        bool reset_body_scroll = false;
        android_vertical_drag_state topic_drag;
        android_vertical_drag_state body_drag;

        static bool handle_vertical_drag( android_vertical_drag_state &state ) {
            ImGuiIO &io = ImGui::GetIO();
            if( ImGui::IsWindowHovered( ImGuiHoveredFlags_AllowWhenBlockedByActiveItem ) &&
                ImGui::IsMouseClicked( ImGuiMouseButton_Left ) ) {
                state.active = true;
                state.start = io.MousePos;
            }
            if( !state.active ) {
                return false;
            }
            const ImVec2 distance( io.MousePos.x - state.start.x, io.MousePos.y - state.start.y );
            const bool moved = std::hypot( distance.x, distance.y ) > 14.0F;
            if( ImGui::IsMouseDown( ImGuiMouseButton_Left ) &&
                std::abs( distance.y ) > std::abs( distance.x ) ) {
                ImGui::SetScrollY( ImGui::GetScrollY() - io.MouseDelta.y );
            }
            if( ImGui::IsMouseReleased( ImGuiMouseButton_Left ) ) {
                state.active = false;
            }
            return moved;
        }
};
} // namespace
#endif

help &get_help()
{
    static help single_instance;
    return single_instance;
}

void help::load( const JsonObject &jo, const std::string &src )
{
    get_help().load_object( jo, src );
}

void help::reset()
{
    get_help().reset_instance();
}

void help::reset_instance()
{
    current_order_start = 0;
    current_src = "";
    help_texts.clear();
}

void help::load_object( const JsonObject &jo, const std::string &src )
{
    if( src == "dda" ) {
        jo.throw_error( string_format( "Vanilla help must be located in %s",
                                       PATH_INFO::jsondir().generic_u8string() ) );
    }
    if( src != current_src ) {
        current_order_start = help_texts.empty() ? 0 : help_texts.crbegin()->first + 1;
        current_src = src;
    }
    std::vector<translation> messages;
    jo.read( "messages", messages );

    translation name;
    jo.read( "name", name );
    const int modified_order = jo.get_int( "order" ) + current_order_start;
    if( !help_texts.try_emplace( modified_order, std::make_pair( name, messages ) ).second ) {
        jo.throw_error_at( "order", "\"order\" must be unique (per src)" );
    }
}

std::string help::get_dir_grid()
{
    static const std::array<action_id, 9> movearray = {{
            ACTION_MOVE_FORTH_LEFT, ACTION_MOVE_FORTH, ACTION_MOVE_FORTH_RIGHT,
            ACTION_MOVE_LEFT,  ACTION_PAUSE,  ACTION_MOVE_RIGHT,
            ACTION_MOVE_BACK_LEFT, ACTION_MOVE_BACK, ACTION_MOVE_BACK_RIGHT
        }
    };

    std::string movement = "<LEFTUP_0>  <UP_0>  <RIGHTUP_0>   <LEFTUP_1>  <UP_1>  <RIGHTUP_1>\n"
                           " \\ | /     \\ | /\n"
                           "  \\|/       \\|/\n"
                           "<LEFT_0>--<pause_0>--<RIGHT_0>   <LEFT_1>--<pause_1>--<RIGHT_1>\n"
                           "  /|\\       /|\\\n"
                           " / | \\     / | \\\n"
                           "<LEFTDOWN_0>  <DOWN_0>  <RIGHTDOWN_0>   <LEFTDOWN_1>  <DOWN_1>  <RIGHTDOWN_1>";

    for( action_id dir : movearray ) {
        std::vector<input_event> keys = keys_bound_to( dir, /*maximum_modifier_count=*/0 );
        for( size_t i = 0; i < 2; i++ ) {
            movement = string_replace( movement, "<" + action_ident( dir ) + string_format( "_%d>", i ),
                                       i < keys.size()
                                       ? string_format( "<color_light_blue>%s</color>",
                                               keys[i].short_description() )
                                       : "<color_red>?</color>" );
        }
    }

    return movement;
}

std::map<int, inclusive_rectangle<point>> help::draw_menu( const catacurses::window &win,
                                       int selected, std::map<int, input_event> &hotkeys ) const
{
    std::map<int, inclusive_rectangle<point>> opt_map;

    werase( win );
    // NOLINTNEXTLINE(cata-use-named-point-constants)
    int y = fold_and_print( win, point( 1, 0 ), getmaxx( win ) - 2, c_white,
                            _( "Please press one of the following for help on that topic:\n"
                               "Press ESC to return to the game." ) ) + 1;

    size_t half_size = help_texts.size() / 2 + 1;
    int second_column = divide_round_up( getmaxx( win ), 2 );
    size_t i = 0;
    for( const auto &text : help_texts ) {
        std::string cat_name;
        auto hotkey_it = hotkeys.find( text.first );
        if( hotkey_it != hotkeys.end() ) {
            cat_name = colorize( hotkey_it->second.short_description(),
                                 selected == text.first ? hilite( c_light_blue ) : c_light_blue );
            cat_name += ": ";
        }
        cat_name += text.second.first.translated();
        const int cat_width = utf8_width( remove_color_tags( cat_name ) );
        if( i < half_size ) {
            second_column = std::max( second_column, cat_width + 4 );
        }

        const point sc_start( i < half_size ? 1 : second_column, y + i % half_size );
        fold_and_print( win, sc_start, getmaxx( win ) - 2,
                        selected == text.first ? hilite( c_white ) : c_white, cat_name );
        ++i;

        opt_map.emplace( text.first,
                         inclusive_rectangle<point>( sc_start, sc_start + point( cat_width - 1, 0 ) ) );
    }

    wnoutrefresh( win );

    return opt_map;
}

std::string help::get_note_colors()
{
    std::string text = _( "Note colors: " );
    for( const auto &color_pair : get_note_color_names() ) {
        // The color index is not translatable, but the name is.
        //~ %1$s: note color abbreviation, %2$s: note color name
        text += string_format( pgettext( "note color", "%1$s:%2$s, " ),
                               colorize( color_pair.first, color_pair.second.color ),
                               color_pair.second.name );
    }

    return text;
}

std::string help::format_help_topic( const std::vector<translation> &messages ) const
{
    std::vector<std::string> translated_messages;
    translated_messages.reserve( messages.size() );
    std::transform( messages.begin(), messages.end(),
    std::back_inserter( translated_messages ), [&]( const translation & line ) {
        std::string line_proc = line.translated();
        if( line_proc == "<DRAW_NOTE_COLORS>" ) {
            line_proc = get_note_colors();
        } else if( line_proc == "<HELP_DRAW_DIRECTIONS>" ) {
            line_proc = get_dir_grid();
        }
        size_t pos = line_proc.find( "<press_", 0, 7 );
        while( pos != std::string::npos ) {
            const size_t pos2 = line_proc.find( ">", pos, 1 );
            if( pos2 == std::string::npos ) {
                break;
            }
            const std::string action = line_proc.substr( pos + 7, pos2 - pos - 7 );
            const std::string replacement = "<color_light_blue>" +
                                            press_x( look_up_action( action ), "", "" ) + "</color>";
            if( replacement.empty() ) {
                debugmsg( "Help json: Unknown action: %s", action );
            } else {
                line_proc = string_replace( line_proc, "<press_" + action + ">", replacement );
            }
            pos = line_proc.find( "<press_", pos2, 7 );
        }
        return line_proc;
    } );

    if( translated_messages.empty() ) {
        return {};
    }
    return std::accumulate( translated_messages.begin() + 1, translated_messages.end(),
                            translated_messages.front(),
    []( std::string lhs, const std::string & rhs ) {
        return std::move( lhs ) + "\n\n" + rhs;
    } );
}

void help::display_help() const
{
#if defined(__ANDROID__)
    std::vector<android_help_topic> topics;
    topics.reserve( help_texts.size() );
    for( const auto &entry : help_texts ) {
        topics.push_back( { entry.second.first.translated(),
                            format_help_topic( entry.second.second ) } );
    }
    android_help_viewer viewer( std::move( topics ) );
    input_context ctxt( "DISPLAY_HELP", keyboard_mode::keychar );
    ctxt.register_action( "QUIT" );
    ctxt.register_action( "SELECT" );
    ctxt.register_action( "MOUSE_MOVE" );
    while( true ) {
        ui_manager::redraw();
        if( viewer.take_close_request() ) {
            return;
        }
        if( ctxt.handle_input() == "QUIT" ) {
            return;
        }
    }
#else
    catacurses::window w_help_border;
    catacurses::window w_help;

    ui_adaptor ui;
    const auto init_windows = [&]( ui_adaptor & ui ) {
        ui_helpers::full_screen_window( ui, &w_help, &w_help_border, nullptr, nullptr, nullptr, 1 );
    };
    init_windows( ui );
    ui.on_screen_resize( init_windows );

    input_context ctxt( "DISPLAY_HELP", keyboard_mode::keychar );
    ctxt.register_cardinal();
    ctxt.register_action( "QUIT" );
    ctxt.register_action( "CONFIRM" );
    // for mouse selection
    ctxt.register_action( "SELECT" );
    ctxt.register_action( "MOUSE_MOVE" );
    // for the menu shortcuts
    ctxt.register_action( "ANY_INPUT" );

    std::string action;
    std::map<int, inclusive_rectangle<point>> opt_map;
    int sel = -1;

    const hotkey_queue &hkq = hotkey_queue::alphabets();
    input_event next_hotkey = ctxt.first_unassigned_hotkey( hkq );
    std::map<int, input_event> hotkeys;
    for( const auto &text : help_texts ) {
        hotkeys.emplace( text.first, next_hotkey );
        next_hotkey = ctxt.next_unassigned_hotkey( hkq, next_hotkey );
    }

    ui.on_redraw( [&]( const ui_adaptor & ) {
        draw_border( w_help_border, BORDER_COLOR, _( "Help" ) );
        wnoutrefresh( w_help_border );
        opt_map = draw_menu( w_help, sel, hotkeys );
    } );

    do {
        ui_manager::redraw();

        sel = -1;
        action = ctxt.handle_input();
        input_event input = ctxt.get_raw_input();

        // Mouse selection
        if( action == "MOUSE_MOVE" || action == "SELECT" ) {
            std::optional<point> coord = ctxt.get_coordinates_text( w_help );
            if( !!coord ) {
                int cnt = run_for_point_in<int, point>( opt_map, *coord,
                [&sel]( const std::pair<int, inclusive_rectangle<point>> &p ) {
                    sel = p.first;
                } );
                if( cnt > 0 && action == "SELECT" ) {
                    auto iter = hotkeys.find( sel );
                    if( iter != hotkeys.end() ) {
                        input = iter->second;
                        action = "CONFIRM";
                    }
                }
            }
        }

        for( const auto &hotkey_entry : hotkeys ) {
            auto help_text_it = help_texts.find( hotkey_entry.first );
            if( help_text_it == help_texts.end() ) {
                continue;
            }
            if( input == hotkey_entry.second ) {
                const std::string topic_text = format_help_topic( help_text_it->second.second );
                if( !topic_text.empty() ) {
                    ui.on_screen_resize( nullptr );

                    const auto get_w_help_border = [&]() {
                        init_windows( ui );
                        return w_help_border;
                    };

                    scrollable_text( get_w_help_border, _( "Help" ), topic_text );

                    ui.on_screen_resize( init_windows );
                }
                action = "CONFIRM";
                break;

            }
        }
    } while( action != "QUIT" );
#endif
}

std::string get_hint()
{
    return SNIPPET.random_from_category( "hint" ).value_or( translation() ).translated();
}
