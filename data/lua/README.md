# Lua UI API v2

This directory contains the built-in Lua entry point and modules for the
experimental, versioned UI runtime. The Lua drawing context targets the
platform-neutral `script_ui_renderer` contract. Complete pages use the shared
ImGui page host on Android and desktop Tiles; terminal builds use the ImTui
fallback. `ui.hud` uses that same host on non-Android builds only. Android's
in-game HUD is the separate native schema-4 subsystem and never calls Lua.
Scripts do not import or depend on any renderer backend.

The current platform policy is Android on SDL3, with Linux and Windows still
using SDL2 while their SDL3 migration proceeds separately. This does not alter
the Lua API: use `ctx:platform()` and renderer capabilities only when a layout
needs a portable fallback.

## Loading and hot reload

Scripts are loaded as one transaction in this order:

1. `data/lua/main.lua`
2. `lua/main.lua` from each active world mod, in mod load order
3. `config/lua/main.lua`

The user entry point therefore has the final opportunity to replace a page or
HUD by registering the same id. `require("foo.bar")` searches the user root,
active mods in reverse load order, and the built-in root. Module names may only
contain letters, digits, `_`, `-`, and `.` and cannot contain empty segments.

The runtime loads automatically after a new game or save has initialized.
Open a page from **Main menu → Other → Extensions**, the in-game
**Extensions** entry, **Options → Mods**, or
**Debug menu → Info… → Open Lua UI pages**, depending on the slots registered
by that page. Press **Reload Lua** after editing a script; recompiling the game
is not required.
Every entry script is loaded into a new Lua state first. If any script fails,
the candidate state is discarded and the currently running state stays active.

Each source may contain `lua/manifest.json`:

```json
{
  "id": "my_mod_id",
  "version": "1.0.0",
  "api_version": 2,
  "capabilities": [ "game.read", "ui.pages", "events" ],
  "dependencies": [ "another_mod_id" ]
}
```

Supported capabilities are `game.read`, `game.actions`, `ui.pages`, `ui.hud`,
`events`, and `state.character`. Unknown capabilities, an incompatible API,
duplicate ids, missing dependencies, or dependencies that load later reject
the whole candidate transaction. The bundled manifest is mandatory. A local
user script without a manifest keeps all capabilities for compatibility. An
active game mod without a manifest receives all compatibility capabilities
except `game.actions`; declare that capability explicitly before submitting
queued game mutations.

Callbacks retain the manifest identity that registered them. Replacing a page
id, loading a helper through `require`, or firing an event later never borrows
the capabilities of a more privileged source.

## Registration

```lua
ui.page("inventory_tools", "Inventory tools", function(ctx)
    ctx:text("Hello, " .. game.player_name())
end)

ui.page("my_mod_settings", {
    title = "My mod",
    category = "settings",
    order = 50,
    slots = { "settings.mods", "main.extensions", "ingame.extensions" }
}, function(ctx)
    ctx:heading("My mod settings")
end)

ui.hud("stamina", {
    title = "Stamina",
    anchor = "top_right", -- top_left/top_right/bottom_left/bottom_right
    x = 16,
    y = 16,
    alpha = 0.8,
    interactive = false,
    background = true,
    title_bar = false,
    contexts = { "DEFAULTMODE" } -- optional active input_context allow-list
}, function(ctx)
    local p = game.player_snapshot()
    ctx:progress_bar(p.stamina / math.max(1, p.stamina_max), "Stamina")
end)

events.on("avatar_moves", function(event)
    print(event.type, event.turn, event.data.terrain)
end)
```

Registering the same page or HUD id again replaces the earlier definition.
Event registrations are additive. An event payload contains `type`, `turn`,
`data`, and `data_types`. Boolean and integer fields keep their Lua types;
other game-specific ids and coordinates are exposed as strings.

`ui.hud` is not consumed on Android. Use Android HUD schema 4 for in-game
information and controls there. Cross-platform mods may still register a Lua
HUD for desktop/terminal builds alongside Android-specific schema-4 templates.

The string-title form of `ui.page` remains compatible and registers in
`main.extensions` and `ingame.extensions`. The descriptor form accepts:

- `title`: visible page name (defaults to the stable page id).
- `category`: navigation group (defaults to `general`).
- `order`: signed sort order, clamped to -10000..10000 (defaults to 100).
- `slots`: one or more logical destinations: `main.extensions`,
  `ingame.extensions`, `settings.mods`, or `debug.tools`.

