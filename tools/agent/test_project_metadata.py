import unittest

from check_project_metadata import validate_context, validate_inventory


class ProjectMetadataTest(unittest.TestCase):
    def test_context_is_valid(self):
        validate_context()

    def test_inventory_is_valid(self):
        validate_inventory()


if __name__ == "__main__":
    unittest.main()
