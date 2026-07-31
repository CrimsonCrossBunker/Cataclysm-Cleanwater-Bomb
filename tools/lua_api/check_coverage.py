#!/usr/bin/env python3
"""Validate and report entry-level CCB coverage of the pinned CBN API."""

from __future__ import annotations

import argparse
import json
from collections import Counter
from pathlib import Path

try:
    from .generate_cbn_coverage import SECTIONS, selector_for, stable_key
except ImportError:
    from generate_cbn_coverage import SECTIONS, selector_for, stable_key


VALID_STATUSES = {"planned", "covered", "not_applicable"}
REQUIRED_FIELDS = {
    "key",
    "selector",
    "domain",
    "status",
    "ccb_equivalent",
    "implementation_evidence",
    "test_evidence",
}
OPTIONAL_FIELDS = {"reason"}
REPOSITORY_ROOT = Path(__file__).resolve().parents[2]


def load(path: Path) -> dict[str, object]:
    value = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(value, dict):
        raise RuntimeError(f"{path} must contain a JSON object")
    return value


def inventory_index(
    inventory: dict[str, object],
) -> dict[str, dict[str, object]]:
    if inventory.get("schema_version") != 1:
        raise RuntimeError("unsupported CBN Lua inventory schema")
    result: dict[str, dict[str, object]] = {}
    for section in SECTIONS:
        entries = inventory.get(section)
        if not isinstance(entries, list):
            raise RuntimeError(f"inventory section {section!r} is invalid")
        for entry in entries:
            if not isinstance(entry, dict):
                raise RuntimeError(
                    f"inventory section {section!r} has a non-object"
                )
            key = stable_key(section, entry)
            if key in result:
                raise RuntimeError(f"duplicate inventory key {key!r}")
            result[key] = selector_for(section, entry)
    return result


def string_list(
    record: dict[str, object],
    field: str,
    key: str,
    *,
    allow_empty: bool = False,
) -> list[str]:
    value = record.get(field)
    if (
        not isinstance(value, list) or
        (not value and not allow_empty) or
        any(not isinstance(item, str) or not item for item in value)
    ):
        qualifier = (
            "a string list" if allow_empty
            else "a non-empty string list"
        )
        raise RuntimeError(f"{key}: {field} must be {qualifier}")
    return value


def verify_evidence(
    evidence: str,
    key: str,
    field: str,
    cache: dict[Path, str],
) -> None:
    if "#" not in evidence:
        raise RuntimeError(
            f"{key}: {field} evidence must use path#needle: {evidence!r}"
        )
    relative_name, needle = evidence.split("#", 1)
    if not relative_name or not needle:
        raise RuntimeError(
            f"{key}: {field} evidence has an empty path or needle"
        )
    path = (REPOSITORY_ROOT / relative_name).resolve()
    try:
        path.relative_to(REPOSITORY_ROOT)
    except ValueError as error:
        raise RuntimeError(
            f"{key}: {field} evidence escapes the repository"
        ) from error
    if not path.is_file():
        raise RuntimeError(
            f"{key}: {field} evidence file is missing: {relative_name}"
        )
    contents = cache.get(path)
    if contents is None:
        contents = path.read_text(encoding="utf-8", errors="replace")
        cache[path] = contents
    if needle not in contents:
        raise RuntimeError(
            f"{key}: {field} evidence needle is stale: {evidence!r}"
        )


