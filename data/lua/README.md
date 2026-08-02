<!-- CCB-DOC-MOVED-START -->
> [!IMPORTANT] **Moved / 已迁移**
>
> Stable document ID / 稳定文档 ID: `lua.v5.overview`
> 中文: https://crimsoncrossbunker.github.io/CCB-Docs/api/lua/v5/overview/
> English: https://crimsoncrossbunker.github.io/CCB-Docs/en/api/lua/v5/overview/
> Moved date / 迁移日期: `2026-08-02`
> Last in-repository commit / 仓库内最后适用 commit: `0378ca2b84303cf614c617c9d9eaa50138cd21ff`
> The maintained documentation now lives in CCB-Docs.
> This in-repository body is no longer maintained. The historical body is retained through `2027-02-02` and may then be removed; this bilingual entry banner remains permanently.
> 本仓库正文不再维护；历史正文至少保留到上述日期，之后可删除，但本双语迁移入口永久保留。
<!-- CCB-DOC-MOVED-END -->
# Lua Mod API v5

This directory contains the built-in Lua entry point and modules for the
experimental, versioned Mod runtime. API v5 is the first comprehensive native
gameplay surface: it combines portable UI, modules, services, events,
scheduling, persistent state, typed values and ids, generation-safe handles,
detached definition/snapshot queries, controlled world mutations, native
hooks, callback actors, mapgen, crafting, character progression, EOCs,
statistics, achievements, weather and calendar control, vehicle/NPC/faction
services, zones, action-menu entries, and PC sidebar widgets. Native pointers
never cross the Lua boundary; reads are bounded snapshots and writes are
validated, capability-gated operations.

The drawing context targets the platform-neutral `script_ui_renderer`
contract. Complete pages use the shared ImGui page host on Android and desktop
Tiles; terminal builds use the ImTui fallback. Desktop keeps its established
keyboard UI and Widget sidebar; Android applies a separate touch profile and
owns the native schema-6 HUD. Scripts do not import or depend on a renderer
backend.

The current platform policy is Android on SDL3, with Linux, macOS, and Windows
using SDL2 while their SDL3 migration is paused. API v5 code should use
`ctx:environment()` for layout and interaction decisions. `ctx:platform()` is
retained for API v2 diagnostics and must not be used to distinguish touch from
desktop interaction.

## Bootstrap profiles

Before the world Lua runtime exists, an isolated data-only Lua loader selects
one built-in profile:

- `ui/profiles/android_touch.lua`
- `ui/profiles/pc_legacy.lua`
- `ui/profiles/terminal_legacy.lua`

These files return one schema-checked table. They receive no standard
libraries, game bindings, file access, or Mod search path and run under small
memory and instruction limits. Invalid profiles fall back to compiled C++
defaults, so a UI edit cannot make the game unbootable.

Profiles own physical metrics and input mapping. Page and Mod code owns only
semantic content and actions. Android may therefore render a normal action as
a large tappable button while PC retains keyboard navigation and its original
sidebar.

## Build availability

The Lua Mod runtime is compiled into desktop and Android builds by default.
Developers can still produce a Lua-free build explicitly with
`CATA_ENABLE_LUA_UI=0` when using Make, or
`-DCATA_ENABLE_LUA_UI=OFF` when configuring CMake.

When disabled, Lua, sol2, the script runtime, its action queue, and its tests
are not compiled or linked. The game does not load scripts, create Lua state
sidecars, or expose the Lua UI debug-menu entry.

## Developer files

- `manifest.schema.json` is the authoritative JSON Schema for
  `lua/manifest.json`. Use the Schema's stable repository URL in a Mod so the
  reference remains valid after copying the Mod to another directory.
- `types/ccb_api_v5.d.lua` is a LuaLS/EmmyLua declaration file for the complete
  public v5 surface. Add this directory to the editor workspace library; never
  `require` the declaration at runtime.
- `reference/ccb_public_api_v5.json` is the generated public denominator for
  CCB-Docs. It records every callable access path, class and field, native
  usertype member and operator, enum family, event and field, hook, callback,
  capability, permission rule, and Manifest field with source locations.
  `reference/ccb_public_api_v5_coverage.json` proves inventory coverage and
  deliberately reports published CCB-Docs coverage separately.
- `examples/api_v5_mod/` is a complete source example covering modules,
  services, hooks, scheduling, typed values, registry queries, state, pages,
  named actions, action-menu integration, and a sidebar widget.
- `reference/cbn_api_inventory.json` pins the 2,398-entry CBN reference surface
  at commit `584939ce64c9d7352d37024132d968c3163edbe2`;
  `reference/cbn_coverage.json` records a verified CCB mapping for every entry.

Regenerate and validate the public contract with:

