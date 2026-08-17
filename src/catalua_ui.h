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

#include "catalua_ui_state.h"
#include "coordinates.h"

class Character;
class Creature;
class const_talker;
class item;
class mapgendata;
struct dialogue;
struct talk_topic;

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
    std::size_t action_menu_entry_count = 0;
    std::size_t sidebar_widget_count = 0;
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

struct action_menu_entry_info {
    std::uint64_t registration_id = 0;
    std::string id;
    std::string name;
    std::string category;
    std::string source;
    int hotkey = -1;
    bool enabled = true;
};

struct sidebar_widget_info {
    std::uint64_t registration_id = 0;
    std::string key;
    std::string id;
    std::string name;
    std::string source;
    int height = 1;
    std::optional<int> order;
    bool default_toggle = true;
    bool redraw_every_frame = false;
    bool enabled = true;
};

struct sidebar_widget_line {
    std::string text;
    std::string color;
};

enum class world_ready_kind : int {
    new_game,
    loaded_game
};

struct native_callback_point {
    std::string coordinate_space;
    tripoint_rel_ms pos;
};

struct native_callback_id {
    std::string kind;
    std::string value;
};

struct native_callback_mission {
    int uid = 0;
};

using native_callback_value = std::variant <
                              bool, std::int64_t, double, std::string,
                              const Character *, const Creature *, const item *,
                              native_callback_point, native_callback_id,
                              std::vector<std::string>, const const_talker *,
                              native_callback_mission >;

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
bool native_hook_contract_exists( std::string_view name );
// Shared hook-contract query used by Lua-first Platform dispatch.  This does
// not expose a legacy handler: it reports which aggregate result fields the
// native hook site understands (for example `allow`, `result`, or `entries`).
bool native_hook_supports_result_field( std::string_view name,
                                        std::string_view field );
std::vector<std::string> collect_native_mapgen_factory_usages(
    const std::vector<std::string> &candidates );
void dispatch_native_monster_spawn(
    const Creature &monster, std::string_view source );
void dispatch_native_npc_spawn(
    const Character &npc, std::string_view source );
std::string dispatch_character_display_skill_info(
    const Character &character, std::string_view skill );
bool dispatch_character_display_skill_action(
    const Character &character, std::string_view skill,
    std::string_view action );
native_hook_result dispatch_native_dialogue_hook(
    std::string_view name, const const_talker &alpha,
    const const_talker &beta, std::string_view topic,
    std::optional<std::string_view> option = std::nullopt,
    bool by_radio = false,
    std::optional<std::string_view> reason = std::nullopt );
void clear_dialogue_response_callbacks();
std::optional<std::string> dialogue_dynamic_line(
    dialogue &d, const talk_topic &topic );
bool gen_lua_dialogue_responses(
    dialogue &d, const talk_topic &topic );
void extend_lua_dialogue_responses(
    dialogue &d, const talk_topic &topic );
talk_topic apply_lua_dialogue_response(
    dialogue &d, std::uint64_t response_id, const talk_topic &fallback );
bool begin_native_npc_interaction(
    const Character &avatar, const Character &npc );
bool allow_native_monster_interaction(
    const Character &avatar, const Creature &monster );
bool allow_native_elevator_use(
    const Character &character,
    const native_callback_point &position,
    const native_callback_point &destination );
bool dispatch_native_callback(
    std::string_view kind, std::string_view target,
    std::string_view method,
    const native_callback_arguments &arguments = {} );
bool dispatch_native_consuming_callback(
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

// Invoke a Lua handler registered by an active script source.  Calls made
// without an active Lua runtime or a matching handler fail open.
bool invoke_lua_handler(
    std::string_view handler, const script_value_map &args,
    const native_callback_arguments &context = {} );

// Lua module names are converted from dotted names to paths below data/lua or
// config/lua.  Exposed for focused tests of the sandbox boundary.
bool is_safe_module_name( std::string_view name );

// Reload all bundled, active-mod, and user scripts as one transaction.  A
// failed reload leaves the previous runtime active.
bool reload_scripts( std::string &error );

// In Lua-enabled builds, parse manifests and execute the top-level scripts for
// explicit Mods in a separate, non-active Lua runtime state.  Top-level APIs
// execute normally, but --check-mods never subscribes callbacks, dispatches
// lifecycle events, or commits script state.  Builds without Lua skip this.
bool validate_mod_scripts( const std::vector<std::string> &mod_ids,
                           std::string &error );

// Run deterministic due callbacks once after the game turn advances.
void on_turn();

// Invoke final, bounded Lua mapgen handlers for one newly generated OMT.
// Worker threads never enter Lua, and builds without Lua provide a no-op.
void dispatch_mapgen_postprocess( mapgendata &data );
bool dispatch_mapgen_generate( mapgendata &data );

// Load scripts after a new game or save has finished initializing.  Errors are
// logged and reported through status(), without aborting game startup.
void on_world_ready(
    world_ready_kind kind = world_ready_kind::loaded_game );

// Dispatch the exact pre-save game hook once.  Persistent sidecars are written
// later by save_persistent_state().
void on_game_save();

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

// Source-owned action-menu entries are replaced transactionally with the Lua
// runtime.  Invocation restores the registering source's capabilities and
// applies the normal callback instruction budget.
std::vector<action_menu_entry_info> registered_action_menu_entries();
bool invoke_action_menu_entry( std::uint64_t registration_id );

// Source-owned PC sidebar widgets are replaced transactionally with the Lua
// runtime.  Android's schema-6 native HUD remains an independent consumer.
// Draw and visibility callbacks restore source capabilities, are instruction
// bounded, and disable only the failing widget.
std::vector<sidebar_widget_info> registered_sidebar_widgets();
bool sidebar_widget_visible( std::string_view key );
std::vector<sidebar_widget_line> render_sidebar_widget(
    std::string_view key, int width, int height );

// Open one page requested by a Lua event callback at the next safe game-input
// boundary.  Returns true when a request was handled.
bool process_pending_navigation();

// Reload scripts, let the user choose a registered page, and run it as a
// regular cataimgui window.  The runtime is initialized lazily on first use.
void show();

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_H
