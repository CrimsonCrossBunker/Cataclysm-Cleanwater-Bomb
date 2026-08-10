# `data/lua/` agent instructions

This subtree contains two distinct contracts:

- the implemented Lua API v5 runtime, manifest, examples, inventories, and
  LuaLS declarations; and
- `LUA_FIRST_PLATFORM.md`, the accepted Platform v1 architecture for future
  pure-Lua core and Mod authoring.  Its implementation status is tracked in
  `ai/lua-first-roadmap.yml`.

- `manifest.schema.json`, `types/ccb_api_v5.d.lua`, native registrations, and
  generated inventories are authoritative for the currently shipped v5 API.
- `types/ccb_platform_v1.d.lua` declares only the separately versioned
  Platform surface with matching native source.  Implemented-but-unverified
  entries stay distinct from available v5 APIs; do not merge its types into v5.
- `LUA_FIRST_PLATFORM.md` is authoritative for Platform v1 design decisions;
  do not present a roadmap item as implemented without matching source and
  tests.
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
- `tools/migrate_lua_first.py` may emit native Lua skeletons and explicit TODO
  reports.  It must never generate a JSON loader, EOC runner, or raw legacy
  object as a hidden compatibility path.
- Platform Mods must not require a `lua/` subdirectory or author-maintained
  JSON manifest.  Templates may recommend structure but may not require it.

Validation:

```sh
python3 tools/lua_api/check_luals_declarations.py
python3 tools/lua_api/check_coverage.py
python3 -m unittest discover -s tools/lua_api -p 'test_*.py'
python3 tools/agent/check_project_metadata.py
```

CCB-Docs 只能解释这些契约；与本目录声明或注册冲突时，应更新并标记文档，
不得以文档覆盖契约。