```sh
python3 tools/lua_api/generate_public_contract.py
python3 tools/lua_api/generate_public_contract.py --check
python3 tools/lua_api/check_public_contract.py
python3 tools/lua_api/check_examples.py --require-luac
python3 -m unittest discover -s tools/lua_api -p 'test_*.py'
```

The CBN mapping percentage is an upstream capability audit, not CCB public API
documentation coverage. Only the v5 public-contract coverage file has the
complete current CCB denominator.

CCB takes the useful structural lessons from Cataclysm: Bright Nights—one
environment per Mod, local modules, explicit lifecycle stages, hot reload, and
developer documentation—but deliberately does not copy BN's unrestricted
native-object binding model. API v5 maps every applicable recorded CBN
capability to typed values, detached snapshots, generation-bound tokens, or
controlled operations. The sole not-applicable reference is CBN's
distribution-grid tracker, whose engine subsystem does not exist in CCB.

## Loading and hot reload

Scripts are loaded as one transaction in this order:

1. `data/lua/main.lua`
2. `lua/main.lua` from each active world mod, in mod load order
3. `config/lua/main.lua`

The user entry point therefore has the final opportunity to replace a page by
registering the same id. In API v4 and v5, `require("foo.bar")` searches only the
calling source's root and accepts both `foo/bar.lua` and
`foo/bar/init.lua`. Cross-source source-code reuse must use
`modules.import(provider_id, "foo.bar")`, and the provider must be `builtin`,
the caller itself, or an earlier source listed in `dependencies`. API v2/v3
retain their legacy reverse-load-order `require` lookup for compatibility.
Module names may only contain letters, digits, `_`, `-`, and `.` and cannot
contain empty segments.

Every source executes in an independent environment. Module exports are cached
per consumer, not globally: two Mods importing the same provider module never
share its mutable export table. Imported source code executes with the
consumer's capabilities. Use a versioned `services` contract, not
`modules.import`, when the provider must retain its own capability identity.

The runtime loads automatically after a new game or save has initialized.
Open a page from **Main menu → Other → Extensions**, the in-game
**Extensions** entry, or **Debug menu → Info… → Open Lua UI pages**, depending
on the slots registered by that page. Android also exposes `settings.mods`
pages from its touch options screen. Desktop keeps the original options UI, so
desktop mods should also register a main-menu or in-game slot. Press
**Reload Lua** after editing a script; recompiling the game is not required.
Every entry script is loaded into a new Lua state first. If any script fails,
the candidate state is discarded and the currently running state stays active.

Each source may contain `lua/manifest.json`:

```json
{
  "$schema": "./manifest.schema.json",
  "id": "my_mod_id",
  "version": "1.0.0",
  "api_version": 5,
  "capabilities": [
    "events",
    "game.callbacks",
    "game.hooks",
    "game.read",
    "game.write",
    "registry.read",
    "scheduler",
    "ui.pages"
  ],
  "dependencies": [ "another_mod_id" ]
}
```

API versions 2 through 5 are accepted. New code should target v5. Supported
capabilities are:

- `events`
- `game.actions`
- `game.actions.dangerous`
- `game.callbacks`
- `game.hooks`
- `game.read`
- `game.write`
- `modules.import`
- `registry.read`
- `scheduler`
- `services.consume`
- `services.provide`
- `state.character`
- `state.page`
- `state.world`
- `ui.pages`

The dangerous-action, module-import, registry, scheduler, and service
capabilities require API v4. `game.callbacks`, `game.hooks`, and `game.write`
require API v5. `game.actions.dangerous` requires `game.actions`;
`game.write` requires `game.read`; `game.hooks` requires `events`; and
`game.callbacks` requires `game.read`. Unknown capabilities, an incompatible
API, duplicate ids, missing dependencies, or dependencies that load later
reject the whole candidate transaction. The bundled manifest is mandatory. A
local user script without a manifest keeps compatibility capabilities but
never receives dangerous-action or v5 mutation authorization. An active game
Mod without a manifest receives all compatibility capabilities except game
actions and v5 mutation capabilities; declare mutations explicitly.

Callbacks retain the manifest identity that registered them. Replacing a page
id, loading a helper through `require`, or firing an event later never borrows
the capabilities of a more privileged source.

## Registration

```lua
ui.page("inventory_tools", "Inventory tools", function(ctx, params)
    ctx:text("Hello, " .. game.player_name())
end)

ui.page("my_mod_settings", {
    title = "My mod",
    category = "settings",
    order = 50,
    slots = { "settings.mods", "main.extensions", "ingame.extensions" }
}, function(ctx, params)
    ctx:heading("My mod settings")
end)

events.on("avatar_moves", function(event)
    print(event.type, event.turn, event.data.terrain)
end)
```

