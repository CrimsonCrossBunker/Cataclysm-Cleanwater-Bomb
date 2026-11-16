#!/usr/bin/env python3
"""Expand North America gameplay profiles into ordinary item groups."""

import argparse
import copy
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data"
ITEMS = DATA / "json/items"
WEAPONS = DATA / "json/itemgroups/Weapons_Mods_Ammo"
DROPS = DATA / "json/monsterdrops"
POLICY = DATA / "raw/north_america_loot.json"


def records(paths):
    return {
        obj["id"]: obj
        for path in paths
        if path.name != "regional_north_america.json"
        for obj in json.loads(path.read_text(encoding="utf-8"))
        if isinstance(obj, dict) and isinstance(obj.get("id"), str)
    }


def item(item_id, prob=100, **fields):
    return {"item": item_id, "prob": prob, **fields}


def reference(group_id, prob=100, **fields):
    return {"group": group_id, "prob": prob, **fields}


def group(group_id, entries, subtype="distribution", **fields):
    return {
        "type": "item_group",
        "id": group_id,
        "subtype": subtype,
        **fields,
        "entries": entries,
    }


def pockets(items, item_id):
    while item_id:
        obj = items[item_id]
        if "pocket_data" in obj:
            return obj["pocket_data"]
        item_id = obj.get("copy-from")
    return []


def magazine_capacity(items, mag):
    return max(
        capacity
        for pocket in pockets(items, mag)
        if pocket["pocket_type"] == "MAGAZINE"
        for capacity in pocket["ammo_restriction"].values()
    )


def weapons_for_profile(items, catalog, profile, settings):
    handgun, longarm, restrict_models = settings
    for gun, category, weight, magazines, *tags in catalog:
        tags = tags[0] if tags else []
        if profile in {"canada", "mexico"} and profile not in tags:
            continue
        if restrict_models and "regulated" in tags:
            continue
        limit = handgun if category == "pistol" else longarm
        # Canadian rimfire kit uses the game's shared 10-round magazine.
        if profile == "canada" and "rimfire" in tags:
            limit = 10
        gun_pockets = pockets(items, gun)
        fits = {
            mag
            for pocket in gun_pockets
            for mag in pocket.get("item_restriction", [])
        }
        if not set(magazines) <= fits:
            raise ValueError(
                f"{gun} has incompatible magazines in the regional catalog"
            )
        choices = [(magazine_capacity(items, mag), mag) for mag in magazines]
        choices = sorted(
            (capacity, mag)
            for capacity, mag in choices
            if not limit or capacity <= limit
        )
        if magazines and not choices:
            continue
        yield gun, category, weight, choices


def catalog_groups(policy, items, base):
    groups = []
    kit_ids = set()
    for profile, settings in policy["profiles"].items():
        catalog = list(
            weapons_for_profile(items, policy["firearms"], profile, settings)
        )
        kit_for_gun = {}
        for gun, category, _, choices in catalog:
            kit_id = f"regional_boxed_{gun}"
            if choices:
                kit_id += "-" + choices[-1][1]
            kit_for_gun[gun] = kit_id
            if kit_id in kit_ids:
                continue
            kit_ids.add(kit_id)
            entries = [item(gun), reference("firearm_box_extras")]
            if choices:
                entries.append(item(choices[-1][1], count=[1, 2]))
            box = (
                "box_pistol"
                if category == "pistol"
                else {
                    "item": "box_longarm",
                    "variant": f"box_longarm_{category}",
                }
            )
            groups.append(
                group(kit_id, entries, "collection", **{"container-item": box})
            )

        for stem in policy["state_groups"] + policy["firearm_groups"]:
            if not stem.startswith("guns_"):
                continue
            ident = f"{stem}-{profile}"
            category = next(
                (
                    kind
                    for kind in ("pistol", "rifle", "shotgun")
                    if stem.startswith(f"guns_{kind}_")
                ),
                None,
            )
            if category is None:
                suffix = stem.removeprefix("guns_common")
                categories = [
                    reference(f"guns_{kind}_common{suffix}-{profile}", weight)
                    for kind, weight in (
                        ("pistol", 90),
                        ("rifle", 30),
                        ("shotgun", 8),
                    )
                    if any(weapon[1] == kind for weapon in catalog)
                ]
                groups.append(group(ident, categories))
                continue
            entries = []
            for gun, kind, weight, choices in catalog:
                if kind != category:
                    continue
                if stem.endswith("_boxed"):
                    entries.append(reference(kit_for_gun[gun], weight))
                    continue
                fields = {}
                if not stem.endswith("_display") and choices:
                    fields["contents-item"] = choices[-1][1]
                if stem.endswith("_worn"):
                    fields["damage"] = [1, 4]
                entries.append(item(gun, weight, **fields))
            # Keep the broad original inventory as part of uncapped U.S. stock.
            # Limit fallback to individual categories to avoid routing loops.
            if (
                profile == "open" and
                stem in base and
                not stem.endswith("_boxed")
            ):
                original = {
                    key: value
                    for key, value in base[stem].items()
                    if not key.startswith("//")
                }
                original["id"] = f"regional_original_{stem}"
                groups.append(original)
                entries.append(
                    reference(
                        original["id"], sum(entry["prob"] for entry in entries)
                    )
                )
            groups.append(group(ident, entries))
    return groups


