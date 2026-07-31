# Lua API coverage tools

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

`check_luals_declarations.py` compares the API v5 LuaLS file to all 438 native
methods across 66 registered tables, the 55 tables attached to `game`, all 15
native usertypes, and all 36 generated coordinate factories. It rejects an
unmapped newly registered table, verifies every `game.*` field's API class,
checks that each stub's parameter annotations match its callable signature,
rejects duplicate methods and fields, requires named option records instead of
opaque `table` parameters, and rejects a stale v4 declaration:

```sh
python3 tools/lua_api/check_luals_declarations.py
python3 -m unittest tools.lua_api.test_check_luals_declarations
```
