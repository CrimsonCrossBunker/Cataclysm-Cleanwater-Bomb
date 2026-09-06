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

The single repository contract gate includes the five live contract checks
and their tool regressions (individual checker CLIs remain diagnostic tools):

```sh
python3 -m unittest discover -s tools/lua_api -p 'test_*.py'
```

No historical API v5/CBN contract, authored manifest, capability sandbox, or
global `game.*` surface is part of the Platform workflow.

## Mod author quick start

```sh
python3 tools/create_lua_mod.py /path/MyMod --template complete
```

Open the generated directory as a workspace in a LuaLS-enabled editor. The
scaffolder adds `.luarc.json` and `.ccb-sdk/ccb.lua` automatically. The SDK file
is a byte-for-byte snapshot of the selected release/checkout's LuaLS declaration;
`version.json` records Platform v1, Lua 5.4 and its SHA-256. Game packages already
include `data/lua/types/ccb_platform_v1.d.lua`; select the file from the actual
target game with `--declarations /path/game/data/lua/types/ccb_platform_v1.d.lua`.
This identifies editor declarations, not the executable currently running or a
promise of native/save compatibility. SDK files never auto-update.

The editor configuration provides completion and API diagnostics, resolves
`require("ccb")` to the SDK, and loads local author modules. The game continues
to provide its real `ccb` module. `.luarc.json` and `.ccb-sdk/` are optional
editor metadata, not a runtime manifest or executable content; omit them with
`--no-editor` or exclude them when packaging. Both templates check the Platform
major version before registering content. An exact declaration revision check
is an author upgrade aid, not a new mandatory runtime version system.

## Diagnose a Mod

With LuaLS installed (the CI/editor gate is tested with 3.19.1):

```sh
python3 tools/lua_api/mod_sdk.py check /path/MyMod
```

`--language-server /absolute/path/to/lua-language-server` selects an existing
server without installing one. Diagnostics include clickable absolute file,
line and column, a diagnostic code, and LuaLS's actual/expected type explanation.
Exit 0 means no warnings/errors in this static check; 1 means diagnostics;
2 means invalid SDK/setup or a failed checker. A crashed or silent checker is
never reported as a pass. This checks author files using the frozen declarations;
it does not audit the declaration library itself, execute callbacks, validate
native content IDs, or prove gameplay/save correctness. The library has existing
annotation gaps, so dynamically typed/undeclared portions need runtime validation.

Lua runtime failures still use the engine's existing Mod/handler context and
Lua error text in `debug.log`. This tooling does not add an in-game debugger or
state/task inspector. Use the game's existing `--check-mods` path for actual
loading, and exercise the affected behavior for runtime acceptance.

## Review an API upgrade

Create a separate scaffold with the target version's declarations, then compare:

```sh
python3 tools/lua_api/mod_sdk.py compare /path/OldMod /path/NewVersionScaffold
```

The JSON report shows the two SDK identities and added, removed, or changed
class/field/function declarations, including parameter and return annotations.
It never overwrites either project. Review changed declarations, read the game's
release/migration notes, then intentionally update the editor SDK and rerun static
and affected runtime checks. Unchanged signatures do not prove behavior parity;
the tool does not invent replacement APIs for removed symbols.

For an interface change, maintainers should explain its concrete before/after
behavior, replacement API if one exists, and save/data implications in release
notes. Preserve supported calls where practical or mark deprecation in LuaLS;
a signature report supplements that explanation, not a compatibility runtime.

## Editor acceptance

CI downloads a SHA-256-pinned LuaLS binary and runs the two real editor tests
once, separately from the fast tool tests. Locally, set `CCB_LUALS` to run them
inside the normal contract suite (otherwise they are explicitly skipped):

```sh
CCB_LUALS=/path/lua-language-server python3 -m unittest discover -s tools/lua_api -p 'test_*.py'
python3 tools/test_create_lua_mod.py
```

The editor gate checks both real templates and deliberately invalid author code
for unknown APIs, missing arguments and wrong argument types. It is a static
acceptance gate and does not trigger a C++ build or a full content audit.
