# `data/lua/` agent instructions

Read `LUA_FIRST_EOC_WORKFLOW.md` for the current goal and progress. Source,
registrations, LuaLS declarations, and relevant tests define current behavior;
`LUA_FIRST_PLATFORM.md` records architectural decisions.

- Use `require("ccb")` as the sole behavior authoring entrypoint. Do not add
  v5, `game.*`, EOC-key APIs, or a second Lua runtime. Static JSON may remain.
- Full standard libraries and external/native modules are allowed at the
  player's risk; do not reintroduce a sandbox or mandatory global quotas.
- When changing a public API, update declarations and regenerate affected
  references with their generator. Never hand-edit generated files.
- Implement actual gameplay needs and add focused regression tests for changed
  behavior. Run relevant checks; a per-selector EOC audit is not a routine gate.
  Report what was not tested. The historical roadmap and generated ledger do
  not replace gameplay evidence.
- Keep templates and examples runnable; Mods need neither a `lua/` subdirectory
  nor an author-maintained JSON manifest.

CCB-Docs explains the contract. If it conflicts with source or declarations,
update the page instead of changing runtime behavior to match prose.
