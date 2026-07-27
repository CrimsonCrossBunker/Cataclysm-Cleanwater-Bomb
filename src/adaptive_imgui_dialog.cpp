#include "adaptive_imgui_dialog.h"

#if defined(TILES)

#include <algorithm>
#include <cmath>
#include <deque>
#include <utility>

#include "cata_imgui.h"
#include "imgui/imgui.h"
#include "input_context.h"
#include "translations.h"
#include "ui_profile.h"
#include "ui_manager.h"

namespace adaptive_imgui_dialog
{
namespace
{

class choice_window : public cataimgui::window
{
    public:
        choice_window( std::string title, std::string message,
                       std::vector<entry> entries, int initial_selection ) :
            cataimgui::window( "Adaptive ImGui choice dialog",
                               ImGuiWindowFlags_NoTitleBar | ImGuiWindowFlags_NoCollapse |
                               ImGuiWindowFlags_NoResize | ImGuiWindowFlags_NoMove |
                               ImGuiWindowFlags_NoSavedSettings ),
            title_( std::move( title ) ), message_( std::move( message ) ),
            entries_( std::move( entries ) ), selected_( initial_selection ) {
            select_enabled_entry();
        }

        std::optional<int> take_choice() {
            if( choices_.empty() ) {
                return std::nullopt;
            }
            const int result = choices_.front();
            choices_.pop_front();
            return result;
        }

        bool take_cancel() {
            const bool result = cancel_requested_;
            cancel_requested_ = false;
            return result;
        }

        void move_selection( const int delta ) {
            if( entries_.empty() || delta == 0 ) {
                return;
            }
            const int count = static_cast<int>( entries_.size() );
            const int direction = delta > 0 ? 1 : -1;
            int remaining = std::abs( delta );
            int candidate = std::clamp( selected_, 0, count - 1 );
            while( remaining-- > 0 ) {
                for( int attempts = 0; attempts < count; ++attempts ) {
                    candidate = ( candidate + direction + count ) % count;
                    if( entries_[candidate].enabled ) {
                        break;
                    }
                }
            }
            if( entries_[candidate].enabled ) {
                selected_ = candidate;
                scroll_to_selection_ = true;
            }
        }

        void activate_selection() {
            if( selected_ >= 0 &&
                static_cast<size_t>( selected_ ) < entries_.size() &&
                entries_[selected_].enabled ) {
                choices_.push_back( selected_ );
            }
        }

    protected:
        cataimgui::bounds get_bounds() override {
            const cata::ui::profile profile = cata::ui::current_profile();
            return profile.is_touch() ? cataimgui::bounds{ 0.0F, 0.0F, 1.0F, 1.0F } :
                   cataimgui::bounds{ -1.0F, -1.0F, profile.page_width, profile.page_height };
        }

