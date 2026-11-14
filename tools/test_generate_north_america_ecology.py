"""Focused tests for the North America ecology atlas bake."""
import unittest

import numpy as np

from generate_north_america_ecology import encode, forest_cover_bands


class EcologyBakeTest(unittest.TestCase):
    def test_runs_stay_within_rows_and_omit_no_data(self):
        rows = np.array([[0, 4, 4, 2], [2, 2, 0, 3]])
        self.assertEqual(list(encode(rows)), [[1, 0, 2, 4], [3, 0, 1, 2],
                                              [0, 1, 2, 2], [3, 1, 1, 3]])

    def test_forest_fraction_ignores_water_and_no_data(self):
        fine = np.array([[[[1, 6], [8, 18], [0, 18]], [[8, 0], [14, 15], [18, 0]]]])
        np.testing.assert_array_equal(forest_cover_bands(fine), [[4, 1, 0]])


if __name__ == "__main__":
    unittest.main()