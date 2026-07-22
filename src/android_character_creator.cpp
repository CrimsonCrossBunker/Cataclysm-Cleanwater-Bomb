#include "android_character_creator.h"

#if defined(__ANDROID__)

#include <algorithm>
#include <array>
#include <cmath>
#include <utility>

#include "cata_utility.h"
#include "character_creator_ui.h"
#include "imgui/imgui.h"
#include "imgui/imgui_stdlib.h"
#include "translations.h"

android_character_creator_ui::android_character_creator_ui( detail_renderer render_details ) :
    cataimgui::window( "Android character creator",
                       ImGuiWindowFlags_NoTitleBar | ImGuiWindowFlags_NoCollapse |
                       ImGuiWindowFlags_NoResize | ImGuiWindowFlags_NoMove |
                       ImGuiWindowFlags_NoSavedSettings ),
    render_details_( std::move( render_details ) )
{
}

void android_character_creator_ui::set_snapshot( android_character_creator_snapshot next )
{
    snapshot_ = std::move( next );
}

void android_character_creator_ui::show_loading()
{
    snapshot_.ready = false;
    snapshot_.rows.clear();
}

std::optional<android_character_creator_action> android_character_creator_ui::take_action()
{
    if( actions_.empty() ) {
        return std::nullopt;
    }
    android_character_creator_action result = std::move( actions_.front() );
    actions_.pop_front();
    return result;
}

cataimgui::bounds android_character_creator_ui::get_bounds()
{
    return { 0.0F, 0.0F, 1.0F, 1.0F };
}

void android_character_creator_ui::draw_controls()
{
    const ImVec2 window_pos = ImGui::GetWindowPos();
    const ImVec2 window_size = ImGui::GetWindowSize();
    const float edge_padding = std::clamp( window_size.x * 0.018F, 14.0F, 28.0F );
    constexpr float footer_height = 64.0F;

    ImGui::GetWindowDrawList()->AddRectFilled(
        window_pos, ImVec2( window_pos.x + window_size.x, window_pos.y + window_size.y ),
        IM_COL32( 6, 9, 12, 255 ) );
    cataimgui::PushGuiFont1_5x();
    ImGui::PushStyleVar( ImGuiStyleVar_FrameRounding, 8.0F );
    ImGui::PushStyleVar( ImGuiStyleVar_FramePadding, ImVec2( 12.0F, 8.0F ) );
    ImGui::PushStyleVar( ImGuiStyleVar_ItemSpacing, ImVec2( 8.0F, 7.0F ) );
    ImGui::PushStyleVar( ImGuiStyleVar_WindowPadding, ImVec2( edge_padding, 10.0F ) );
    ImGui::PushStyleColor( ImGuiCol_ChildBg, ImVec4( 0.035F, 0.050F, 0.062F, 0.98F ) );
    ImGui::PushStyleColor( ImGuiCol_Border, ImVec4( 0.22F, 0.36F, 0.40F, 0.78F ) );
    ImGui::PushStyleColor( ImGuiCol_Button, ImVec4( 0.065F, 0.085F, 0.105F, 1.0F ) );
    ImGui::PushStyleColor( ImGuiCol_ButtonHovered, ImVec4( 0.10F, 0.28F, 0.31F, 1.0F ) );
    ImGui::PushStyleColor( ImGuiCol_ButtonActive, ImVec4( 0.13F, 0.39F, 0.42F, 1.0F ) );
    ImGui::PushStyleColor( ImGuiCol_Text, ImVec4( 0.90F, 0.94F, 0.95F, 1.0F ) );

    if( !snapshot_.ready ) {
        draw_loading_page();
    } else {
        draw_identity_bar();
        draw_tabs();
        ImGui::Separator();
        if( snapshot_.tab == CHARCREATOR_SUMMARY ) {
            draw_summary_page( footer_height );
        } else {
            draw_selection_page( footer_height );
        }
        ImGui::Separator();
        draw_footer();
    }

    ImGui::PopStyleColor( 6 );
    ImGui::PopStyleVar( 4 );
    cataimgui::PopGuiFont1_5x();
}

void android_character_creator_ui::queue_command( const std::string &command )
{
    actions_.push_back( { android_character_creator_action_type::command, 0, command } );
}