        void draw_controls() override {
            const cata::ui::profile profile = cata::ui::current_profile();
            const ImVec2 window_pos = ImGui::GetWindowPos();
            const ImVec2 window_size = ImGui::GetWindowSize();
            const float edge_padding = std::max( profile.frame_padding_x * 2.0F,
                                                 profile.item_spacing_x * 2.0F );
            const float footer_height = profile.row_wide;

            ImGui::GetWindowDrawList()->AddRectFilled(
                window_pos, ImVec2( window_pos.x + window_size.x, window_pos.y + window_size.y ),
                IM_COL32( 6, 9, 12, 255 ) );
            const bool scaled_font = profile.text_scale != 1.0F;
            if( scaled_font ) {
                cataimgui::PushGuiFontScaled( profile.text_scale );
            }
            ImGui::PushStyleVar( ImGuiStyleVar_FrameRounding, profile.corner_radius );
            ImGui::PushStyleVar( ImGuiStyleVar_FrameBorderSize, 1.0F );
            ImGui::PushStyleVar(
                ImGuiStyleVar_FramePadding,
                ImVec2( profile.frame_padding_x, profile.frame_padding_y ) );
            ImGui::PushStyleVar(
                ImGuiStyleVar_ItemSpacing,
                ImVec2( profile.item_spacing_x, profile.item_spacing_y ) );
            ImGui::PushStyleVar(
                ImGuiStyleVar_WindowPadding,
                ImVec2( edge_padding, profile.frame_padding_y * 2.0F ) );
            ImGui::PushStyleColor( ImGuiCol_ChildBg, ImVec4( 0.035F, 0.050F, 0.062F, 1.0F ) );
            ImGui::PushStyleColor( ImGuiCol_Border, ImVec4( 0.22F, 0.36F, 0.40F, 0.78F ) );
            ImGui::PushStyleColor( ImGuiCol_Button, ImVec4( 0.065F, 0.085F, 0.105F, 1.0F ) );
            ImGui::PushStyleColor( ImGuiCol_ButtonHovered, ImVec4( 0.10F, 0.28F, 0.31F, 1.0F ) );
            ImGui::PushStyleColor( ImGuiCol_ButtonActive, ImVec4( 0.13F, 0.39F, 0.42F, 1.0F ) );
            ImGui::PushStyleColor( ImGuiCol_Text, ImVec4( 0.90F, 0.94F, 0.95F, 1.0F ) );

            ImGui::TextUnformatted( title_.c_str() );
            if( !message_.empty() ) {
                ImGui::Separator();
                ImGui::TextWrapped( "%s", message_.c_str() );
            }
            ImGui::Separator();

            if( ImGui::BeginChild( "##adaptive_choice_entries", ImVec2( 0.0F, -footer_height ),
                                   ImGuiChildFlags_Borders,
                                   ImGuiWindowFlags_AlwaysVerticalScrollbar ) ) {
                const bool suppress_click = cataimgui::handle_vertical_swipe(
                                                profile.allow_swipe,
                                                profile.frame_padding_x );
                for( size_t index = 0; index < entries_.size(); ++index ) {
                    draw_entry( static_cast<int>( index ), entries_[index], suppress_click );
                }
            }
            ImGui::EndChild();

            ImGui::Separator();
            const float button_width = std::clamp(
                                           window_size.x * 0.22F,
                                           profile.width_normal, profile.width_wide );
            ImGui::SetCursorPosX( std::max( edge_padding,
                                            window_size.x - edge_padding - button_width ) );
            if( ImGui::Button( _( "Back" ),
                               ImVec2( button_width, profile.row_normal ) ) ) {
                cancel_requested_ = true;
            }

            ImGui::PopStyleColor( 6 );
            ImGui::PopStyleVar( 5 );
            if( scaled_font ) {
                cataimgui::PopGuiFontScaled();
            }
        }

    private:
        std::string title_;
        std::string message_;
        std::vector<entry> entries_;
        int selected_ = 0;
        std::deque<int> choices_;
        bool cancel_requested_ = false;
        bool scroll_to_selection_ = true;

        void select_enabled_entry() {
            if( entries_.empty() ) {
                selected_ = -1;
                return;
            }
            selected_ = std::clamp( selected_, 0, static_cast<int>( entries_.size() ) - 1 );
            if( entries_[selected_].enabled ) {
                return;
            }
            for( size_t index = 0; index < entries_.size(); ++index ) {
                if( entries_[index].enabled ) {
                    selected_ = static_cast<int>( index );
                    return;
                }
            }
            selected_ = -1;
        }

        void draw_entry( const int index, const entry &item, const bool suppress_click ) {
            ImGui::PushID( index );
            if( !item.enabled ) {
                ImGui::BeginDisabled();
            }
            const bool selected = selected_ == index;
            if( selected ) {
                ImGui::PushStyleColor( ImGuiCol_Button, ImVec4( 0.08F, 0.30F, 0.34F, 1.0F ) );
                ImGui::PushStyleColor( ImGuiCol_Border, ImVec4( 0.32F, 0.72F, 0.75F, 1.0F ) );
            } else if( item.danger ) {
                ImGui::PushStyleColor( ImGuiCol_Button, ImVec4( 0.30F, 0.08F, 0.08F, 1.0F ) );
                ImGui::PushStyleColor( ImGuiCol_Border, ImVec4( 0.64F, 0.22F, 0.18F, 0.9F ) );
            }
            const std::string label = item.label + "###adaptive_choice_entry";
            const cata::ui::profile profile = cata::ui::current_profile();
            if( ImGui::Button( label.c_str(),
                               ImVec2( -1.0F, profile.row_normal ) ) && !suppress_click ) {
                selected_ = index;
                choices_.push_back( index );
            }
            if( item.enabled && ImGui::IsItemHovered() ) {
                selected_ = index;
            }
            if( selected && scroll_to_selection_ ) {
                ImGui::SetScrollHereY( 0.5F );
                scroll_to_selection_ = false;
            }
            if( selected || item.danger ) {
                ImGui::PopStyleColor( 2 );
            }
            if( !item.description.empty() ) {
                ImGui::Indent( profile.frame_padding_x );
                ImGui::TextWrapped( "%s", item.description.c_str() );
                ImGui::Unindent( profile.frame_padding_x );
            }
            if( !item.enabled ) {
                ImGui::EndDisabled();
            }
            ImGui::Separator();
            ImGui::PopID();
        }
};

class compact_dialog_window : public cataimgui::window
{
    public:
        compact_dialog_window( std::string title, std::string message,
                               std::vector<entry> entries, const int initial_selection ) :
            cataimgui::window( "Adaptive ImGui compact dialog",
                               ImGuiWindowFlags_NoTitleBar | ImGuiWindowFlags_NoCollapse |
                               ImGuiWindowFlags_NoResize | ImGuiWindowFlags_NoMove |
                               ImGuiWindowFlags_NoSavedSettings ),
            title_( std::move( title ) ), message_( std::move( message ) ),
            entries_( std::move( entries ) ), selected_( initial_selection ) {
            select_enabled_entry();
        }