Registering the same page id again replaces the earlier definition. Event
registrations are additive. An event payload contains `type`, `turn`, `data`,
and `data_types`. Boolean and integer fields keep their Lua types; other
game-specific ids and coordinates are exposed as strings.

Lua has no `ui.hud` surface. Android uses the native schema-6 layout for
in-game information and controls. API v5 can register source-owned
`sidebar` widgets in PC's original native Widget sidebar; these intentionally
do not cross into the Android Java HUD. Use a portable `ui.page` for information
that must be available on every platform.

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
under the Mods entry in Android's touch options page. Re-registering a page
during hot reload keeps the selected page when its stable id still exists.

## Events, lifecycle, and scheduler

`events.on(name, callback)` returns an owned subscription id.
`events.off(id)` can remove only the current source's subscription. The options
form adds stable priority ordering and one-shot delivery:

```lua
local subscription = events.on("avatar_moves", {
    priority = 100,
    once = true
}, function(event)
    print(event.type, event.turn)
end)
events.off(subscription)
```

Higher priorities run first; equal priorities retain registration order. A
handler returning `false` stops propagation for that emission. A failing
handler is removed without disabling unrelated callbacks.

A plain, non-game event name is source-local. Emit only copied scalar data:

```lua
events.on("quest_updated", function(event)
    print(event.data.quest_id, event.data.stage)
end)
events.emit("quest_updated", { quest_id = "intro", stage = 2 })
```

To observe a dependency's custom event, declare the dependency and call
`events.on_from(provider_id, name, callback)`. Custom payloads accept at most 32
string keys and only booleans, finite numbers, and strings; the complete copied
map is limited to 16 KiB. Custom-event and service recursion are independently
limited to 16 calls.

Native game events have a separately discoverable, strictly typed surface:

```lua
for _, name in ipairs(game.native_events.list()) do
    local description = game.native_events.describe(name)
    print(name, #description.fields, description.emittable)
end

local save_subscription = game.native_events.on(
    "game_save",
    { priority = 10 },
    function(event)
        print(event.type, event.turn)
    end
)
game.native_events.off(save_subscription)
```

`events.native_types()` and `events.describe_native(name)` provide the same
catalogue for code that also targets the global event facade.
`game.native_events.emit(name, fields)` is intentionally narrower than custom
`events.emit`: it is available only inside an active runtime callback, requires
`events`, `game.read`, and `game.write`, and accepts exactly the native field
set returned by `describe`. Missing or extra fields, wrong Lua types, invalid
typed ids, and malformed coordinate strings are rejected before anything
enters the native event bus.

Lifecycle event names are:

- `ccb.lifecycle.reload`, delivered to the new successful hot-reload runtime;
- `ccb.lifecycle.world_ready`, after a new game/save runtime has loaded;
- `ccb.lifecycle.before_save`, before the Lua sidecars are written;
- `ccb.lifecycle.after_save`, with `success` and `error` fields;
- `ccb.lifecycle.shutdown`, before a world/runtime is discarded.

The deterministic scheduler uses game turns, never wall-clock time:

```lua
local one_shot = scheduler.after(10, function(id, now, due)
    print("ten turns elapsed", id, now, due)
end)

local repeating
repeating = scheduler.every(60, function()
    -- Returning false also cancels a repeating callback.
    return state.character.get("enabled", true)
end)

scheduler.cancel(one_shot)
print(scheduler.now())
```

Delays and intervals are 1..1,000,000,000 turns. A runtime may own at most 256
tasks and executes at most 64 due callbacks in one turn. Ordering
is by due turn and then registration order. Tasks and callbacks are replaced
transactionally on hot reload.

## Modules and services

Use `require` for modules inside the current source. Use
`modules.import(provider_id, module_name)` only for declared source-code
dependencies. Both forms accept `foo.lua` and `foo/init.lua`; traversal,
absolute paths, native searchers, dynamic libraries, and arbitrary file loads
are unavailable.

Services are the privilege-preserving cross-Mod boundary:

```lua
services.provide("quest.api", {
    version = 2,
    methods = {
        get = function(arguments)
            return {
                id = arguments.id,
                stage = state.world.get("stage." .. arguments.id, 0)
            }
        end
    }
})

if services.available("story_mod", "quest.api", 2) then
    local quest = services.call(
        "story_mod", "quest.api", "get", { id = "intro" })
end
```

`services.provide` replaces one service atomically. A service has 1..64 unique
methods and a version in 1..1,000,000. `services.list()` returns only services
owned by the caller, `builtin`, or declared dependencies. Calls execute under
the provider's capability identity and instruction budget, then copy the
result back to the consumer. Arguments and results accept at most 64 scalar
entries, 8 KiB per string, and 64 KiB total; tables, functions, userdata, and
native object references cannot cross the boundary.

