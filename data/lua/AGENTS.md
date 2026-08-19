# `data/lua/` agent instructions

This subtree contains:

- the implemented CCB Lua 0.1 runtime, manifest, examples, inventories, and
  LuaLS declarations; and
- `LUA_FIRST_PLATFORM.md`, the platform architecture specification for pure-Lua
  core and Mod authoring. Its implementation status is tracked in
  `ai/lua-first-roadmap.yml`.

- `manifest.schema.json`, `types/ccb_api_v5.d.lua`, native registrations, and
  generated inventories are authoritative for the current Lua runtime contract.
- `LUA_FIRST_PLATFORM.md` is authoritative for CCB Lua 0.1 platform design decisions.
- `LUA_FIRST_EOC_WORKFLOW.md` defines the active EOC-capability objective,
  domain-batch development cadence, and deferred acceptance gate.  Follow it
  for Lua-first EOC parity work.
- Never hand-edit generated reference inventories; run their named generator.
- Maintenance of existing v5 code keeps declaring the minimum capabilities it
  uses.  New Platform code follows the separately versioned Platform contract
  and does not expose JSON loaders or EOC-key-shaped APIs.
- Keep examples runnable and synchronized with declarations.
- `templates/minimal/` and `templates/complete/` contain no JSON/EOC and are
  copied by `tools/create_lua_mod.py`; never make their suggested directories
  loader requirements.  The complete template's Mod-id token is replaced only
  in the scaffold staging directory before atomic installation.
- `ai/lua-first-replacement-ledger.yml` is generated.  Change its generator,
  never the ledger by hand, and do not promote a planned selector without
  source, declaration, test, and documentation evidence.
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
- During implementation, do not compile C++, start Catch2, regenerate every
  inventory, or run broad validation after each edit.  Defer execution to the
  batch acceptance gate unless a check is needed to unblock an otherwise
  unresolved native signature or safety boundary.
- At acceptance, compile once and run one broad matching Catch2 process.
  Focused filters are diagnostic follow-ups after a failure, not prerequisites
  for a broad suite that will exercise the same code.
- Do not rerun a passing gate unless a later change touched its evidence.

Final acceptance commands are selected from `ai/test-matrix.yml`; common Lua
contract commands include:

```sh
python3 tools/lua_api/check_luals_declarations.py
python3 tools/lua_api/check_coverage.py
python3 -m unittest discover -s tools/lua_api -p 'test_*.py'
python3 tools/agent/check_project_metadata.py
```

CCB-Docs 只能解释这些契约；与本目录声明或注册冲突时，应更新并标记文档，
不得以文档覆盖契约。
