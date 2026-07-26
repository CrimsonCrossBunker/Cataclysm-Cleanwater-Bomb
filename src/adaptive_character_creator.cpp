#include "adaptive_character_creator.h"

#if defined(TILES)

#include <algorithm>
#include <array>
#include <cmath>
#include <utility>

#include "cata_utility.h"
#include "character_creator_ui.h"
#include "imgui/imgui.h"
#include "imgui/imgui_stdlib.h"
#include "translations.h"
#include "ui_profile.h"

adaptive_character_creator_ui::adaptive_character_creator_ui( detail_renderer render_details,
        preview_renderer render_preview ) :
    cataimgui::window( "Adaptive character creator",
                       ImGuiWindowFlags_NoTitleBar | ImGuiWindowFlags_NoCollapse |
                       ImGuiWindowFlags_NoResize | ImGuiWindowFlags_NoMove |
                       ImGuiWindowFlags_NoSavedSettings ),
    render_details_( std::move( render_details ) ),
    render_preview_( std::move( render_preview ) )
{
}

void adaptive_character_creator_ui::set_snapshot( adaptive_character_creator_snapshot next )
{
    if( !editing_name_ ) {
        name_input_ = next.name;
    }
    if( !editing_age_ ) {
        age_input_ = std::to_string( next.age );
    }
    if( !editing_height_ ) {
        height_input_ = std::to_string( next.height );
    }
    snapshot_ = std::move( next );
}

void adaptive_character_creator_ui::show_loading()
{
    snapshot_.ready = false;
    snapshot_.rows.clear();
}

std::optional<adaptive_character_creator_action> adaptive_character_creator_ui::take_action()
{
    if( actions_.empty() ) {
        return std::nullopt;
    }
    adaptive_character_creator_action result = std::move( actions_.front() );
    actions_.pop_front();
    return result;
}

cataimgui::bounds adaptive_character_creator_ui::get_bounds()
{
    const cata::ui::profile profile = cata::ui::current_profile();
    return profile.is_touch() ? cataimgui::bounds{ 0.0F, 0.0F, 1.0F, 1.0F } :
           cataimgui::bounds{ -1.0F, -1.0F, profile.page_width, profile.page_height };
}

void adaptive_character_creator_ui::draw_controls()
{
    const ImVec2 window_pos = ImGui::GetWindowPos();
    const ImVec2 window_size = ImGui::GetWindowSize();
    const cata::ui::profile profile = cata::ui::current_profile();
    const float edge_padding = std::max( profile.frame_padding_x,
                                         profile.item_spacing_x * 1.5F );
    const float footer_height = profile.row_wide;

    ImGui::GetWindowDrawList()->AddRectFilled(
        window_pos, ImVec2( window_pos.x + window_size.x, window_pos.y + window_size.y ),
        IM_COL32( 6, 9, 12, 255 ) );
    const bool scaled_font = profile.text_scale != 1.0F;
    if( scaled_font ) {
        cataimgui::PushGuiFontScaled( profile.text_scale );
    }
    ImGui::PushStyleVar( ImGuiStyleVar_FrameRounding, profile.corner_radius );
    ImGui::PushStyleVar(
        ImGuiStyleVar_FramePadding,
        ImVec2( profile.frame_padding_x, profile.frame_padding_y ) );
    ImGui::PushStyleVar(
        ImGuiStyleVar_ItemSpacing,
        ImVec2( profile.item_spacing_x, profile.item_spacing_y ) );
    ImGui::PushStyleVar(
        ImGuiStyleVar_WindowPadding,
        ImVec2( edge_padding, profile.frame_padding_y * 1.5F ) );
    ImGui::PushStyleColor( ImGuiCol_ChildBg, ImVec4( 0.035F, 0.050F, 0.062F, 0.98F ) );
    ImGui::PushStyleColor( ImGuiCol_Border, ImVec4( 0.22F, 0.36F, 0.40F, 0.78F ) );
    ImGui::PushStyleColor( ImGuiCol_Button, ImVec4( 0.065F, 0.085F, 0.105F, 1.0F ) );
    ImGui::PushStyleColor( ImGuiCol_ButtonHovered, ImVec4( 0.10F, 0.28F, 0.31F, 1.0F ) );
    ImGui::PushStyleColor( ImGuiCol_ButtonActive, ImVec4( 0.13F, 0.39F, 0.42F, 1.0F ) );
    ImGui::PushStyleColor( ImGuiCol_Text, ImVec4( 0.90F, 0.94F, 0.95F, 1.0F ) );

    if( !snapshot_.ready ) {
        draw_loading_page();
    } else {
        draw_identity_bar( profile );
        draw_tabs( profile );
        ImGui::Separator();
        if( snapshot_.tab == CHARCREATOR_SUMMARY ) {
            draw_summary_page( footer_height, profile );
        } else {
            draw_selection_page( footer_height, profile );
        }
        ImGui::Separator();
        draw_footer( profile );
    }

    ImGui::PopStyleColor( 6 );
    ImGui::PopStyleVar( 4 );
    if( scaled_font ) {
        cataimgui::PopGuiFontScaled();
    }
}