## Definition registry

`registry` exposes read-only, detached definition snapshots for `item`,
`monster`, `terrain`, `furniture`, `recipe`, `mutation`, `bionic`, and `skill`.
It never returns a C++ pointer or a live mutable definition.

```lua
local page = registry.list("item", {
    offset = 0,
    limit = 64,
    query = "water",
    details = false
})
for _, entry in ipairs(page.entries) do
    local detail = registry.get("item", entry.id)
    print(detail.id, detail.name, detail.weight_grams)
end
```

The default page size is 64 and the maximum is 256. Search matches stable ids
and translated names. `registry.revision()` changes when the language-backed
index is rebuilt; use it to invalidate cached labels. Returned tables are
fresh snapshots and may be changed locally without altering game data.

## API v5 values, ids, and handles

API v5 does not expose borrowed C++ objects. It uses three kinds of values:

- immutable `GameId`, `GameEnum`, unit, time, and coordinate userdata;
- detached Lua tables for definitions and state snapshots; and
- generation-bound tokens or `GameHandle` values for live instances.

```lua
local avatar = game.handles.avatar()
assert(avatar:is_valid())

local water = game.types.id("item", "water")
local position = game.coords.tripoint_abs_ms(100, 200, 0)
local delay = game.time.duration(30, "minutes")
local mass = game.units.new("mass", 2.5, "kilogram")

print(water.kind, water.value, water:is_valid())
print(position:to("omt"), delay:display(), mass:value("gram"))
```

`game.types.id_kinds()`, `game.units.kinds()`, `game.coords.kinds()`, and
`game.enums.kinds()` are the runtime catalogues. Coordinate values carry both
origin and scale; mismatched arithmetic and lossy conversions throw instead of
silently mixing spaces. `project_remain` and `project_combine` preserve the
remainder when changing scale. Bounded `line`, `rectangle`, and `box`
constructors accept an explicit maximum point count.

`game.time.now()`, `game.time.turn_zero()`, and
`game.time.before_time_starts()` return exact `TimePoint` values. `TimeDuration`
stores exact turns. `game.time.snapshot(point)` expands a point into its
calendar, season, moon, sunrise/sunset, and day/night values;
`game.time.calendar()` captures the native world calendar and start points.
`set_now` and `advance` accept an optional expected clock for optimistic
conflict detection and deliberately do not simulate skipped turns.

`game.weather.types/type`, `current`, and `generator` expose copied native
weather data. `forecast` is deterministic, bounded to 14 days, and does not
mutate generator state. Weather, temperature, and wind overrides are explicit
checked writes and `clear_overrides()` restores all native defaults. Unit
values reject cross-dimension arithmetic and expose a checked conversion
through `value(unit)`.

`game.enums.describe(kind)` records whether an old CBN enum is native,
represented by a JSON id, or not applicable. `game.definitions` is the typed
counterpart of the compatibility `registry`: `describe`, `exists`, `get`, and
`list` accept `GameId` values and return detached data.

`game.serde` serializes only the documented immutable values, booleans,
numbers, strings, and bounded acyclic tables. The format has explicit size,
depth, node, and table-entry limits and never invokes a constructor named by
serialized input.

A live `GameHandle` contains an opaque locator plus the runtime and world
generation in which it was created. Use `handle:is_valid()` or
`handle:status()` before retaining it. Native service calls return a result
envelope:

```lua
local result = game.characters.snapshot(avatar)
if result.ok then
    print(result.value.name)
else
    print(result.error.code, result.error.message)
end
```

Handles become invalid when their object disappears, the world changes, or a
successful Lua reload replaces the runtime. Lua can never construct or edit a
handle's locator.

## API v5 gameplay services

All namespaces below require API v5 and `game.read`; mutating functions also
require `game.write`. Every operation validates ids, coordinate spaces,
generations, ranges, and result limits before touching native state; crafting
and spell casting enter their existing safe action queues. The declaration
file gives every method's exact parameters and result type.

