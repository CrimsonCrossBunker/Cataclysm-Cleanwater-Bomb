"""Check bundled North American transport, charts, and ground data."""

import json
import unittest
from pathlib import Path

from generate_north_america_ground import FORMS, ground_cover

DATA = Path(__file__).resolve().parents[1] / "data"


def read(relative):
    return json.loads((DATA / relative).read_text(encoding="utf-8"))


class NorthAmericaInfrastructureTest(unittest.TestCase):
    def test_all_region_maps_are_discoverable_from_local_stock(self):
        regions = {
            record[0] for record in
            read("raw/north_america.jurisdictions")["polygons"]
        }
        charts = read("json/items/book/atlas_road_maps.json")
        stock = {
            entry["id"]: entry for entry in
            read("json/itemgroups/atlas_road_maps.json")
        }
        self.assertEqual(
            regions,
            {item["use_action"]["atlas_jurisdiction"] for item in charts},
        )
        self.assertEqual(stock["roadmap_stock"]["items"], [["roadmap", 100]])
        for chart in charts:
            region = chart["use_action"]["atlas_jurisdiction"]
            entries = stock[f"roadmap_stock-{region}"]["entries"]
            self.assertEqual(
                max(entries, key=lambda entry: entry["prob"])["item"],
                chart["id"],
            )

    def test_every_surface_preserves_its_base_and_grass_transitions(self):
        path = (DATA / "json/furniture_and_terrain" /
                "terrain-north-america-ground-cover.json")
        self.assertEqual(path.read_text(encoding="utf-8"), ground_cover())
        variants = {entry["id"]: entry for entry in json.loads(ground_cover())}
        soils = read("raw/north_america.soils")["types"]
        for soil in soils:
            prefix = f"t_atlas_soil_{soil}"
            for suffix, (base, _, next_cover) in FORMS.items():
                terrain = variants[f"{prefix}_{suffix}"]
                self.assertEqual(terrain["copy-from"], base)
                if next_cover:
                    self.assertEqual(
                        terrain["transforms_into"], f"{prefix}_{next_cover}",
                    )
                    self.assertIn(terrain["transforms_into"], variants)

    def test_roads_have_canonical_bounded_segments_and_all_lane_widths(self):
        roads = read("raw/north_america.transport")
        self.assertEqual({road[0] for road in roads}, {2, 4, 6, 8, 12})
        self.assertEqual(len(roads), len({tuple(road[1:]) for road in roads}))
        for _, x1, y1, x2, y2 in roads:
            self.assertLess((x1, y1), (x2, y2))
            self.assertLessEqual(max(abs(x2 - x1), abs(y2 - y1)), 126)
        self.assertTrue(any(
            lanes == 12 and -30_000 <= x1 <= -27_000 and -7_000 <= y1 <= -5_000
            for lanes, x1, y1, _, _ in roads
        ))

    def test_permafrost_regions_follow_the_observed_extent(self):
        atlas = read("raw/north_america.permafrost")

        def at(lat, lon):
            y = int((atlas["north"] - lat) / atlas["step"])
            x = int((lon - atlas["west"]) / atlas["step"])
            return atlas["rows"][y][x]

        self.assertEqual(set("".join(atlas["rows"])), set(".CDSI"))
        self.assertEqual(at(71.29, -156.79), "C")  # Utqiagvik
        self.assertEqual(at(63.75, -68.52), "C")  # Iqaluit
        self.assertEqual(at(68.36, -133.72), "D")  # Mackenzie delta
        self.assertEqual(at(49.90, -97.10), ".")  # Winnipeg
        self.assertEqual(at(42.35, -71.09), ".")  # Boston


if __name__ == "__main__":
    unittest.main()
