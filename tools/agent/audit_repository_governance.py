#!/usr/bin/env python3
"""Validate the GitHub audit and disabled repository Ruleset target."""

from __future__ import annotations

import argparse
import json
import subprocess
import sys
from datetime import date
from pathlib import Path

import jsonschema
import yaml


ROOT = Path(__file__).resolve().parents[2]
TARGET_PATH = ROOT / "ai/repository-settings.target.yml"
SCHEMA_PATH = ROOT / "ai/repository-settings.target.schema.json"
DEPENDABOT_PATH = ROOT / ".github/dependabot.yml"
OWNERSHIP_PATH = ROOT / "OWNERSHIP.md"
GOVERNANCE_PATH = ROOT / "GOVERNANCE.md"
PROJECT_MAP_PATH = ROOT / "ai/project-map.yml"
ALLOWED_PERMISSION_LEVELS = {"none", "read", "write"}
ALLOWED_PERMISSION_SCOPES = {
    "actions",
    "attestations",
    "checks",
    "contents",
    "deployments",
    "discussions",
    "id-token",
    "issues",
    "models",
    "packages",
    "pages",
    "pull-requests",
    "security-events",
    "statuses",
}


def load_yaml(path: Path) -> dict:
    data = yaml.safe_load(path.read_text(encoding="utf-8"))
    if not isinstance(data, dict):
        raise ValueError(f"{path.relative_to(ROOT)} must contain a mapping")
    return data


def tracked_paths(*pathspecs: str) -> list[str]:
    result = subprocess.run(
        ["git", "ls-files", "-z", "--", *pathspecs],
        cwd=ROOT,
        check=True,
        capture_output=True,
    )
    return sorted(
        item.decode("utf-8")
        for item in result.stdout.split(b"\0")
        if item
    )


def blocker(entry: dict, identifier: str) -> dict | None:
    return next(
        (
            item
            for item in entry.get("blockers", [])
            if item.get("id") == identifier
        ),
        None,
    )


def required_check_contexts(entry: dict) -> list[str]:
    rules = entry["target"]["github_ruleset"]["rules"]
    status_rule = next(
        (
            item
            for item in rules
            if item.get("type") == "required_status_checks"
        ),
        None,
    )
    if status_rule is None:
        return []
    checks = status_rule.get("parameters", {}).get(
        "required_status_checks", []
    )
    return [item.get("context") for item in checks]


def rules_by_type(entry: dict) -> dict[str, list[dict]]:
    grouped: dict[str, list[dict]] = {}
    for rule in entry["target"]["github_ruleset"]["rules"]:
        grouped.setdefault(rule.get("type"), []).append(rule)
    return grouped


