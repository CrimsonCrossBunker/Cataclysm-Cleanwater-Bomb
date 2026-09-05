#include <string>

#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "imgui/imgui.h"
#include "imgui/imgui_stdlib.h"

TEST_CASE( "imgui_filter_backspace_removes_one_unicode_character", "[imgui][input]" )
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
    std::string text = "背包";
    auto frame = [&]( bool focus ) {
        ImGui::NewFrame();
        ImGui::Begin( "filter" );
        if( focus ) {
            ImGui::SetKeyboardFocusHere();
        }
        ImGui::InputText( "text", &text );
        ImGui::End();
        ImGui::Render();
    };
    frame( true );
    frame( false );
    // Place the cursor at the end without a selection, just as when editing
    // a previously saved filter.
    io.AddKeyEvent( ImGuiKey_End, true );
    frame( false );
    io.AddKeyEvent( ImGuiKey_End, false );
    frame( false );
    io.AddKeyEvent( ImGuiKey_Backspace, true );
    frame( false );
    io.AddKeyEvent( ImGuiKey_Backspace, false );
    frame( false );
    CHECK( text == "背" );
    io.AddInputCharactersUTF8( "包" );
    frame( false );
    CHECK( text == "背包" );
}
