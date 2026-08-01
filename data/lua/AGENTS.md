# `data/lua/` agent instructions

This subtree contains the built-in runtime entry point, manifest schema,
examples, reference inventories, and LuaLS declarations for the public Lua API.

- `manifest.schema.json`, `types/ccb_api_v5.d.lua`, native registrations, and
  generated inventories are authoritative API contracts.
- Never hand-edit generated reference inventories; run their named generator.
- New code targets API v5 and declares the minimum capabilities it uses.
- Keep examples runnable and synchronized with declarations.

Validation:

```sh
python3 tools/lua_api/check_luals_declarations.py
python3 tools/lua_api/check_coverage.py
python3 -m unittest discover -s tools/lua_api -p 'test_*.py'
```

CCB-Docs 只能解释这些契约；与本目录声明或注册冲突时，应更新并标记文档，
不得以文档覆盖契约。
