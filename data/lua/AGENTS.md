# `data/lua/` agent instructions

This subtree contains two distinct contracts:

- the implemented Lua API v5 runtime, manifest, examples, inventories, and
  LuaLS declarations; and
- `LUA_FIRST_PLATFORM.md`, the accepted Platform v1 architecture for future
  pure-Lua core and Mod authoring.  Its implementation status is tracked in
  `ai/lua-first-roadmap.yml`.

- `manifest.schema.json`, `types/ccb_api_v5.d.lua`, native registrations, and
  generated inventories are authoritative for the currently shipped v5 API.
- `LUA_FIRST_PLATFORM.md` is authoritative for Platform v1 design decisions;
  do not present a roadmap item as implemented without matching source and
  tests.
- Never hand-edit generated reference inventories; run their named generator.
- Maintenance of existing v5 code keeps declaring the minimum capabilities it
  uses.  New Platform code follows the separately versioned Platform contract
  and does not expose JSON loaders or EOC-key-shaped APIs.
- Keep examples runnable and synchronized with declarations.
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
