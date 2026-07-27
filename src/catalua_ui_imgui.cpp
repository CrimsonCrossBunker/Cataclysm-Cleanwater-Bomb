#include "catalua_ui_imgui.h"

#include <algorithm>
#include <optional>
#include <stdexcept>
#include <string>

#include "cata_imgui.h"
#include "catalua_ui_renderer.h"
#include "imgui/imgui.h"
#include "imgui/imgui_stdlib.h"
#include "input_context_actions.h"
#include "ui_profile.h"

namespace cata::lua_ui
{

namespace
{

constexpr std::uint32_t capability_mask =
    static_cast<std::uint32_t>( script_ui_capability::colored_text ) |
    static_cast<std::uint32_t>( script_ui_capability::inline_layout ) |
    static_cast<std::uint32_t>( script_ui_capability::item_width ) |
    static_cast<std::uint32_t>( script_ui_capability::progress_bar ) |
    static_cast<std::uint32_t>( script_ui_capability::buttons ) |
    static_cast<std::uint32_t>( script_ui_capability::selection ) |
    static_cast<std::uint32_t>( script_ui_capability::numeric_input ) |
    static_cast<std::uint32_t>( script_ui_capability::text_input ) |
    static_cast<std::uint32_t>( script_ui_capability::child_regions ) |
    static_cast<std::uint32_t>( script_ui_capability::tables ) |
    static_cast<std::uint32_t>( script_ui_capability::tabs ) |
    static_cast<std::uint32_t>( script_ui_capability::trees ) |
    static_cast<std::uint32_t>( script_ui_capability::modals ) |
    static_cast<std::uint32_t>( script_ui_capability::tooltips ) |
    static_cast<std::uint32_t>( script_ui_capability::virtualization ) |
    static_cast<std::uint32_t>( script_ui_capability::radial_selection ) |
    static_cast<std::uint32_t>( script_ui_capability::action_slots );

constexpr std::string_view platform_name()
{
#if defined(TILES)
#if defined(USE_SDL3)
    return "sdl3";
#else
    return "sdl2";
#endif
#else
    return "imtui";
#endif
}

std::string widget_label( const std::string &id, const std::string &label )
{
    return label + "###lua_widget_" + id;
}

class imgui_script_ui_renderer final : public script_ui_renderer
{
    public:
        imgui_script_ui_renderer() : profile_( cata::ui::current_profile() ) {}

        script_ui_renderer_info info() const override {
            return { "imgui", platform_name(), capability_mask, true, false };
        }

        double available_width() const override {
            return ImGui::GetContentRegionAvail().x;
        }

        void text( const std::string &value ) override {
            ImGui::TextWrapped( "%s", value.c_str() );
        }

        void heading( const std::string &value ) override {
            ImGui::SeparatorText( value.c_str() );
        }

        void bullet_text( const std::string &value ) override {
            ImGui::BulletText( "%s", value.c_str() );
        }

        void disabled_text( const std::string &value ) override {
            ImGui::TextDisabled( "%s", value.c_str() );
        }

        void text_colored( const std::string &value, double red, double green, double blue,
                           double alpha ) override {
            ImGui::TextColored( ImVec4( static_cast<float>( red ), static_cast<float>( green ),
                                        static_cast<float>( blue ), static_cast<float>( alpha ) ),
                                "%s", value.c_str() );
        }

        void separator() override {
            ImGui::Separator();
        }

        void same_line() override {
            ImGui::SameLine();
        }

        void new_line() override {
            ImGui::NewLine();
        }

        void spacing() override {
            ImGui::Spacing();
        }

        void set_next_item_width( double width ) override {
            ImGui::SetNextItemWidth( static_cast<float>( width ) );
        }

        void progress_bar( double fraction,
                           const std::optional<std::string> &overlay ) override {
            const float clamped = static_cast<float>( std::clamp( fraction, 0.0, 1.0 ) );
            if( overlay ) {
                ImGui::ProgressBar( clamped, ImVec2( -1.0F, 0.0F ), overlay->c_str() );
            } else {
                ImGui::ProgressBar( clamped, ImVec2( -1.0F, 0.0F ) );
            }
        }

