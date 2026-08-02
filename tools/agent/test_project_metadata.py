import copy
import unittest
from unittest import mock

import yaml

from check_project_metadata import (
    ROOT,
    tracked_paths,
    validate_context,
    validate_documentation_registry,
    validate_inventory,
    validate_repository_settings,
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

    def test_repository_rules_cannot_activate_without_two_reviewers(self):
        path = ROOT / "ai/repository-settings.target.yml"
        settings = yaml.safe_load(path.read_text(encoding="utf-8"))
        settings = copy.deepcopy(settings)
        settings["entries"][0]["enabled"] = True

        with self.assertRaisesRegex(ValueError, "without two reviewers"):
            validate_repository_settings(settings)

    def test_repository_target_prohibits_bot_approval(self):
        path = ROOT / "ai/repository-settings.target.yml"
        settings = yaml.safe_load(path.read_text(encoding="utf-8"))
        settings = copy.deepcopy(settings)
        settings["entries"][0]["target"]["actions"][
            "bot_may_approve_pull_requests"
        ] = True

        with self.assertRaisesRegex(ValueError, "must not approve"):
            validate_repository_settings(settings)

    def test_inventory_is_valid(self):
        validate_inventory()

    def test_documentation_registry_is_valid(self):
        validate_documentation_registry()


if __name__ == "__main__":
    unittest.main()
