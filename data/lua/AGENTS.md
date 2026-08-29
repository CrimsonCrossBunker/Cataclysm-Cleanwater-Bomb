# `data/lua/` agent instructions

This subtree contains the sole CCB Lua Platform runtime, examples, inventories,
and LuaLS declarations.  `LUA_FIRST_PLATFORM.md` is the architecture
specification for pure-Lua core and Mod authoring; implementation status is
tracked in `ai/lua-first-roadmap.yml`.

- `types/ccb_platform_v1.d.lua`, native Platform registrations, and generated
  Platform inventories are authoritative for the current Lua runtime contract.
- `LUA_FIRST_PLATFORM.md` is authoritative for CCB Lua 0.1 platform design decisions.
- `LUA_FIRST_EOC_WORKFLOW.md` defines the active EOC-capability objective,
  domain-batch development cadence, and deferred acceptance gate.  Follow it
  for Lua-first EOC parity work.
- Never hand-edit generated reference inventories; run their named generator.
- Do not add a second Lua runtime, `game.*` surface, capability sandbox,
  authored manifest, JSON loader, EOC runner, or EOC-key-shaped API. Useful
  native operations belong under the Platform contract; compatibility-only
  operations are deleted.
- Keep examples runnable and synchronized with declarations.
- `templates/minimal/` and `templates/complete/` contain no JSON/EOC and are
  copied by `tools/create_lua_mod.py`; never make their suggested directories
  loader requirements.  The complete template's Mod-id token is replaced only
  in the scaffold staging directory before atomic installation.
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

Development and validation cadence:

- Implement a coherent domain closure rather than one legacy selector at a
  time.  Add declarations, migration support, and test code in the same batch.
- During implementation, do not compile C++, start Catch2, run Python
  checkers, run generators, refresh the public contract/ledger/registry, or
  audit the full corpus after each edit. Defer all of them to the final batch
  gate unless a check is needed to unblock an otherwise unresolved native
  signature or safety boundary.
- At acceptance, compile once and run one broad matching Catch2 process.
  Focused filters are diagnostic follow-ups after a failure, not prerequisites
  for a broad suite that will exercise the same code.
- Do not rerun a passing gate unless a later change touched its evidence.

Final acceptance commands are selected from `ai/test-matrix.yml`; common Lua
contract commands include:

```sh
python3 tools/lua_api/check_luals_declarations.py
python3 tools/lua_api/check_platform_native_inventory.py
python3 tools/lua_api/check_platform_contract.py
python3 tools/lua_api/check_platform_coverage.py
python3 -m unittest discover -s tools/lua_api -p 'test_*.py'
python3 tools/agent/check_project_metadata.py
```

CCB-Docs 只能解释这些契约；与本目录声明或注册冲突时，应更新并标记文档，
不得以文档覆盖契约。