        bool button( const std::string &id, const std::string &label ) override {
            const bool activated = ImGui::Button(
                                       widget_label( id, label ).c_str(),
                                       ImVec2( 0.0F, touch_target_height() ) );
            return activated && !cataimgui::interaction_suppressed();
        }

        bool small_button( const std::string &id, const std::string &label ) override {
            if( profile_.is_touch() ) {
                return button( id, label );
            }
            const bool activated =
                ImGui::SmallButton( widget_label( id, label ).c_str() );
            return activated && !cataimgui::interaction_suppressed();
        }

        bool checkbox( const std::string &id, const std::string &label, bool value ) override {
            const bool original = value;
            ImGui::Checkbox( widget_label( id, label ).c_str(), &value );
            return cataimgui::interaction_suppressed() ? original : value;
        }

        bool radio_button( const std::string &id, const std::string &label,
                           bool active ) override {
            const bool activated =
                ImGui::RadioButton( widget_label( id, label ).c_str(), active );
            return activated && !cataimgui::interaction_suppressed();
        }

        bool selectable( const std::string &id, const std::string &label,
                         bool selected ) override {
            const bool activated = ImGui::Selectable(
                                       widget_label( id, label ).c_str(), selected, 0,
                                       ImVec2( 0.0F, touch_target_height() ) );
            return activated && !cataimgui::interaction_suppressed();
        }

        int slider_int( const std::string &id, const std::string &label, int value, int minimum,
                        int maximum ) override {
            const int original = value;
            ImGui::SliderInt( widget_label( id, label ).c_str(), &value, minimum, maximum );
            return cataimgui::interaction_suppressed() ? original : value;
        }

        double slider_float( const std::string &id, const std::string &label, double value,
                             double minimum, double maximum ) override {
            const double original = value;
            float result = static_cast<float>( value );
            ImGui::SliderFloat( widget_label( id, label ).c_str(), &result,
                                static_cast<float>( minimum ),
                                static_cast<float>( maximum ) );
            return cataimgui::interaction_suppressed() ? original : result;
        }

        int input_int( const std::string &id, const std::string &label, int value ) override {
            const int original = value;
            ImGui::InputInt( widget_label( id, label ).c_str(), &value );
            return cataimgui::interaction_suppressed() ? original : value;
        }

        double input_float( const std::string &id, const std::string &label,
                            double value ) override {
            const double original = value;
            float result = static_cast<float>( value );
            ImGui::InputFloat( widget_label( id, label ).c_str(), &result );
            return cataimgui::interaction_suppressed() ? original : result;
        }

        std::string input_text( const std::string &id, const std::string &label,
                                const std::string &value ) override {
            std::string result = value;
            ImGui::InputText( widget_label( id, label ).c_str(), &result );
            return cataimgui::interaction_suppressed() ? value : result;
        }

        std::string radial_select(
            const std::string &id, const std::string &center_label,
            const std::vector<script_ui_radial_option> &options ) override {
            const std::string popup_id = widget_label( id + "/popup", "radial" );
            if( ImGui::Button(
                    widget_label( id, center_label ).c_str(),
                    ImVec2( 0.0F, touch_target_height() ) ) &&
                !cataimgui::interaction_suppressed() ) {
                ImGui::OpenPopup( popup_id.c_str() );
            }
            std::string result;
            if( ImGui::BeginPopup( popup_id.c_str() ) ) {
                for( const script_ui_radial_option &option : options ) {
                    if( option.enabled ) {
                        if( ImGui::Selectable(
                                widget_label( id + "/" + option.id, option.label ).c_str(),
                                option.selected, 0,
                                ImVec2( 0.0F, touch_target_height() ) ) &&
                            !cataimgui::interaction_suppressed() ) {
                            result = option.id;
                            ImGui::CloseCurrentPopup();
                        }
                    } else {
                        ImGui::TextDisabled( "%s", option.label.c_str() );
                    }
                }
                ImGui::EndPopup();
            }
            return result;
        }

