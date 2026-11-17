"""Check the checked-in urban cells and their references to the place atlas."""

import json
from pathlib import Path
import unittest


class UrbanAtlasTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        raw = Path(__file__).resolve().parents[1] / "data" / "raw"
        cls.atlas = json.loads(
            (raw /
             "north_america.atlas").read_text(
                encoding="utf-8"))
        cls.urban = json.loads(
            (raw /
             "north_america.urban").read_text(
                encoding="utf-8"))

    def test_cells_are_unique_and_reference_large_centers(self):
        self.assertEqual(self.urban["version"], 1)
        self.assertEqual(self.urban["district_size"], 48)
        districts = self.urban["districts"]
        self.assertGreater(len(districts), 10000)
        cells = [(x, y) for x, y, _ in districts]
        self.assertEqual(cells, sorted(set(cells)))
        places = self.atlas["cities"]
        cities = {city for _, _, city in districts}
        self.assertTrue(all(0 <= index < len(places) for index in cities))
        self.assertTrue(all(places[index][5] >= 100000 for index in cities))
        names = {places[index][2] for index in cities}
        self.assertTrue({"Boston", "Winnipeg", "Mexico City"} <= names)
        self.assertNotIn("Churchill", names)


if __name__ == "__main__":
    unittest.main()