void adaptive_character_creator_ui::queue_command( const std::string &command )
{
    actions_.push_back( { adaptive_character_creator_action_type::command, 0, command, {} } );
}

void adaptive_character_creator_ui::queue_value(
    const adaptive_character_creator_action_type type, const std::string &value )
{
    actions_.push_back( { type, 0, {}, value } );
}

void adaptive_character_creator_ui::draw_loading_page()
{
    const ImVec2 available = ImGui::GetContentRegionAvail();
    const char *message = _( "Preparing character creator…" );
    const ImVec2 message_size = ImGui::CalcTextSize( message );
    ImGui::SetCursorPos( ImVec2( std::max( 0.0F, ( available.x - message_size.x ) * 0.5F ),
                                 std::max( 0.0F, ( available.y - message_size.y ) * 0.5F ) ) );
    ImGui::TextUnformatted( message );
}

void adaptive_character_creator_ui::draw_age_input( const char *id, const float width )
{
    ImGui::SetNextItemWidth( width );
    const bool submitted = ImGui::InputText( id, &age_input_,
                           ImGuiInputTextFlags_CharsDecimal |
                           ImGuiInputTextFlags_EnterReturnsTrue );
    const bool deactivated = ImGui::IsItemDeactivatedAfterEdit();
    editing_age_ = ImGui::IsItemActive();
    if( ( submitted || deactivated ) && age_input_ != std::to_string( snapshot_.age ) ) {
        queue_value( adaptive_character_creator_action_type::set_age, age_input_ );
    }
}

void adaptive_character_creator_ui::draw_height_input( const char *id, const float width )
{
    ImGui::SetNextItemWidth( width );
    const bool submitted = ImGui::InputText( id, &height_input_,
                           ImGuiInputTextFlags_CharsDecimal |
                           ImGuiInputTextFlags_EnterReturnsTrue );
    const bool deactivated = ImGui::IsItemDeactivatedAfterEdit();
    editing_height_ = ImGui::IsItemActive();
    if( ( submitted || deactivated ) && height_input_ != std::to_string( snapshot_.height ) ) {
        queue_value( adaptive_character_creator_action_type::set_height, height_input_ );
    }
}

bool adaptive_character_creator_ui::draw_template_save_controls(
    const cata::ui::profile &profile )
{
    ImGui::AlignTextToFramePadding();
    ImGui::TextUnformatted( _( "Name of template:" ) );
    ImGui::SameLine();
    ImGui::SetNextItemWidth( profile.width_normal );
    const bool submitted = ImGui::InputTextWithHint(
                               "##adaptive_character_template_name", _( "Name" ),
                               &template_name_input_, ImGuiInputTextFlags_EnterReturnsTrue );
    const bool valid_name = !template_name_input_.empty() &&
                            template_name_input_.find( '/' ) == std::string::npos;
    ImGui::SameLine();
    if( !valid_name ) {
        ImGui::BeginDisabled();
    }
    const bool save_clicked = ImGui::Button(
                                  _( "Save Template" ),
                                  ImVec2( profile.width_compact, profile.row_compact ) );
    if( !valid_name ) {
        ImGui::EndDisabled();
    }
    if( valid_name && ( submitted || save_clicked ) ) {
        queue_value( adaptive_character_creator_action_type::save_template,
                     template_name_input_ );
    }
    return true;
}

