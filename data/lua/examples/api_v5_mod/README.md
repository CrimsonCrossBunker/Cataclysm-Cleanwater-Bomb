# Lua API v5 example Mod

This directory is a complete, intentionally small Lua source example. To turn
it into a real Mod, copy `lua/` into a Mod whose JSON `modinfo.json` id is
`ccb_lua_v5_example`, or change the manifest id and the provider id used in
`main.lua` to match your Mod.

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
- a source-owned native action-menu entry and PC sidebar widget; and
- a typed native lifecycle hook.

The Android schema-6 HUD is deliberately not involved. Lua pages and the
native Android HUD are separate extension surfaces.
