#include "android_imgui_dialog.h"

#if defined(__ANDROID__)

#include <algorithm>
#include <cmath>
#include <deque>
#include <utility>

#include "cata_imgui.h"
#include "imgui/imgui.h"
#include "input_context.h"
#include "translations.h"
#include "ui_manager.h"

namespace android_imgui_dialog
{
namespace
{

class choice_window : public cataimgui::window
{
    public:
        choice_window( std::string title, std::string message,
                       std::vector<entry> entries, int initial_selection ) :
            cataimgui::window( "Android ImGui choice dialog",
                               ImGuiWindowFlags_NoTitleBar | ImGuiWindowFlags_NoCollapse |
                               ImGuiWindowFlags_NoResize | ImGuiWindowFlags_NoMove |
                               ImGuiWindowFlags_NoSavedSettings ),
            title_( std::move( title ) ), message_( std::move( message ) ),
            entries_( std::move( entries ) ), selected_( initial_selection ) {}

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

    protected:
        cataimgui::bounds get_bounds() override {
            return { 0.0F, 0.0F, 1.0F, 1.0F };
        }

        void draw_controls() override {
            const ImVec2 window_pos = ImGui::GetWindowPos();
            const ImVec2 window_size = ImGui::GetWindowSize();
            const float edge_padding = std::clamp( window_size.x * 0.025F, 18.0F, 42.0F );
            constexpr float footer_height = 68.0F;

            ImGui::GetWindowDrawList()->AddRectFilled(
                window_pos, ImVec2( window_pos.x + window_size.x, window_pos.y + window_size.y ),
                IM_COL32( 6, 9, 12, 255 ) );
            cataimgui::PushGuiFont1_5x();
            ImGui::PushStyleVar( ImGuiStyleVar_FrameRounding, 8.0F );
            ImGui::PushStyleVar( ImGuiStyleVar_FrameBorderSize, 1.0F );
            ImGui::PushStyleVar( ImGuiStyleVar_FramePadding, ImVec2( 14.0F, 10.0F ) );
            ImGui::PushStyleVar( ImGuiStyleVar_ItemSpacing, ImVec2( 8.0F, 8.0F ) );
            ImGui::PushStyleVar( ImGuiStyleVar_WindowPadding, ImVec2( edge_padding, 14.0F ) );
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

            if( ImGui::BeginChild( "##android_choice_entries", ImVec2( 0.0F, -footer_height ),
                                   ImGuiChildFlags_Borders,
                                   ImGuiWindowFlags_AlwaysVerticalScrollbar ) ) {
                const bool suppress_click = handle_vertical_drag();
                for( size_t index = 0; index < entries_.size(); ++index ) {
                    draw_entry( static_cast<int>( index ), entries_[index], suppress_click );
                }
            }
            ImGui::EndChild();

            ImGui::Separator();
            const float button_width = std::clamp( window_size.x * 0.22F, 220.0F, 380.0F );
            ImGui::SetCursorPosX( std::max( edge_padding,
                                            window_size.x - edge_padding - button_width ) );
            if( ImGui::Button( _( "Back" ), ImVec2( button_width, 50.0F ) ) ) {
                cancel_requested_ = true;
            }

            ImGui::PopStyleColor( 6 );
            ImGui::PopStyleVar( 5 );
            cataimgui::PopGuiFont1_5x();
        }

    private:
        std::string title_;
        std::string message_;
        std::vector<entry> entries_;
        int selected_ = 0;
        std::deque<int> choices_;
        bool cancel_requested_ = false;
        bool dragging_ = false;
        ImVec2 drag_start_;

        bool handle_vertical_drag() {
            ImGuiIO &io = ImGui::GetIO();
            if( ImGui::IsWindowHovered( ImGuiHoveredFlags_AllowWhenBlockedByActiveItem ) &&
                ImGui::IsMouseClicked( ImGuiMouseButton_Left ) ) {
                dragging_ = true;
                drag_start_ = io.MousePos;
            }
            if( !dragging_ ) {
                return false;
            }
            const ImVec2 distance( io.MousePos.x - drag_start_.x,
                                   io.MousePos.y - drag_start_.y );
            const bool moved = std::hypot( distance.x, distance.y ) > 14.0F;
            if( ImGui::IsMouseDown( ImGuiMouseButton_Left ) &&
                std::abs( distance.y ) > std::abs( distance.x ) ) {
                ImGui::SetScrollY( ImGui::GetScrollY() - io.MouseDelta.y );
            }
            if( ImGui::IsMouseReleased( ImGuiMouseButton_Left ) ) {
                dragging_ = false;
            }
            return moved;
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
            const std::string label = item.label + "###android_choice_entry";
            if( ImGui::Button( label.c_str(), ImVec2( -1.0F, 52.0F ) ) && !suppress_click ) {
                selected_ = index;
                choices_.push_back( index );
            }
            if( selected || item.danger ) {
                ImGui::PopStyleColor( 2 );
            }
            if( !item.description.empty() ) {
                ImGui::Indent( 10.0F );
                ImGui::TextWrapped( "%s", item.description.c_str() );
                ImGui::Unindent( 10.0F );
            }
            if( !item.enabled ) {
                ImGui::EndDisabled();
            }
            ImGui::Separator();
            ImGui::PopID();
        }
};

} // namespace

std::optional<int> select( const std::string &title, const std::vector<entry> &entries,
                           const std::string &message, int initial_selection )
{
    if( entries.empty() ) {
        return std::nullopt;
    }
    initial_selection = std::clamp( initial_selection, 0, static_cast<int>( entries.size() ) - 1 );
    choice_window viewer( title, message, entries, initial_selection );
    input_context ctxt( "ANDROID_IMGUI_CHOICE" );
    ctxt.register_action( "QUIT" );
    ctxt.register_action( "SELECT" );
    ctxt.register_action( "MOUSE_MOVE" );

    while( true ) {
        ui_manager::redraw();
        if( const std::optional<int> choice = viewer.take_choice() ) {
            return choice;
        }
        if( viewer.take_cancel() || ctxt.handle_input() == "QUIT" ) {
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
    const std::optional<int> result = select( title, entries, message, 1 );
    return result && *result == 0;
}

} // namespace android_imgui_dialog

#endif // __ANDROID__