        std::string action_slot(
            const std::string &id, const std::string &selected_action,
            const int context_revision,
            const std::vector<script_ui_action_option> &options ) override {
            std::vector<const script_ui_action_option *> available;
            available.reserve( options.size() );
            for( const script_ui_action_option &option : options ) {
                if( option.enabled ) {
                    available.push_back( &option );
                }
            }
            if( available.empty() ) {
                ImGui::BeginDisabled();
                ImGui::Button(
                    widget_label( id, "—" ).c_str(),
                    ImVec2( -1.0F, touch_target_height() ) );
                ImGui::EndDisabled();
                return {};
            }

            auto selected = std::find_if( available.begin(), available.end(),
            [&]( const script_ui_action_option * option ) {
                return option->id == selected_action;
            } );
            const script_ui_action_option *current =
                selected == available.end() ? available.front() : *selected;
            const std::string popup_id = widget_label( id + "/popup", "actions" );
            const bool has_selector = available.size() > 1;
            ImVec2 trigger_size( -1.0F, touch_target_height() );
            float selector_width = 0.0F;
            if( has_selector ) {
                selector_width = std::max(
                                     ImGui::GetFrameHeight(), touch_target_height() );
                trigger_size.x = std::max(
                                     1.0F, ImGui::GetContentRegionAvail().x - selector_width -
                                     ImGui::GetStyle().ItemSpacing.x );
            }
            if( ImGui::Button( widget_label( id + "/trigger", current->label ).c_str(),
                               trigger_size ) &&
                !cataimgui::interaction_suppressed() ) {
                if( current->activate ) {
                    current->activate();
                } else {
                    cata::input_context_actions::enqueue(
                        current->id, context_revision );
                }
            }

            std::string result = current->id;
            if( has_selector ) {
                ImGui::SameLine();
                if( ImGui::Button( widget_label( id + "/selector", "▾" ).c_str(),
                                   ImVec2( selector_width, touch_target_height() ) ) &&
                    !cataimgui::interaction_suppressed() ) {
                    ImGui::OpenPopup( popup_id.c_str() );
                }
                if( ImGui::BeginPopup( popup_id.c_str() ) ) {
                    for( const script_ui_action_option *option : available ) {
                        if( ImGui::Selectable(
                                widget_label( id + "/" + option->id, option->label ).c_str(),
                                option == current, 0,
                                ImVec2( 0.0F, touch_target_height() ) ) &&
                            !cataimgui::interaction_suppressed() ) {
                            result = option->id;
                            ImGui::CloseCurrentPopup();
                        }
                    }
                    ImGui::EndPopup();
                }
            }
            return result;
        }

        void child( const std::string &id, double height,
                    const std::function<void()> &draw ) override {
            ImGui::BeginChild( widget_label( id, "" ).c_str(),
                               ImVec2( 0.0F, static_cast<float>( height ) ), true );
            const bool suppress_interaction = cataimgui::handle_vertical_swipe(
                                                  profile_.allow_swipe,
                                                  profile_.frame_padding_x );
            const cataimgui::scoped_interaction_suppression suppression(
                suppress_interaction );
            try {
                draw();
            } catch( ... ) {
                ImGui::EndChild();
                throw;
            }
            ImGui::EndChild();
        }

        void table( const std::string &id, int columns,
                    const std::function<void()> &draw ) override {
            if( !ImGui::BeginTable( widget_label( id, "" ).c_str(), columns,
                                    ImGuiTableFlags_Borders | ImGuiTableFlags_RowBg |
                                    ImGuiTableFlags_Resizable ) ) {
                return;
            }
            ++table_depth_;
            try {
                draw();
            } catch( ... ) {
                --table_depth_;
                ImGui::EndTable();
                throw;
            }
            --table_depth_;
            ImGui::EndTable();
        }