| Namespace | Read surface | Controlled write surface |
| --- | --- | --- |
| `game.creatures` | avatar, position and nearby queries, snapshots | — |
| `game.characters` | avatar/by-id/nearby and detailed snapshots | stats, healing, movement mode |
| `game.effects` | list, presence and snapshot | add, update, remove |
| `game.bionics` | definitions and installed instances | install, remove, power, activation, configuration |
| `game.items` | snapshots, pockets, contents, variables, flags, techniques | bounded item field/variable/flag/technique updates |
| `game.inventory` | traversal, lookup and resource checks | give, remove, wield, wear, stash |
| `game.mutations` | definitions and character state | grant, remove, activate, choose variant |
| `game.spells` | definitions, spellbook and mana | learn/forget, experience/level/mana, favorite, queued cast |
| `game.missions` | definitions, tokens, status and random selection | reserve, assign, select, advance, complete/fail/cancel/abandon |
| `game.recipes` / `game.requirements` | filtered recipes and structured requirements | — |
| `game.crafting` | — | queue a validated craft start |
| `game.world` | active-map bounds, tiles, regions and vehicles | terrain/furniture/traps/fields/items |
| `game.overmap` | existing-only tile/search/match queries | terrain, vision, exploration, notes and reveal |
| `game.hordes` | group definitions, entities, legacy groups and summaries | spawn/update/remove/signal/advance |
| `game.skills` | skill definitions and character levels/training | bounded level, exercise, training and practice updates |
| `game.proficiencies` | definitions, categories and learning progress | grant/remove/practice/set progress |
| `game.vitamins` / `game.addictions` | definitions and character pools/state | bounded pool, exposure and withdrawal updates |
| `game.needs` | hunger, thirst, calories, sleep and health | checked set/modify/reset operations |
| `game.martial_arts` | style definitions, known and selected state | learn/remove/select/trigger and hand policy |
| `game.vehicles` | prototypes, live state, lift, parts and fuels | rename, cruise/stop/tracking and part enablement |
| `game.npcs` | class catalogue and live NPC snapshots | rename, attitude and opinion updates |
| `game.factions` / `game.camps` | faction resources/relations and bounded camp discovery | reputation/resources/policy/ownership/board updates |
| `game.zones` | zone types, tokens, position and membership | create/rename/enable/move/remove |
| `game.eocs` / `game.variables` | authored EOC metadata and talker variables | callback-scoped test/activate/queue and checked variables |
| `game.achievements` / `game.statistics` | achievement progress, event history, transformations and scores | manual achievement controls |
| `game.time` / `game.weather` | native calendar, forecasts, definitions and current state | conflict-checked clock and explicit weather overrides |
| `game.native_events` | all 113 native event schemas and subscriptions | exact-schema callback-scoped event emission |

Additional bounded services replace the remaining CBN game helpers:

- `game.messages.recent/add`, `game.constants.snapshot`, and
  `game.random.int/chance`;
- `game.sound.play/play_ambient` and the platform-neutral
  `game.targeting` selectors;
- `game.spawns.monster/hallucination`, `game.followers.list/add/remove`, and
  guarded `game.relocation.local_at/overmap_at`;
- `game.world.to_absolute/to_bubble` for explicit coordinate conversion; and
- `game.diagnostics.snapshot/recent` for path-free runtime health and errors.

Sound, targeting, spawn, follower mutation, relocation, random, message-write,
and other interaction services require an active callback. Relocation also
requires `game.actions.dangerous`. This prevents a top-level script or a draw
loop from moving the player or repeatedly opening native interaction UIs.

`game.api_catalog()` returns the native capability-domain catalogue and
`game.api_supports(domain)` returns true only for a fully covered domain. The
repository's stricter CBN comparison lives in
`reference/cbn_coverage.json`: its schema-2 audit joins all 2,398 pinned
inventory entries to implementation and test evidence. The current native
inventory records 132 typed-id kinds, 190 JSON definition types, 113 native
events, and 39 reviewed capability domains; CCB-specific CDDA-derived systems
are included in addition to the CBN reference mapping.

## Hooks and callback actors

`game.hooks` exposes 52 typed native lifecycle boundaries. Call
`game.hooks.list()` or `describe(name)` to discover each hook's payload,
result fields, mode, and capability requirements. Observe hooks ignore return
values. Intercept hooks accept only their declared result fields and require
`game.write`.

```lua
local id = game.hooks.on("on_character_try_move", {
    priority = 100,
}, function(payload)
    if state.character.get("freeze_movement", false) then
        return { allow = false }
    end
end)

-- A source can remove only its own registration.
game.hooks.off(id)
```

Priority is -10000..10000; higher values run first and equal values retain
registration order. `once = true` removes a handler after its first delivery.
Payloads use typed ids, coordinates, handles, mission tokens, or detached
tables. Invalid return keys/types reject only that invocation. A throwing or
over-budget handler is disabled without affecting other Mods.

`game.callbacks` attaches Lua methods to one validated JSON definition. The 11
kinds are `iuse`, `iwieldable`, `iwearable`, `iequippable`, `istate`, `imelee`,
`iranged`, `bionic`, `mutation`, `trap`, and `monster`.