def magazine_groups(policy, items, base):
    groups = []
    for profile, settings in policy["profiles"].items():
        catalog = list(
            weapons_for_profile(items, policy["firearms"], profile, settings)
        )
        for stem in policy["state_groups"] + policy["firearm_groups"]:
            if not stem.startswith("mags_"):
                continue
            ident = f"{stem}-{profile}"
            if stem.endswith("_packaged"):
                groups.append(
                    group(
                        ident,
                        [
                            item(
                                "blister_pack",
                                **{
                                    "contents-group": (
                                        f"mags_common_restricted-{profile}"
                                    ),
                                },
                            )
                        ],
                    )
                )
                continue
            entries = {}
            for _, category, weight, choices in catalog:
                if ("pistol" in stem and category != "pistol") or (
                    "rifle" in stem and category != "rifle"
                ):
                    continue
                for index, (_, mag) in enumerate(reversed(choices)):
                    entries[mag] = entries.get(mag, 0) + max(
                        1, weight // (1 << index)
                    )
            if profile == "open" and stem == "mags_common":
                original = copy.deepcopy(base[stem])
                original["id"] = "regional_original_mags_common"
                groups.append(original)
            choices = [
                item(mag, weight) for mag, weight in sorted(entries.items())
            ]
            if profile == "open":
                choices.append(
                    reference(
                        "regional_original_mags_common", sum(entries.values())
                    )
                )
            groups.append(group(ident, choices))
    return groups


def ammunition_groups(policy, base):
    groups = []
    longarms = {
        "22lr",
        "12",
        "20",
        "410",
        "308",
        "3006",
        "3030",
        "270",
        "303",
        "338",
        "4570",
    }
    allowed = {
        "canada": longarms | {"223", "762", "762R", "300", "450"},
        "mexico": longarms - {"338"} | {"380", "38"},
    }
    aliases = {
        "22_lr": "22lr",
        "270win_jsp": "270",
        "338lapua_hpbt": "338",
        "762_54R": "762R",
    }
    stems = [
        stem
        for stem in policy["state_groups"] + policy["firearm_groups"]
        if stem.startswith("ammo_")
    ]
    for stem in stems:
        groups.append(
            group(f"regional_original_{stem}", base[stem]["entries"])
        )
    for profile in policy["profiles"]:
        for stem in stems:
            if profile not in allowed:
                groups.append(
                    group(
                        f"{stem}-{profile}",
                        [reference(f"regional_original_{stem}")],
                    )
                )
                continue
            entries = []
            for entry in base[stem]["entries"]:
                key = entry.get("group", entry.get("item"))
                calibre = (
                    key.removeprefix("boxed_")
                    .removesuffix("_used")
                    .removesuffix("_looted")
                )
                calibre = calibre.removesuffix("_loose")
                calibre = aliases.get(calibre, calibre)
                if calibre not in allowed[profile]:
                    continue
                if calibre in longarms:
                    entry = {**entry, "prob": entry["prob"] * 2}
                entries.append(entry)
            groups.append(group(f"{stem}-{profile}", entries))
    return groups


def uniform_groups(policy, base):
    groups = []
    for name, (shirt, pants, boots, hat) in policy["uniforms"].items():
        top = item(
            "postman_shirt" if shirt == "sheriff" else "dress_shirt",
            variant=shirt,
        )
        trousers = item("pants_tactical", variant=pants)
        helmet = [item(hat, 85), item("helmet_riot", 15)]
        for stem, entries in {
            "cop_torso": [top],
            "cop_pants": [trousers],
            "cop_shoes": [item(boots)],
            "cop_helmet": helmet,
            "NC_CITY_COP_shirt": [top],
            "NC_CITY_COP_pants": [trousers],
            "NC_CITY_COP_shoes": [item(boots)],
            "NC_CITY_COP_hat": [item(hat)],
        }.items():
            groups.append(group(f"{stem}-{name}", entries))
        officer = copy.deepcopy(base["clothing_navy_officer"])
        officer["id"] += f"-{name}"
        if name in {
            "ontario",
            "quebec",
            "pacific_ca",
            "rcmp",
            "central_mx",
            "patrol_mx",
        }:
            officer["items"][:3] = [
                item(boots),
                item("hat_ball"),
                item("dress_shirt", variant="white"),
                item("pants_tactical", variant="tactical_pants_black"),
            ]
        groups.append(officer)
    return groups


