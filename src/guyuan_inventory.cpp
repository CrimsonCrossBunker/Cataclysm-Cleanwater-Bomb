#include "advanced_inv.h"
#include "inventory_ui.h"

#include "guyuan_hud.h"

#if defined(TILES)
#include <algorithm>
#include <string>
#include <imgui/imgui.h>

#include "advanced_inv_listitem.h"
#include "cata_imgui.h"
#include "catacharset.h"
#include "guyuan_ui.h"
#include "input_context.h"
#include "item.h"
#include "item_category.h"
#include "output.h"
#include "translations.h"
#include "ui_manager.h"

namespace
{
constexpr ImGuiWindowFlags inventory_flags = ImGuiWindowFlags_NoSavedSettings |
        ImGuiWindowFlags_NoMove | ImGuiWindowFlags_NoResize | ImGuiWindowFlags_NoCollapse |
        ImGuiWindowFlags_NoTitleBar | ImGuiWindowFlags_NoNav |
        ImGuiWindowFlags_NoScrollbar | ImGuiWindowFlags_NoScrollWithMouse;

void place_window()
{
    const ImGuiViewport &viewport = *ImGui::GetMainViewport();
    const guyuan_ui::window_layout bounds = guyuan_ui::fit_window( viewport.WorkSize.x,
                                            viewport.WorkSize.y );
    ImGui::SetNextWindowPos( ImVec2( viewport.WorkPos.x + bounds.x,
                                   viewport.WorkPos.y + bounds.y ) );
    ImGui::SetNextWindowSize( ImVec2( bounds.width, bounds.height ) );
}

bool command( const input_context &ctxt, const char *action )
{
    if( !ctxt.is_registered_action( action ) ) {
        return false;
    }
    const std::string text = ctxt.get_button_text( action );
    return ImGui::Button( text.c_str() );
}

void action_menu( const input_context &ctxt, std::string &pending )
{
    if( ImGui::BeginMenu( _( "Actions" ) ) ) {
        for( const char *action : { "EXAMINE", "EXAMINE_CONTENTS", "SHOW_HIDE_CONTENTS",
                                   "SHOW_HIDE_CONTENTS_ALL", "TOGGLE_ENTRY", "MARK_WITH_COUNT",
                                   "TOGGLE_FAVORITE", "TOGGLE_AUTO_PICKUP", "WIELD", "WEAR",
                                   "UNLOAD_CONTAINER", "CATEGORY_SELECTION", "VIEW_CATEGORY_MODE",
                                   "ORGANIZE_MENU", "HELP_KEYBINDINGS", "QUIT" } ) {
            if( ctxt.is_registered_action( action ) &&
                ImGui::MenuItem( ctxt.get_button_text( action ).c_str() ) ) {
                pending = action;
            }
        }
        ImGui::EndMenu();
    }
}
}
#endif

