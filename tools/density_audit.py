#!/usr/bin/env python3
"""Per-unit density audit for count_by_charges items.

CDDA engine semantics (verified in src/item.cpp):
  * weight():  for count_by_charges, total = type->weight * charges.
               => JSON "weight" is ALREADY per unit.
  * volume():  for count_by_charges, total = type->volume * charges / stack_size.
               => per-unit volume = JSON "volume" / stack_size.   (item.cpp:2274-2289)
  * The same volume/stack_size formula is used for longest_side in
    item_factory.cpp:868-871.

So a unit's physical density is:
      density [g/cm3] = weight_mg/1000  /  (volume_ml / stack_size)
                      = (weight_mg * stack_size) / (volume_ml * 1000)

stack_size resolution mirrors Item_factory::finalize_pre:
  explicit JSON "stack_size"  ->  ammo->count  ->  comestible->stack_size
  ->  charges_default()  ->  1 (plain stackable).

This script flags items whose per-unit density falls outside a plausible band.
Read-only: prints a report, writes nothing.

Reference densities (g/cm3): water 1.0, dry sand ~1.6, table salt ~2.2,
aluminium 2.7, iron 7.9, copper 8.96, lead 11.3, mercury 13.5, gold 19.3,
osmium 22.6 (densest element). Foams/aerogels can reach ~0.02; loose powders
0.3-2. We warn outside [0.05, 25] and hard-flag outside [0.01, 30].
"""
import json, glob, re, sys

SOFT_LO, SOFT_HI = 0.05, 25.0
HARD_LO, HARD_HI = 0.01, 30.0

def to_ml(v):
    if v is None:
        return None
    m = re.match(r'\s*([\d.]+)\s*(ml|L)?', str(v))
    if not m:
        return None
    n = float(m.group(1))
    return n * 1000 if m.group(2) == 'L' else n

def to_mg(w):
    if w is None:
        return None
    m = re.match(r'\s*([\d.]+)\s*(mg|g|kg)?', str(w))
    if not m:
        return None
    n = float(m.group(1))
    return {'kg': n*1e6, 'g': n*1000, 'mg': n, None: n}[m.group(2)]


def load_itypes():
    byid = {}
    fileof = {}
    for fp in glob.glob("data/json/items/**/*.json", recursive=True):
        try:
            d = json.load(open(fp, encoding="utf-8"))
        except Exception:
            continue
        for o in (d if isinstance(d, list) else [d]):
            if not isinstance(o, dict):
                continue
            ident = o.get("id") or o.get("abstract")
            if not ident:
                continue
            for k in ([ident] if isinstance(ident, str) else ident):
                byid[k] = o
                fileof[k] = fp
    return byid, fileof


def main():
    byid, fileof = load_itypes()

    def res(i, field, seen=None):
        seen = seen or set()
        if i in seen or i not in byid:
            return None
        seen.add(i)
        o = byid[i]
        if field in o:
            return o[field]
        cf = o.get("copy-from")
        return res(cf, field, seen) if cf else None

    def is_cbc(i):
        if res(i, "stackable") is True:
            return True
        if "AMMO" in (res(i, "subtypes") or []):
            return True
        if byid.get(i, {}).get("type") == "AMMO":
            return True
        if res(i, "ammo_type") is not None:
            return True
        o = byid.get(i, {})
        if (o.get("type") == "COMESTIBLE" or res(i, "comestible") is not None) \
                and res(i, "phase") in ("liquid", "gas"):
            return True
        return False

    def stack_size(i):
        # explicit top-level stack_size
        ss = res(i, "stack_size")
        if isinstance(ss, int) and ss > 0:
            return ss, "explicit"
        # ammo "count" carries stack_size as count — but ONLY for AMMO subtypes.
        # For MAGAZINE subtypes "count" is magazine capacity (e.g. 240000 ml of
        # fuel, 4800 battery charges), which is NOT a volume divisor. Skip those.
        subtypes = res(i, "subtypes") or []
        is_magazine = "MAGAZINE" in subtypes or res(i, "magazine") is not None
        if not is_magazine:
            cnt = res(i, "count")
            if isinstance(cnt, int) and cnt > 0:
                return cnt, "ammo-count"
        # plain stackable / charges_default -> 1
        return 1, "default-1"

    def is_magazine(i):
        return "MAGAZINE" in (res(i, "subtypes") or []) or res(i, "magazine") is not None

    rows = []
    for i in byid:
        # skip abstracts (no concrete id) — only audit real items
        o = byid[i]
        if o.get("abstract") == i and o.get("id") != i:
            continue
        if not is_cbc(i):
            continue
        # MAGAZINE items (tanks, battery cells) carry whole-container weight and
        # capacity-as-count; per-unit density is not meaningful for them.
        if is_magazine(i) and "--include-magazines" not in sys.argv:
            continue
        vol = to_ml(res(i, "volume"))
        wt = to_mg(res(i, "weight"))
        if not vol or not wt or vol <= 0:
            continue
        ss, ss_src = stack_size(i)
        per_unit_vol = vol / ss
        if per_unit_vol <= 0:
            continue
        density = (wt / 1000.0) / per_unit_vol  # g / cm3
        rows.append((density, i, wt, vol, ss, ss_src, per_unit_vol))

    rows.sort()
    hard = [r for r in rows if r[0] < HARD_LO or r[0] > HARD_HI]
    soft = [r for r in rows if (HARD_LO <= r[0] < SOFT_LO) or (SOFT_HI < r[0] <= HARD_HI)]

    def fmt(r):
        d, i, wt, vol, ss, src, puv = r
        return (f"  {d:8.3f} g/cm3  {i:28} wt={wt:>8.0f}mg vol={vol:>6.0f}ml "
                f"stack={ss:>5}({src}) per-unit={puv:.3f}ml")

    print(f"Audited {len(rows)} count_by_charges items.\n")
    print(f"=== HARD outliers (density <{HARD_LO} or >{HARD_HI} g/cm3) : {len(hard)} ===")
    for r in hard:
        print(fmt(r))
    print(f"\n=== SOFT outliers ([{HARD_LO},{SOFT_LO}) or ({SOFT_HI},{HARD_HI}]) : {len(soft)} ===")
    for r in soft:
        print(fmt(r))

    if "--all" in sys.argv:
        print(f"\n=== ALL (sorted by density) ===")
        for r in rows:
            print(fmt(r))


if __name__ == "__main__":
    main()