def validate_target(
    target: dict,
    *,
    as_of: date | None = None,
    max_age_days: int | None = None,
) -> list[str]:
    errors: list[str] = []
    schema = json.loads(SCHEMA_PATH.read_text(encoding="utf-8"))
    validator = jsonschema.Draft202012Validator(
        schema,
        format_checker=jsonschema.FormatChecker(),
    )
    for error in sorted(validator.iter_errors(target), key=str):
        location = ".".join(str(part) for part in error.absolute_path)
        errors.append(f"schema {location or '<root>'}: {error.message}")
    if errors:
        return errors

    audit = target["audit"]
    entry = target["entries"][0]
    record = entry["manual_record"]
    ruleset = entry["target"]["github_ruleset"]
    bypass = entry["target"]["bypass_policy"]
    reviewer_audit = audit["reviewer_confirmation"]
    check_audit = audit["required_check_evidence"]
    prerequisites = entry["prerequisites"]

    if audit["actions"]["default_workflow_permissions"] != "read":
        errors.append(
            "default Actions token permissions must remain read-only"
        )
    if audit["actions"]["can_approve_pull_request_reviews"] is not False:
        errors.append("Actions must not be allowed to approve pull requests")
    if audit["repository"]["allow_auto_merge"] is not False:
        errors.append("repository auto-merge must remain disabled")
    expected_security = {
        "secret_scanning": "enabled",
        "secret_scanning_push_protection": "enabled",
        "dependabot_security_updates": "enabled",
        "vulnerability_alerts_http_status": 204,
        "automated_security_fixes": "enabled",
    }
    for setting, expected_value in expected_security.items():
        if audit["security"][setting] != expected_value:
            errors.append(
                f"audited security setting {setting} is not "
                f"{expected_value!r}"
            )

    if audit["repository"]["default_branch"] != entry["branch"]:
        errors.append(
            "audited default branch does not match the target branch"
        )
    if reviewer_audit["confirmed_willing_humans"] != len(
        record["confirmed_reviewers"]
    ):
        errors.append("reviewer audit count does not match the manual record")
    if prerequisites["minimum_confirmed_human_reviewers"] != reviewer_audit[
        "required_willing_humans"
    ]:
        errors.append("ruleset and audit require different reviewer counts")
    if reviewer_audit["confirmed_willing_humans"] < prerequisites[
        "minimum_confirmed_human_reviewers"
    ]:
        reviewer_blocker = blocker(entry, "reviewer-quorum")
        if not reviewer_blocker or reviewer_blocker.get("state") != "open":
            errors.append("missing open reviewer-quorum blocker")
    elif blocker(entry, "reviewer-quorum"):
        errors.append("satisfied reviewer policy retains reviewer-quorum blocker")
    if check_audit["default_branch_success_confirmed"] != (
        check_audit["status"] == "default_branch_stable"
    ):
        errors.append("required-check status and evidence flag disagree")
    if not check_audit["default_branch_success_confirmed"]:
        check_blocker = blocker(entry, "default-branch-check-stability")
        if not check_blocker or check_blocker.get("state") != "open":
            errors.append("missing open default-branch check blocker")
        if record["required_checks"]:
            errors.append(
                "unverified checks must not enter the applied record"
            )
    if not bypass["configured_actors"]:
        bypass_blocker = blocker(entry, "emergency-bypass-owner")
        if not bypass_blocker or bypass_blocker.get("state") != "open":
            errors.append("missing open emergency bypass owner blocker")
    if bypass["configured_actors"] != record["emergency_bypass_actors"]:
        errors.append("target and applied emergency bypass actors differ")
    if bypass["configured_actors"] != ruleset["bypass_actors"]:
        errors.append("bypass policy and Ruleset payload actors differ")

    blocker_ids = [item["id"] for item in entry["blockers"]]
    if len(blocker_ids) != len(set(blocker_ids)):
        errors.append("duplicate blocker IDs")

    observed_rulesets = audit["repository"]["rulesets"]
    if not observed_rulesets and record["ruleset_id"] is not None:
        errors.append("ruleset ID is recorded although the audit found none")
    unresolved = [
        item["id"]
        for item in entry["blockers"]
        if item["state"] == "open"
    ]
    if unresolved and entry["enabled"]:
        errors.append("ruleset cannot be enabled with open blockers")
    if unresolved and ruleset["enforcement"] != "disabled":
        errors.append(
            "ruleset payload must remain disabled with open blockers"
        )
    if entry["enabled"] != (ruleset["enforcement"] == "active"):
        errors.append("enabled flag and ruleset enforcement disagree")

    ref_condition = ruleset["conditions"].get("ref_name", {})
    if ref_condition.get("include") != ["refs/heads/master"]:
        errors.append("Ruleset must target only refs/heads/master")
    if ref_condition.get("exclude") != []:
        errors.append("Ruleset target must not have branch exclusions")

    grouped_rules = rules_by_type(entry)
    required_rule_types = {
        "deletion",
        "non_fast_forward",
        "pull_request",
        "required_status_checks",
    }
    for rule_type in sorted(required_rule_types):
        if len(grouped_rules.get(rule_type, [])) != 1:
            errors.append(f"Ruleset needs exactly one {rule_type} rule")
    pull_rules = grouped_rules.get("pull_request", [])
    if len(pull_rules) == 1:
        parameters = pull_rules[0].get("parameters", {})
        expected = {
            "dismiss_stale_reviews_on_push": False,
            "require_code_owner_review": False,
            "require_last_push_approval": False,
            "required_approving_review_count": 0,
            "required_review_thread_resolution": True,
        }
        for name, value in expected.items():
            if parameters.get(name) != value:
                errors.append(
                    f"pull-request rule has invalid {name}: "
                    f"{parameters.get(name)!r}"
                )
    status_rules = grouped_rules.get("required_status_checks", [])
    if len(status_rules) == 1:
        parameters = status_rules[0].get("parameters", {})
        if parameters.get("strict_required_status_checks_policy") is not True:
            errors.append("required checks must use strict branch validation")
        if parameters.get("do_not_enforce_on_create") is not True:
            errors.append("required checks must not block branch creation")

    contexts = required_check_contexts(entry)
    if not contexts or any(not item for item in contexts):
        errors.append("ruleset target needs named required status checks")
    if len(contexts) != len(set(contexts)):
        errors.append("ruleset target has duplicate required status checks")
    recorded_checks_differ = sorted(record["required_checks"]) != sorted(
        contexts
    )
    if record["required_checks"] and recorded_checks_differ:
        errors.append("applied required checks differ from the target")
    if entry["enabled"]:
        if len(record["confirmed_reviewers"]) < prerequisites[
            "minimum_confirmed_human_reviewers"
        ]:
            errors.append("active Ruleset lacks confirmed human reviewers")
        required_record_fields = (
            "enabled_at",
            "enabled_by",
            "ruleset_id",
            "bypass_tested_at",
        )
        missing_record = [
            name for name in required_record_fields if not record[name]
        ]
        if missing_record:
            missing_names = ", ".join(missing_record)
            errors.append(
                f"active Ruleset has incomplete manual record: {missing_names}"
            )

    if not audit["organization"]["two_factor_requirement_enabled"]:
        rollout = audit["two_factor_rollout"]
        if rollout["tracking_issue"] != 564:
            errors.append("disabled organization 2FA must retain blocker #564")
        if rollout["status"] != "blocked_pending_member_audit_and_notice":
            errors.append("organization 2FA blocker status is inconsistent")
    elif audit["two_factor_rollout"]["status"] != "enabled":
        errors.append(
            "enabled organization 2FA needs an enabled rollout record"
        )

    if max_age_days is not None:
        if max_age_days < 1:
            errors.append("max audit age must be positive")
        else:
            observed = date.fromisoformat(audit["observed_at"])
            reference = as_of or date.today()
            age = (reference - observed).days
            if age < 0:
                errors.append("audit date is later than the comparison date")
            elif age > max_age_days:
                errors.append(
                    f"repository audit is {age} days old; limit is "
                    f"{max_age_days}"
                )
    return errors


