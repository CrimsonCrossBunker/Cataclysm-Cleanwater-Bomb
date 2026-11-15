"""Checks the shipped boundary coverage and generated game item groups."""

import json
import unittest

from generate_regional_loot import DATA, ITEMS, POLICY, build, magazine_capacity, records, render


class RegionalJsonFormatTest(unittest.TestCase):
    def test_existing_repository_layout(self):
        for name in ("itemgroups/Weapons_Mods_Ammo/conversions/conversion_guns.json",
                     "itemgroups/Clothing_Gear/military.json"):
            with self.subTest(path=name):
                original = (DATA / "json" / name).read_text(encoding="utf-8")
                self.assertEqual(render(json.loads(original)) + "\n", original)

    def test_nested_collections_and_string_contents(self):
        value = [{"entries": [{"item": "{ } [ ]\u00a0", "charges": [0, 4]}, {}, []]}]
        self.assertEqual(render(value),
                         '[\n  { "entries": [ { "item": "{ } [ ]\\u00a0", '
                         '"charges": [ 0, 4 ] }, {  }, [  ] ] }\n]')
        self.assertEqual(render([]), "[\n  \n]")
        self.assertEqual(render({}), "{\n  \n}")

    def test_collection_limit_counts_bytes_and_separators(self):
        boundary = {"name": "x" * 106}
        flat = render(boundary, indent=2)
        self.assertEqual(len(flat.encode("utf-8")), 120)
        self.assertNotIn("\n", flat)
        self.assertIn("\n", render({"name": "x" * 107}, indent=2))
        self.assertNotIn("\n", render({"name": "é" * 53}, indent=2))
        self.assertIn("\n", render({"name": "é" * 54}, indent=2))
        lines = render([boundary, boundary]).splitlines()
        self.assertEqual(lines[1], "  " + flat + ",")
        self.assertEqual(lines[2], "  {")


class RegionalLootTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.policy = json.loads(POLICY.read_text(encoding="utf-8"))
        cls.outputs = build()
        cls.groups = {
            obj["id"]: obj for output in cls.outputs.values() for obj in json.loads(output)
        }

    def test_projection_and_loot_profiles_cover_the_same_regions(self):
        shapes = json.loads((DATA / "raw/north_america.jurisdictions").read_text(encoding="utf-8"))
        jurisdictions = {shape[0] for shape in shapes["polygons"]}
        self.assertEqual(len(jurisdictions), 96)
        self.assertEqual(jurisdictions, {"US-MA"} | {row[0] for row in self.policy["jurisdictions"]})
        for code, profile, uniform in self.policy["jurisdictions"]:
            for stem in self.policy["state_groups"]:
                self.assertEqual(self.groups[f"{stem}-{code}"]["entries"][0]["group"],
                                 f"{stem}-{profile}")
            for stem in self.policy["uniform_groups"]:
                self.assertIn(f"{stem}-{uniform}", self.groups)
            for stem in self.policy["firearm_groups"]:
                self.assertIn(f"{stem}-{profile}", self.groups)

    def test_boxed_pistol_magazines_change_by_profile(self):
        def magazine_for_m9(profile):
            boxes = self.groups[f"guns_pistol_common_boxed-{profile}"]["entries"]
            box = next(entry["group"] for entry in boxes if entry["group"].startswith("regional_boxed_m9-"))
            return self.groups[box]["entries"][-1]["item"]

        items = records(ITEMS.rglob("*.json"))
        self.assertEqual(magazine_capacity(items, magazine_for_m9("open")), 15)
        self.assertEqual(magazine_capacity(items, magazine_for_m9("restricted_split")), 15)
        self.assertEqual(magazine_capacity(items, magazine_for_m9("restricted10")), 10)
        self.assertEqual(self.groups["guns_pistol_common_boxed-canada"]["entries"], [])

    def test_mexican_ammunition_and_canadian_duty_clothes(self):
        mexican = {entry["group"] for entry in self.groups["ammo_common_boxed-mexico"]["entries"]}
        self.assertIn("boxed_380", mexican)
        self.assertIn("boxed_22lr", mexican)
        self.assertNotIn("boxed_9mm", mexican)
        self.assertEqual(self.groups["cop_torso-rcmp"]["entries"][0]["variant"], "gray")
        self.assertEqual(self.groups["cop_shoes-texas"]["entries"][0]["item"], "boots_western")

    def test_generated_files_are_current_and_ids_are_unique(self):
        count = 0
        for path, expected in self.outputs.items():
            self.assertEqual(path.read_text(encoding="utf-8"), expected)
            count += len(json.loads(expected))
        self.assertEqual(len(self.groups), count)


if __name__ == "__main__":
    unittest.main()