Slots are navigation contracts, not pixel coordinates. A mod therefore
registers one page implementation and lets the page host place it correctly
for touch, mouse/keyboard, or terminal input. Pages in `settings.mods` appear
under the Mods entry in the shared Tiles options page. Re-registering a page
during hot reload keeps the selected page when its stable id still exists.

## Drawing context

The callback receives a safe `ctx` facade. It deliberately does not expose
manual ImGui Begin/End or Push/Pop pairs, so one script cannot corrupt the
global ImGui stack.

Renderer metadata lets a script choose a portable fallback without importing
backend-specific APIs:

```lua
ctx:backend()             -- "imgui"
ctx:platform()            -- "sdl2", "sdl3", or "imtui"
ctx:is_immediate_mode()   -- true for ImGui/ImTui
ctx:uses_native_widgets() -- false for the current renderer
ctx:supports("text_input")
```

Capability names are `colored_text`, `inline_layout`, `item_width`,
`progress_bar`, `buttons`, `selection`, `numeric_input`, `text_input`,
`child_regions`, `tables`, `tabs`, `trees`, `modals`, `tooltips`, and
`virtualization`, `radial_selection`, and `action_slots`. Radial selection
reports support for a center button with surrounding choices; renderers without
a radial layout may use a native popup/list fallback. Action slots are semantic
named-action controls backed by the active `input_context`, not synthetic keys.
Widget calls remain safe when a capability is unavailable; the adapter may
provide a simplified or read-only fallback.

Layout and text:

```lua
ctx:text("wrapped text")
ctx:heading("Section")
ctx:bullet_text("item")
ctx:disabled_text("hint")
ctx:text_colored("status", 0.2, 1.0, 0.4, 1.0)
ctx:separator()
ctx:same_line()
ctx:new_line()
ctx:spacing()
ctx:set_next_item_width(240)
ctx:progress_bar(0.75, "75%")
```

Inputs return the new value (or whether an action was activated):

```lua
if ctx:button("Apply") then end
if ctx:small_button("+") then end
enabled = ctx:checkbox("Enabled", enabled)
if ctx:radio_button("Mode A", mode == "a") then mode = "a" end
if ctx:selectable("Entry", selected) then selected = true end
count = ctx:slider_int("Count", count, 0, 100)
ratio = ctx:slider_float("Ratio", ratio, 0.0, 1.0)
count = ctx:input_int("Count", count)
ratio = ctx:input_float("Ratio", ratio)
name = ctx:input_text("Name", name)
```

The forms above use the visible label as the widget id for compatibility.
For translated labels, dynamic labels, or repeated labels, use an explicit
stable id that is unique within the page or HUD callback:

```lua
if ctx:button_id("apply_changes", "Apply") then end
enabled = ctx:checkbox_id("feature_enabled", "Enabled", enabled)
count = ctx:slider_int_id("item_count", "Count", count, 0, 100)
name = ctx:input_text_id("player_name", "Name", name)
```

A radial selector takes 1..8 stable options and returns the selected id, or an
empty string when no choice was made:

```lua
local selected = ctx:radial_select_id("movement", "行走", {
    { id = "walk", label = "行走\n0.00 秒", enabled = true, selected = true },
    { id = "run", label = "奔跑\n0.50 秒", enabled = true, selected = false }
})
```

An action slot is a semantic HUD control whose selected action is validated
against the exact input-context revision that produced it:

```lua
local input = game.actions.context_snapshot()
local selected = game.state_get("hud.ground_action", "pickup")
selected = ctx:action_slot_id("ground_action", selected, input.revision, {
    { id = "pickup", label = "拾取" },
    { id = "drop", label = "丢脚下" },
    { id = "drop_adj", label = "丢旁边" }
})
game.state_set("hud.ground_action", selected)
```

Pass only candidates present in `input.available`. With no available candidate
the widget is disabled, with one candidate the whole widget is a
single trigger, and with multiple candidates it becomes a large trigger plus a
small selector. Selecting a candidate returns its id; pressing the trigger
queues that named action directly in the renderer and does not return a
synthetic click or key. Stable widget ids and character state preserve the
choice across redraws and hot reloads.