def validate_dependabot(config: dict) -> list[str]:
    errors: list[str] = []
    if config.get("version") != 2:
        errors.append("Dependabot config must use version 2")
    updates = config.get("updates")
    if not isinstance(updates, list):
        return errors + ["Dependabot updates must be a list"]
    actions = [
        item
        for item in updates
        if item.get("package-ecosystem") == "github-actions"
        if item.get("directory") == "/"
    ]
    if len(actions) != 1:
        return errors + ["Dependabot needs one root github-actions update"]
    schedule = actions[0].get("schedule", {})
    if schedule.get("interval") != "weekly":
        errors.append("GitHub Actions Dependabot updates must be weekly")
    if schedule.get("timezone") != "Asia/Shanghai":
        errors.append("Dependabot schedule must record Asia/Shanghai")
    limit = actions[0].get("open-pull-requests-limit")
    if not isinstance(limit, int) or limit < 1:
        errors.append("Dependabot open pull request limit must be positive")
    return errors


def workflow_permission_errors(path: str, workflow: dict) -> list[str]:
    errors: list[str] = []

    def check(value: object, location: str) -> None:
        if value == "write-all":
            errors.append(f"{path}: {location} uses forbidden write-all")
            return
        if value is None or value == "read-all":
            return
        if not isinstance(value, dict):
            errors.append(f"{path}: invalid permissions at {location}")
            return
        for scope, level in value.items():
            if scope not in ALLOWED_PERMISSION_SCOPES:
                errors.append(
                    f"{path}: unknown {scope} permission at {location}"
                )
                continue
            if level not in ALLOWED_PERMISSION_LEVELS:
                errors.append(
                    f"{path}: invalid {scope} permission at {location}: "
                    f"{level}"
                )

    check(workflow.get("permissions"), "workflow")
    jobs = workflow.get("jobs", {})
    if not isinstance(jobs, dict):
        return errors + [f"{path}: jobs must be a mapping"]
    for job_id, job in jobs.items():
        if isinstance(job, dict):
            check(job.get("permissions"), f"job {job_id}")
    return errors


