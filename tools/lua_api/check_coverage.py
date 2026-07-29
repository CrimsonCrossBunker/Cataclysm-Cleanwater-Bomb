#!/usr/bin/env python3
"""Validate and report CCB coverage of the recorded CBN Lua surface."""

from __future__ import annotations

import argparse
import fnmatch
import json
from collections import Counter
from pathlib import Path


SECTIONS = (
    "types",
    "functions",
    "members",
    "ids",
    "hooks",
    "callback_actors",
    "callbacks",
)
VALID_STATUSES = {"planned", "covered", "not_applicable"}


def matches_rule(
    section: str,
    entry: dict[str, object],
    rule: dict[str, object],
) -> bool:
    sections = rule.get("sections", SECTIONS)
    if section not in sections:
        return False
    file_name = str(entry.get("file", ""))
    globs = rule.get("file_globs", ["*"])
    return any(fnmatch.fnmatch(file_name, pattern) for pattern in globs)


def load(path: Path) -> dict[str, object]:
    value = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(value, dict):
        raise RuntimeError(f"{path} must contain a JSON object")
    return value


def check(
    inventory_path: Path, coverage_path: Path, require_complete: bool
) -> dict[str, object]:
    inventory = load(inventory_path)
    coverage = load(coverage_path)
    if coverage.get("schema_version") != 1:
        raise RuntimeError("unsupported Lua coverage schema")

    domains = coverage.get("domains")
    if not isinstance(domains, list) or not domains:
        raise RuntimeError("coverage manifest has no domains")
    domain_by_id: dict[str, dict[str, object]] = {}
    for domain in domains:
        if not isinstance(domain, dict):
            raise RuntimeError("coverage domain must be an object")
        domain_id = domain.get("id")
        status = domain.get("status")
        if not isinstance(domain_id, str) or domain_id in domain_by_id:
            raise RuntimeError(
                f"invalid or duplicate coverage domain {domain_id!r}"
            )
        if status not in VALID_STATUSES:
            raise RuntimeError(
                f"invalid status for coverage domain {domain_id!r}"
            )
        rules = domain.get("rules")
        if not isinstance(rules, list) or not rules:
            raise RuntimeError(f"coverage domain {domain_id!r} has no rules")
        if status == "covered":
            evidence = domain.get("evidence")
            tests = domain.get("tests")
            if not isinstance(evidence, list) or not evidence:
                raise RuntimeError(
                    f"covered domain {domain_id!r} has no API evidence"
                )
            if not isinstance(tests, list) or not tests:
                raise RuntimeError(
                    f"covered domain {domain_id!r} has no test evidence"
                )
        if status == "not_applicable" and not domain.get("reason"):
            raise RuntimeError(
                f"not-applicable domain {domain_id!r} has no reason"
            )
        domain_by_id[domain_id] = domain

    counts: Counter[str] = Counter()
    status_counts: Counter[str] = Counter()
    unmatched: list[str] = []
    ambiguous: list[str] = []
    total = 0
    for section in SECTIONS:
        entries = inventory.get(section)
        if not isinstance(entries, list):
            raise RuntimeError(f"inventory section {section!r} is invalid")
        for entry in entries:
            if not isinstance(entry, dict):
                raise RuntimeError(
                    f"inventory section {section!r} contains a non-object"
                )
            total += 1
            matching = [
                domain
                for domain in domains
                if any(
                    matches_rule(section, entry, rule)
                    for rule in domain["rules"]
                )
            ]
            label = (
                f"{section}:{entry.get('name', entry.get('cpp_type', '?'))}"
                f"@{entry.get('file', '?')}:{entry.get('line', '?')}"
            )
            if not matching:
                unmatched.append(label)
                continue
            if len(matching) > 1:
                domain_names = ", ".join(d["id"] for d in matching)
                ambiguous.append(label + " -> " + domain_names)
                continue
            domain = matching[0]
            counts[str(domain["id"])] += 1
            status_counts[str(domain["status"])] += 1

    if unmatched:
        preview = "\n".join(unmatched[:20])
        raise RuntimeError(
            f"{len(unmatched)} inventory entries are unclassified:\n{preview}"
        )
    if ambiguous:
        preview = "\n".join(ambiguous[:20])
        raise RuntimeError(
            f"{len(ambiguous)} inventory entries are classified twice:\n"
            f"{preview}"
        )
    empty_domains = sorted(
        domain_id for domain_id in domain_by_id if counts[domain_id] == 0
    )
    if empty_domains:
        raise RuntimeError(
            f"coverage domains match no inventory entries: {empty_domains}"
        )

    completed = status_counts["covered"] + status_counts["not_applicable"]
    result: dict[str, object] = {
        "total": total,
        "completed": completed,
        "percent": round(completed * 100.0 / total, 2),
        "by_status": dict(sorted(status_counts.items())),
        "by_domain": dict(sorted(counts.items())),
    }
    if require_complete and completed != total:
        raise RuntimeError(
            f"Lua API coverage is {result['percent']}%, expected 100%: "
            f"{result['by_status']}"
        )
    return result


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--inventory",
        type=Path,
        default=Path("data/lua/reference/cbn_api_inventory.json"),
    )
    parser.add_argument(
        "--coverage",
        type=Path,
        default=Path("data/lua/reference/cbn_coverage.json"),
    )
    parser.add_argument("--require-complete", action="store_true")
    args = parser.parse_args()
    result = check(args.inventory, args.coverage, args.require_complete)
    print(json.dumps(result, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
