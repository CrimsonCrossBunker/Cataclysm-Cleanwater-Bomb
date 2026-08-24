# CCB Lua 0.1 contract and coverage tools

## CCB Lua 0.1 public contract denominator

`generate_public_contract.py` joins the authoritative native registrations,
LuaLS declarations, Manifest Schema, event specifications, hook/callback
registries, enum registry, and the existing native inventory. It produces:

- `data/lua/reference/ccb_public_api_v5.json`, the immutable generated input
  for CCB-Docs API pages; and
- `data/lua/reference/ccb_public_api_v5_coverage.json`, the unique-symbol
  denominator and missing-documentation report.

Every callable contains parameter, return, error mode, API version,
introduction-status, deprecation, capability, source, example, and generated
documentation-id metadata. Dynamic enum values remain explicitly runtime
generated rather than being guessed. The generator also enforces native and
LuaLS member parity, all 113 native events and 242 fields, all 61 hooks, all
38 callback kind-method pairs, and Schema/runtime/LuaLS capability parity.

```sh
python3 tools/lua_api/generate_public_contract.py
tools/format/json_formatter.cgi data/lua/reference/ccb_public_api_v5.json
tools/format/json_formatter.cgi data/lua/reference/ccb_public_api_v5_coverage.json
python3 tools/lua_api/generate_public_contract.py --check
python3 tools/lua_api/check_public_contract.py
python3 tools/lua_api/check_examples.py --require-luac
python3 tools/lua_api/check_cmake_contract.py
python3 -m unittest discover -s tools/lua_api -p 'test_*.py'
```

`check_cmake_contract.py` keeps bundled Lua on the same ABI in Make and CMake.
Make compiles the bundled `.c` sources as C++, so CMake must also apply
`LANGUAGE CXX`; otherwise sol2 and the native bridge request C++-mangled
`lua_*` symbols from a C ABI archive. The checker also preserves `libsol`
propagation through `configure_lua_ui` while Lua-disabled builds remain inert.
It also prevents headless `--check-mods` from initializing options twice.  A
second initialization retains option-group registrations while clearing their
options, emits `D_ERROR`, and makes an otherwise successful validation exit 1.

Generated JSON must not be edited by hand. The coverage file distinguishes
100% inventory coverage from CCB-Docs publication coverage; the latter stays
`null` until the stacked documentation PR publishes the generated reference.
`check_public_contract.py` validates both generated outputs against their
Draft 2020-12 Schemas as well as rebuilding them from every authority.

## CBN comparison inventory

`generate_cbn_inventory.py` records the public Lua surface exposed by a
specific Cataclysm: Bright Nights checkout.  The checked-in snapshot is a
reference inventory, not a compatibility contract: CCB keeps its own API
names and maps each applicable capability to a safer CCB equivalent.

Regenerate the snapshot from a CBN checkout:

```sh
python3 tools/lua_api/generate_cbn_inventory.py \
  --cbn-root /path/to/Cataclysm-BN \
  --output data/lua/reference/cbn_api_inventory.json
```

Validate the committed snapshot without requiring a CBN checkout:

```sh
python3 tools/lua_api/generate_cbn_inventory.py \
  --check-snapshot data/lua/reference/cbn_api_inventory.json
```

`generate_cbn_coverage.py` expands the pinned inventory into the checked-in
schema-2, entry-level audit:

```sh
python3 tools/lua_api/generate_cbn_coverage.py
tools/format/json_formatter.cgi data/lua/reference/cbn_coverage.json
python3 tools/lua_api/generate_cbn_coverage.py --check-snapshot
```

The snapshot check compares parsed JSON so the repository formatter may apply
its canonical layout without making the generated coverage data appear stale.

Every one of the 2,398 inventory entries has:

- a canonical key and an exact copy of its inventory selector;
- a completion status and CCB capability domain;
- the CCB API that replaces the CBN binding;
- repository-relative `path#needle` implementation and test evidence; and
- a reason when, and only when, the status is `not_applicable`.

The generator contains the reviewed architectural mappings.  Hooks map to
their exact `game.hooks.on("<name>", handler)` registration, callback actors
map to their exact CCB callback kind, and callback methods map to the matching
descriptor field.  Most native-object functions map at capability-domain
level because CCB deliberately replaces CBN's borrowed native objects with
bounded snapshots, typed handles, and controlled operations.

`check_coverage.py` joins the audit back to the inventory by canonical key.
It rejects missing, duplicate, stale, or inexact selectors, invalid status
transitions, empty mappings, missing evidence, and stale evidence anchors.
`planned` entries continue to count as incomplete:

```sh
python3 tools/lua_api/check_coverage.py
python3 tools/lua_api/check_coverage.py --require-complete
```

Run the validator regression suite with:

```sh
python3 -m unittest tools.lua_api.test_check_coverage
```

The only accepted `not_applicable` entry is
`get_distribution_grid_tracker`: it exposes CBN's power-distribution engine
subsystem, which CCB does not contain.  Coordinate conversion, action-menu
entries, native sidebar widgets, and bounded diagnostics all have CCB
equivalents and must not be classified as exceptions.

`check_luals_declarations.py` compares the API v5 LuaLS file to all 748 native
methods across 81 registered tables, the 65 tables attached to `game`, all 16
native usertypes, and all 36 generated coordinate factories. It rejects an
unmapped newly registered table, verifies every `game.*` field's API class,
checks that each stub's parameter annotations match its callable signature,
rejects duplicate methods and fields, requires named option records instead of
opaque `table` parameters, and rejects a stale v4 declaration:

```sh
python3 tools/lua_api/check_luals_declarations.py
python3 -m unittest tools.lua_api.test_check_luals_declarations
```
