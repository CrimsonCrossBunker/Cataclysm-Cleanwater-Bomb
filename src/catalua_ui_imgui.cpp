#include "catalua_ui_imgui.h"

#include <algorithm>
#include <optional>
#include <stdexcept>
#include <string>

#include "catalua_ui_renderer.h"
#include "imgui/imgui.h"
#include "imgui/imgui_stdlib.h"

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
    static_cast<std::uint32_t>( script_ui_capability::radial_selection );

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
        script_ui_renderer_info info() const override {
            return { "imgui", platform_name(), capability_mask, true, false };
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
            return ImGui::Button( widget_label( id, label ).c_str() );
        }

        bool small_button( const std::string &id, const std::string &label ) override {
            return ImGui::SmallButton( widget_label( id, label ).c_str() );
        }

        bool checkbox( const std::string &id, const std::string &label, bool value ) override {
            ImGui::Checkbox( widget_label( id, label ).c_str(), &value );
            return value;
        }

        bool radio_button( const std::string &id, const std::string &label,
                           bool active ) override {
            return ImGui::RadioButton( widget_label( id, label ).c_str(), active );
        }

        bool selectable( const std::string &id, const std::string &label,
                         bool selected ) override {
            return ImGui::Selectable( widget_label( id, label ).c_str(), selected );
        }

        int slider_int( const std::string &id, const std::string &label, int value, int minimum,
                        int maximum ) override {
            ImGui::SliderInt( widget_label( id, label ).c_str(), &value, minimum, maximum );
            return value;
        }

        double slider_float( const std::string &id, const std::string &label, double value,
                             double minimum, double maximum ) override {
            float result = static_cast<float>( value );
            ImGui::SliderFloat( widget_label( id, label ).c_str(), &result,
                                static_cast<float>( minimum ),
                                static_cast<float>( maximum ) );
            return result;
        }

        int input_int( const std::string &id, const std::string &label, int value ) override {
            ImGui::InputInt( widget_label( id, label ).c_str(), &value );
            return value;
        }

        double input_float( const std::string &id, const std::string &label,
                            double value ) override {
            float result = static_cast<float>( value );
            ImGui::InputFloat( widget_label( id, label ).c_str(), &result );
            return result;
        }

        std::string input_text( const std::string &id, const std::string &label,
                                const std::string &value ) override {
            std::string result = value;
            ImGui::InputText( widget_label( id, label ).c_str(), &result );
            return result;
        }

        std::string radial_select(
            const std::string &id, const std::string &center_label,
            const std::vector<script_ui_radial_option> &options ) override {
            const std::string popup_id = widget_label( id + "/popup", "radial" );
            if( ImGui::Button( widget_label( id, center_label ).c_str() ) ) {
                ImGui::OpenPopup( popup_id.c_str() );
            }
            std::string result;
            if( ImGui::BeginPopup( popup_id.c_str() ) ) {
                for( const script_ui_radial_option &option : options ) {
                    if( option.enabled ) {
                        if( ImGui::Selectable(
                                widget_label( id + "/" + option.id, option.label ).c_str(),
                                option.selected ) ) {
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

        void child( const std::string &id, double height,
                    const std::function<void()> &draw ) override {
            ImGui::BeginChild( widget_label( id, "" ).c_str(),
                               ImVec2( 0.0F, static_cast<float>( height ) ), true );
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
            if( !ImGui::BeginTabItem( widget_label( id, label ).c_str() ) ) {
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
            if( !ImGui::TreeNode( widget_label( id, label ).c_str() ) ) {
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
        int table_depth_ = 0;
        int tab_depth_ = 0;
};

} // namespace

std::unique_ptr<script_ui_renderer> make_imgui_script_ui_renderer()
{
    return std::make_unique<imgui_script_ui_renderer>();
}

} // namespace cata::lua_ui
