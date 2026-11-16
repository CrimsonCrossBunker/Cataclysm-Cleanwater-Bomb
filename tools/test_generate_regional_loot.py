"""Checks the shipped boundary coverage and generated game item groups."""

import json
import unittest

from generate_regional_loot import (
    DATA,
    ITEMS,
    POLICY,
    build,
    magazine_capacity,
    records,
    render,
)


class RegionalLootTest(unittest.TestCase):
    def test_nested_ranges_use_formatter_spacing(self):
        self.assertEqual(
            render({"item": "stick", "count": [1, 2]}, indent=4),
            '{ "item": "stick", "count": [ 1, 2 ] }',
        )

    def test_wrapping_counts_collection_separator(self):
        entry = {"item": "x" * 104}
        inline = '{ "item": "' + "x" * 104 + '" }'
        wrapped = '{\n      "item": "' + "x" * 104 + '"\n    }'
        self.assertEqual(
            render([entry, entry], indent=2),
            "[\n    " + inline + ",\n    " + wrapped + "\n  ]",
        )

    def test_top_level_objects_stay_multiline(self):
        self.assertEqual(
            render([{"item": "stick"}]),
            '[\n  {\n    "item": "stick"\n  }\n]',
        )

    @classmethod
    def setUpClass(cls):
        cls.policy = json.loads(POLICY.read_text(encoding="utf-8"))
        cls.outputs = build()
        cls.groups = {
            obj["id"]: obj
            for output in cls.outputs.values()
            for obj in json.loads(output)
        }

    def test_projection_and_loot_profiles_cover_the_same_regions(self):
        shapes = json.loads(
            (DATA / "raw/north_america.jurisdictions").read_text(
                encoding="utf-8"
            )
        )
        jurisdictions = {shape[0] for shape in shapes["polygons"]}
        self.assertEqual(len(jurisdictions), 96)
        self.assertEqual(
            jurisdictions,
            {"US-MA"} | {row[0] for row in self.policy["jurisdictions"]},
        )
        for code, profile, uniform in self.policy["jurisdictions"]:
            for stem in self.policy["state_groups"]:
                self.assertEqual(
                    self.groups[f"{stem}-{code}"]["entries"][0]["group"],
                    f"{stem}-{profile}",
                )
            for stem in self.policy["uniform_groups"]:
                self.assertIn(f"{stem}-{uniform}", self.groups)
            for stem in self.policy["firearm_groups"]:
                self.assertIn(f"{stem}-{profile}", self.groups)

    def test_boxed_pistol_magazines_change_by_profile(self):
        def magazine_for_m9(profile):
            boxes = self.groups[f"guns_pistol_common_boxed-{profile}"][
                "entries"
            ]
            box = next(
                entry["group"]
                for entry in boxes
                if entry["group"].startswith("regional_boxed_m9-")
            )
            return self.groups[box]["entries"][-1]["item"]

        items = records(ITEMS.rglob("*.json"))
        self.assertEqual(magazine_capacity(items, magazine_for_m9("open")), 15)
        self.assertEqual(
            magazine_capacity(items, magazine_for_m9("restricted_split")), 15
        )
        self.assertEqual(
            magazine_capacity(items, magazine_for_m9("restricted10")), 10
        )
        self.assertEqual(
            self.groups["guns_pistol_common_boxed-canada"]["entries"], []
        )

    def test_mexican_ammunition_and_canadian_duty_clothes(self):
        mexican = {
            entry["group"]
            for entry in self.groups["ammo_common_boxed-mexico"]["entries"]
        }
        self.assertIn("boxed_380", mexican)
        self.assertIn("boxed_22lr", mexican)
        self.assertNotIn("boxed_9mm", mexican)
        self.assertEqual(
            self.groups["cop_torso-rcmp"]["entries"][0]["variant"], "gray"
        )
        self.assertEqual(
            self.groups["cop_shoes-texas"]["entries"][0]["item"],
            "boots_western",
        )

    def test_generated_files_are_current_and_ids_are_unique(self):
        count = 0
        for path, expected in self.outputs.items():
            self.assertEqual(path.read_text(encoding="utf-8"), expected)
            count += len(json.loads(expected))
        self.assertEqual(len(self.groups), count)


if __name__ == "__main__":
    unittest.main()