bool inventory_selector::draw_guyuan_window()
{
    guyuan_visible = false;
#if defined(TILES)
    const auto current_ui = ui.lock();
    // Native quantity/filter prompts and the container examiner retain their own layout.
    if( !guyuan_hud::enabled() || native_view_only || spopup ||
        !current_ui ) {
        return false;
    }
    guyuan_visible = true;
    const guyuan_ui::scoped_style theme;
    cataimgui::PushGuiFont();
    place_window();
    ImGui::PushID( this );
    if( ImGui::Begin( "###guyuan_inventory", nullptr,
                     inventory_flags | ImGuiWindowFlags_MenuBar ) ) {
        ImGui::BeginDisabled( !current_ui->is_on_top );
        if( ImGui::BeginMenuBar() ) {
            action_menu( ctxt, guyuan_action );
            ImGui::EndMenuBar();
        }
        const auto stats = display_stats ? get_stats() : std::vector<std::string>();
        const std::string clean_hint = remove_color_tags( hint );
        const float wrap_width = std::max( 1.0F, ImGui::GetContentRegionAvail().x );
        float header_height = ImGui::GetTextLineHeightWithSpacing();
        if( !clean_hint.empty() ) {
            header_height += ImGui::CalcTextSize( clean_hint.c_str(), nullptr, false, wrap_width ).y +
                             ImGui::GetStyle().ItemSpacing.y;
        }
        for( const std::string &stat : stats ) {
            header_height += ImGui::CalcTextSize( remove_color_tags( stat ).c_str(), nullptr,
                                                false, wrap_width ).y + ImGui::GetStyle().ItemSpacing.y;
        }
        header_height = std::min( header_height, ImGui::GetContentRegionAvail().y * 0.30F );
        if( ImGui::BeginChild( "summary", ImVec2( 0, std::max( 1.0F, header_height ) ) ) ) {
            ImGui::TextWrapped( "%s", remove_color_tags( title ).c_str() );
            if( !clean_hint.empty() ) {
                ImGui::TextWrapped( "%s", clean_hint.c_str() );
            }
            for( const std::string &stat : stats ) {
                ImGui::TextWrapped( "%s", remove_color_tags( stat ).c_str() );
            }
        }
        ImGui::EndChild();
        if( command( ctxt, "INVENTORY_FILTER" ) ) {
            guyuan_action = "INVENTORY_FILTER";
        }
        if( !filter.empty() ) {
            ImGui::SameLine();
            if( command( ctxt, "RESET_FILTER" ) ) {
                guyuan_action = "RESET_FILTER";
            }
            ImGui::TextUnformatted( filter.c_str() );
            if( ImGui::IsItemHovered() ) {
                ImGui::SetTooltip( "%s", filter.c_str() );
            }
        }

        const auto visible_columns = get_visible_columns();
        const float footer_width = ImGui::CalcTextSize( ctxt.get_button_text( "CONFIRM" ).c_str() ).x +
                                   ImGui::CalcTextSize( ctxt.get_button_text( "QUIT" ).c_str() ).x +
                                   ImGui::GetStyle().FramePadding.x * 4 + ImGui::GetStyle().ItemSpacing.x;
        const bool wrap_footer = footer_width > ImGui::GetContentRegionAvail().x;
        const float message_height = guyuan_message.empty() ? 0.0F :
                                     ImGui::CalcTextSize( remove_color_tags( guyuan_message ).c_str(), nullptr,
                                             false, wrap_width ).y + ImGui::GetStyle().ItemSpacing.y;
        const float footer_height = ImGui::GetFrameHeightWithSpacing() * ( wrap_footer ? 2 : 1 ) +
                                    message_height;
        const float list_height = std::max( 1.0F, ImGui::GetContentRegionAvail().y - footer_height );
        const bool use_tabs = visible_columns.size() > 1 &&
                              ImGui::GetContentRegionAvail().x < visible_columns.size() * 360.0F;
        const item_location highlighted = get_highlighted().is_item() ?
                                          get_highlighted().any_item() : item_location();
        const bool scroll_to_selection = highlighted != guyuan_scrolled_item;
        const bool body_visible = ImGui::BeginChild( "body", ImVec2( 0, list_height ), false,
                                  ImGuiWindowFlags_NoScrollbar | ImGuiWindowFlags_NoScrollWithMouse );
        if( body_visible && !visible_columns.empty() &&
            ( use_tabs ? ImGui::BeginTabBar( "columns" ) :
              ImGui::BeginTable( "columns", visible_columns.size(),
                                ImGuiTableFlags_Resizable | ImGuiTableFlags_BordersInnerV ) ) ) {
            for( inventory_column *column : visible_columns ) {
                if( !use_tabs ) {
                    ImGui::TableNextColumn();
                }
                ImGui::PushID( column );
                const bool active = column == &get_active_column();
                const std::string label = column == &own_inv_column ? _( "Inventory" ) :
                                          column == &own_gear_column ? _( "Equipment" ) :
                                          column == &map_column ? _( "Nearby" ) : _( "Selected" );
                if( use_tabs ) {
                    if( !ImGui::BeginTabItem( label.c_str(), nullptr,
                                             active && scroll_to_selection ? ImGuiTabItemFlags_SetSelected : 0 ) ) {
                        ImGui::PopID();
                        continue;
                    }
                } else {
                    ImGui::TextColored( active ? ImVec4( 0.87F, 0.75F, 0.46F, 1.0F ) :
                                        ImVec4( 0.65F, 0.66F, 0.64F, 1.0F ), "%s", label.c_str() );
                }
                std::vector<const inventory_entry *> entries;
                const item_category *category = nullptr;
                int highlighted_row = -1;
                for( const inventory_entry &entry : column->display_entries() ) {
                    // Native paging inserts blank entries and repeated category headings.
                    if( entry.is_null() || ( entry.is_category() && entry.get_category_ptr() == category ) ) {
                        continue;
                    }
                    if( entry.is_category() ) {
                        category = entry.get_category_ptr();
                    }
                    if( column->is_highlighted( entry ) ) {
                        highlighted_row = entries.size();
                    }
                    entries.push_back( &entry );
                }
                const auto &column_preset = column->display_preset();
                const int cells = column_preset.get_cells_count();
                const bool show_denials = std::any_of( entries.begin(), entries.end(),
                []( const inventory_entry *entry ) {
                    return entry->is_item() && entry->denial && !entry->denial->empty();
                } );
                if( ImGui::BeginTable( "items", cells + 1 + ( show_denials ? 1 : 0 ), ImGuiTableFlags_ScrollY |
                                      ImGuiTableFlags_RowBg | ImGuiTableFlags_Resizable,
                                      ImVec2( 0, std::max( 1.0F, ImGui::GetContentRegionAvail().y - ImGui::GetStyle().CellPadding.y ) ) ) ) {
                    ImGui::TableSetupColumn( "##key", ImGuiTableColumnFlags_WidthFixed, 66.0F );
                    for( int cell = 0; cell < cells; ++cell ) {
                        ImGui::TableSetupColumn( ( "##cell" + std::to_string( cell ) ).c_str() );
                    }
                    if( show_denials ) {
                        ImGui::TableSetupColumn( "##denial", ImGuiTableColumnFlags_WidthStretch );
                    }
                    const float row_height = ImGui::GetFrameHeight() + ImGui::GetStyle().CellPadding.y * 2;
                    ImGuiListClipper clipper;
                    clipper.Begin( entries.size(), row_height );
                    if( active && scroll_to_selection && highlighted_row >= 0 ) {
                        clipper.IncludeItemByIndex( highlighted_row );
                    }
                    while( clipper.Step() ) {
                        for( int row = clipper.DisplayStart; row < clipper.DisplayEnd; ++row ) {
                            const inventory_entry &entry = *entries[row];
                            ImGui::PushID( row );
                            ImGui::TableNextRow( ImGuiTableRowFlags_None, row_height );
                            ImGui::TableNextColumn();
                            if( entry.is_item() ) {
                                if( column->is_multiselect() && column->allows_selecting() ) {
                                    bool checked = entry.chosen_count > 0;
                                    ImGui::BeginDisabled( !entry.is_selectable() );
                                    if( ImGui::Checkbox( "##mark", &checked ) && entry.is_selectable() ) {
                                        guyuan_item = entry.any_item();
                                        guyuan_action = "SELECT";
                                    }
                                    ImGui::EndDisabled();
                                } else if( entry.chevron && column->allows_selecting() ) {
                                    if( ImGui::SmallButton( ">" ) ) {
                                        guyuan_item = entry.any_item();
                                        guyuan_action = "SHOW_HIDE_CONTENTS";
                                    }
                                } else if( showing_invlet() && entry.get_invlet() > 0 ) {
                                    ImGui::TextUnformatted( utf32_to_utf8( entry.get_invlet() ).c_str() );
                                }
                                if( entry.chosen_count > 0 ) {
                                    ImGui::SameLine();
                                    ImGui::Text( "%zu", entry.chosen_count );
                                }
                            }
                            for( int cell = 0; cell < cells; ++cell ) {
                                ImGui::TableNextColumn();
                                const std::string text = column_preset.get_cell_text( entry, cell );
                                if( cell == 0 && entry.is_item() ) {
                                    ImGui::PushStyleColor( ImGuiCol_Text,
                                                          cataimgui::imvec4_from_color( column_preset.get_color( entry ) ) );
                                    const std::string name = remove_color_tags( text ) + "###item";
                                    if( ImGui::Selectable( name.c_str(), active && column->is_highlighted( entry ),
                                                          ImGuiSelectableFlags_AllowDoubleClick,
                                                          ImVec2( 0, ImGui::GetFrameHeight() ) ) &&
                                        column->allows_selecting() ) {
                                        guyuan_item = entry.any_item();
                                        guyuan_action = ImGui::IsMouseDoubleClicked( 0 ) && entry.is_selectable() ?
                                                        "SELECT" : "MOUSE_MOVE";
                                    }
                                    ImGui::PopStyleColor();
                                    if( ImGui::IsItemHovered() ) {
                                        const std::string denial = entry.denial ? *entry.denial :
                                                                   column_preset.get_denial( entry );
                                        ImGui::SetTooltip( "%s%s%s", remove_color_tags( text ).c_str(),
                                                           denial.empty() ? "" : "\n", remove_color_tags( denial ).c_str() );
                                    }
                                    if( active && scroll_to_selection && column->is_highlighted( entry ) ) {
                                        ImGui::SetScrollHereY();
                                    }
                                } else {
                                    cataimgui::draw_colored_text( text, entry.is_category() ? c_yellow : c_light_gray );
                                }
                            }
                            if( show_denials ) {
                                ImGui::TableNextColumn();
                                if( entry.is_item() && entry.denial && !entry.denial->empty() ) {
                                    const std::string reason = remove_color_tags( *entry.denial );
                                    ImGui::TextColored( ImVec4( 0.95F, 0.43F, 0.38F, 1.0F ), "%s", reason.c_str() );
                                    if( ImGui::IsItemHovered() ) {
                                        ImGui::SetTooltip( "%s", reason.c_str() );
                                    }
                                }
                            }
                            ImGui::PopID();
                        }
                    }
                    ImGui::EndTable();
                }
                if( use_tabs ) {
                    ImGui::EndTabItem();
                }
                ImGui::PopID();
            }
            if( use_tabs ) {
                ImGui::EndTabBar();
            } else {
                ImGui::EndTable();
            }
        }
        ImGui::EndChild();
        guyuan_scrolled_item = highlighted;
        if( !guyuan_message.empty() ) {
            ImGui::PushStyleColor( ImGuiCol_Text, ImVec4( 0.95F, 0.43F, 0.38F, 1.0F ) );
            ImGui::TextWrapped( "%s", remove_color_tags( guyuan_message ).c_str() );
            ImGui::PopStyleColor();
        }
        if( command( ctxt, "CONFIRM" ) ) {
            guyuan_action = "CONFIRM";
        }
        if( !wrap_footer ) {
            ImGui::SameLine();
        }
        if( command( ctxt, "QUIT" ) ) {
            guyuan_action = "QUIT";
        }
        ImGui::EndDisabled();
    }
    ImGui::End();
    ImGui::PopID();
    ImGui::PopFont();
    return true;
#else
    return false;
#endif
}