void adaptive_character_creator_ui::draw_summary_description_inputs(
    const cata::ui::profile &profile )
{
    ImGui::AlignTextToFramePadding();
    ImGui::TextUnformatted( _( "Age:" ) );
    ImGui::SameLine();
    draw_age_input( "##adaptive_character_summary_age",
                    profile.minimum_target * 1.8F );

    ImGui::AlignTextToFramePadding();
    ImGui::TextUnformatted( _( "Height:" ) );
    ImGui::SameLine();
    draw_height_input( "##adaptive_character_summary_height",
                       profile.minimum_target * 2.0F );
    ImGui::SameLine();
    ImGui::TextUnformatted( _( "cm" ) );

    if( ImGui::Button( _( "Blood type:" ),
                       ImVec2( profile.width_compact, profile.row_compact ) ) ) {
        queue_command( "CHANGE_BLOOD_TYPE" );
    }
    ImGui::SameLine();
    ImGui::AlignTextToFramePadding();
    ImGui::TextUnformatted( snapshot_.blood.c_str() );
}

void adaptive_character_creator_ui::draw_identity_bar( const cata::ui::profile &profile )
{
    const float row_height = profile.row_compact + profile.item_spacing_y;
    if( ImGui::BeginChild( "##adaptive_character_identity", ImVec2( 0.0F, row_height ),
                           ImGuiChildFlags_None,
                           ImGuiWindowFlags_HorizontalScrollbar |
                           ImGuiWindowFlags_NoScrollWithMouse ) ) {
        ImGui::AlignTextToFramePadding();
        ImGui::TextUnformatted( _( "Character" ) );
        ImGui::SameLine();
        ImGui::SetNextItemWidth( profile.width_normal );
        const bool submit_name = ImGui::InputTextWithHint(
                                     "##adaptive_character_name", _( "Name" ), &name_input_,
                                     ImGuiInputTextFlags_EnterReturnsTrue );
        const bool name_deactivated = ImGui::IsItemDeactivatedAfterEdit();
        editing_name_ = ImGui::IsItemActive();
        if( ( submit_name || name_deactivated ) && name_input_ != snapshot_.name ) {
            queue_value( adaptive_character_creator_action_type::set_name, name_input_ );
        }
        ImGui::SameLine();
        if( ImGui::Button( _( "Random" ),
                           ImVec2( profile.width_compact, profile.row_compact ) ) ) {
            queue_command( "RANDOMIZE_CHAR_NAME" );
        }
        ImGui::SameLine();
        if( ImGui::Button(
                snapshot_.gender.c_str(),
                ImVec2( profile.minimum_target * 2.5F, profile.row_compact ) ) ) {
            queue_command( "CHANGE_GENDER" );
        }
        if( profile.allow_swipe &&
            ImGui::IsWindowHovered( ImGuiHoveredFlags_AllowWhenBlockedByActiveItem ) &&
            ImGui::IsMouseDragging( ImGuiMouseButton_Left ) ) {
            ImGui::SetScrollX( ImGui::GetScrollX() - ImGui::GetIO().MouseDelta.x );
        }
    }
    ImGui::EndChild();

    if( ImGui::BeginChild( "##adaptive_character_quick_info", ImVec2( 0.0F, row_height ),
                           ImGuiChildFlags_None,
                           ImGuiWindowFlags_HorizontalScrollbar |
                           ImGuiWindowFlags_NoScrollWithMouse ) ) {
        bool has_previous_item = false;
        if( snapshot_.tab == CHARCREATOR_SUMMARY ) {
            has_previous_item = draw_template_save_controls( profile );
        } else {
            ImGui::AlignTextToFramePadding();
            ImGui::TextUnformatted( _( "Age:" ) );
            ImGui::SameLine();
            draw_age_input( "##adaptive_character_age",
                            profile.minimum_target * 1.8F );

            ImGui::SameLine();
            ImGui::AlignTextToFramePadding();
            ImGui::TextUnformatted( _( "Height:" ) );
            ImGui::SameLine();
            draw_height_input( "##adaptive_character_height",
                               profile.minimum_target * 2.0F );
            ImGui::SameLine();
            ImGui::AlignTextToFramePadding();
            ImGui::TextUnformatted( _( "cm" ) );
            has_previous_item = true;
        }

        const std::array<std::pair<std::string, std::string>, 3> buttons = {{
                { snapshot_.blood, "CHANGE_BLOOD_TYPE" },
                { _( "Location" ), "CHOOSE_LOCATION" },
                { _( "Randomize" ), "RANDOMIZE_CHAR_DESCRIPTION" },
            }
        };
        const std::array<float, 3> widths = {{
                profile.minimum_target * 2.5F,
                profile.width_compact,
                profile.width_normal
            }
        };
        for( size_t i = 0; i < buttons.size(); ++i ) {
            if( has_previous_item ) {
                ImGui::SameLine();
            }
            const std::string label = buttons[i].first + "###adaptive_character_quick_" +
                                      std::to_string( i );
            if( ImGui::Button(
                    label.c_str(), ImVec2( widths[i], profile.row_compact ) ) ) {
                queue_command( buttons[i].second );
            }
            has_previous_item = true;
        }
        if( profile.allow_swipe &&
            ImGui::IsWindowHovered( ImGuiHoveredFlags_AllowWhenBlockedByActiveItem ) &&
            ImGui::IsMouseDragging( ImGuiMouseButton_Left ) ) {
            ImGui::SetScrollX( ImGui::GetScrollX() - ImGui::GetIO().MouseDelta.x );
        }
    }
    ImGui::EndChild();
}

