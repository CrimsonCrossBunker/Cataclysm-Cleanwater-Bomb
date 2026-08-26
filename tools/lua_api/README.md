# Lua-first Platform checks

This directory contains checks for the repository's only supported Lua
runtime: Platform v1.  The authoritative declaration file is
`data/lua/types/ccb_platform_v1.d.lua`; native registrations live in
`src/catalua_loader.cpp`, `src/catalua_runtime.cpp`, and the Platform content
transactions.

Run the lightweight contract checks with:

```sh
python3 tools/lua_api/check_luals_declarations.py
python3 tools/lua_api/check_ccb_inventory.py
python3 tools/lua_api/check_cmake_contract.py
python3 -m unittest discover -s tools/lua_api -p 'test_*.py'
```

Generated native inventory is refreshed with
`python3 tools/lua_api/generate_ccb_inventory.py`.  No API v5 declaration,
manifest, capability sandbox, `game.*` surface, CBN inventory, or compatibility
contract is part of this workflow.
