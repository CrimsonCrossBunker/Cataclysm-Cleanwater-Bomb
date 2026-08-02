#!/usr/bin/env python3
"""Report mapped documentation impact and enforce staged PR fields."""

from __future__ import annotations

import argparse
import fnmatch
import os
import re
import subprocess
import sys
from pathlib import Path

import yaml


ROOT = Path(__file__).resolve().parents[2]
MAP_PATH = ROOT / "ai/docs-impact.yml"
DOCUMENTATION_PR_FIELDS = (
    "Documentation impact",
    "Related CCB-Docs PR",
    "Affected documentation IDs",
    "Generated reference impact",
)
RESPONSIBLE_HUMAN_FIELD = "Responsible human"
VALID_ENFORCEMENT = {"advisory", "required", "staged"}
PLACEHOLDER_VALUES = {
    "-",
    "n/a",
    "na",
    "no",
    "none",
    "not applicable",
    "tbd",
    "todo",
    "待定",
    "无",
    "无影响",
}
GITHUB_USER_MENTION = re.compile(
    r"(?<![\w/-])@[A-Za-z0-9](?:[A-Za-z0-9-]{0,37}[A-Za-z0-9])?(?![\w/-])"
)
CCB_DOCS_PR_REFERENCE = re.compile(
    r"(?:https://github\.com/CrimsonCrossBunker/CCB-Docs/pull/[1-9][0-9]*"
    r"|CrimsonCrossBunker/CCB-Docs#[1-9][0-9]*)",
    re.IGNORECASE,
)


def load_rules(path: Path = MAP_PATH) -> list[dict]:
    """Load mappings and resolve the staged top-level enforcement mode."""
    data = yaml.safe_load(path.read_text(encoding="utf-8"))
    if not isinstance(data, dict):
        raise ValueError("documentation impact map must contain a mapping")
    mode = data.get("enforcement")
    if mode not in VALID_ENFORCEMENT:
        raise ValueError(
            f"unsupported documentation impact enforcement: {mode}"
        )
    entries = data.get("entries")
    if not isinstance(entries, list):
        raise ValueError("documentation impact entries must be a list")

    rules: list[dict] = []
    for entry in entries:
        if not isinstance(entry, dict):
            raise ValueError("documentation impact entry must be a mapping")
        enforcement = entry.get("enforcement")
        if mode == "staged" and enforcement is None:
            raise ValueError(
                f"staged documentation impact entry {entry.get('id')} "
                "must declare enforcement"
            )
        if enforcement is None:
            enforcement = mode
        if enforcement not in {"advisory", "required"}:
            raise ValueError(
                f"invalid enforcement for {entry.get('id')}: {enforcement}"
            )
        rules.append({**entry, "enforcement": enforcement})
    return rules


def changed_files(base: str, head: str) -> list[str]:
    output = subprocess.run(
        ["git", "diff", "--name-only", base, head, "--"],
        cwd=ROOT,
        check=True,
        stdout=subprocess.PIPE,
        text=True,
    ).stdout
    return [line.strip() for line in output.splitlines() if line.strip()]


def impacts(files: list[str], rules: list[dict]) -> list[dict]:
    matched = []
    for rule in rules:
        hit = sorted(
            {
                path
                for path in files
                if any(
                    fnmatch.fnmatch(path, pattern)
                    for pattern in rule.get("patterns", [])
                )
            }
        )
        if hit:
            matched.append({**rule, "matched_files": hit})
    return matched


def field_value(body: str, heading: str) -> str | None:
    pattern = re.compile(
        rf"^####\s+{re.escape(heading)}\s*$\n(.*?)(?=^####\s+|\Z)",
        re.MULTILINE | re.DOTALL | re.IGNORECASE,
    )
    match = pattern.search(body)
    if not match:
        return None
    return re.sub(
        r"<!--.*?-->", "", match.group(1), flags=re.DOTALL
    ).strip()


def is_placeholder(value: str | None) -> bool:
    if value is None:
        return True
    normalized = re.sub(r"[`*_]", "", value).strip().lower().rstrip(".。")
    return not normalized or normalized in PLACEHOLDER_VALUES


def mentioned_document_ids(value: str, expected: set[str]) -> set[str]:
    mentioned = set()
    for identifier in expected:
        pattern = re.compile(
            rf"(?<![A-Za-z0-9_.-]){re.escape(identifier)}"
            r"(?![A-Za-z0-9_.-])"
        )
        if pattern.search(value):
            mentioned.add(identifier)
    return mentioned


