# Lua API v4 example Mod

This directory is a complete, intentionally small Lua source example. To turn
it into a real Mod, copy `lua/` into a Mod whose JSON `modinfo.json` id is
`ccb_lua_v4_example`, or change the manifest id and the provider id used in
`main.lua` to match your Mod.

The example demonstrates:

- a source-local module loaded with `require`;
- a versioned service with copied scalar arguments and results;
- custom and lifecycle events;
- a deterministic turn scheduler;
- read-only definition-registry search;
- character/page state;
- one page shared by Android touch, desktop ImGui, and terminal ImTui;
- named actions from the current input context.

The Android schema-6 HUD is deliberately not involved. Lua pages and the
native Android HUD are separate extension surfaces.
