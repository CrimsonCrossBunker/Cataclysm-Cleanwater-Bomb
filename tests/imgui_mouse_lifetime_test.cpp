#include "cata_catch.h"
#include "cata_imgui.h"
#include "cata_scope_helpers.h"
#include "imgui/imgui.h"
#include "imgui/imgui_internal.h"
#include "ui_manager.h"

namespace
{
class mouse_test_window : public cataimgui::window
{
    public:
        mouse_test_window() : window( "mouse_lifetime_test" ) {}

    protected:
        void draw_controls() override {}
};
} // namespace

TEST_CASE( "closing_last_imgui_window_releases_mouse", "[imgui][input][mouse_capture]" )
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
    REQUIRE_FALSE( ui_adaptor::has_imgui() );
    {
        mouse_test_window menu;
        ImGui::NewFrame();
        ImGui::Begin( "held_mouse" );
        ImGui::SetActiveID( ImGui::GetID( "held_button" ), ImGui::GetCurrentWindow() );
        ImGui::End();
        ImGui::Render();
        // Model a menu destroyed before its queued mouse-up is processed.
        io.MouseDown[0] = true;
        io.WantCaptureMouse = true;
        io.AddMouseButtonEvent( 0, false );
        REQUIRE( cataimgui::client::want_capture_mouse() );
    }
    CHECK_FALSE( io.MouseDown[0] );
    CHECK( context->ActiveId == 0 );
    CHECK( context->InputEventsQueue.empty() );
    CHECK_FALSE( cataimgui::client::want_capture_mouse() );

    // ImGui's previous-frame capture flag can stay set until NewFrame.
    // It must not suppress input while no live GUI adaptor remains.
    io.WantCaptureMouse = true;
    CHECK_FALSE( cataimgui::client::want_capture_mouse() );
}
