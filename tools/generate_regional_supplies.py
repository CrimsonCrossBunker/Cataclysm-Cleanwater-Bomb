#!/usr/bin/env python3
"""Generate jurisdiction-suffixed store and service item groups."""

import argparse
import json

from generate_regional_loot import (
    DATA, ITEMS, WEAPONS, group, item, records, reference, render,
)

SUPPLIES = DATA / "raw/north_america_supplies.json"
FOOD = DATA / "json/itemgroups/Food"
APPAREL = DATA / "json/itemgroups/Clothing_Gear"
SERVICE = WEAPONS / "arsenal"


def store_groups(policy, existing):
    food = []
    apparel = []
    for stem in policy["regional_groups"]:
        output = apparel if stem == "coats_unisex" else food
        # Keep the original distribution available inside the localized group.
        # Referencing the original ID directly would re-enter the scope
        # redirect.
        original = {
            key: value for key, value in existing[stem].items()
            if not key.startswith("//")
        }
        original["id"] = f"regional_supply_original_{stem}"
        output.append(original)

    for code, fruit, vegetable, pantry, outerwear in policy["jurisdictions"]:
        dry, canned, liquid, sauce, bread = policy["pantries"][pantry]
        for stem, additions in {
            "produce": [item(fruit, 20), item(vegetable, 20)],
            "fresh_produce": [item(fruit, 20), item(vegetable, 20)],
            "small_crate_of_fruits": [item(fruit, 40, count=[3, 12])],
            "small_crate_of_vegetables": [item(vegetable, 40, count=[3, 12])],
            "dry_goods": [reference(dry, 35)],
            "pantry_liquids": [item(liquid, 30)],
            "commercial_grains": [reference(dry, 40)],
            "commercial_canned_meals": [item(canned, 40)],
            "commercial_sauces_dressings": [item(sauce, 30)],
            "commercial_bread_specialty": [item(bread, 40)],
            "coats_unisex": [
                item(coat, 25) for coat in policy["outerwear"][outerwear]
            ],
        }.items():
            destination = apparel if stem == "coats_unisex" else food
            destination.append(group(
                f"{stem}-{code}",
                [
                    reference(f"regional_supply_original_{stem}", 60),
                    *additions,
                ],
            ))
    return food, apparel


