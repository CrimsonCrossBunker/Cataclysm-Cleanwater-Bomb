#include <array>

#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "crafting_gui.h"
#include "imgui/imgui.h"

TEST_CASE( "crafting_keyboard_tabs_do_not_restore_stale_selection", "[crafting][imgui]" )
{
    ImGuiContext *previous = ImGui::GetCurrentContext();
    ImGuiContext *context = ImGui::CreateContext();
    on_out_of_scope cleanup( [&]() {
        ImGui::DestroyContext( context );
        ImGui::SetCurrentContext( previous );
    } );
    ImGuiIO &io = ImGui::GetIO();
    io.IniFilename = nullptr;
    io.DisplaySize = ImVec2( 800, 600 );
    io.DeltaTime = 1.0F / 60.0F;
    unsigned char *pixels = nullptr;
    int width = 0;
    int height = 0;
    io.Fonts->GetTexDataAsRGBA32( &pixels, &width, &height );

    const std::array<const char *, 3> labels = { "Food", "Weapons", "Armor" };
    std::array<ImVec2, 3> centers;
    int selected = 0;
    int visible = -1;
    bool synchronizing = true;
    int changes = 0;
    const auto frame = [&]() {
        ImGui::NewFrame();
        ImGui::SetNextWindowSize( ImVec2( 600, 400 ) );
        ImGui::Begin( "crafting_tabs_test" );
        int pending = -1;
        if( ImGui::BeginTabBar( "categories" ) ) {
            for( int i = 0; i < 3; ++i ) {
                const ImGuiTabItemFlags flags = synchronizing && selected == i ?
                                                ImGuiTabItemFlags_SetSelected : ImGuiTabItemFlags_None;
                if( ImGui::BeginTabItem( labels[i], nullptr, flags ) ) {
                    visible = i;
                    if( crafting_tab_selection_changed( selected, i, synchronizing ) ) {
                        pending = i;
                    }
                    ImGui::EndTabItem();
                }
                const ImVec2 min = ImGui::GetItemRectMin();
                const ImVec2 max = ImGui::GetItemRectMax();
                centers[i] = ImVec2( ( min.x + max.x ) / 2, ( min.y + max.y ) / 2 );
            }
            ImGui::EndTabBar();
        }
        synchronizing = false;
        if( pending >= 0 ) {
            selected = pending;
            ++changes;
        }
        ImGui::End();
        ImGui::Render();
    };
    frame();
    frame();
    frame();
    REQUIRE( visible == 0 );

    // Next/previous category and subcategory use this same synchronization path.
    for( int target : {
             1, 0, 2
         } ) {
        const int old = selected;
        selected = target;
        synchronizing = true;
        frame();
        CHECK( visible == old );
        CHECK( selected == target );
        frame();
        CHECK( visible == target );
        CHECK( selected == target );
        CHECK( changes == 0 );
    }

    // A real mouse click must still be accepted once synchronization finishes.
    io.AddMousePosEvent( centers[0].x, centers[0].y );
    frame();
    io.AddMouseButtonEvent( 0, true );
    frame();
    io.AddMouseButtonEvent( 0, false );
    frame();
    frame();
    CHECK( selected == 0 );
    CHECK( changes == 1 );
}