```lua
local bandage = game.types.id("item", "bandages")
game.callbacks.register("iuse", bandage, {
    priority = 20,
    can_use = function(payload)
        return { allow = payload.character ~= nil }
    end,
    on_use = function(payload)
        game.messages.add("Lua item callback ran", "good")
        return true
    end,
})
```

Use `game.callbacks.list()` or `describe(kind)` for the exact method catalogue
and whether a method is a decision gate. A descriptor must contain at least
one valid method; unknown fields are rejected. Registrations are source-owned,
hot-reload transactional, bounded globally and per target, and restore the
registering source's permissions whenever native C++ calls them.

## Mapgen callbacks

`game.mapgen.on_postprocess(options, callback)` registers a filtered,
deterministic callback for one 24×24 OMT mapgen operation:

```lua
game.mapgen.on_postprocess({
    terrain_ids = { "field" },
    z_min = 0,
    z_max = 0,
}, function(ctx)
    if ctx:random_chance(1, 20) then
        ctx:set_terrain(12, 12, game.types.id("terrain", "t_grass"))
    end
end)
```

The callback-scoped `ScriptMapgenContext` exposes neighbor ids, rotation,
deterministic random values, terrain/furniture/trap reads and writes,
groundcover, bounded nested generators, and a tightly limited full generator.
It becomes invalid immediately after the callback. Each context has an
operation budget; filters accept at most 64 existing overmap terrain ids.

## Native action menu and PC sidebar

API v5 can place a source-owned entry in the native action menu:

```lua
local menu_id = game.action_menu.register({
    id = "open_my_mod",
    name = "My Mod",
    category = "info",
    hotkey = "m",
}, function()
    ui.open("my_mod_settings")
end)
```

`off`, `list`, and `limits` are source-scoped. Built-in category ids sort with
their native categories; safe custom category ids are also accepted. Callbacks
run under their registering source's permissions and instruction budget.

The global `sidebar` table, also available as `game.sidebar`, implements the
CBN-compatible `register_widget`, `clear_widgets`, and `get_layout_id` calls,
plus `register`, `off`, `list`, and `limits`:

```lua
sidebar.register_widget({
    id = "my_status",
    name = "My status",
    height = 2,
    order = 500,
    default_toggle = true,
    draw = function()
        return {
            { text = "Lua ready", color = "light_green" },
            game.time.now():display(),
        }
    end,
})
```

The stable native panel key is `lua:<source-id>:<widget-id>`. Player toggle and
ordering choices survive hot reload. `draw` may return a multiline string,
string array, or `{ text, color }` line array. `panel_visible` may be a boolean
or callback; `render` is an optional compatibility callback. A bad widget
disables only itself. Per-source/runtime counts, line count, per-line bytes,
total output, height, and callback instructions are all bounded.

Lua sidebar widgets are mounted only in PC's native sidebar. Android's Java
schema-6 HUD remains an independent surface and never calls into Lua.

## Page navigation

Every page callback receives `function(ctx, params)`. The second argument is an
empty table when the page was opened from a navigation slot, so API v2
one-argument callbacks remain valid. A page or event callback may request safe
navigation:

```lua
ui.page("quest_detail", "Quest detail", function(ctx, params)
    ctx:heading(params.title or "Quest")
    if ctx:button_id("back", i18n.gettext("Back")) then
        ui.back()
    end
end)

events.on("game_begin", function(event)
    ui.open("quest_detail", {
        title = event.data.cdda_version,
        first_visit = true
    })
end)
```

- `ui.open(page_id, params)` pushes a registered page onto the current host.
- `ui.back()` pops one page; at the root it closes the host.
- `ui.close()` closes the complete page host.

Navigation is queued and consumed after the active draw/event callback has
returned, so Lua never creates or destroys an ImGui window in the middle of a
frame. Entry scripts cannot navigate while they are registering surfaces. An
event-triggered open is consumed at the next normal game-input boundary.

The queue holds at most 16 requests and a host stack holds at most 32 pages. An
`ui.open` parameter table accepts at most 32 unique string keys and only
boolean, integer, finite floating-point, or string values. Keys are limited to
64 bytes, strings to 4096 bytes, and the complete table to 16 KiB. A target
must already be registered and its id must contain 1 to 128 bytes.

## Localization

Use the renderer-independent `i18n` facade for visible strings:

```lua
local title = i18n.gettext("Inventory")
local hint = i18n.pgettext("Lua tool hint", "Back")
local count = i18n.ngettext("%d item", "%d items", item_count)
local contextual = i18n.npgettext(
    "Lua inventory count", "%d item", "%d items", item_count
)
local revision = i18n.language_revision()
```

These functions return owned Lua strings from the active game catalogue.
`language_revision()` changes after the game language changes and can be used
to invalidate a Mod's own translated-label cache. Message and context sizes
are bounded; plural counts must be non-negative.

