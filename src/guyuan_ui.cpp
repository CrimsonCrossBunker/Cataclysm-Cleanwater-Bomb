#include "guyuan_ui.h"

#include "guyuan_hud.h"

#if defined(TILES)
#include <imgui/imgui.h>
#endif

guyuan_ui::scoped_style::scoped_style()
{
#if defined(TILES)
    active = guyuan_hud::enabled();
    if( !active ) {
        return;
    }
    ImGui::PushStyleVar( ImGuiStyleVar_WindowRounding, 2.0F );
    ImGui::PushStyleVar( ImGuiStyleVar_FrameRounding, 1.0F );
    ImGui::PushStyleVar( ImGuiStyleVar_TabRounding, 0.0F );
    ImGui::PushStyleVar( ImGuiStyleVar_WindowPadding, ImVec2( 12.0F, 10.0F ) );
    ImGui::PushStyleVar( ImGuiStyleVar_FramePadding, ImVec2( 7.0F, 4.0F ) );
    ImGui::PushStyleVar( ImGuiStyleVar_ItemSpacing, ImVec2( 8.0F, 6.0F ) );
    ImGui::PushStyleColor( ImGuiCol_Text, ImVec4( 0.87F, 0.87F, 0.84F, 1.0F ) );
    ImGui::PushStyleColor( ImGuiCol_TextDisabled, ImVec4( 0.60F, 0.61F, 0.59F, 1.0F ) );
    ImGui::PushStyleColor( ImGuiCol_WindowBg, ImVec4( 0.075F, 0.085F, 0.095F, 0.99F ) );
    ImGui::PushStyleColor( ImGuiCol_ChildBg, ImVec4( 0.10F, 0.11F, 0.12F, 1.0F ) );
    ImGui::PushStyleColor( ImGuiCol_PopupBg, ImVec4( 0.10F, 0.11F, 0.12F, 1.0F ) );
    ImGui::PushStyleColor( ImGuiCol_Border, ImVec4( 0.30F, 0.31F, 0.31F, 1.0F ) );
    ImGui::PushStyleColor( ImGuiCol_Separator, ImVec4( 0.33F, 0.34F, 0.34F, 1.0F ) );
    ImGui::PushStyleColor( ImGuiCol_FrameBg, ImVec4( 0.18F, 0.19F, 0.20F, 1.0F ) );
    ImGui::PushStyleColor( ImGuiCol_FrameBgHovered, ImVec4( 0.28F, 0.29F, 0.29F, 1.0F ) );
    ImGui::PushStyleColor( ImGuiCol_FrameBgActive, ImVec4( 0.32F, 0.32F, 0.29F, 1.0F ) );
    ImGui::PushStyleColor( ImGuiCol_Button, ImVec4( 0.25F, 0.21F, 0.15F, 1.0F ) );
    ImGui::PushStyleColor( ImGuiCol_ButtonHovered, ImVec4( 0.39F, 0.31F, 0.20F, 1.0F ) );
    ImGui::PushStyleColor( ImGuiCol_ButtonActive, ImVec4( 0.46F, 0.35F, 0.20F, 1.0F ) );
    ImGui::PushStyleColor( ImGuiCol_Header, ImVec4( 0.30F, 0.25F, 0.16F, 1.0F ) );
    ImGui::PushStyleColor( ImGuiCol_HeaderHovered, ImVec4( 0.36F, 0.31F, 0.23F, 1.0F ) );
    ImGui::PushStyleColor( ImGuiCol_HeaderActive, ImVec4( 0.44F, 0.35F, 0.22F, 1.0F ) );
    ImGui::PushStyleColor( ImGuiCol_TitleBg, ImVec4( 0.16F, 0.14F, 0.11F, 1.0F ) );
    ImGui::PushStyleColor( ImGuiCol_TitleBgActive, ImVec4( 0.28F, 0.22F, 0.14F, 1.0F ) );
    ImGui::PushStyleColor( ImGuiCol_CheckMark, ImVec4( 0.77F, 0.66F, 0.38F, 1.0F ) );
    ImGui::PushStyleColor( ImGuiCol_Tab, ImVec4( 0.22F, 0.17F, 0.11F, 1.0F ) );
    ImGui::PushStyleColor( ImGuiCol_TabHovered, ImVec4( 0.40F, 0.30F, 0.17F, 1.0F ) );
    ImGui::PushStyleColor( ImGuiCol_TabSelected, ImVec4( 0.34F, 0.25F, 0.14F, 1.0F ) );
    ImGui::PushStyleColor( ImGuiCol_TableHeaderBg, ImVec4( 0.19F, 0.18F, 0.15F, 1.0F ) );
    ImGui::PushStyleColor( ImGuiCol_TableRowBgAlt, ImVec4( 0.16F, 0.17F, 0.18F, 0.45F ) );
#endif
}

guyuan_ui::scoped_style::~scoped_style()
{
#if defined(TILES)
    if( active ) {
        ImGui::PopStyleColor( 24 );
        ImGui::PopStyleVar( 6 );
    }
#endif
}
