from __future__ import annotations

import copy
import unittest
from datetime import date

from audit_repository_governance import (
    DEPENDABOT_PATH,
    load_yaml,
    validate_dependabot,
    validate_repository,
    validate_target,
    workflow_permission_errors,
)


class RepositoryGovernanceTest(unittest.TestCase):
    def setUp(self) -> None:
        self.target, errors = validate_repository(as_of=date(2026, 8, 2))
        self.assertEqual(errors, [])

    def test_recorded_repository_audit_is_valid(self) -> None:
        self.assertEqual(self.target["audit"]["repository"]["rulesets"], [])
        self.assertFalse(self.target["entries"][0]["enabled"])

    def test_ruleset_cannot_activate_without_reviewers(self) -> None:
        target = copy.deepcopy(self.target)
        target["entries"][0]["enabled"] = True
        target["entries"][0]["target"]["github_ruleset"][
            "enforcement"
        ] = "active"
        errors = validate_target(target)
        self.assertTrue(any("open blockers" in error for error in errors))

    def test_unverified_checks_cannot_enter_applied_record(self) -> None:
        target = copy.deepcopy(self.target)
        target["entries"][0]["manual_record"]["required_checks"] = [
            "Lua public contract"
        ]
        errors = validate_target(target)
        self.assertTrue(any("unverified checks" in error for error in errors))

    def test_required_rules_cannot_be_removed(self) -> None:
        target = copy.deepcopy(self.target)
        rules = target["entries"][0]["target"]["github_ruleset"]["rules"]
        deletion = next(rule for rule in rules if rule["type"] == "deletion")
        deletion["type"] = "non_fast_forward"
        errors = validate_target(target)
        self.assertTrue(any("one deletion rule" in error for error in errors))

    def test_pull_request_rule_keeps_non_author_gate(self) -> None:
        target = copy.deepcopy(self.target)
        rules = target["entries"][0]["target"]["github_ruleset"]["rules"]
        pull_rule = next(
            rule for rule in rules if rule["type"] == "pull_request"
        )
        pull_rule["parameters"]["require_last_push_approval"] = False
        errors = validate_target(target)
        self.assertTrue(
            any("require_last_push_approval" in error for error in errors)
        )

    def test_bypass_actor_cannot_be_invented_in_one_record(self) -> None:
        target = copy.deepcopy(self.target)
        target["entries"][0]["target"]["bypass_policy"][
            "configured_actors"
        ] = [
            {
                "actor_id": 1,
                "actor_type": "RepositoryRole",
                "bypass_mode": "always",
            }
        ]
        errors = validate_target(target)
        self.assertTrue(
            any("bypass actors differ" in error for error in errors)
        )

    def test_ruleset_payload_cannot_hide_a_bypass_actor(self) -> None:
        target = copy.deepcopy(self.target)
        target["entries"][0]["target"]["github_ruleset"][
            "bypass_actors"
        ] = [
            {
                "actor_id": 1,
                "actor_type": "RepositoryRole",
                "bypass_mode": "always",
            }
        ]
        errors = validate_target(target)
        self.assertTrue(
            any("payload actors differ" in error for error in errors)
        )

    def test_false_organization_2fa_retains_issue_564(self) -> None:
        target = copy.deepcopy(self.target)
        target["audit"]["two_factor_rollout"]["tracking_issue"] = 999
        errors = validate_target(target)
        self.assertTrue(any("#564" in error for error in errors))

    def test_actions_bot_approval_is_rejected(self) -> None:
        target = copy.deepcopy(self.target)
        target["audit"]["actions"][
            "can_approve_pull_request_reviews"
        ] = True
        errors = validate_target(target)
        self.assertTrue(
            any("must not be allowed" in error for error in errors)
        )

    def test_auto_merge_is_rejected(self) -> None:
        target = copy.deepcopy(self.target)
        target["audit"]["repository"]["allow_auto_merge"] = True
        errors = validate_target(target)
        self.assertTrue(any("auto-merge" in error for error in errors))

    def test_freshness_is_only_enforced_when_requested(self) -> None:
        self.assertEqual(
            validate_target(self.target, as_of=date(2027, 1, 1)), []
        )
        errors = validate_target(
            self.target,
            as_of=date(2027, 1, 1),
            max_age_days=100,
        )
        self.assertTrue(any("days old" in error for error in errors))

    def test_dependabot_actions_schedule_is_valid(self) -> None:
        config = load_yaml(DEPENDABOT_PATH)
        self.assertEqual(validate_dependabot(config), [])

    def test_write_all_workflow_permission_is_rejected(self) -> None:
        errors = workflow_permission_errors(
            ".github/workflows/example.yml",
            {"jobs": {"release": {"permissions": "write-all"}}},
        )
        self.assertEqual(len(errors), 1)
        self.assertIn("forbidden write-all", errors[0])

    def test_unknown_workflow_permission_is_rejected(self) -> None:
        errors = workflow_permission_errors(
            ".github/workflows/example.yml",
            {"permissions": {"repository-projects": "write"}, "jobs": {}},
        )
        self.assertEqual(len(errors), 1)
        self.assertIn("unknown repository-projects", errors[0])


if __name__ == "__main__":
    unittest.main()