        std::optional<int> take_choice() {
            if( choices_.empty() ) {
                return std::nullopt;
            }
            const int result = choices_.front();
            choices_.pop_front();
            return result;
        }

        void move_selection( const int delta ) {
            if( entries_.empty() || delta == 0 ) {
                return;
            }
            const int count = static_cast<int>( entries_.size() );
            const int direction = delta > 0 ? 1 : -1;
            int candidate = std::clamp( selected_, 0, count - 1 );
            for( int attempts = 0; attempts < count; ++attempts ) {
                candidate = ( candidate + direction + count ) % count;
                if( entries_[candidate].enabled ) {
                    selected_ = candidate;
                    return;
                }
            }
        }

        void activate_selection() {
            if( selected_ >= 0 &&
                static_cast<size_t>( selected_ ) < entries_.size() &&
                entries_[selected_].enabled ) {
                choices_.push_back( selected_ );
            }
        }

    protected:
        cataimgui::bounds get_bounds() override {
            const cata::ui::profile profile = cata::ui::current_profile();
            return profile.is_touch() ? cataimgui::bounds{ 0.0F, 0.0F, 1.0F, 1.0F } :
                   cataimgui::bounds{ -1.0F, -1.0F, profile.page_width, profile.page_height };
        }

        void draw_controls() override {
            const cata::ui::profile profile = cata::ui::current_profile();
            const ImVec2 window_pos = ImGui::GetWindowPos();
            const ImVec2 window_size = ImGui::GetWindowSize();
            ImGui::GetWindowDrawList()->AddRectFilled(
                window_pos, ImVec2( window_pos.x + window_size.x, window_pos.y + window_size.y ),
                IM_COL32( 2, 4, 6, 210 ) );

            const bool scaled_font = profile.text_scale != 1.0F;
            if( scaled_font ) {
                cataimgui::PushGuiFontScaled( profile.text_scale );
            }
            const float panel_width_max = std::max(
                                              1.0F,
                                              std::min( profile.width_wide * 2.3F,
                                                      window_size.x -
                                                      profile.frame_padding_x * 2.0F ) );
            const float panel_width_min = std::min( profile.width_wide,
                                                    panel_width_max );
            const float panel_width = std::clamp(
                                          window_size.x * 0.68F,
                                          panel_width_min, panel_width_max );
            const float text_height = ImGui::CalcTextSize( message_.c_str(), nullptr, false,
                                      std::max( 1.0F, panel_width -
                                                profile.frame_padding_x * 4.0F ) ).y;
            const float panel_height_max = std::max(
                                               1.0F,
                                               window_size.y -
                                               profile.frame_padding_y * 2.0F );
            const float panel_height_min = std::min( profile.panel_normal,
                                           panel_height_max );
            const float panel_height = std::clamp(
                                           text_height + profile.row_wide +
                                           profile.frame_padding_y * 4.0F,
                                           panel_height_min, panel_height_max );
            const ImVec2 panel_pos( ( window_size.x - panel_width ) * 0.5F,
                                    ( window_size.y - panel_height ) * 0.5F );
            ImGui::SetCursorPos( panel_pos );

            ImGui::PushStyleVar( ImGuiStyleVar_ChildRounding, profile.corner_radius );
            ImGui::PushStyleVar( ImGuiStyleVar_FrameRounding, profile.corner_radius );
            ImGui::PushStyleVar( ImGuiStyleVar_FrameBorderSize, 1.0F );
            ImGui::PushStyleVar(
                ImGuiStyleVar_FramePadding,
                ImVec2( profile.frame_padding_x, profile.frame_padding_y ) );
            ImGui::PushStyleVar(
                ImGuiStyleVar_ItemSpacing,
                ImVec2( profile.item_spacing_x, profile.item_spacing_y ) );
            ImGui::PushStyleVar(
                ImGuiStyleVar_WindowPadding,
                ImVec2( profile.frame_padding_x * 2.0F,
                        profile.frame_padding_y * 2.0F ) );
            ImGui::PushStyleColor( ImGuiCol_ChildBg, ImVec4( 0.035F, 0.050F, 0.062F, 1.0F ) );
            ImGui::PushStyleColor( ImGuiCol_Border, ImVec4( 0.28F, 0.52F, 0.56F, 0.92F ) );
            ImGui::PushStyleColor( ImGuiCol_Button, ImVec4( 0.07F, 0.11F, 0.14F, 1.0F ) );
            ImGui::PushStyleColor( ImGuiCol_ButtonHovered, ImVec4( 0.10F, 0.32F, 0.35F, 1.0F ) );
            ImGui::PushStyleColor( ImGuiCol_ButtonActive, ImVec4( 0.14F, 0.43F, 0.46F, 1.0F ) );
            ImGui::PushStyleColor( ImGuiCol_Text, ImVec4( 0.92F, 0.95F, 0.96F, 1.0F ) );
            if( ImGui::BeginChild( "##adaptive_compact_dialog_panel",
                                   ImVec2( panel_width, panel_height ),
                                   ImGuiChildFlags_Borders ) ) {
                ImGui::TextUnformatted( title_.c_str() );
                ImGui::Separator();
                ImGui::TextWrapped( "%s", message_.c_str() );

                const float button_height = profile.row_normal;
                const float gap = profile.item_spacing_x;
                const float max_button_width = entries_.size() == 1 ?
                                               profile.width_normal :
                                               profile.width_wide;
                const float button_width = std::max(
                                               1.0F,
                                               std::min(
                                                   max_button_width,
                                                   ( panel_width -
                                                     profile.frame_padding_x * 4.0F - gap *
                                                     ( entries_.size() - 1 ) ) /
                                                   entries_.size() ) );
                const float row_width = button_width * entries_.size() +
                                        gap * ( entries_.size() - 1 );
                ImGui::SetCursorPosY(
                    panel_height - button_height - profile.frame_padding_y * 2.0F );
                ImGui::SetCursorPosX( ( panel_width - row_width ) * 0.5F );
                for( size_t index = 0; index < entries_.size(); ++index ) {
                    if( index > 0 ) {
                        ImGui::SameLine( 0.0F, gap );
                    }
                    ImGui::PushID( static_cast<int>( index ) );
                    const bool selected = selected_ == static_cast<int>( index );
                    if( !entries_[index].enabled ) {
                        ImGui::BeginDisabled();
                    }
                    if( selected ) {
                        ImGui::PushStyleColor(
                            ImGuiCol_Button,
                            entries_[index].danger ?
                            ImVec4( 0.48F, 0.10F, 0.08F, 1.0F ) :
                            ImVec4( 0.08F, 0.30F, 0.34F, 1.0F ) );
                        ImGui::PushStyleColor(
                            ImGuiCol_Border,
                            entries_[index].danger ?
                            ImVec4( 0.90F, 0.34F, 0.25F, 1.0F ) :
                            ImVec4( 0.32F, 0.72F, 0.75F, 1.0F ) );
                    } else if( entries_[index].danger ) {
                        ImGui::PushStyleColor( ImGuiCol_Button,
                                               ImVec4( 0.34F, 0.08F, 0.07F, 1.0F ) );
                    }
                    if( ImGui::Button( entries_[index].label.c_str(),
                                       ImVec2( button_width, button_height ) ) ) {
                        selected_ = static_cast<int>( index );
                        choices_.push_back( static_cast<int>( index ) );
                    }
                    if( entries_[index].enabled && ImGui::IsItemHovered() ) {
                        selected_ = static_cast<int>( index );
                    }
                    if( selected ) {
                        ImGui::PopStyleColor( 2 );
                    } else if( entries_[index].danger ) {
                        ImGui::PopStyleColor();
                    }
                    if( !entries_[index].enabled ) {
                        ImGui::EndDisabled();
                    }
                    ImGui::PopID();
                }
            }
            ImGui::EndChild();
            ImGui::PopStyleColor( 6 );
            ImGui::PopStyleVar( 6 );
            if( scaled_font ) {
                cataimgui::PopGuiFontScaled();
            }
        }