def required_field_errors(body: str, result: list[dict]) -> list[str]:
    """Return blocking errors for mappings explicitly marked required."""
    required = [
        item for item in result if item.get("enforcement") == "required"
    ]
    if not required:
        return []

    errors: list[str] = []
    values = {
        heading: field_value(body, heading)
        for heading in DOCUMENTATION_PR_FIELDS
    }
    for heading, value in values.items():
        if value is None:
            errors.append(f"missing required PR field: {heading}")
        elif is_placeholder(value):
            errors.append(
                f"required PR field must not be a placeholder: {heading}"
            )

    related = values["Related CCB-Docs PR"]
    if related and not is_placeholder(related):
        if not CCB_DOCS_PR_REFERENCE.search(related):
            errors.append(
                "Related CCB-Docs PR must link a CrimsonCrossBunker/CCB-Docs "
                "pull request for required documentation impact"
            )

    affected = values["Affected documentation IDs"]
    if affected and not is_placeholder(affected):
        for item in required:
            expected_ids = set(item.get("documentation_ids", []))
            if expected_ids and not mentioned_document_ids(
                affected, expected_ids
            ):
                identifiers = ", ".join(sorted(expected_ids))
                errors.append(
                    "Affected documentation IDs must name at least one mapped "
                    f"ID for {item['id']}: {identifiers}"
                )
    return errors


def validate_pr_body(body: str, result: list[dict] | None = None) -> list[str]:
    """Return all blocking responsibility and staged-impact errors."""
    errors: list[str] = []
    responsible = field_value(body, RESPONSIBLE_HUMAN_FIELD)
    if responsible is None:
        errors.append(f"missing PR field: {RESPONSIBLE_HUMAN_FIELD}")
    else:
        mentions = GITHUB_USER_MENTION.findall(responsible)
        if not mentions or all(
            mention.lower() == "@username" for mention in mentions
        ):
            errors.append("Responsible human must name a real GitHub account")
        elif "[bot]" in responsible.lower():
            errors.append("Responsible human must not be a bot account")
    errors.extend(required_field_errors(body, result or []))
    return errors


def documentation_field_warnings(
    body: str, result: list[dict] | None = None
) -> list[str]:
    """Return warnings for fields that are not already required."""
    if any(
        item.get("enforcement") == "required" for item in (result or [])
    ):
        return []
    warnings = []
    for heading in DOCUMENTATION_PR_FIELDS:
        if field_value(body, heading) is None:
            warnings.append(f"missing advisory PR field: {heading}")
    return warnings


def report(result: list[dict]) -> str:
    if not result:
        return "Documentation impact: no mapped documentation IDs."
    lines = ["Documentation impact (staged enforcement):"]
    for item in result:
        ids = ", ".join(item.get("documentation_ids", [])) or "none mapped"
        generated = "yes" if item.get("generated_reference_impact") else "no"
        checks = ", ".join(item.get("required_check_ids", [])) or "none"
        lines.append(
            f"- [{item['enforcement']}] {item['id']}: docs={ids}; "
            f"generated-reference={generated}; checks={checks}; "
            f"files={', '.join(item['matched_files'])}"
        )
    return "\n".join(lines)


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--base")
    parser.add_argument("--head")
    parser.add_argument("--changed-file", action="append", default=[])
    parser.add_argument("--check-pr-body", action="store_true")
    args = parser.parse_args()

    files = list(args.changed_file)
    if args.base or args.head:
        if not (args.base and args.head):
            parser.error("--base and --head must be provided together")
        files.extend(changed_files(args.base, args.head))
    files = sorted(set(files))

    result = impacts(files, load_rules())
    message = report(result)
    print(message)
    summary_path = os.environ.get("GITHUB_STEP_SUMMARY")
    if summary_path:
        with open(summary_path, "a", encoding="utf-8") as summary:
            summary.write("## Documentation impact\n\n" + message + "\n")

    if args.check_pr_body:
        body = os.environ.get("PR_BODY", "")
        errors = validate_pr_body(body, result)
        warnings = documentation_field_warnings(body, result)
        for warning in warnings:
            print(f"::warning::{warning}", file=sys.stderr)
        for error in errors:
            print(f"::error::{error}", file=sys.stderr)
        if errors:
            return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