void adaptive_character_creator_ui::draw_tabs( const cata::ui::profile &profile )
{
    static const std::array<const char *, 7> labels = {{
            "Scenario", "Profession", "Background", "Stats", "Traits", "Skills", "Summary"
        }
    };
    if( ImGui::BeginChild(
            "##adaptive_character_tabs",
            ImVec2( 0.0F, profile.row_compact + profile.item_spacing_y ),
            ImGuiChildFlags_None,
            ImGuiWindowFlags_HorizontalScrollbar |
            ImGuiWindowFlags_NoScrollWithMouse ) ) {
        for( int i = 0; i < static_cast<int>( labels.size() ); ++i ) {
            if( i > 0 ) {
                ImGui::SameLine();
            }
            const bool selected = i == static_cast<int>( snapshot_.tab );
            if( selected ) {
                ImGui::PushStyleColor( ImGuiCol_Button, ImVec4( 0.08F, 0.30F, 0.34F, 1.0F ) );
                ImGui::PushStyleColor( ImGuiCol_Border, ImVec4( 0.32F, 0.72F, 0.75F, 1.0F ) );
            }
            const std::string translated = _( labels[i] );
            const float width = std::max(
                                    profile.minimum_target * 2.5F,
                                    ImGui::CalcTextSize( translated.c_str() ).x +
                                    profile.frame_padding_x * 2.0F );
            const std::string label = translated + "###adaptive_character_tab_" + std::to_string( i );
            if( ImGui::Button(
                    label.c_str(), ImVec2( width, profile.row_compact ) ) && !selected ) {
                actions_.push_back( { adaptive_character_creator_action_type::select_tab, i, {}, {} } );
                filter_.clear();
            }
            if( selected ) {
                ImGui::PopStyleColor( 2 );
            }
        }
        if( profile.allow_swipe &&
            ImGui::IsWindowHovered( ImGuiHoveredFlags_AllowWhenBlockedByActiveItem ) &&
            ImGui::IsMouseDragging( ImGuiMouseButton_Left ) ) {
            ImGui::SetScrollX( ImGui::GetScrollX() - ImGui::GetIO().MouseDelta.x );
        }
    }
    ImGui::EndChild();
}

bool adaptive_character_creator_ui::handle_vertical_drag(
    drag_state &state, const cata::ui::profile &profile )
{
    if( !profile.allow_swipe ) {
        return false;
    }
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
    const bool moved = std::hypot( distance.x, distance.y ) >
                       profile.frame_padding_x;
    if( ImGui::IsMouseDown( ImGuiMouseButton_Left ) &&
        std::abs( distance.y ) > std::abs( distance.x ) ) {
        ImGui::SetScrollY( ImGui::GetScrollY() - io.MouseDelta.y );
    }
    if( ImGui::IsMouseReleased( ImGuiMouseButton_Left ) ) {
        state.active = false;
    }
    return moved;
}

