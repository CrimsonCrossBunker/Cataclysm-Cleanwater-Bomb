#!/usr/bin/env python3
"""Validate exact, unique replacement-ledger coverage."""

from __future__ import annotations

import json
from collections import Counter
from pathlib import Path

import jsonschema
import yaml


ROOT = Path(__file__).resolve().parents[2]
LEDGER = ROOT / "ai/lua-first-replacement-ledger.yml"
SCHEMA = ROOT / "ai/lua-first-replacement-ledger.schema.json"


def check() -> dict[str, int]:
    ledger = yaml.safe_load(LEDGER.read_text(encoding="utf-8"))
    schema = json.loads(SCHEMA.read_text(encoding="utf-8"))
    jsonschema.Draft202012Validator(schema).validate(ledger)
    entries = ledger["entries"]
    identities = [
        (entry["inventory"], entry["selector"]) for entry in entries
    ]
    duplicates = sorted(
        key for key, count in Counter(identities).items() if count != 1
    )
    if duplicates:
        raise RuntimeError(
            "replacement ledger has duplicate selectors: "
            f"{duplicates[:20]}"
        )

    source_ids = [source["id"] for source in ledger["sources"]]
    if len(source_ids) != len(set(source_ids)):
        raise RuntimeError("replacement ledger repeats an inventory source")

    expected: set[tuple[str, str]] = set()
    for source in ledger["sources"]:
        document = json.loads(
            (ROOT / source["path"]).read_text(encoding="utf-8")
        )
        if (
            source["source_fingerprint"] !=
            document["source"]["source_fingerprint"]
        ):
            raise RuntimeError(
                f"inventory fingerprint changed for {source['id']}"
            )
        values = {entry[source["selector"]] for entry in document["entries"]}
        if len(values) != source["entry_count"]:
            raise RuntimeError(f"inventory count changed for {source['id']}")
        expected.update((source["id"], value) for value in values)
    actual = set(identities)
    missing = sorted(expected - actual)
    extra = sorted(actual - expected)
    if missing or extra:
        raise RuntimeError(
            "replacement ledger coverage differs: "
            f"missing={missing[:20]}, extra={extra[:20]}"
        )
    expected_summary = {"total": len(entries)}
    for status in (
        "implemented_unverified",
        "bounded_implemented_unverified",
        "primitive_available_unverified",
        "planned",
        "private_adapter",
        "reviewed_not_applicable",
    ):
        expected_summary[status] = sum(
            entry["status"] == status for entry in entries
        )
    if ledger["summary"] != expected_summary:
        raise RuntimeError("replacement ledger status summary is stale")

    implemented_statuses = {
        "implemented_unverified",
        "bounded_implemented_unverified",
    }
    evidenced_statuses = implemented_statuses | {
        "primitive_available_unverified",
    }
    for entry in entries:
        if entry["status"] in evidenced_statuses:
            evidence = entry["evidence"]
            required_kinds = (
                "src/",
                "data/lua/types/",
                "tests/",
                "data/lua/LUA_FIRST_PLATFORM.md",
            )
            if any(not any(value.startswith(kind) for value in evidence)
                   for kind in required_kinds):
                raise RuntimeError(
                    "implemented selector or primitive lacks source, "
                    "declaration, test, or "
                    "documentation evidence: "
                    f"{entry['inventory']}:{entry['selector']}"
                )
            if (
                entry["status"] in implemented_statuses and
                "tools/migrate_lua_first.py" not in evidence
            ):
                raise RuntimeError(
                    "implemented selector lacks migration evidence: "
                    f"{entry['inventory']}:{entry['selector']}"
                )
            if entry["legacy_dependency"] != "none":
                raise RuntimeError(
                    "implemented selector has an unresolved public legacy "
                    "dependency: "
                    f"{entry['inventory']}:{entry['selector']}"
                )
        for evidence in entry["evidence"]:
            if (
                evidence.startswith(
                    ("src/", "data/", "tests/", "tools/", "ai/")
                ) and not (ROOT / evidence).exists()
            ):
                raise RuntimeError(
                    "replacement evidence path does not exist: "
                    f"{evidence}"
                )
    return expected_summary


def main() -> int:
    result = check()
    print(
        f"Lua-first replacement ledger covers {result['total']} selectors; "
        f"{result['implemented_unverified']} have full unverified coverage "
        "and "
        f"{result['bounded_implemented_unverified']} have bounded unverified "
        "coverage."
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
