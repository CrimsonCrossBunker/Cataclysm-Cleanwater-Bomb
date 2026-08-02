# Lua API v5 example Mod

This directory is a complete, intentionally small loadable Mod. Copy the whole
`api_v5_mod/` directory into `data/mods/` (or a user Mod directory) and enable
"CCB Lua API v5 Example". If you change the Mod id, change the Lua manifest id
and any provider ids in `main.lua` to match it.

The example demonstrates:

- a source-local module loaded with `require`;
- a versioned service with copied scalar arguments and results;
- custom and lifecycle events;
- a deterministic turn scheduler;
- read-only definition-registry search;
- character/page state;
- one page shared by Android touch, desktop ImGui, and terminal ImTui;
- named actions from the current input context;
- typed game values and detached definition lookup;
- native calendar/weather snapshots and native event schema subscriptions;
- a source-owned native action-menu entry and PC sidebar widget; and
- a typed native lifecycle hook.

The Android schema-6 HUD is deliberately not involved. Lua pages and the
native Android HUD are separate extension surfaces.

Repository validation checks `modinfo.json`, Manifest Schema conformance,
tracked Lua syntax, example references, and the equality of the Mod and Lua
source ids.