def service_drops(base):
    groups = []
    for country, variant in (
        ("ca", "tactical_pants_black"),
        ("mx", "tactical_pants_grey"),
    ):
        swat = copy.deepcopy(base["mon_zombie_swat_death_drops"])
        swat["id"] += "-" + country
        swat["entries"] = [
            (
                item("pants_tactical", damage=[0, 4], variant=variant)
                if entry.get("group") == "swat_pants"
                else entry
            )
            for entry in swat["entries"]
            if entry.get("item") != "badge_swat"
        ]
        torso = copy.deepcopy(base["swat_torso"])
        torso["id"] += "-" + country
        torso["entries"][1] = item(
            "dress_shirt", variant="black", damage=[0, 4]
        )
        next(
            entry
            for entry in swat["entries"]
            if entry.get("group") == "swat_torso"
        )["group"] = torso["id"]
        groups.extend([swat, torso])

        marine = copy.deepcopy(base["mon_zombie_marine_death_drops"])
        marine["id"] += "-" + country
        marine["entries"] = [
            (
                item("pants_tactical", damage=[0, 4], variant=variant)
                if entry.get("item") == "pants_army"
                else entry
            )
            for entry in marine["entries"]
            if entry.get("group") != "clothing_navy"
        ]
        marine["entries"].extend(
            [
                item("combat_shirt", damage=[0, 4]),
                item("nomex_socks"),
                reference("underwear"),
            ]
        )
        groups.append(marine)
    return groups


def _compact_json(value):
    if isinstance(value, dict):
        parts = [
            json.dumps(key, ensure_ascii=False) + ": " + _compact_json(part)
            for key, part in value.items()
        ]
        return "{ " + ", ".join(parts) + " }"
    if isinstance(value, list):
        return "[ " + ", ".join(_compact_json(part) for part in value) + " ]"
    return json.dumps(value, ensure_ascii=False)


def render(value, indent=0, separator=0):
    """Format item groups with the repository formatter's spacing and width."""
    flat = _compact_json(value)
    if isinstance(value, (dict, list)):
        left, right = ("{", "}") if isinstance(value, dict) else ("[", "]")
        if indent > 2 and len(flat.encode("utf-8")) + separator <= 120:
            return flat
        if isinstance(value, dict):
            parts = [
                json.dumps(key) + ": " + render(part, indent + 2)
                for key, part in value.items()
            ]
        else:
            parts = [
                render(part, indent + 2, indent + 4 if index else 0)
                for index, part in enumerate(value)
            ]
        return (
            left + "\n" +
            ",\n".join(" " * (indent + 2) + part for part in parts) +
            ("\n" + " " * indent + right)
        )
    return flat


def build():
    policy = json.loads(POLICY.read_text(encoding="utf-8"))
    base = records(
        [
            *WEAPONS.rglob("*.json"),
            *DROPS.glob("*.json"),
            DATA / "json/itemgroups/Clothing_Gear/military.json",
        ]
    )
    items = records(ITEMS.rglob("*.json"))
    buckets = {
        WEAPONS: catalog_groups(policy, items, base),
        WEAPONS / "ammo": ammunition_groups(policy, base),
        WEAPONS / "magazines": magazine_groups(policy, items, base),
        DROPS: uniform_groups(policy, base) + service_drops(base),
    }
    for stem, directory in zip(policy["state_groups"], list(buckets)[:3]):
        for code, profile, _ in policy["jurisdictions"]:
            buckets[directory].append(
                group(f"{stem}-{code}", [reference(f"{stem}-{profile}")])
            )
    return {
        path / "regional_north_america.json": render(groups) + "\n"
        for path, groups in buckets.items()
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    for path, output in build().items():
        if args.check:
            if not path.exists() or path.read_text(encoding="utf-8") != output:
                parser.exit(
                    1,
                    "Regional loot is out of date: "
                    f"{path.relative_to(ROOT)}\n",
                )
        else:
            path.write_text(output, encoding="utf-8", newline="\n")


if __name__ == "__main__":
    main()