    private:
        std::string title_;
        std::string message_;
        std::vector<entry> entries_;
        int selected_ = 0;
        std::deque<int> choices_;

        void select_enabled_entry() {
            if( entries_.empty() ) {
                selected_ = -1;
                return;
            }
            selected_ = std::clamp( selected_, 0, static_cast<int>( entries_.size() ) - 1 );
            if( entries_[selected_].enabled ) {
                return;
            }
            for( size_t index = 0; index < entries_.size(); ++index ) {
                if( entries_[index].enabled ) {
                    selected_ = static_cast<int>( index );
                    return;
                }
            }
            selected_ = -1;
        }
};

std::optional<int> run_compact_dialog( const std::string &title, const std::string &message,
                                       const std::vector<entry> &entries,
                                       const int initial_selection = 0 )
{
    compact_dialog_window viewer( title, message, entries, initial_selection );
    input_context ctxt( "ADAPTIVE_IMGUI_CHOICE" );
    ctxt.register_action( "LEFT" );
    ctxt.register_action( "RIGHT" );
    ctxt.register_action( "UP" );
    ctxt.register_action( "DOWN" );
    ctxt.register_action( "CONFIRM" );
    ctxt.register_action( "QUIT" );
    while( true ) {
        ui_manager::redraw();
        if( const std::optional<int> choice = viewer.take_choice() ) {
            return choice;
        }
        const std::string action = ctxt.handle_input();
        if( action == "LEFT" || action == "UP" ) {
            viewer.move_selection( -1 );
        } else if( action == "RIGHT" || action == "DOWN" ) {
            viewer.move_selection( 1 );
        } else if( action == "CONFIRM" ) {
            viewer.activate_selection();
        } else if( action == "QUIT" ) {
            return std::nullopt;
        }
    }
}

} // namespace

std::optional<int> select( const std::string &title, const std::vector<entry> &entries,
                           const std::string &message, int initial_selection,
                           const std::string &hud_scene_id,
                           const std::string &hud_scene_title )
{
    if( entries.empty() ) {
        return std::nullopt;
    }
    initial_selection = std::clamp( initial_selection, 0, static_cast<int>( entries.size() ) - 1 );
    choice_window viewer( title, message, entries, initial_selection );
    input_context ctxt( "ADAPTIVE_IMGUI_CHOICE" );
#if defined(__ANDROID__)
    if( !hud_scene_id.empty() ) {
        ctxt.set_hud_scene( hud_scene_id, hud_scene_title.empty() ? title : hud_scene_title );
    }
#else
    ( void )hud_scene_id;
    ( void )hud_scene_title;
#endif
    ctxt.register_action( "QUIT" );
    ctxt.register_action( "UP" );
    ctxt.register_action( "DOWN" );
    ctxt.register_action( "PAGE_UP" );
    ctxt.register_action( "PAGE_DOWN" );
    ctxt.register_action( "CONFIRM" );
    ctxt.register_action( "SELECT" );
    ctxt.register_action( "MOUSE_MOVE" );

    while( true ) {
        ui_manager::redraw();
        if( const std::optional<int> choice = viewer.take_choice() ) {
            return choice;
        }
        if( viewer.take_cancel() ) {
            return std::nullopt;
        }
        const std::string action = ctxt.handle_input();
        if( action == "UP" ) {
            viewer.move_selection( -1 );
        } else if( action == "DOWN" ) {
            viewer.move_selection( 1 );
        } else if( action == "PAGE_UP" ) {
            viewer.move_selection( -5 );
        } else if( action == "PAGE_DOWN" ) {
            viewer.move_selection( 5 );
        } else if( action == "CONFIRM" ) {
            viewer.activate_selection();
        } else if( action == "QUIT" ) {
            return std::nullopt;
        }
    }
}

bool confirm( const std::string &title, const std::string &message,
              const std::string &confirm_label, const std::string &cancel_label,
              const bool danger )
{
    const std::vector<entry> entries = {
        { confirm_label, std::string(), true, danger },
        { cancel_label, std::string(), true, false }
    };
    const std::optional<int> result = run_compact_dialog( title, message, entries,
                                      danger ? 1 : 0 );
    return result && *result == 0;
}

void message( const std::string &title, const std::string &message,
              const std::string &button_label )
{
    const std::vector<entry> entries = {
        { button_label.empty() ? _( "OK" ) : button_label, std::string(), true, false }
    };
    run_compact_dialog( title, message, entries );
}

} // namespace adaptive_imgui_dialog

#endif // TILES