## Drawing context

The callback receives a safe `ctx` facade. It deliberately does not expose
manual ImGui Begin/End or Push/Pop pairs, so one script cannot corrupt the
global ImGui stack.

`ctx` is ephemeral: it is valid only while the page's current draw callback is
running. Do not save it in a global, table, closure, scheduled callback, event
handler, or service. Calls through a retained context are rejected after draw
returns. Keep persistent values in Lua or the scoped `state` APIs and use the
fresh `ctx` supplied to each redraw.

Renderer metadata lets a script choose a portable fallback without importing
backend-specific APIs:

```lua
ctx:backend()             -- "imgui"
ctx:platform()            -- "sdl2", "sdl3", or "imtui"
ctx:is_immediate_mode()   -- true for ImGui/ImTui
ctx:uses_native_widgets() -- false for the current renderer
ctx:supports("text_input")

local env = ctx:environment()
env.profile                -- android_touch/pc_legacy/terminal_legacy
env.input                  -- touch/mouse_keyboard/terminal
env.density                -- touch/comfortable/compact
env.breakpoint             -- narrow/regular/wide
env.touch
env.hover
env.keyboard_navigation
env.long_press_dangerous
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

API v3 replaces physical layout values with profile tokens:

```lua
ctx:text_tone("Ready", "good")
ctx:item_width("normal") -- compact/normal/wide/fill

ctx:scroll("details", "normal", function()
    ctx:text("The profile decides the region height.")
end)

ctx:grid("cards", 1, 2, 3, function()
    -- narrow/regular/wide column counts; use table_next_row/column as usual.
end)

ctx:virtual_list_rows(#items, "compact", function(first, last)
    for index = first, last - 1 do
        ctx:text(items[index + 1])
    end
end)
```

Semantic tones are `normal`, `muted`, `good`, `warning`, `bad`, and `info`.
Interactive widgets automatically use the touch profile's minimum target on
Android. Mods do not mark a widget as “Android-clickable”.

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
stable id that is unique within the page callback:

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

An action slot is a semantic action control whose selected action is validated
against the exact input-context revision that produced it:

```lua
local input = game.actions.context_snapshot()
local selected = game.state_get("action.ground_action", "pickup")
selected = ctx:action_slot_id("ground_action", selected, input.revision, {
    { id = "pickup", label = "拾取" },
    { id = "drop", label = "丢脚下" },
    { id = "drop_adj", label = "丢旁边" }
})
game.state_set("action.ground_action", selected)
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

Android has no Lua HUD renderer, retained Lua widget tree, or direct
Java-to-Lua interaction bridge. Schema 6 is the only Android in-game HUD. It
has no automatically injected layout.
The first time an input scene is observed, Android creates one empty layout.
Future official templates must be explicitly chosen and copied once; they
never merge into or overwrite a user layout.

A HUD scene has a stable `hud_scene_id` and title independent of its keybinding
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
Lua pages are not information sources for schema 6. Original C++/JSON Widgets
remain the shared information contract: PC keeps the original sidebar renderer
while Android projects those Widgets into editable HUD information elements.

Controls carry the exact input-context revision they rendered. An imported
action ID cannot execute unless it is registered by that current scene.
Destructive/debug actions remain visible in the catalogue, but a layout must
explicitly authorize each one and the player must long-press it at runtime.
Stale, unauthorized, or unregistered commands are rejected by the native
bounded queue.

Schema 6 is stored with Android `AtomicFile` under app-private storage.
Supported schema 4 and 5 files are validated and migrated when imported;
older archived HUD/extra-button preferences are never silently activated.
Export supports one layout or all scenes. Import always shows a validated
preview; full packages may be merged or may replace only the current schema-6
package.

Schema-6 game reads and snapshot publication run on the game thread. Android
Views poll immutable snapshots and never access live game objects. Leaving
gameplay invalidates the snapshot so controls and scene information cannot leak
into a different screen. Lua pages remain available on Android through the
ordinary ImGui page host and are unrelated to this HUD snapshot.

## Game API and reload state

- `game.api_version` is `5`. Manifests targeting API v2 through v4 remain
  accepted for their original surfaces.
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
- `game.runtime_status()` returns load state, runtime/world generations,
  page/action-menu/sidebar/event/mapgen/source counts, memory use and limit,
  latest runtime error, `callback_count`, `callback_time_total_us`,
  `callback_time_max_us`, `slow_callback_count`, and `last_slow_callback`. A
  callback taking at least 8 ms is recorded as slow; use these cumulative
  fields to find callbacks doing too much.
- `game.state_get(key, default)` and `game.state_set(key, value)` are the API v2
  compatibility state. They remain per-character and use their original,
  unnamespaced keys.