bool advanced_inventory::draw_guyuan_window()
{
    guyuan_visible = false;
#if defined(TILES)
    if( !guyuan_hud::enabled() || filter_edit || !ui || !ui->is_on_top ) {
        return false;
    }
    guyuan_visible = true;
    const guyuan_ui::scoped_style theme;
    cataimgui::PushGuiFont();
    place_window();
    if( ImGui::Begin( "###guyuan_storage", nullptr, inventory_flags | ImGuiWindowFlags_MenuBar ) ) {
        input_context &ctxt = *shortcut_context;
        if( ImGui::BeginMenuBar() ) {
            std::string menu_action;
            action_menu( ctxt, menu_action );
            if( !menu_action.empty() ) {
                guyuan_action = menu_action;
                guyuan_side = src;
            }
            ImGui::EndMenuBar();
        }
        ImGui::TextUnformatted( _( "Advanced Inventory" ) );
        // Use native recalc on both panes before taking any row references.
        for( side p : { left, right } ) {
            if( recalc || panes[p].recalc ) {
                recalc_pane( p );
            }
            panes[p].fix_index();
        }
        const auto queue = [&]( const char *action, side p, int index = -1 ) {
            guyuan_action = action;
            guyuan_side = p;
            guyuan_index = index;
        };
        const float height = std::max( 1.0F, ImGui::GetContentRegionAvail().y );
        const float pane_height = std::max( 1.0F, height - ImGui::GetStyle().CellPadding.y * 2 );
        const float details_height = std::min( pane_height * 0.40F,
                                             ImGui::GetFrameHeightWithSpacing() * 5 );
        const float items_height = std::max( 1.0F, pane_height - details_height -
                                            ImGui::GetStyle().ItemSpacing.y );
        if( ImGui::BeginTable( "panes", 2, ImGuiTableFlags_Resizable | ImGuiTableFlags_BordersInnerV,
                               ImVec2( 0, height ) ) ) {
            for( side p : { left, right } ) {
                ImGui::TableNextColumn();
                ImGui::PushID( p );
                advanced_inventory_pane &pane = panes[p];
                const bool show_category = ImGui::GetContentRegionAvail().x >= 440.0F;
                const bool show_details = ImGui::BeginChild( "location_details", ImVec2( 0, details_height ) );
                if( show_details ) {
                    if( ImGui::Selectable( ( p == src ? _( "Source" ) : _( "Destination" ) ), p == src ) ) {
                        queue( p == left ? "LEFT" : "RIGHT", p );
                    }
                    const advanced_inv_area &area = squares[pane.get_area()];
                    if( ImGui::BeginCombo( "##location", area.name.c_str() ) ) {
                        for( const advanced_inv_area &location : squares ) {
                            if( ImGui::Selectable( location.name.c_str(), location.id == pane.get_area() ) ) {
                                for( const advanced_inv_area &candidate : squares ) {
                                    if( screen_relative_location( candidate.id ) == location.id ) {
                                        guyuan_action = candidate.actionname;
                                        break;
                                    }
                                }
                                guyuan_index = -1;
                                guyuan_side = p;
                            }
                        }
                        ImGui::EndCombo();
                    }
                    if( pane.container ) {
                        ImGui::TextWrapped( "%s", remove_color_tags( pane.container->tname() ).c_str() );
                    } else {
                        ImGui::TextWrapped( "%s", area.desc[pane.in_vehicle()].c_str() );
                    }
                    if( area.can_store_in_vehicle() ) {
                        bool cargo = pane.in_vehicle();
                        if( ImGui::Checkbox( _( "Vehicle" ), &cargo ) ) {
                            queue( "TOGGLE_VEH", p );
                        }
                    }
                    if( ImGui::BeginMenu( _( "Transfer" ) ) ) {
                        for( const char *action : { "MOVE_SINGLE_ITEM", "MOVE_VARIABLE_ITEM", "MOVE_ITEM_STACK",
                                                   "MOVE_ALL_ITEMS", "FILTER", "RESET_FILTER", "SORT", "EXAMINE" } ) {
                            if( ImGui::MenuItem( ctxt.get_button_text( action ).c_str() ) ) {
                                queue( action, p );
                            }
                        }
                        ImGui::EndMenu();
                    }
                    if( !pane.get_filter().empty() ) {
                        ImGui::TextWrapped( "%s", pane.get_filter().c_str() );
                    }
                    if( ImGui::Button( ctxt.get_button_text( "MOVE_VARIABLE_ITEM" ).c_str() ) ) {
                        queue( "MOVE_VARIABLE_ITEM", p );
                    }
                }
                ImGui::EndChild();
                if( ImGui::BeginTable( "items", show_category ? 3 : 2,
                                      ImGuiTableFlags_ScrollY | ImGuiTableFlags_RowBg |
                                      ImGuiTableFlags_Resizable,
                                      ImVec2( 0, items_height ) ) ) {
                    ImGui::TableSetupColumn( _( "Item" ), ImGuiTableColumnFlags_WidthStretch );
                    ImGui::TableSetupColumn( _( "Quantity" ), ImGuiTableColumnFlags_WidthFixed, 70.0F );
                    if( show_category ) {
                        ImGui::TableSetupColumn( _( "Category" ), ImGuiTableColumnFlags_WidthStretch );
                    }
                    ImGui::TableSetupScrollFreeze( 0, 1 );
                    ImGui::TableHeadersRow();
                    const float row_height = ImGui::GetFrameHeight() + ImGui::GetStyle().CellPadding.y * 2;
                    ImGuiListClipper clipper;
                    clipper.Begin( pane.items.size(), row_height );
                    if( pane.index >= 0 && pane.index < static_cast<int>( pane.items.size() ) ) {
                        clipper.IncludeItemByIndex( pane.index );
                    }
                    while( clipper.Step() ) {
                        for( int row = clipper.DisplayStart; row < clipper.DisplayEnd; ++row ) {
                            const advanced_inv_listitem &entry = pane.items[row];
                            ImGui::PushID( row );
                            ImGui::TableNextRow( ImGuiTableRowFlags_None, row_height );
                            ImGui::TableNextColumn();
                            const std::string name = remove_color_tags( entry.name ) + "###item";
                            if( ImGui::Selectable( name.c_str(), pane.index == row,
                                                   ImGuiSelectableFlags_AllowDoubleClick | ImGuiSelectableFlags_SpanAllColumns,
                                                   ImVec2( 0, ImGui::GetFrameHeight() ) ) ) {
                                queue( ImGui::IsMouseDoubleClicked( 0 ) ? "MOVE_ITEM_STACK" :
                                       ( p == left ? "LEFT" : "RIGHT" ), p, row );
                            }
                            if( ImGui::IsItemHovered() ) {
                                ImGui::SetTooltip( "%s", remove_color_tags( entry.name ).c_str() );
                            }
                            if( pane.index == row && guyuan_scrolled_index[p] != pane.index ) {
                                ImGui::SetScrollHereY();
                            }
                            ImGui::TableNextColumn();
                            ImGui::Text( "%d", entry.amount );
                            if( show_category ) {
                                ImGui::TableNextColumn();
                                ImGui::TextUnformatted( entry.cat ? entry.cat->name_header().c_str() : "" );
                            }
                            ImGui::PopID();
                        }
                    }
                    ImGui::EndTable();
                }
                guyuan_scrolled_index[p] = pane.index;
                ImGui::PopID();
            }
            ImGui::EndTable();
        }
    }
    ImGui::End();
    ImGui::PopFont();
    return true;
#else
    return false;
#endif
}
