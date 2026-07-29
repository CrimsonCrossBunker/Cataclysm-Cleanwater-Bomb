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

`check_coverage.py` classifies every recorded entry into one CCB capability
domain.  A domain can become `covered` only when it names both public API and
test evidence.  Planned entries continue to count as incomplete:

```sh
python3 tools/lua_api/check_coverage.py
python3 tools/lua_api/check_coverage.py --require-complete
```
