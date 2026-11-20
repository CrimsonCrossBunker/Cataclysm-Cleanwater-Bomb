# `data/lua/` agent instructions

Read `LUA_FIRST_EOC_WORKFLOW.md` for current goals and `LUA_FIRST_PLATFORM.md` for architecture decisions.

- Use `require("ccb")` as the sole behavior entrypoint; do not add v5, `game.*`, EOC-key APIs, or a second Lua runtime.
- Allow full standard libraries and external/native modules; do not reintroduce a sandbox or mandatory global quotas.
- Update LuaLS declarations and regenerate references with their generator on public API changes (never hand-edit generated files).
- Keep templates/examples runnable; mods need neither a `lua/` subdirectory nor a manual JSON manifest.
- If CCB-Docs prose conflicts with source or declarations, fix the docs and leave runtime unchanged.
