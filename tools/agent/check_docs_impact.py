#!/usr/bin/env python3
"""Report documentation impact without blocking source changes in Phase 0/1."""

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
REQUIRED_PR_FIELDS = (
    "Responsible human",
    "Documentation impact",
    "Related CCB-Docs PR",
    "Affected documentation IDs",
    "Generated reference impact",
)


def load_rules(path: Path = MAP_PATH) -> list[dict]:
    data = yaml.safe_load(path.read_text(encoding="utf-8"))
    if data.get("enforcement") != "advisory":
        raise ValueError("Phase 0/1 documentation impact must be advisory")
    return data["entries"]


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
    visible = re.sub(
        r"<!--.*?-->", "", match.group(1), flags=re.DOTALL
    ).strip()
    return visible


def validate_pr_body(body: str) -> list[str]:
    errors = []
    values = {
        heading: field_value(body, heading) for heading in REQUIRED_PR_FIELDS
    }
    for heading, value in values.items():
        if value is None:
            errors.append(f"missing PR field: {heading}")
    responsible = values.get("Responsible human")
    if responsible is not None and (
        not responsible or responsible.lower() == "@username"
    ):
        errors.append("Responsible human must name a real GitHub account")
    return errors


def report(result: list[dict]) -> str:
    if not result:
        return "Documentation impact advisory: no mapped documentation IDs."
    lines = ["Documentation impact advisory (non-blocking in Phase 0/1):"]
    for item in result:
        ids = ", ".join(item.get("documentation_ids", [])) or (
            "no Phase 0/1 page yet"
        )
        generated = "yes" if item.get("generated_reference_impact") else "no"
        lines.append(
            f"- {item['id']}: docs={ids}; generated-reference={generated}; "
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

    message = report(impacts(files, load_rules()))
    print(message)
    summary_path = os.environ.get("GITHUB_STEP_SUMMARY")
    if summary_path:
        with open(summary_path, "a", encoding="utf-8") as summary:
            summary.write("## Documentation impact\n\n" + message + "\n")

    if args.check_pr_body:
        errors = validate_pr_body(os.environ.get("PR_BODY", ""))
        for error in errors:
            print(f"::error::{error}", file=sys.stderr)
        if errors:
            return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
