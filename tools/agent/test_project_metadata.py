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

    def test_repository_uses_one_responsible_human_without_approval_gate(self):
        path = ROOT / "ai/repository-settings.target.yml"
        settings = yaml.safe_load(path.read_text(encoding="utf-8"))
        reviewer = settings["audit"]["reviewer_confirmation"]
        self.assertEqual(reviewer["confirmed_willing_humans"], 1)
        self.assertEqual(reviewer["required_willing_humans"], 1)
        self.assertEqual(
            settings["entries"][0]["manual_record"]["confirmed_reviewers"][0][
                "login"
            ],
            "LYHGLYTX",
        )
        pull_rule = next(
            rule
            for rule in settings["entries"][0]["target"]["github_ruleset"]["rules"]
            if rule["type"] == "pull_request"
        )
        self.assertEqual(
            pull_rule["parameters"]["required_approving_review_count"], 0
        )
        self.assertFalse(pull_rule["parameters"]["require_last_push_approval"])
        validate_repository_settings(settings)

    def test_repository_target_prohibits_bot_approval(self):
        path = ROOT / "ai/repository-settings.target.yml"
        settings = yaml.safe_load(path.read_text(encoding="utf-8"))
        settings = copy.deepcopy(settings)
        settings["audit"]["actions"][
            "can_approve_pull_request_reviews"
        ] = True

        with self.assertRaisesRegex(ValueError, "must not be allowed"):
            validate_repository_settings(settings)

    def test_inventory_is_valid(self):
        validate_inventory()

    def test_documentation_registry_is_valid(self):
        validate_documentation_registry()


if __name__ == "__main__":
    unittest.main()
