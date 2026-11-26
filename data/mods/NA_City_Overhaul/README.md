# North America City Overhaul

Optional mod for Cataclysm: Cleanwater Bomb. It changes **North America city
generation only**, and only in two ways. It ships nothing else and is disabled
by default.

## What it changes

### 1. City horde size

`external_options.json` sets:

```json
{ "type": "EXTERNAL_OPTION", "name": "SPAWN_CITY_HORDE_SCALAR", "stype": "float", "value": 30.0 }
```

Horde count is `city size × SPAWN_CITY_HORDE_SCALAR × SPAWN_DENSITY`. The default
of 80 makes a max-size (55) North America city spawn 4400 zombies; at 30 it is
1650, about −62 %, while the scatter radius is unchanged.

### 2. City block composition (houses → shops)

`region_overlay.json` overlays `region_settings_city` id `default` with
`copy-from` + `extend` on the `houses` pool:

| Group | Entries | Weight |
| --- | --- | --- |
| Plain vanilla residences | 161 | forced to **1** (instead of 100–300) |
| Vanilla houses with actual content (apartments, school, motel, fishing pond, prepper/fortified/crack houses, …) | 16 | kept at original weight (160 total) |
| Shops added by this mod | 58 | 5961 total |
| Buildings other mods add to `houses` (Magiclysm's `wizard_tower_1/2`, `house_technomancer`, `house_elf_01`, `catalegacy_future`'s `house_09b`, `xedra_evolved`'s `safe_house`, `railroads`' `railroad_station_city`) | — | untouched |

Result: about 1 in 5 city residential lots becomes a shop instead of a lottery
house, while other mods' buildings are not removed.

### Why `extend` with weight 1 instead of replacing the pool

`generic_factory.h` `handler<weighted_int_list>::insert` calls `add_or_replace`,
so listing an existing id inside `extend` **changes its weight** instead of
appending a duplicate. Deleting or replacing the whole `houses` pool would cut
off buildings other mods add to it — with `wizard_tower_1/2` that means wizard
towers disappear from cities entirely.

Measured pool composition after overlaying all enabled mods (total 6412):

| Metric | Vanilla | Replace-pool approach | This mod |
| --- | --- | --- | --- |
| `wizard_tower_1/2` share of `houses` | 0.399 % | 0 % | **0.468 %** (+17 %) |
| `safe_house` / `railroad_station_city` | 0.067 % | 0 % | **0.078 %** |
| `house_09b` | 0.266 % | 0 % | **0.312 %** |
| Residential lot → shop | ≈0 % | 21.4 % | **19.9 %** |

Because the mod only lowers weights, mods installed later keep benefiting: a
new mod's `houses` entries are added at full weight and the denominator simply
grows. `shops`, `parks` and other pools are not touched at all.

## Tuning

Everything is plain data:

- Horde density: change `value` in `external_options.json` (default 80 =
  vanilla).
- Shop share: the shop weights are the design value × 0.55; raising or lowering
  them (or lowering the 161 forced-1 residences is not possible — 1 is the
  minimum) shifts the ratio. The current value targets ≈20 % of residential
  lots.

## Testing done (2026-11-26, build `2026-11-26-1537`)

- `cataclysm-tiles.exe --check-mods ccb na_city_overhaul` → loads clean; no
  `error_skipped_members`, no unresolved pool ids. (Exit code 1 in check mode
  is the repository's own style/plural warnings, not a failure.)
- New game on a North America world, mod enabled: shops appear throughout city
  blocks as intended; horde density noticeably lower and considered
  "tight but acceptable"; wizard tower rate to be observed long-term.

## Compatibility

- Depends on `ccb` only.
- Does not modify core files, does not `delete` or replace any pool, and is
  opt-in.
- Works alongside mods that add to the `houses` pool.