void android_character_creator_ui::draw_loading_page()
{
    const ImVec2 available = ImGui::GetContentRegionAvail();
    const char *message = _( "Preparing character creator…" );
    const ImVec2 message_size = ImGui::CalcTextSize( message );
    ImGui::SetCursorPos( ImVec2( std::max( 0.0F, ( available.x - message_size.x ) * 0.5F ),
                                 std::max( 0.0F, ( available.y - message_size.y ) * 0.5F ) ) );
    ImGui::TextUnformatted( message );
}

void android_character_creator_ui::draw_identity_bar()
{
    ImGui::TextUnformatted( _( "Create Character" ) );
    ImGui::SameLine();
    if( ImGui::Button( ( snapshot_.name + "###android_character_name" ).c_str(),
                       ImVec2( 250.0F, 46.0F ) ) ) {
        queue_command( "CHANGE_NAME" );
    }
    ImGui::SameLine();
    if( ImGui::Button( snapshot_.gender.c_str(), ImVec2( 125.0F, 46.0F ) ) ) {
        queue_command( "CHANGE_GENDER" );
    }
    ImGui::SameLine();
    if( ImGui::BeginChild( "##android_character_quick_info", ImVec2( 0.0F, 50.0F ),
                           ImGuiChildFlags_None,
                           ImGuiWindowFlags_HorizontalScrollbar |
                           ImGuiWindowFlags_NoScrollWithMouse ) ) {
        const std::array<std::pair<std::string, std::string>, 5> buttons = {{
                { snapshot_.age, "CHANGE_AGE" },
                { snapshot_.height, "CHANGE_HEIGHT" },
                { snapshot_.blood, "CHANGE_BLOOD_TYPE" },
                { _( "Location" ), "CHOOSE_LOCATION" },
                { _( "Randomize" ), "RANDOMIZE_CHAR_DESCRIPTION" },
            }
        };
        for( size_t i = 0; i < buttons.size(); ++i ) {
            if( i > 0 ) {
                ImGui::SameLine();
            }
            const std::string label = buttons[i].first + "###android_character_quick_" +
                                      std::to_string( i );
            if( ImGui::Button( label.c_str(), ImVec2( 155.0F, 44.0F ) ) ) {
                queue_command( buttons[i].second );
            }
        }
        if( ImGui::IsWindowHovered( ImGuiHoveredFlags_AllowWhenBlockedByActiveItem ) &&
            ImGui::IsMouseDragging( ImGuiMouseButton_Left ) ) {
            ImGui::SetScrollX( ImGui::GetScrollX() - ImGui::GetIO().MouseDelta.x );
        }
    }
    ImGui::EndChild();
}

void android_character_creator_ui::draw_tabs()
{
    static const std::array<const char *, 7> labels = {{
            "Scenario", "Profession", "Background", "Stats", "Traits", "Skills", "Summary"
        }
    };
    if( ImGui::BeginChild( "##android_character_tabs", ImVec2( 0.0F, 55.0F ),
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
            const float width = std::max( 145.0F, ImGui::CalcTextSize( translated.c_str() ).x + 34.0F );
            const std::string label = translated + "###android_character_tab_" + std::to_string( i );
            if( ImGui::Button( label.c_str(), ImVec2( width, 46.0F ) ) && !selected ) {
                actions_.push_back( { android_character_creator_action_type::select_tab, i, {} } );
                filter_.clear();
            }
            if( selected ) {
                ImGui::PopStyleColor( 2 );
            }
        }
        if( ImGui::IsWindowHovered( ImGuiHoveredFlags_AllowWhenBlockedByActiveItem ) &&
            ImGui::IsMouseDragging( ImGuiMouseButton_Left ) ) {
            ImGui::SetScrollX( ImGui::GetScrollX() - ImGui::GetIO().MouseDelta.x );
        }
    }
    ImGui::EndChild();
}

