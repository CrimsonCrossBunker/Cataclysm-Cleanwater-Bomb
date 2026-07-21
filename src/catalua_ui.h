#pragma once
#ifndef CATA_SRC_CATALUA_UI_H
#define CATA_SRC_CATALUA_UI_H

#include <cstddef>
#include <cstdint>
#include <string>
#include <string_view>

namespace cata::lua_ui
{

constexpr int api_version = 2;

struct runtime_status {
    bool loaded = false;
    std::size_t generation = 0;
    std::size_t page_count = 0;
    std::size_t hud_count = 0;
    std::size_t event_handler_count = 0;
    std::size_t source_count = 0;
    std::size_t memory_used = 0;
    std::size_t memory_limit = 0;
    std::uint64_t callback_count = 0;
    std::uint64_t callback_time_total_us = 0;
    std::uint64_t callback_time_max_us = 0;
    std::uint64_t slow_callback_count = 0;
    std::string last_slow_callback;
    std::string last_error;
};

// Lua module names are converted from dotted names to paths below data/lua or
// config/lua.  Exposed for focused tests of the sandbox boundary.
bool is_safe_module_name( std::string_view name );

// Reload all bundled, active-mod, and user scripts as one transaction.  A
// failed reload leaves the previous runtime active.
bool reload_scripts( std::string &error );

// Load scripts after a new game or save has finished initializing.  Errors are
// logged and reported through status(), without aborting game startup.
void on_world_ready();

// Save the current runtime's small typed state to a per-character sidecar.
// Failure is reported but must not invalidate the main game save.
bool save_persistent_state( std::string &error );

// Tear down event subscriptions and HUD adaptors when leaving a game.
void shutdown();

// Snapshot runtime health for debug tools and tests.
runtime_status status();

// Compile and execute a standalone snippet with the same CPU guard used by
// runtime callbacks.  This does not expose game bindings.
bool validate_snippet( std::string_view source, int instruction_limit, std::string &error );

// Android's Java UI thread only exchanges immutable JSON and queued widget
// events.  Lua callbacks and game snapshots remain on the game thread.
void publish_android_snapshot();
std::string android_snapshot_json();
bool submit_android_interaction( const std::string &widget_id, const std::string &encoded_value );
bool select_android_page( const std::string &page_id );

// Reload scripts, let the user choose a registered page, and run it as a
// regular cataimgui window.  The runtime is initialized lazily on first use.
void show();

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_H