        void table_next_row() override {
            if( table_depth_ == 0 ) {
                throw std::runtime_error( "ctx:table_next_row must be called inside ctx:table" );
            }
            ImGui::TableNextRow();
        }

        bool table_next_column() override {
            if( table_depth_ == 0 ) {
                throw std::runtime_error( "ctx:table_next_column must be called inside ctx:table" );
            }
            return ImGui::TableNextColumn();
        }

        void tabs( const std::string &id, const std::function<void()> &draw ) override {
            if( !ImGui::BeginTabBar( widget_label( id, "" ).c_str() ) ) {
                return;
            }
            ++tab_depth_;
            try {
                draw();
            } catch( ... ) {
                --tab_depth_;
                ImGui::EndTabBar();
                throw;
            }
            --tab_depth_;
            ImGui::EndTabBar();
        }

        bool tab( const std::string &id, const std::string &label,
                  const std::function<void()> &draw ) override {
            if( tab_depth_ == 0 ) {
                throw std::runtime_error( "ctx:tab must be called inside ctx:tabs" );
            }
            const bool suppressed = cataimgui::interaction_suppressed();
            if( suppressed ) {
                ImGui::BeginDisabled();
            }
            const bool open =
                ImGui::BeginTabItem( widget_label( id, label ).c_str() );
            if( suppressed ) {
                ImGui::EndDisabled();
            }
            if( !open ) {
                return false;
            }
            try {
                draw();
            } catch( ... ) {
                ImGui::EndTabItem();
                throw;
            }
            ImGui::EndTabItem();
            return true;
        }

        bool tree( const std::string &id, const std::string &label, bool default_open,
                   const std::function<void()> &draw ) override {
            ImGui::SetNextItemOpen( default_open, ImGuiCond_Once );
            const bool suppressed = cataimgui::interaction_suppressed();
            if( suppressed ) {
                ImGui::BeginDisabled();
            }
            const bool open =
                ImGui::TreeNode( widget_label( id, label ).c_str() );
            if( suppressed ) {
                ImGui::EndDisabled();
            }
            if( !open ) {
                return false;
            }
            try {
                draw();
            } catch( ... ) {
                ImGui::TreePop();
                throw;
            }
            ImGui::TreePop();
            return true;
        }

        bool modal( const std::string &id, const std::string &title, bool open,
                    const std::function<void()> &draw ) override {
            const std::string popup_id = widget_label( id, title );
            if( !open ) {
                return false;
            }
            ImGui::OpenPopup( popup_id.c_str() );
            bool remains_open = true;
            if( ImGui::BeginPopupModal( popup_id.c_str(), &remains_open,
                                        ImGuiWindowFlags_AlwaysAutoResize ) ) {
                try {
                    draw();
                } catch( ... ) {
                    ImGui::EndPopup();
                    throw;
                }
                ImGui::EndPopup();
            }
            return remains_open && ImGui::IsPopupOpen( popup_id.c_str() );
        }

        void tooltip( const std::string &text ) override {
            if( ImGui::IsItemHovered( ImGuiHoveredFlags_DelayNormal ) ) {
                ImGui::SetTooltip( "%s", text.c_str() );
            }
        }

        void virtual_list( int item_count, double item_height,
                           const std::function<void( int, int )> &draw_range ) override {
            ImGuiListClipper clipper;
            clipper.Begin( item_count, static_cast<float>( item_height ) );
            while( clipper.Step() ) {
                draw_range( clipper.DisplayStart, clipper.DisplayEnd );
            }
        }

    private:
        float touch_target_height() const {
            return profile_.is_touch() ? profile_.minimum_target : 0.0F;
        }

        const cata::ui::profile profile_;
        int table_depth_ = 0;
        int tab_depth_ = 0;
};

} // namespace

std::unique_ptr<script_ui_renderer> make_imgui_script_ui_renderer()
{
    return std::make_unique<imgui_script_ui_renderer>();
}

} // namespace cata::lua_ui