def armory_groups(policy):
    assembled_weapons = policy["assembled_weapons"]

    def weapon_entry(weapon, **fields):
        # A group can install a conversion before the outer entry sets charges.
        if weapon in assembled_weapons:
            return reference(assembled_weapons[weapon], **fields)
        return item(weapon, **fields)

    groups = [
        group("regional_military_reserve_ammo", [
            reference("ammo_can_300_full"),
        ]),
        group("regional_military_surplus_firearms", [
            reference("guns_common"),
        ]),
        group("regional_military_surplus_magazines", [
            reference("mags_common"),
        ]),
    ]
    for country, equipment in policy["armories"].items():
        guns = {}
        kits = []
        cases = []
        magazines = []
        reserve = []
        for role, weight in (("sidearm", 20), ("rifle", 55), ("secondary", 10),
                             ("support", 10), ("medium_support", 5),
                             ("sniper", 5)):
            if role not in equipment:
                continue
            weapon, mag, ammo = equipment[role]
            kit_name = f"regional_service_kit_{role}-{country}"
            case_name = f"regional_service_case_{role}-{country}"
            guns[role] = weapon_entry(weapon, charges=[0, 8])
            groups.append(group(
                kit_name, [weapon_entry(weapon), item(mag)], "collection",
            ))
            groups.append(group(
                case_name, [reference(kit_name), reference(ammo)],
                "collection",
            ))
            kits.append(reference(kit_name, weight))
            cases.append(reference(case_name, weight))
            magazines.append(item(mag, weight))
            reserve.append(reference(ammo, weight))

        regional_patrol_kit = f"regional_patrol_kit-{country}"
        groups.append(group(regional_patrol_kit, [
            reference("regional_service_kit_rifle-" + country),
            reference(equipment["rifle"][2]),
        ], "collection"))
        patrol_groups = [
            reference(ident, 20) for ident in equipment["police_longarms"]
        ]
        pistol_groups = [
            reference(ident, 50) for ident in equipment["police_pistols"]
        ]
        police_pistol, police_pistol_mag, spare_pistol = (
            equipment["police_field_sidearm"]
        )
        police_rifle, police_rifle_mag, spare_rifle = (
            equipment["police_field_rifle"]
        )
        pistol_in_field = weapon_entry(
            police_pistol, charges=[0, 8], damage=[0, 3],
        )
        rifle_in_field = weapon_entry(
            police_rifle, charges=[0, 15], damage=[0, 3],
        )
        police_magazines = [
            item(police_pistol_mag), item(police_rifle_mag), item("mp5mag"),
        ]
        issue_rifles = [
            {**guns["rifle"], "prob": 85}, {**guns["secondary"], "prob": 15},
        ]
        rifle_guns = [
            *issue_rifles, weapon_entry(equipment["sniper"][0], prob=5),
        ]
        support_guns = [
            guns[role] for role in ("support", "medium_support")
            if role in guns
        ]
        variants = {
            "police_armory_any_pistol": pistol_groups,
            "police_armory_any_assaultrifle": [
                reference(regional_patrol_kit, 60), *patrol_groups,
            ],
            "police_armory_any_smg": [reference("police_armory_mp5")],
            "police_armory_any_sniperrifle": [
                reference(f"regional_service_case_sniper-{country}"),
            ],
            "police_armory_any_shotgun": [
                reference("police_armory_shotgun_pick1"),
                reference("police_armory_boxes_shotshells"),
            ],
            "sidearms_cop": [pistol_in_field],
            "sidearms_cop_in_field": [
                pistol_in_field, reference(spare_pistol),
            ],
            "sidearms_cop_in_field_no_gun": [reference(spare_pistol)],
            "longguns_cop": [rifle_in_field],
            "longguns_cop_loaded": [rifle_in_field],
            "longguns_cop_in_field": [rifle_in_field, reference(spare_rifle)],
            "longguns_cop_in_field_no_gun": [reference(spare_rifle)],
            "guns_swat": [
                reference(f"longguns_cop_in_field-{country}", 85),
                {"collection": [
                    item("hk_mp5", charges=[0, 8]), item("mp5mag"),
                ], "prob": 15},
            ],
            "mags_cop": police_magazines,
            "mags_swat": police_magazines,
            "military_standard_pistols": [guns["sidearm"]],
            "military_standard_assault_rifles": issue_rifles,
            "military_grenadier_assault_rifles": [guns["rifle"]],
            "military_standard_lmgs": support_guns,
            "military_standard_sniper_rifles": [guns["sniper"]],
            "military_standard_shotguns": [
                weapon_entry(equipment["shotgun"], charges=[0, 4]),
            ],
            "guns_rifle_milspec": rifle_guns,
            "guns_pistol_milspec": [guns["sidearm"]],
            "guns_smg_milspec": [item("hk_mp5")],
            "mags_milspec": magazines,
            "mags_military": magazines,
            "milspec_arsenal_group_guns&mags&cans": cases,
            "milspec_arsenal_group_guns": kits,
            "milspec_arsenal_group_ammo_full": reserve,
            "regional_military_reserve_ammo": [
                reference(equipment["sniper"][2]),
            ],
            "regional_military_surplus_firearms": rifle_guns + [
                weapon_entry(equipment["sidearm"][0], prob=30),
            ],
            "regional_military_surplus_magazines": magazines,
        }
        if variants.keys() != set(policy["service_groups"]):
            raise ValueError(
                f"Service group list does not match the {country} definitions"
            )
        collections = {
            "police_armory_any_shotgun", "sidearms_cop_in_field",
            "longguns_cop_in_field",
        }
        for stem, entries in variants.items():
            subtype = "collection" if stem in collections else "distribution"
            groups.append(group(f"{stem}-{country}", entries, subtype))
    return groups


def validate_references(generated, existing, items):
    ids = {obj["id"] for obj in generated}
    if len(ids) != len(generated) or ids.intersection(existing):
        raise ValueError("Duplicate regional supply group ID")

    def check(value, context):
        if isinstance(value, dict):
            for key, entry in value.items():
                if (key == "item" and isinstance(entry, str) and
                        entry not in items):
                    raise ValueError(f"{context}: unknown item {entry}")
                if (key == "group" and isinstance(entry, str) and
                        entry not in ids and entry not in existing):
                    raise ValueError(f"{context}: unknown group {entry}")
                if isinstance(entry, (dict, list)):
                    check(entry, context)
        elif isinstance(value, list):
            for entry in value:
                check(entry, context)

    for obj in generated:
        check(obj, obj["id"])


def build():
    policy = json.loads(SUPPLIES.read_text(encoding="utf-8"))
    existing = records(path for path in (DATA / "json").rglob("*.json")
                       if path.name != "regional_supplies_north_america.json")
    items = records(ITEMS.rglob("*.json"))
    food, apparel = store_groups(policy, existing)
    service = armory_groups(policy)
    validate_references(food + apparel + service, existing, items)
    return {
        path / "regional_supplies_north_america.json": render(groups) + "\n"
        for path, groups in (
            (FOOD, food), (APPAREL, apparel), (SERVICE, service),
        )
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    for path, output in build().items():
        if args.check:
            if not path.exists() or path.read_text(encoding="utf-8") != output:
                parser.exit(1, f"Regional supplies are out of date: {path}\n")
        else:
            path.write_text(output, encoding="utf-8", newline="\n")


if __name__ == "__main__":
    main()
