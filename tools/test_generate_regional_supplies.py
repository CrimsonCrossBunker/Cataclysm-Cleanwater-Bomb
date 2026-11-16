"""Check regional content coverage, reference integrity, and sampled soils."""

import json
import unittest

from generate_regional_supplies import DATA, ITEMS, SUPPLIES, build, records
from generate_north_america_soils import HEIGHT, WIDTH


class RegionalSuppliesTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.policy = json.loads(SUPPLIES.read_text(encoding="utf-8"))
        cls.files = build()
        cls.groups = {
            obj["id"]: obj
            for value in cls.files.values() for obj in json.loads(value)}

    def test_all_atlas_jurisdictions_have_store_groups(self):
        atlas = json.loads(
            (DATA / "raw/north_america.jurisdictions").read_text(
                encoding="utf-8"))
        codes = {row[0] for row in self.policy["jurisdictions"]}
        self.assertEqual(codes, {row[0] for row in atlas["polygons"]})
        self.assertEqual(len(codes), len(self.policy["jurisdictions"]))
        for code in codes:
            for stem in self.policy["regional_groups"]:
                group = self.groups[f"{stem}-{code}"]
                self.assertEqual(
                    group["entries"][0]["group"],
                    f"regional_supply_original_{stem}")

    def test_specialties_and_flags(self):
        self.assertIn(
            "regional_avocado",
            {entry.get("item")
             for entry in self.groups["fresh_produce-MX-MIC"]["entries"]})
        self.assertIn(
            "syrup",
            {entry.get("item")
             for entry in self.groups["pantry_liquids-CA-QC"]["entries"]})
        variants = records(ITEMS.rglob("*.json"))["national_flag"]["variants"]
        self.assertEqual(
            self.policy["civic_flags"], {
                "CA": "canadian_flag", "MX": "mexican_flag"})
        self.assertTrue(
            set(self.policy["civic_flags"].values()) <=
            {v["id"] for v in variants})

    def test_service_weapon_and_reserve_ammunition_are_paired(self):
        for country, equipment in self.policy["armories"].items():
            for stem in self.policy["service_groups"]:
                self.assertIn(f"{stem}-{country}", self.groups)
            for role in ("sidearm", "rifle", "support", "sniper", "secondary"):
                gun, magazine, ammo = equipment[role]
                kit = self.groups[f"regional_service_kit_{role}-{country}"]
                assembly = self.policy["assembled_weapons"].get(gun)
                weapon_entry = {
                    "group": assembly} if assembly else {
                    "item": gun}
                self.assertEqual(
                    kit["entries"],
                    [{**weapon_entry, "prob": 100},
                     {"item": magazine, "prob": 100}])
                case = self.groups[f"regional_service_case_{role}-{country}"]
                self.assertEqual(case["entries"][1]["group"], ammo)
                self.assertIn(
                    ammo,
                    {entry["group"]
                     for entry in self.groups
                     [f"milspec_arsenal_group_ammo_full-{country}"]
                     ["entries"]})

    def test_generated_item_groups_are_current(self):
        for path, expected in self.files.items():
            self.assertEqual(path.read_text(encoding="utf-8"), expected)

    def test_police_drops_share_the_local_field_ammunition(self):
        for country, equipment in self.policy["armories"].items():
            for stem, role in (("sidearms_cop", "police_field_sidearm"),
                               ("longguns_cop", "police_field_rifle")):
                gun, magazine, spare = equipment[role]
                carried = self.groups[f"{stem}_in_field-{country}"]["entries"]
                assembly = self.policy["assembled_weapons"].get(gun)
                if assembly:
                    self.assertEqual(carried[0]["group"], assembly)
                else:
                    self.assertEqual(carried[0]["item"], gun)
                self.assertEqual(carried[1]["group"], spare)
                self.assertEqual(
                    self.groups[f"{stem}_in_field_no_gun-{country}"]
                    ["entries"][0]["group"],
                    spare,)
                self.assertIn(
                    magazine,
                    {entry["item"]
                     for entry in self.groups[f"mags_cop-{country}"]
                     ["entries"]})

    def test_canadian_m4_is_assembled_before_loading(self):
        conversion_groups = records([
            DATA / "json/itemgroups/Weapons_Mods_Ammo/conversions" /
            "conversion_guns.json"
        ])
        receiver = conversion_groups["modular_m4a1"]["entries"][0]
        self.assertEqual(receiver["item"], "modular_m4_carbine")
        self.assertIn("retool_ar15_223rem_medium", receiver["contents-item"])
        self.assertNotIn(
            '"item": "modular_m4_carbine"',
            json.dumps(
                self.groups))
        for stem, count in (
            ("longguns_cop_loaded", 15),
                ("military_standard_assault_rifles", 8)):
            gun = next(entry for entry in self.groups[f"{stem}-CA"]["entries"]
                       if entry.get("group") == "modular_m4a1")
            self.assertEqual(gun["charges"], [0, count])

    def test_soil_atlas_has_prairie_and_desert_terrain(self):
        atlas = json.loads(
            (DATA / "raw/north_america.soils").read_text(encoding="utf-8"))
        tiles = records(
            [DATA / "json/furniture_and_terrain" /
             "terrain-north-america-soils.json"]
        )
        self.assertEqual(len(atlas["rows"]), HEIGHT)
        for row in atlas["rows"]:
            self.assertEqual(len(row), WIDTH)
            self.assertTrue(set(row) <= {"."} |
                            {chr(ord("A") + i)
                             for i in range(len(atlas["types"]))})
        for soil in atlas["types"]:
            self.assertEqual(
                tiles[f"t_atlas_soil_{soil}"]["copy-from"],
                "t_dirt")
            self.assertEqual(
                tiles[f"t_atlas_soil_{soil}_tilled"]
                ["copy-from"],
                "t_dirtmound")

        def at(latitude, longitude):
            y = int((atlas["north"] - latitude) / atlas["step"])
            x = int((longitude - atlas["west"]) / atlas["step"])
            return atlas["types"][ord(atlas["rows"][y][x]) - ord("A")]

        with self.subTest(region="Canadian Prairies"):
            for point in [(49.85, -99.95), (52.13, -106.67), (53.55, -113.49)]:
                self.assertEqual(at(*point), "prairie")
        self.assertEqual(at(31.76, -106.49), "sandy_loam")


if __name__ == "__main__":
    unittest.main()