def validate_record(
    record: dict[str, object],
    expected_selector: dict[str, object],
    evidence_cache: dict[Path, str],
) -> tuple[str, str]:
    key = str(record.get("key", "<missing key>"))
    fields = set(record)
    missing_fields = REQUIRED_FIELDS - fields
    extra_fields = fields - REQUIRED_FIELDS - OPTIONAL_FIELDS
    if missing_fields:
        raise RuntimeError(
            f"{key}: coverage fields are missing: {sorted(missing_fields)}"
        )
    if extra_fields:
        raise RuntimeError(
            f"{key}: unknown coverage fields: {sorted(extra_fields)}"
        )
    if record["selector"] != expected_selector:
        raise RuntimeError(f"{key}: coverage selector is stale or inexact")
    section = str(expected_selector["section"])
    inventory_entry = dict(expected_selector)
    inventory_entry.pop("section")
    if key != stable_key(section, inventory_entry):
        raise RuntimeError(f"{key}: coverage key is not canonical")

    domain = record.get("domain")
    if not isinstance(domain, str) or not domain:
        raise RuntimeError(f"{key}: domain must be a non-empty string")
    status = record.get("status")
    if status not in VALID_STATUSES:
        raise RuntimeError(f"{key}: invalid coverage status {status!r}")

    equivalent = string_list(
        record,
        "ccb_equivalent",
        key,
        allow_empty=status != "covered",
    )
    implementation = string_list(
        record, "implementation_evidence", key
    )
    tests = string_list(record, "test_evidence", key)
    for evidence in implementation:
        verify_evidence(
            evidence, key, "implementation_evidence", evidence_cache
        )
    for evidence in tests:
        verify_evidence(evidence, key, "test_evidence", evidence_cache)

    reason = record.get("reason")
    if status == "not_applicable":
        if equivalent:
            raise RuntimeError(
                f"{key}: not_applicable entries cannot name an equivalent"
            )
        if not isinstance(reason, str) or not reason.strip():
            raise RuntimeError(
                f"{key}: not_applicable entries must include a reason"
            )
    elif reason is not None:
        raise RuntimeError(
            f"{key}: reason is only valid for not_applicable entries"
        )
    return str(status), domain


def validate_source(
    inventory: dict[str, object],
    coverage: dict[str, object],
    inventory_path: Path,
) -> None:
    source = inventory.get("source")
    recorded = coverage.get("source_inventory")
    if not isinstance(source, dict) or not isinstance(recorded, dict):
        raise RuntimeError("inventory source metadata is missing")
    expected = {
        "path": inventory_path.name,
        "schema_version": inventory.get("schema_version"),
        **source,
    }
    if recorded != expected:
        raise RuntimeError("coverage source inventory metadata is stale")


def check(
    inventory_path: Path,
    coverage_path: Path,
    require_complete: bool,
) -> dict[str, object]:
    inventory = load(inventory_path)
    coverage = load(coverage_path)
    if coverage.get("schema_version") != 2:
        raise RuntimeError("unsupported Lua coverage schema")
    validate_source(inventory, coverage, inventory_path)
    expected = inventory_index(inventory)

    records = coverage.get("entries")
    if not isinstance(records, list) or not records:
        raise RuntimeError("coverage manifest has no entries")
    coverage_by_key: dict[str, dict[str, object]] = {}
    for record in records:
        if not isinstance(record, dict):
            raise RuntimeError("coverage manifest contains a non-object entry")
        key = record.get("key")
        if not isinstance(key, str) or not key:
            raise RuntimeError("coverage entry has an invalid key")
        if key in coverage_by_key:
            raise RuntimeError(f"duplicate coverage key {key!r}")
        coverage_by_key[key] = record

    missing = sorted(set(expected) - set(coverage_by_key))
    stale = sorted(set(coverage_by_key) - set(expected))
    if missing:
        preview = "\n".join(missing[:20])
        raise RuntimeError(
            f"{len(missing)} inventory entries lack coverage:\n{preview}"
        )
    if stale:
        preview = "\n".join(stale[:20])
        raise RuntimeError(
            f"{len(stale)} coverage entries are stale:\n{preview}"
        )

    status_counts: Counter[str] = Counter()
    domain_counts: Counter[str] = Counter()
    evidence_cache: dict[Path, str] = {}
    for key, expected_selector in expected.items():
        status, domain = validate_record(
            coverage_by_key[key], expected_selector, evidence_cache
        )
        status_counts[status] += 1
        domain_counts[domain] += 1

    total = len(expected)
    completed = (
        status_counts["covered"] + status_counts["not_applicable"]
    )
    result: dict[str, object] = {
        "total": total,
        "completed": completed,
        "percent": round(completed * 100.0 / total, 2),
        "by_status": {
            status: status_counts[status]
            for status in sorted(VALID_STATUSES)
        },
        "by_domain": dict(sorted(domain_counts.items())),
    }
    if coverage.get("summary") != result:
        raise RuntimeError("coverage summary is stale")
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