void adaptive_character_creator_ui::draw_selection_page(
    const float footer_height, const cata::ui::profile &profile )
{
    const float content_width = ImGui::GetContentRegionAvail().x;
    const float column_gap = ImGui::GetStyle().ItemSpacing.x;
    const bool show_preview = snapshot_.preview_available && render_preview_ &&
                              profile.breakpoint_for_width( content_width ) !=
                              cata::ui::layout_breakpoint::narrow;
    const float list_fraction = show_preview ? 0.35F : 0.39F;
    const float reserved_width = profile.width_compact * ( show_preview ? 2.0F : 1.0F ) +
                                 column_gap * ( show_preview ? 2.0F : 1.0F );
    const float list_width_max = std::max(
                                     1.0F,
                                     std::min( profile.panel_wide,
                                             content_width - reserved_width ) );
    const float list_width_min = std::min( profile.panel_normal, list_width_max );
    const float list_width = std::clamp(
                                 content_width * list_fraction,
                                 list_width_min, list_width_max );
    const float preview_width = show_preview ?
                                std::clamp( content_width * 0.18F,
                                            profile.width_compact,
                                            profile.width_normal ) : 0.0F;
    if( ImGui::BeginChild( "##adaptive_character_list", ImVec2( list_width, -footer_height ),
                           ImGuiChildFlags_Borders ) ) {
        ImGui::TextUnformatted( _( "Search:" ) );
        ImGui::SameLine();
        ImGui::SetNextItemWidth( -1.0F );
        ImGui::InputText( "##adaptive_character_filter", &filter_ );
        ImGui::Separator();
        if( ImGui::BeginChild( "##adaptive_character_rows", ImVec2( 0.0F, 0.0F ),
                               ImGuiChildFlags_None,
                               ImGuiWindowFlags_AlwaysVerticalScrollbar ) ) {
            const bool suppress_click = handle_vertical_drag( list_drag_, profile );
            for( const adaptive_character_creator_row_snapshot &row : snapshot_.rows ) {
                if( !filter_.empty() && !lcmatch( row.label, filter_ ) ) {
                    continue;
                }
                ImGui::PushID( row.index );
                if( !row.enabled ) {
                    ImGui::BeginDisabled();
                }
                if( row.selected ) {
                    ImGui::PushStyleColor( ImGuiCol_Button, ImVec4( 0.08F, 0.30F, 0.34F, 1.0F ) );
                    ImGui::PushStyleColor( ImGuiCol_Border, ImVec4( 0.32F, 0.72F, 0.75F, 1.0F ) );
                }
                const std::string prefix = row.active ? "✓  " : "";
                if( ImGui::Button( ( prefix + row.label + "###row" ).c_str(),
                                   ImVec2( -1.0F, profile.row_compact ) ) &&
                    !suppress_click ) {
                    actions_.push_back( { adaptive_character_creator_action_type::select_row,
                                          row.index, {}, {} } );
                }
                if( row.selected ) {
                    ImGui::PopStyleColor( 2 );
                }
                if( !row.enabled ) {
                    ImGui::EndDisabled();
                }
                ImGui::PopID();
            }
        }
        ImGui::EndChild();
    }
    ImGui::EndChild();

    ImGui::SameLine();
    const float detail_width = show_preview ? -preview_width - column_gap : 0.0F;
    if( ImGui::BeginChild( "##adaptive_character_detail", ImVec2( detail_width, -footer_height ),
                           ImGuiChildFlags_Borders,
                           ImGuiWindowFlags_AlwaysVerticalScrollbar ) ) {
        handle_vertical_drag( detail_drag_, profile );
        draw_current_details( profile );
    }
    ImGui::EndChild();

    if( show_preview ) {
        ImGui::SameLine();
        draw_preview_panel( -footer_height );
    }
}

void adaptive_character_creator_ui::draw_preview_panel( const float height )
{
    if( ImGui::BeginChild( "##adaptive_character_preview", ImVec2( 0.0F, height ),
                           ImGuiChildFlags_Borders,
                           ImGuiWindowFlags_NoScrollbar | ImGuiWindowFlags_NoScrollWithMouse ) ) {
        ImGui::TextUnformatted( _( "Preview" ) );
        ImGui::Separator();
        render_preview_( ImGui::GetContentRegionAvail() );
    }
    ImGui::EndChild();
}

const adaptive_character_creator_row_snapshot *adaptive_character_creator_ui::selected_row() const
{
    const auto found = std::find_if( snapshot_.rows.begin(), snapshot_.rows.end(),
    []( const adaptive_character_creator_row_snapshot & row ) {
        return row.selected;
    } );
    return found == snapshot_.rows.end() ? nullptr : &*found;
}