Every interactive method has a matching `_id` form whose first argument is
the stable id and second argument is the visible label. Buttons report a
one-frame activation. Other inputs use a controlled-value model: the script
passes the current value on every draw and receives the updated value. This is
the shared interaction contract for ImGui/ImTui renderers.

Structured layout callbacks keep backend Begin/End and Push/Pop pairs outside
Lua, including when a nested callback raises an error:

```lua
ctx:child("scroll_region", 240, function()
    ctx:table("stats", 2, function()
        ctx:table_next_row()
        ctx:table_next_column()
        ctx:text("Strength")
        ctx:table_next_column()
        ctx:text("8")
    end)
end)

ctx:tabs("detail_tabs", function()
    ctx:tab("status", "Status", function() ctx:text("Ready") end)
    ctx:tab("history", "History", function() ctx:text("No entries") end)
end)

ctx:tree("advanced", "Advanced", false, function()
    ctx:tooltip("Rendered by the active backend")
    ctx:text("More settings")
end)

ctx:modal("confirm", "Confirm", modal_open, function()
    if ctx:button_id("confirm_yes", "Apply") then modal_open = false end
end)

ctx:virtual_list(#items, 24, function(first, last)
    for index = first, last - 1 do
        ctx:text(items[index + 1])
    end
end)
```

`ctx:table` accepts 1..64 columns. A virtual list accepts up to 1,000,000
logical items. The callback receives a zero-based, half-open `[first, last)`
visible range; render only that range (add one when indexing a normal Lua
sequence).

## Android HUD separation

Android never consumes `ui.hud` registrations and has no Lua HUD renderer,
snapshot JNI, retained widget tree, or Lua interaction bridge. Schema 4 is the
only Android in-game HUD. It has no built-in or dynamically injected layout.
The first time an input scene is observed, Android creates one empty layout.
Future official templates must be explicitly chosen and copied once; they
never merge into or overwrite a user layout.

An HUD scene has a stable `hud_scene_id` and title independent of its keybinding
category. This lets two actual screens that both use `UILIST` opt into separate
layouts. Every scene owns multiple named layouts and one active layout.
Android is landscape-only and uses one 1920×1080 virtual canvas, so there is no
portrait/landscape duplication.

A layout contains exactly three element types:

- An information element references one read-only native source.
- A control references one or more actions from that scene's last known action
  catalogue. The main region triggers the selected action; a small secondary
  region opens the complete candidate menu by default. Individual controls may
  instead configure that secondary region to cycle candidates one at a time.
- An element group contains nested information, controls, and groups.

Child positions are relative to the parent group's origin, while child sizes
remain in the same 1920×1080 units as root elements. Moving a group therefore
moves its entire subtree. Resizing a group does not scale or rewrite any child;
content outside the new group bounds is clipped. The editor only manipulates
the current hierarchy level. Enter a group before editing its children.

Open the full manager through the Android HUD option or hold three fingers on
the current game screen. The editor supports a grid, offline placeholder
previews, drag/resize, element properties, nested group navigation, undo,
redo, cancel, and Done. Edits remain in a detached draft; Done validates and
atomically commits the complete layout.

C++ owns the information-source catalogue and publishes only immutable values
subscribed by the active layout. Sources include the semantic pieces of the
mobile sidebar, formatted logs, the SDL pixel minimap, a 7×7 overmap grid, a
local square-cell threat radar, and every raw widget as an advanced source.
Lua pages and non-Android Lua HUDs are not information sources for schema 4.

Controls carry the exact input-context revision they rendered. An imported
action ID cannot execute unless it is registered by that current scene.
Destructive/debug actions remain visible in the catalogue, but a layout must
explicitly authorize each one and the player must long-press it at runtime.
Stale, unauthorized, or unregistered commands are rejected by the native
bounded queue.

Schema 4 is stored with Android `AtomicFile` under app-private storage.
Existing schema 1–3 HUD and old extra-button preferences are copied into a
separate archive and are not migrated or activated. Export supports one layout
or all scenes. Import always shows a validated preview; full packages may be
merged or may replace only the current schema-4 package.

Schema-4 game reads and snapshot publication run on the game thread. Android
Views poll immutable snapshots and never access live game objects. Leaving
gameplay invalidates the snapshot so controls and scene information cannot leak
into a different screen. Lua pages remain available on Android through the
ordinary ImGui page host and are unrelated to this HUD snapshot.

