#include <cstddef>
#include <memory>
#include <utility>
#include <vector>

#include "activity_actor_definitions.h"
#include "avatar.h"
#include "cached_options.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "clzones.h"
#include "coordinates.h"
#include "game.h"
#include "imgui/imgui.h"
#include "mapbuffer.h"
#include "player_activity.h"
#include "submap.h"
#include "type_id.h"
#include "ui_manager.h"

static const activity_id ACT_WAIT( "ACT_WAIT" );
static const efftype_id effect_sleep( "sleep" );

namespace
{
bool cleanup_preserving_loaded_submaps()
{
    // Session cleanup owns MAPBUFFER, but the test runner keeps the same map
    // between sections. Keep its borrowed submap pointers alive across cleanup.
    std::vector<std::pair<tripoint_abs_sm, std::unique_ptr<submap>>> submaps;
    for( auto &entry : MAPBUFFER ) {
        if( entry.second ) {
            submaps.emplace_back( entry.first, std::move( entry.second ) );
        }
    }
    on_out_of_scope restore_submaps( [&]() {
        MAPBUFFER.clear();
        for( auto &entry : submaps ) {
            MAPBUFFER.add_submap( entry.first, entry.second );
        }
    } );
    return turn_handler::cleanup_at_end();
}
} // namespace

// Run explicitly in a separate test process: cleanup_at_end also discards the
// global overmap cache, which unrelated gameplay tests may still reference.
TEST_CASE( "session_cleanup_removes_wait_popup_and_restarts_progress_ui",
           "[.wait_popup_cleanup]" )
{
    REQUIRE( test_mode );
    avatar &u = get_avatar();
    REQUIRE_FALSE( u.has_effect( effect_sleep ) );

    ImGuiContext *previous = ImGui::GetCurrentContext();
    ImGuiContext *context = ImGui::CreateContext();
    on_out_of_scope restore_context( [&]() {
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

    restore_on_out_of_scope restore_turn( calendar::turn );
    restore_on_out_of_scope restore_quit( g->uquit );
    restore_on_out_of_scope restore_activity( u.activity );
    restore_on_out_of_scope restore_backlog( u.backlog );
    restore_on_out_of_scope restore_view_offset( u.view_offset );
    const point_rel_ms driving_offset = g->driving_view_offset;
    on_out_of_scope restore_driving_offset( [&]() {
        g->set_driving_view_offset( driving_offset );
    } );
    restore_on_out_of_scope restore_zones( zone_manager::get_manager() );
    on_out_of_scope restore_progress_ui( [&]() {
        u.remove_effect( effect_sleep );
        u.activity = player_activity();
        g->handle_progress_ui();
    } );

    u.activity = player_activity();
    g->handle_progress_ui();
    const size_t baseline = ui_adaptor::ui_stack_size();
    calendar::turn = calendar::turn_zero + 17_seconds;
    REQUIRE_FALSE( calendar::once_every( 1_minutes ) );

    bool has_popup = true;
    SECTION( "sleeping" ) {
        u.add_effect( effect_sleep, 1_hours );
        REQUIRE( u.has_effect( effect_sleep ) );
    }
    SECTION( "trying_to_fall_asleep" ) {
        u.activity = player_activity( try_sleep_activity_actor( 1_hours ) );
    }
    SECTION( "waiting" ) {
        u.activity = player_activity( ACT_WAIT, to_moves<int>( 1_hours ) );
    }
    SECTION( "no_wait_popup" ) {
        has_popup = false;
    }
    g->handle_progress_ui();
    REQUIRE( ui_adaptor::ui_stack_size() == baseline + ( has_popup ? 1 : 0 ) );

    // Exercise the shared end-of-session cleanup without death screens or
    // graveyard/world writes. The caller has already saved before QUIT_SAVED.
    g->uquit = QUIT_SAVED;
    CHECK( cleanup_preserving_loaded_submaps() );
    CHECK( ui_adaptor::ui_stack_size() == baseline );
    CHECK( cleanup_preserving_loaded_submaps() );
    CHECK( ui_adaptor::ui_stack_size() == baseline );

    // Independently verify first-frame state, even if the cleanup assertion
    // above fails on the old implementation and leaves the popup alive.
    g->wait_popup_reset();
    g->uquit = QUIT_NO;
    calendar::turn += 1_seconds;
    REQUIRE_FALSE( calendar::once_every( 1_minutes ) );
    if( !has_popup ) {
        u.activity = player_activity( ACT_WAIT, to_moves<int>( 1_hours ) );
    }
    // No idle progress frame runs between sessions; a loaded save may already
    // contain sleep or an activity. Its first popup must appear immediately.
    g->handle_progress_ui();
    CHECK( ui_adaptor::ui_stack_size() == baseline + 1 );

    if( u.has_effect( effect_sleep ) ) {
        u.remove_effect( effect_sleep );
        g->handle_progress_ui();
        CHECK( ui_adaptor::ui_stack_size() == baseline );
    } else {
        // Cancellation already releases the popup before the next redraw.
        u.cancel_activity();
        CHECK( ui_adaptor::ui_stack_size() == baseline );
    }
}
