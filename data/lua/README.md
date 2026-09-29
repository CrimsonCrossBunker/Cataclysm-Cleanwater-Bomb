# CCB Lua-first Platform

CCB has one supported Lua runtime: Platform v1.  A Platform Mod is discovered
from its root `main.lua`; optional metadata is returned by `mod.lua` through
`ccb.ModDefinition`.  Mods do not use JSON manifests, an authored `lua/`
subdirectory, EOCs, or the former `game.*` API.

The architecture and authoring contract are documented in
[LUA_FIRST_PLATFORM.md](LUA_FIRST_PLATFORM.md). The short current goal and
progress page is [LUA_FIRST_EOC_WORKFLOW.md](LUA_FIRST_EOC_WORKFLOW.md).

LuaLS declarations are in `types/ccb_platform_v1.d.lua`.  Contract and
inventory checks are documented in
[tools/lua_api/README.md](../../tools/lua_api/README.md).