## Game API and reload state

- `game.api_version` is `2`.
- `game.add_msg(text)` writes to the game message log.
- `game.player_name()` returns the current avatar name.
- `game.player_snapshot()` returns copied character status: name, moves, stamina,
  stamina_max, pain, focus, speed, hunger, thirst, sleepiness, morale, stored_kcal,
  healthy_kcal, kcal_percent, radiation, bionic_power_kj,
  bionic_power_max_kj, current and desired movement-mode ids/names, whether a
  mode switch is pending, and absolute x/y/z. `game.player_stats()` remains as
  a compatibility alias with the same result.
- `game.time_snapshot()` returns turn, displayed year, stable `season_id`,
  translated `season_name`, one-based day of season, hour, minute, and display.
- `game.movement_modes_snapshot()` returns every movement mode with stable id,
  translated name, availability, current/desired flags, and the same switch
  move cost and seconds shown by the original movement-mode menu.
- `game.weather_snapshot()` returns stable id, translated name, Celsius and
  option-formatted temperatures, dangerous/raining flags, sight penalty, wind
  speed, and wind direction.
- `game.inventory_snapshot(limit)` returns `{ items, total, returned, limit,
  truncated }`. The default limit is 128 and values above 512 are capped; a
  negative limit is rejected. Each item contains stable id, translated display
  name and category, persistent instance `uid`, charges, charge-counting flag,
  weight in grams, volume in milliliters, direct contents count, and
  worn/wielded flags. This is the wielded, worn, and top-level character
  inventory view; it does not recursively flatten container contents.
- `game.effects_snapshot(limit)` returns current effects with stable id,
  translated name and short description, body part id, remaining duration,
  intensity, and permanence. The default limit is 64 and maximum is 512.
- `game.skills_snapshot(limit)` returns non-obsolete, non-contextual skills with
  practical and knowledge levels/progress, training/rust state, and combat
  classification. The default limit is 128 and maximum is 512.
- `game.equipment_snapshot(limit)` separates the wielded item and worn items.
  The default limit is 64 and maximum is 512.
- `game.item_contents_snapshot(uid, limit)` finds a carried item by its
  persistent instance UID and returns only its direct contents. The result
  reports `found` and `search_truncated`; lookup is capped at 4096 visited nodes
  and 16 nesting levels, while returned contents default to 128 and cap at 512.
- `game.current_tile_snapshot(field_limit)` returns the character's absolute
  position, terrain/furniture ids and names, outside/passable/move/light state,
  ground item count, bounded fields, and only traps the character can actually
  see. Field results default to 32 and cap at 512.
- `game.mutations_snapshot(limit)` returns stable ids, translated names and
  descriptions, active/activatable state, base/purifiable/threshold flags, and
  point values. The default limit is 128 and maximum is 512.
- `game.bionics_snapshot(limit)` returns each installed bionic's instance UID,
  stable id, translated name and description, powered/activatable/included
  state, timers, and activation energy. The default limit is 128 and maximum
  is 512.
- `game.missions_snapshot(limit)` returns active, completed, and failed missions
  with stable type id, instance UID, status, selection, deadline, and target
  metadata. The default limit is 128 and maximum is 512.
- `game.activity_snapshot(backlog_limit)` returns the current activity and a
  bounded backlog, including stable ids, verbs, progress, remaining work, and
  interruptibility. The backlog defaults to 64 entries and caps at 512.
- `game.nearby_creatures_snapshot(radius, limit)` returns only creatures the
  avatar can currently see, with kind, attitude, distance, and hit points.
  Radius defaults to 20 and caps at 60; count defaults to 64 and caps at 256.
- `game.runtime_status()` returns load state, generation, page/HUD/event/source
  counts, memory use and limit, latest runtime error, `callback_count`,
  `callback_time_total_us`, `callback_time_max_us`, `slow_callback_count`, and
  `last_slow_callback`. A callback taking at least 8 ms is recorded as slow;
  use these cumulative fields to find HUD or event callbacks doing too much
  per frame.