void adaptive_character_creator_ui::draw_current_details( const cata::ui::profile &profile )
{
    const adaptive_character_creator_row_snapshot *row = selected_row();
    if( row == nullptr ) {
        ImGui::TextWrapped( "%s", _( "Select an entry to view its details." ) );
        return;
    }

    ImGui::TextWrapped( "%s", row->label.c_str() );
    ImGui::Separator();
    render_details_( snapshot_.tab, {} );
    ImGui::Dummy( ImVec2( 0.0F, profile.item_spacing_y ) );

    if( snapshot_.tab == CHARCREATOR_STATS || snapshot_.tab == CHARCREATOR_SKILLS ) {
        if( ImGui::Button(
                _( "−" ),
                ImVec2( profile.minimum_target * 2.0F, profile.row_compact ) ) ) {
            queue_command( "DECREASE_VALUE" );
        }
        ImGui::SameLine();
        if( ImGui::Button(
                _( "+" ),
                ImVec2( profile.minimum_target * 2.0F, profile.row_compact ) ) ) {
            queue_command( "INCREASE_VALUE" );
        }
        return;
    }

    const bool toggle = snapshot_.tab == CHARCREATOR_BACKGROUND ||
                        snapshot_.tab == CHARCREATOR_TRAITS;
    const std::string label = toggle ? ( row->active ? _( "Remove" ) : _( "Add" ) ) :
                              _( "Select" );
    if( !row->enabled ) {
        ImGui::BeginDisabled();
    }
    if( ImGui::Button(
            label.c_str(),
            ImVec2( profile.width_normal, profile.row_compact ) ) ) {
        actions_.push_back( { adaptive_character_creator_action_type::activate_row,
                              row->index, {}, {} } );
    }
    if( !row->enabled ) {
        ImGui::EndDisabled();
    }
}

void adaptive_character_creator_ui::draw_summary_page(
    const float footer_height, const cata::ui::profile &profile )
{
    const float content_width = ImGui::GetContentRegionAvail().x;
    const bool show_preview = snapshot_.preview_available && render_preview_ &&
                              profile.breakpoint_for_width( content_width ) !=
                              cata::ui::layout_breakpoint::narrow;
    const float preview_width = show_preview ?
                                std::clamp( content_width * 0.20F,
                                            profile.width_compact,
                                            profile.width_normal ) : 0.0F;
    const float column_gap = ImGui::GetStyle().ItemSpacing.x;
    const float summary_width = show_preview ? -preview_width - column_gap : 0.0F;
    if( ImGui::BeginChild( "##adaptive_character_summary", ImVec2( summary_width, -footer_height ),
                           ImGuiChildFlags_Borders,
                           ImGuiWindowFlags_AlwaysVerticalScrollbar ) ) {
        handle_vertical_drag( summary_drag_, profile );
        const inline_renderer draw_description_inputs = [this, &profile]() {
            draw_summary_description_inputs( profile );
        };
        render_details_( CHARCREATOR_SUMMARY, draw_description_inputs );
    }
    ImGui::EndChild();

    if( show_preview ) {
        ImGui::SameLine();
        draw_preview_panel( -footer_height );
    }
}

void adaptive_character_creator_ui::draw_footer( const cata::ui::profile &profile )
{
    const float gap = profile.item_spacing_x;
    const float width = std::max(
                            1.0F,
                            ( ImGui::GetContentRegionAvail().x - gap * 2.0F ) / 3.0F );
    if( ImGui::Button( _( "Return" ),
                       ImVec2( width, profile.row_compact ) ) ) {
        queue_command( "QUIT" );
    }
    ImGui::SameLine( 0.0F, gap );
    if( snapshot_.tab == CHARCREATOR_SCENARIO ) {
        ImGui::BeginDisabled();
    }
    if( ImGui::Button( _( "Previous" ),
                       ImVec2( width, profile.row_compact ) ) ) {
        queue_command( "PREV_TAB" );
    }
    if( snapshot_.tab == CHARCREATOR_SCENARIO ) {
        ImGui::EndDisabled();
    }
    ImGui::SameLine( 0.0F, gap );
    const char *next_label = snapshot_.tab == CHARCREATOR_SUMMARY ? _( "Finish" ) : _( "Next" );
    if( ImGui::Button( next_label,
                       ImVec2( width, profile.row_compact ) ) ) {
        queue_command( "NEXT_TAB" );
    }
}

#endif // TILES