def validate_workflow_permissions() -> list[str]:
    errors: list[str] = []
    for path in tracked_paths(".github/workflows"):
        if not path.endswith((".yml", ".yaml")):
            continue
        workflow = load_yaml(ROOT / path)
        errors.extend(workflow_permission_errors(path, workflow))
    return errors


def validate_ownership(target: dict) -> list[str]:
    errors: list[str] = []
    tracked = tracked_paths()
    if any(Path(path).name == "CODEOWNERS" for path in tracked):
        errors.append("CODEOWNERS must not exist before owners are confirmed")
    ownership = OWNERSHIP_PATH.read_text(encoding="utf-8")
    reviewers = target["entries"][0]["manual_record"][
        "confirmed_reviewers"
    ]
    if not reviewers and "_none recorded_" not in ownership:
        errors.append("OWNERSHIP.md must state that no reviewer is confirmed")
    for reviewer in reviewers:
        login = reviewer.get("login") if isinstance(reviewer, dict) else None
        if not login or f"@{login}" not in ownership:
            errors.append(
                "confirmed reviewer is absent from OWNERSHIP.md: "
                f"{login}"
            )
    return errors


def governance_policy_errors(governance: str, project_map: str) -> list[str]:
    """Reject prose that would lock the sole Responsible human out of merges."""
    errors: list[str] = []
    normalized_governance = " ".join(governance.split())
    normalized_project_map = " ".join(project_map.split())
    obsolete_phrases = (
        "at least two active human reviewers",
        "Confirm two active human reviewer",
        "two confirmed human reviewers",
        "至少两名拥有审查权限",
    )
    for phrase in obsolete_phrases:
        if phrase in normalized_governance or phrase in normalized_project_map:
            errors.append(f"obsolete two-reviewer governance policy remains: {phrase}")
    for phrase in (
        "One Responsible human is sufficient",
        "target approval count remains zero",
        "一名 Responsible human 即可",
    ):
        if phrase not in normalized_governance:
            errors.append(f"GOVERNANCE.md is missing single-maintainer policy: {phrase}")
    if "One Responsible human is sufficient" not in normalized_project_map:
        errors.append("ai/project-map.yml is missing the single-maintainer boundary")
    return errors


def validate_repository(
    *,
    as_of: date | None = None,
    max_age_days: int | None = None,
) -> tuple[dict, list[str]]:
    target = load_yaml(TARGET_PATH)
    errors = validate_target(
        target,
        as_of=as_of,
        max_age_days=max_age_days,
    )
    errors.extend(validate_dependabot(load_yaml(DEPENDABOT_PATH)))
    errors.extend(validate_workflow_permissions())
    errors.extend(validate_ownership(target))
    errors.extend(
        governance_policy_errors(
            GOVERNANCE_PATH.read_text(encoding="utf-8"),
            PROJECT_MAP_PATH.read_text(encoding="utf-8"),
        )
    )
    return target, errors


def summary(target: dict) -> str:
    audit = target["audit"]
    entry = target["entries"][0]
    reviewers = audit["reviewer_confirmation"]
    return (
        "repository governance audit is internally consistent: "
        f"rulesets={len(audit['repository']['rulesets'])}; "
        f"reviewers={reviewers['confirmed_willing_humans']}/"
        f"{reviewers['required_willing_humans']}; "
        f"checks={audit['required_check_evidence']['status']}; "
        f"ruleset={entry['target']['github_ruleset']['enforcement']}; "
        "organization-2FA="
        f"{audit['organization']['two_factor_requirement_enabled']}"
    )


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--check", action="store_true")
    parser.add_argument("--as-of", type=date.fromisoformat)
    parser.add_argument("--max-age-days", type=int)
    parser.add_argument("--ruleset-json", action="store_true")
    args = parser.parse_args()

    try:
        target, errors = validate_repository(
            as_of=args.as_of,
            max_age_days=args.max_age_days,
        )
    except (
        OSError,
        ValueError,
        subprocess.CalledProcessError,
        yaml.YAMLError,
    ) as error:
        print(error, file=sys.stderr)
        return 1
    for error in errors:
        print(error, file=sys.stderr)
    if errors:
        return 1
    if args.ruleset_json:
        print(
            json.dumps(
                target["entries"][0]["target"]["github_ruleset"],
                ensure_ascii=False,
                indent=2,
            )
        )
    else:
        print(summary(target))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