- `game.state_get(key, default)` and `game.state_set(key, value)` preserve small
  boolean, integer, floating-point, or string values across successful and
  failed hot reloads. Integer and floating-point number types remain distinct.
  A candidate reload receives a copy of the active state; its changes are only
  committed when every entry script succeeds. Passing `nil` to `state_set`
  removes a key. The state is saved per character in
  `<encoded-character-id>.lua_ui.json` beside the normal character save and is
  restored before entry scripts run. It therefore follows world snapshots and
  graveyard handling without being embedded in the main save format.

Local Lua variables are replaced on successful reload. Use the state API for
values that should survive editing or restarting the game. State is limited to
1024 keys, 256 bytes per key, 64 KiB per string, 512 KiB of key/value data, and
a 1 MiB sidecar file. Invalid values and non-finite numbers are rejected before
changing the active state. A missing file means empty state; a damaged or
unsupported file is reported in `debug.log` and `game.runtime_status()` while
the game and Lua scripts continue with defaults. Failure to write this
experimental sidecar never invalidates the main game save.

All snapshot calls are read-only and return ordinary Lua tables containing
copied booleans, numbers, and strings. They never expose native `avatar`,
`item`, weather, or time objects, so scripts cannot retain dangling game-object
references across turns or reloads. Inventory results are bounded because page
and HUD callbacks may run every frame; request only the number of entries the
current UI needs.

## Queued game actions

Game mutations use a bounded request queue instead of changing C++ objects in
the draw/event callback. This keeps hot reload transactional and lets the main
input loop validate and execute at most one request at a safe point:

```lua
local request_id = game.actions.enqueue("wait")
local moved = game.actions.enqueue("move", { direction = "north_east" })
local used = game.actions.enqueue("use_item", { uid = item.uid })
local toggled = game.actions.enqueue("toggle_mutation", { id = mutation.id })
local bionic = game.actions.enqueue("toggle_bionic", { uid = installed.uid })
local canceled_activity = game.actions.enqueue("cancel_activity")
local cycled_movement = game.actions.enqueue("cycle_move_mode")
local selected_movement = game.actions.enqueue("set_move_mode", { id = "crouch" })

game.actions.cancel(request_id) -- only while still queued
local queue = game.actions.status(32)
```

Allowed directions are `north`, `north_east`, `east`, `south_east`, `south`,
`south_west`, `west`, and `north_west`. The queue holds at most 64 requests and
keeps the latest 128 results. Status entries are `queued`, `succeeded`,
`failed`, or `canceled` and include request id, action type, turn, error, and
whether the request consumed a normal action. Invalid ids/options are rejected
before enqueue. Requests can only be submitted from an active page, HUD, or
event callback—not while candidate entry scripts are loading—and are disabled
in multiplayer sessions.

`game.actions.context_snapshot()` is the separate, low-latency input action
catalogue used by HUD controls. It returns:

```lua
{
    category = "DEFAULTMODE",
    revision = 17,
    actions = {
        {
            id = "pickup",
            label = "拾取",
            group = "items",
            repeatable = false,
            dangerous = false
        }
    },
    available = { pickup = true }
}
```

The active `input_context` republishes this immutable catalogue only when its
category, ids, or labels change. A UI trigger carries both action id and the
rendered revision into a 16-entry platform-neutral queue. Consumption checks
the revision again and confirms that the receiving context still registered
the id. Context changes clear pending actions; debug, deletion, reset,
quickload, and suicide actions are marked dangerous and cannot enter this HUD
queue. This action-id path is intentionally separate from the turn-level
`game.actions.enqueue(...)` mutation queue above.

Repeated input in the same context takes an id/catalog-token/language-generation
fast path, so normal movement does not rebuild or retranslate the complete
action list. Lua candidate validation is batched under one lock per action slot;
the final trigger is still revision-checked again when it enters the queue.

## Isolation and limits

Each runtime has a 32 MiB Lua memory limit. Entry scripts and every page, HUD,
and event callback run under an instruction budget. A callback that errors or
exceeds its budget is disabled independently and the error is recorded in
`debug.log`; other callbacks continue. A failed entry script never replaces
the current runtime.

Only the base, package, math, string, and table libraries are opened. File and
dynamic-code entry points (`dofile`, `loadfile`, `load`, `loadstring`, and
`package.loadlib`) are unavailable. `io`, `os`, and `debug` are not opened.

This is an application scripting boundary, not a security boundary for running
untrusted downloaded code. Keep installed Lua scripts under the same trust
model as installed game mods.