API v3 adds three explicitly scoped stores:

```lua
local enabled = state.character.get("enabled", false)
state.character.set("enabled", not enabled)

local chapter = state.world.get("chapter", 1)
state.world.set("chapter", chapter + 1)

-- Only legal while this page's draw callback is active.
local draft = state.page.get("draft", "")
state.page.set("draft", draft)
```

- `state.character` survives reloads and restarts for the current character.
- `state.world` survives reloads and restarts and is shared by characters in
  the current world.
- `state.page` survives successful hot reloads for the current runtime session,
  but is cleared when leaving/reloading a world. It is available only from a
  page draw callback.

Every API v3 key is automatically namespaced by the registering manifest id;
page keys are additionally namespaced by page id. Two Mods can therefore use
the same local key without collisions. A candidate reload receives copies of
all three stores and commits mutations only if every entry script succeeds.
Passing `nil` to a `set` function removes that key. Character state is stored
beside the normal save as `<encoded-character-id>.lua_ui.json`; world state is
stored as `<world>/lua_ui_world.json`. Both are restored before entry scripts
run. Page state is deliberately memory-only.

Local Lua variables are replaced on successful reload. Use the appropriate
state scope for values that should survive editing or restarting the game.
Each store is limited to 1024 keys, 256 bytes per stored namespaced key, 64 KiB
per string, and 512 KiB of key/value data; each persistent sidecar is limited
to 1 MiB. Invalid values and non-finite numbers are rejected before changing
the active state. A missing file means empty state; a damaged or unsupported
file is reported in `debug.log` and `game.runtime_status()` while the game and
Lua scripts continue with defaults. Failure to write either experimental
sidecar never invalidates the main game save.

All snapshot calls are read-only and return ordinary Lua tables containing
copied booleans, numbers, and strings. They never expose native `avatar`,
`item`, weather, or time objects, so scripts cannot retain dangling game-object
references across turns or reloads. Inventory results are bounded because page
callbacks may run every frame; request only the number of entries the current
UI needs.

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
`failed`, `canceled`, or `denied` and include request id, action type, turn, error, and
whether the request consumed a normal action. Invalid ids/options are rejected
before enqueue. Requests can only be submitted from an active page or event
callback—not while candidate entry scripts are loading—and are disabled in
multiplayer sessions.

`game.actions.context_snapshot()` is the separate, low-latency input action
catalogue used by Lua action controls. It returns:

```lua
{
    category = "DEFAULTMODE",
    hud_scene_id = "gameplay",
    hud_scene_title = "Gameplay",
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
scene, category, ids, or labels change. A UI trigger carries both action id and
the rendered revision into a 16-entry platform-neutral queue. Consumption
checks the revision again and confirms that the receiving context still
registered the id. Context changes clear pending actions.

API v4 also exposes
`game.actions.enqueue_context(action_id, context_revision)`. Ordinary named
actions require `game.actions`. Debug, deletion, reset, quickload, and suicide
actions additionally require the explicit `game.actions.dangerous` manifest
capability. Without it, their `context.available` value is false and action
slots are disabled. Even with the capability, a dangerous request is not
injected until the player approves a one-time native confirmation naming the
source and action. Revisions and registration are validated both before and
after confirmation. This action-id path is intentionally separate from the
turn-level `game.actions.enqueue(...)` mutation queue above.

Repeated input in the same context takes an id/catalog-token/language-generation
fast path, so normal movement does not rebuild or retranslate the complete
action list. Lua candidate validation is batched under one lock per action slot;
the final trigger is still revision-checked again when it enters the queue.

## Isolation and limits

Each runtime has a 32 MiB Lua memory limit. Every source receives a strict
environment with its own API and standard-library tables; there is no fallback
to a shared `_G`. Local globals remain visible to that source's entry script
and modules but cannot collide with another Mod.

Entry scripts and every page, event, scheduler, and service callback run under
an instruction budget. A callback that errors or exceeds its budget is removed
or disabled independently and the error is recorded in `debug.log`; other
callbacks continue. Budget errors cannot be suppressed with `pcall` or
`xpcall`; they propagate to the C++ callback boundary. A failed entry script
never replaces the current runtime.

Only the safe base functions and isolated package, math, string, and table
libraries are exposed. The package table has empty paths/searchers and exists
only for compatibility with the custom `require`. File and dynamic-code entry
points (`dofile`, `loadfile`, `load`, `loadstring`, `package.searchpath`, and
`package.loadlib`) are unavailable. `io`, `os`, `debug`, and native C modules
are not opened.

This is an application scripting boundary, not a security boundary for running
untrusted downloaded code. Keep installed Lua scripts under the same trust
model as installed game mods.
