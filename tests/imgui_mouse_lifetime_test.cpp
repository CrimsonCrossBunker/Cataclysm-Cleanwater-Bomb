#include "cata_catch.h"
#include "cata_imgui.h"
#include "cata_scope_helpers.h"
#include "imgui/imgui.h"
#include "imgui/imgui_internal.h"
#include "ui_manager.h"

#if defined(TILES)
    #include <initializer_list>
    #include <memory>

    #include "point.h"
    #include "sdl_renderer_recovery.h"
    #include "sdl_wrappers.h"
    #include "sdltiles.h"
#endif

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

#if defined(TILES)
TEST_CASE( "imgui_consumes_display_buffer_mouse_coordinates_once",
           "[imgui][input][sdl3]" )
{
    software_render_fixture fx;
    REQUIRE( fx.available() );
    ImGuiContext *previous = ImGui::GetCurrentContext();
    on_out_of_scope restore_context( [previous]() {
        ImGui::SetCurrentContext( previous );
    } );
    std::unique_ptr<cataimgui::client> client = renderer_recovery_test_support::make_imgui_client();
    mouse_test_window menu;
    REQUIRE( ui_adaptor::has_imgui() );
    ImGuiContext *context = ImGui::GetCurrentContext();
    ImGuiIO &io = ImGui::GetIO();
    io.DisplaySize = ImVec2( 2880, 1800 );
    io.DeltaTime = 1.0F / 60.0F;
    unsigned char *pixels = nullptr;
    point font_atlas;
    io.Fonts->GetTexDataAsRGBA32( &pixels, &font_atlas.x, &font_atlas.y );
    for( int frame = 0; frame < 2; ++frame ) {
        ImGui::NewFrame();
        ImGui::Begin( "pointer_target" );
        ImGui::End();
        ImGui::Render();
    }
    REQUIRE( client->any_window_shown() );

    for( const int scale : {
             1, 2, 4
         } ) {
        renderer_recovery_test_support::set_scaling_and_resize_window( scale, 1440, 900 );
        renderer_recovery_test_support::override_drawable_pixels( 2880, 1800 );
        renderer_coordinator.drain_pending();
        REQUIRE( renderer_coordinator.is_render_allowed() );
        context->InputEventsQueue.clear();
        SDL_Event event{};
        event.type = CATA_MOUSEMOTION;
        event.motion.windowID = SDL_GetWindowID( get_sdl_window() );
        event.motion.x = 700;
        event.motion.y = 400;
        convert_event_to_display_buffer_coords( &event );
        CHECK( event.motion.x == 1400.0F / scale );
        CHECK( event.motion.y == 800.0F / scale );
        client->process_input( &event );
        bool found_position = false;
        for( const ImGuiInputEvent &queued : context->InputEventsQueue ) {
            if( queued.Type == ImGuiInputEventType_MousePos ) {
                CAPTURE( scale );
                CHECK( queued.MousePos.PosX == event.motion.x );
                CHECK( queued.MousePos.PosY == event.motion.y );
                found_position = true;
            }
        }
        REQUIRE( found_position );
    }
}
#endif // TILES