bool android_character_creator_ui::handle_vertical_drag()
{
    ImGuiIO &io = ImGui::GetIO();
    if( ImGui::IsWindowHovered( ImGuiHoveredFlags_AllowWhenBlockedByActiveItem ) &&
        ImGui::IsMouseClicked( ImGuiMouseButton_Left ) ) {
        dragging_ = true;
        drag_start_ = io.MousePos;
    }
    if( !dragging_ ) {
        return false;
    }
    const ImVec2 distance( io.MousePos.x - drag_start_.x, io.MousePos.y - drag_start_.y );
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

void android_character_creator_ui::draw_selection_page( const float footer_height )
{
    const float content_width = ImGui::GetContentRegionAvail().x;
    const float list_width = std::clamp( content_width * 0.43F, 420.0F, 680.0F );
    if( ImGui::BeginChild( "##android_character_list", ImVec2( list_width, -footer_height ),
                           ImGuiChildFlags_Borders ) ) {
        ImGui::TextUnformatted( _( "Search:" ) );
        ImGui::SameLine();
        ImGui::SetNextItemWidth( -1.0F );
        ImGui::InputText( "##android_character_filter", &filter_ );
        ImGui::Separator();
        if( ImGui::BeginChild( "##android_character_rows", ImVec2( 0.0F, 0.0F ),
                               ImGuiChildFlags_None,
                               ImGuiWindowFlags_AlwaysVerticalScrollbar ) ) {
            const bool suppress_click = handle_vertical_drag();
            for( const android_character_creator_row_snapshot &row : snapshot_.rows ) {
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
                                   ImVec2( -1.0F, 50.0F ) ) && !suppress_click ) {
                    actions_.push_back( { android_character_creator_action_type::select_row,
                                          row.index, {} } );
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
    if( ImGui::BeginChild( "##android_character_detail", ImVec2( 0.0F, -footer_height ),
                           ImGuiChildFlags_Borders,
                           ImGuiWindowFlags_AlwaysVerticalScrollbar ) ) {
        handle_vertical_drag();
        draw_current_details();
    }
    ImGui::EndChild();
}

const android_character_creator_row_snapshot *android_character_creator_ui::selected_row() const
{
    const auto found = std::find_if( snapshot_.rows.begin(), snapshot_.rows.end(),
    []( const android_character_creator_row_snapshot & row ) {
        return row.selected;
    } );
    return found == snapshot_.rows.end() ? nullptr : &*found;
}

void android_character_creator_ui::draw_current_details()
{
    const android_character_creator_row_snapshot *row = selected_row();
    if( row == nullptr ) {
        ImGui::TextWrapped( "%s", _( "Select an entry to view its details." ) );
        return;
    }

    ImGui::TextWrapped( "%s", row->label.c_str() );
    ImGui::Separator();
    render_details_( snapshot_.tab );
    ImGui::Dummy( ImVec2( 0.0F, 12.0F ) );

    if( snapshot_.tab == CHARCREATOR_STATS || snapshot_.tab == CHARCREATOR_SKILLS ) {
        if( ImGui::Button( _( "−" ), ImVec2( 110.0F, 50.0F ) ) ) {
            queue_command( "DECREASE_VALUE" );
        }
        ImGui::SameLine();
        if( ImGui::Button( _( "+" ), ImVec2( 110.0F, 50.0F ) ) ) {
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
    if( ImGui::Button( label.c_str(), ImVec2( 230.0F, 50.0F ) ) ) {
        actions_.push_back( { android_character_creator_action_type::activate_row,
                              row->index, {} } );
    }
    if( !row->enabled ) {
        ImGui::EndDisabled();
    }
}

void android_character_creator_ui::draw_summary_page( const float footer_height )
{
    if( ImGui::BeginChild( "##android_character_summary", ImVec2( 0.0F, -footer_height ),
                           ImGuiChildFlags_Borders,
                           ImGuiWindowFlags_AlwaysVerticalScrollbar ) ) {
        handle_vertical_drag();
        render_details_( CHARCREATOR_SUMMARY );
    }
    ImGui::EndChild();
}

void android_character_creator_ui::draw_footer()
{
    constexpr float gap = 10.0F;
    const float width = ( ImGui::GetContentRegionAvail().x - gap * 2.0F ) / 3.0F;
    if( ImGui::Button( _( "Return" ), ImVec2( width, 50.0F ) ) ) {
        queue_command( "QUIT" );
    }
    ImGui::SameLine( 0.0F, gap );
    if( snapshot_.tab == CHARCREATOR_SCENARIO ) {
        ImGui::BeginDisabled();
    }
    if( ImGui::Button( _( "Previous" ), ImVec2( width, 50.0F ) ) ) {
        queue_command( "PREV_TAB" );
    }
    if( snapshot_.tab == CHARCREATOR_SCENARIO ) {
        ImGui::EndDisabled();
    }
    ImGui::SameLine( 0.0F, gap );
    const char *next_label = snapshot_.tab == CHARCREATOR_SUMMARY ? _( "Finish" ) : _( "Next" );
    if( ImGui::Button( next_label, ImVec2( width, 50.0F ) ) ) {
        queue_command( "NEXT_TAB" );
    }
}

#endif // __ANDROID__
