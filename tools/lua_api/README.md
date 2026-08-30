# Lua-first Platform tools

This directory contains Platform-only declaration, native-registration, public
contract, and synchronization checks for CCB's sole Lua runtime.  The
authoritative LuaLS declaration is
`data/lua/types/ccb_platform_v1.d.lua`; native registration is discovered from
the workspace's `src/lua_platform_*` files.

The final generated reference outputs are:

- `data/lua/reference/ccb_platform_native_inventory.json`
- `data/lua/reference/ccb_platform_api_v1.json`
- `data/lua/reference/ccb_platform_api_v1_coverage.json`

Their explicit schemas are:

- `data/lua/reference/ccb_platform_native_inventory.schema.json`
- `data/lua/reference/ccb_platform_api_v1.schema.json`
- `data/lua/reference/ccb_platform_api_v1_coverage.schema.json`

The first output is produced by
`generate_platform_native_inventory.py`. The public-contract generator reads
that inventory plus the LuaLS declaration and validates its output against the
Platform v1 schema. The synchronization-coverage generator compares LuaLS
classes, native registration roots, and the public contract, also using its
explicit schema. Its result is not JSON/EOC migration parity or a historical
API coverage score.

The acceptance commands are intentionally documented here but are deferred to
the final batch gate:

```sh
python3 tools/lua_api/check_luals_declarations.py
python3 tools/lua_api/check_platform_native_inventory.py
python3 tools/lua_api/check_platform_contract.py
python3 tools/lua_api/check_platform_coverage.py
python3 tools/lua_api/check_cmake_contract.py
python3 -m unittest discover -s tools/lua_api -p 'test_*.py'
```

No historical API v5/CBN contract, authored manifest, capability sandbox, or
global `game.*` surface is part of the Platform workflow.
