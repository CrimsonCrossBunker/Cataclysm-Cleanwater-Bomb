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
    validate_lua_first_roadmap,
    validate_repository_settings,
)
from check_lua_first_replacement_ledger import check as check_lua_first_replacement_ledger


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

    def test_lua_first_roadmap_is_valid(self):
        validate_lua_first_roadmap()

    def test_lua_first_replacement_ledger_is_exact(self):
        result = check_lua_first_replacement_ledger()
        self.assertEqual(result["total"], 775)

    def test_lua_first_roadmap_rejects_dependency_cycles(self):
        path = ROOT / "ai/lua-first-roadmap.yml"
        roadmap = yaml.safe_load(path.read_text(encoding="utf-8"))
        roadmap = copy.deepcopy(roadmap)
        roadmap["milestones"][0]["depends_on"] = [
            roadmap["milestones"][-1]["id"]
        ]

        with self.assertRaisesRegex(ValueError, "cycle"):
            validate_lua_first_roadmap(roadmap)

    def test_available_lua_first_capability_cannot_require_public_legacy(self):
        path = ROOT / "ai/lua-first-roadmap.yml"
        roadmap = yaml.safe_load(path.read_text(encoding="utf-8"))
        roadmap = copy.deepcopy(roadmap)
        roadmap["capabilities"][0]["status"] = "available"
        roadmap["capabilities"][0]["legacy_dependency"] = "public_legacy"

        with self.assertRaisesRegex(ValueError, "public legacy"):
            validate_lua_first_roadmap(roadmap)

    def test_documentation_registry_is_valid(self):
        validate_documentation_registry()


if __name__ == "__main__":
    unittest.main()
