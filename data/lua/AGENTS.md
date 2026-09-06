# `data/lua/` agent instructions

This subtree contains the sole CCB Lua Platform runtime, examples, inventories,
and LuaLS declarations.  `LUA_FIRST_PLATFORM.md` is the architecture
specification for pure-Lua core and Mod authoring; implementation status is
tracked in `ai/lua-first-roadmap.yml`.

- `types/ccb_platform_v1.d.lua`, native Platform registrations, and generated
  Platform inventories are authoritative for the current Lua runtime contract.
- `LUA_FIRST_PLATFORM.md` is authoritative for CCB Lua 0.1 platform design decisions.
- `LUA_FIRST_EOC_WORKFLOW.md` defines the active EOC-capability objective,
  domain-batch development cadence, and scoped acceptance gates.  Follow it
  for Lua-first EOC parity work.
- The accepted trust policy in `LUA_FIRST_PLATFORM.md` permits full standard
  libraries and external/native modules at the player's risk. Do not reintroduce
  sandbox tiers or mandatory global runtime quotas; preserve supported `ccb`
  correctness and lifetime checks. The current loader restrictions still need
  implementation changes, so do not describe the accepted policy as shipped.
- Never hand-edit generated reference inventories; run their named generator.
- Do not add a second Lua runtime, `game.*` surface, capability sandbox,
  authored manifest, JSON loader, EOC runner, or EOC-key-shaped API. Useful
  native operations belong under the Platform contract; compatibility-only
  operations are deleted.
- Keep examples runnable and synchronized with declarations.
- `templates/minimal/` and `templates/complete/` contain no runtime JSON/EOC and are
  copied by `tools/create_lua_mod.py`; never make their suggested directories
  loader requirements.  The complete template's Mod-id token is replaced only
  in the scaffold staging directory before atomic installation.
  The scaffolder may add optional `.luarc.json` and a frozen `.ccb-sdk/` for
  editor use; neither is a runtime manifest, and `--no-editor` omits them.
- `ai/lua-first-replacement-ledger.yml` is generated. Change its generator,
  never the ledger by hand. A bounded or primitive disposition is not
  completeness; only the final semantic gate may produce a verified status.
- `primitive_available_unverified` means only that composable native domain
  building blocks exist; it is not selector-level parity and must not be
  described as a completed migration.
- `bounded_implemented_unverified` means one or more explicitly named legacy
  shapes have source, declarations, tests, migration output, and documentation;
  it never claims that every legal shape of that selector has parity.
- `tools/migrate_lua_first.py` may emit native Lua skeletons and explicit TODO
  reports.  It must never generate a JSON loader, EOC runner, or raw legacy
  object as a hidden compatibility path.
- Platform Mods must not require a `lua/` subdirectory or author-maintained
  JSON manifest.  Templates may recommend structure but may not require it.

Follow `LUA_FIRST_EOC_WORKFLOW.md` for validation selection and cadence.
The single Lua contract gate includes live repository checks and tool regressions:

```sh
python3 -m unittest discover -s tools/lua_api -p 'test_*.py'
```

CCB-Docs 只能解释这些契约；与本目录声明或注册冲突时，应更新并标记文档，
不得以文档覆盖契约。
