import unittest
from unittest import mock

from check_project_metadata import (
    tracked_paths,
    validate_context,
    validate_documentation_registry,
    validate_inventory,
)


class ProjectMetadataTest(unittest.TestCase):
    @mock.patch("check_project_metadata.subprocess.run")
    def test_path_discovery_reads_only_the_git_index(self, run):
        run.return_value.stdout = b"AGENTS.md\0tools/AGENTS.md\0"

        self.assertEqual(tracked_paths(), ["AGENTS.md", "tools/AGENTS.md"])
        command = run.call_args.args[0]
        self.assertIn("--cached", command)
        self.assertNotIn("--others", command)

    def test_context_is_valid(self):
        validate_context()

    def test_inventory_is_valid(self):
        validate_inventory()

    def test_documentation_registry_is_valid(self):
        validate_documentation_registry()


if __name__ == "__main__":
    unittest.main()
