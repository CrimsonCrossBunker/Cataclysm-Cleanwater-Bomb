# JSON and EOC contract inventories

`generate_contracts.py` creates three checked, machine-readable snapshots:

- `data/reference/json/ccb_json_object_types.json`
- `data/reference/json/ccb_eoc_conditions.json`
- `data/reference/json/ccb_eoc_effects.json`

The current snapshots cover all 191 `DynamicDataLoader` registration calls
(190 unique types), all 275 detected public condition keys, and all 306
detected public effect keys.  CI pins these counts until the source registries
change intentionally.  These are parser-registry coverage figures, not a
claim that every handler's field contract has been classified.

The output directory is outside `data/json/`, so the game data loader does not
mistake reference metadata for runtime content.  Discovery is restricted to
tracked paths returned by `git ls-files`; the generator never walks a checkout
or build cache.

Run the generator after changing `DynamicDataLoader` registrations, EOC parser
tables, or tracked JSON examples:

```sh
python3 tools/json_api/generate_contracts.py
make -j2 tools/format/json_formatter.cgi RELEASE=1
tools/format/json_formatter.cgi data/reference/json/ccb_json_object_types.json
tools/format/json_formatter.cgi data/reference/json/ccb_eoc_conditions.json
tools/format/json_formatter.cgi data/reference/json/ccb_eoc_effects.json
python3 tools/json_api/generate_contracts.py --check
python3 -m unittest discover -s tools/json_api -p 'test_*.py'
```

`--check` compares parsed JSON so the repository formatter remains the single
authority for whitespace.  The JSON style workflow separately rejects a
non-canonical layout.  The tests validate the inventory Schema, hard coverage
counts, source symbols and line numbers, documentation evidence, and every
published example JSON Pointer.

## Confidence boundaries

The inventories separate facts directly proven by source from incomplete
classification:

- loader registrations and parser order come from their C++ registries;
- source evidence includes a tracked path, line, and symbol;
- data examples include a tracked path and JSON Pointer;
- `mandatory()` and `optional()` are accepted as field-requiredness evidence;
- occurrence counts never establish requiredness;
- lexical examples and documentation mentions are labelled lexical-only;
- handler parameters, defaults, talkers, variables, and contexts remain
  `unclassified` until reviewed source evidence can prove them;
- `u_` and `npc_` names are only legacy alpha/beta aliases and do not prove a
  concrete runtime talker type;
- no complete general JSON or EOC Schema is claimed.

`contract-inventory.schema.json` describes the generated inventory format.  It
is not a Schema for game JSON and must never be presented as one.

Generated snapshots must not be edited by hand.  Extend the extractor or add
source-adjacent, non-behavioural metadata when a contract can be proven.
