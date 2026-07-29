#pragma once
#ifndef CATA_SRC_CATALUA_UI_H
#define CATA_SRC_CATALUA_UI_H

#include <cstddef>
#include <cstdint>
#include <optional>
#include <string>
#include <string_view>
#include <variant>
#include <vector>

class Character;
class Creature;
class item;
class mapgendata;

namespace cata::lua_ui
{

constexpr int minimum_api_version = 2;
constexpr int api_version = 5;

constexpr bool is_enabled() noexcept
{
#if defined(CATA_ENABLE_LUA_UI) && CATA_ENABLE_LUA_UI
    return true;
#else
    return false;
#endif
}

struct runtime_status {
    bool loaded = false;
    std::size_t generation = 0;
    std::size_t world_generation = 0;
    std::size_t page_count = 0;
    std::size_t event_handler_count = 0;
    std::size_t mapgen_handler_count = 0;
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

struct page_info {
    std::string id;
    std::string title;
    std::string category;
    std::vector<std::string> slots;
    int order = 100;
};

struct native_callback_point {
    std::string coordinate_space;
    int x = 0;
    int y = 0;
    int z = 0;
};

struct native_callback_id {
    std::string kind;
    std::string value;
};

using native_callback_value = std::variant <
                              bool, std::int64_t, double, std::string,
                              const Character *, const Creature *, const item *,
                              native_callback_point, native_callback_id,
                              std::vector<std::string> >;

struct native_callback_argument {
    std::string name;
    native_callback_value value;
};

using native_callback_arguments = std::vector<native_callback_argument>;

struct native_menu_entry {
    std::string id;
    std::string label;
    bool enabled = true;
};

struct native_hook_result {
    bool allowed = true;
    bool handled = false;
    std::string text;
    std::optional<std::string> result;
    std::vector<std::string> results;
    std::vector<native_menu_entry> menu_entries;
};

// Dispatch detached native payloads to API-v5 hooks and callback actors.
// Missing runtimes or handlers are fail-open.  A false result is only
// meaningful for a documented intercept/decision callback.
native_hook_result dispatch_native_hook_result(
    std::string_view name,
    const native_callback_arguments &arguments = {} );
bool dispatch_native_hook(
    std::string_view name, const native_callback_arguments &arguments = {} );
bool has_native_hook( std::string_view name );
void dispatch_native_monster_spawn(
    const Creature &monster, std::string_view source );
void dispatch_native_npc_spawn(
    const Character &npc, std::string_view source );
bool dispatch_native_callback(
    std::string_view kind, std::string_view target,
    std::string_view method,
    const native_callback_arguments &arguments = {} );
bool has_native_callback(
    std::string_view kind, std::string_view target,
    std::string_view method );
std::vector<native_menu_entry> collect_native_callback_menu_entries(
    std::string_view kind, std::string_view target,
    std::string_view method,
    const native_callback_arguments &arguments = {} );
std::vector<native_menu_entry> collect_native_hook_menu_entries(
    std::string_view name,
    const native_callback_arguments &arguments = {} );

// Lua module names are converted from dotted names to paths below data/lua or
// config/lua.  Exposed for focused tests of the sandbox boundary.
bool is_safe_module_name( std::string_view name );

// Reload all bundled, active-mod, and user scripts as one transaction.  A
// failed reload leaves the previous runtime active.
bool reload_scripts( std::string &error );

// Run deterministic due callbacks once after the game turn advances.
void on_turn();

// Invoke final, bounded Lua mapgen handlers for one newly generated OMT.
// Worker threads never enter Lua, and builds without Lua provide a no-op.
void dispatch_mapgen_postprocess( mapgendata &data );

// Load scripts after a new game or save has finished initializing.  Errors are
// logged and reported through status(), without aborting game startup.
void on_world_ready();

// Save small typed character and world state to independent sidecars.  Page
// state is session-only.  A sidecar failure is reported but must never
// invalidate the main game save.
bool save_persistent_state( std::string &error );

// Tear down event subscriptions and page state when leaving a game.
void shutdown();

// Snapshot runtime health for debug tools and tests.
runtime_status status();

// Compile and execute a standalone snippet with the same CPU guard used by
// runtime callbacks.  This does not expose game bindings.
bool validate_snippet( std::string_view source, int instruction_limit, std::string &error );

// Platform-neutral page registry.  Slots are logical navigation locations,
// never pixel coordinates.  Complete pages use the shared ImGui/ImTui host.
// Android's native schema-6 HUD is a separate subsystem.
std::vector<page_info> registered_pages( std::string_view slot = {} );
bool has_registered_pages( std::string_view slot = {} );
bool show_page( std::string_view page_id );
void show_slot( std::string_view slot );

// Open one page requested by a Lua event callback at the next safe game-input
// boundary.  Returns true when a request was handled.
bool process_pending_navigation();

// Reload scripts, let the user choose a registered page, and run it as a
// regular cataimgui window.  The runtime is initialized lazily on first use.
void show();

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_H
