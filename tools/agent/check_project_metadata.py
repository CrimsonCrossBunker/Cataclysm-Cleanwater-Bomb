#!/usr/bin/env python3
"""Validate agent routing metadata and the frozen Markdown inventory."""

from __future__ import annotations

import argparse
import fnmatch
import json
import subprocess
from collections import Counter
from pathlib import Path

import jsonschema
import yaml

from generate_markdown_inventory import contributor_rejection_reason


ROOT = Path(__file__).resolve().parents[2]
CONTEXT_FILES = (
    ROOT / "ai/project-map.yml",
    ROOT / "ai/test-matrix.yml",
    ROOT / "ai/generated-files.yml",
    ROOT / "ai/docs-impact.yml",
    ROOT / "ai/repository-settings.target.yml",
)


def load_yaml(path: Path) -> dict:
    data = yaml.safe_load(path.read_text(encoding="utf-8"))
    if not isinstance(data, dict):
        raise ValueError(f"{path.relative_to(ROOT)} must contain a mapping")
    return data


def tracked_paths() -> list[str]:
    output = subprocess.run(
        ["git", "ls-files", "-z", "--cached"],
        cwd=ROOT,
        check=True,
        stdout=subprocess.PIPE,
    ).stdout.decode("utf-8")
    return [item for item in output.split("\0") if item]


def path_pattern_exists(pattern: str, known: list[str]) -> bool:
    if pattern == ".":
        return True
    if "obj-lua" in Path(pattern).parts:
        raise ValueError("obj-lua is forbidden in agent path metadata")
    clean = pattern.rstrip("/")
    if any(char in clean for char in "*?["):
        return any(fnmatch.fnmatch(path, clean) for path in known)
    target = ROOT / clean
    return target.exists() or any(
        path.startswith(clean + "/") for path in known
    )


def unique_ids(data: dict, label: str) -> set[str]:
    ids = [entry.get("id") for entry in data.get("entries", [])]
    if len(ids) != len(set(ids)):
        raise ValueError(f"duplicate id in {label}")
    return set(ids)


def validate_context() -> None:
    schema_path = ROOT / "ai/context.schema.json"
    schema = json.loads(schema_path.read_text(encoding="utf-8"))
    documents = {path.name: load_yaml(path) for path in CONTEXT_FILES}
    known = tracked_paths()
    for path in CONTEXT_FILES:
        jsonschema.Draft202012Validator(schema).validate(documents[path.name])
        unique_ids(documents[path.name], path.name)

    tests = documents["test-matrix.yml"]
    test_ids = unique_ids(tests, "test-matrix.yml")
    for entry in tests["entries"]:
        if not entry.get("command") or not entry.get("workdir"):
            raise ValueError(
                f"test entry {entry['id']} needs command and workdir"
            )
        if not (ROOT / entry["workdir"]).is_dir():
            raise ValueError(
                f"missing workdir for {entry['id']}: {entry['workdir']}"
            )
        for pattern in entry.get("paths", []):
            if not path_pattern_exists(pattern, known):
                raise ValueError(f"unmatched test path pattern: {pattern}")

    project = documents["project-map.yml"]
    for entry in project["entries"]:
        for validation_id in entry.get("validation_ids", []):
            if validation_id not in test_ids:
                raise ValueError(
                    f"unknown validation id {validation_id} in {entry['id']}"
                )
        if not (ROOT / entry["instructions"]).is_file():
            raise ValueError(
                f"missing instructions for {entry['id']}: "
                f"{entry['instructions']}"
            )
        for pattern in entry.get("paths", []):
            if not path_pattern_exists(pattern, known):
                raise ValueError(f"unmatched project path pattern: {pattern}")

    generated = documents["generated-files.yml"]
    for entry in generated["entries"]:
        if entry.get("validation_id") not in test_ids:
            raise ValueError(
                f"unknown generated-file validation id in {entry['id']}"
            )
        if entry.get("tracked"):
            for pattern in entry.get("paths", []):
                if not path_pattern_exists(pattern, known):
                    raise ValueError(
                        f"missing tracked generated file: {pattern}"
                    )

    impact = documents["docs-impact.yml"]
    if impact.get("enforcement") != "advisory":
        raise ValueError("Phase 0/1 documentation impact must remain advisory")
    for entry in impact["entries"]:
        for pattern in entry.get("patterns", []):
            if not path_pattern_exists(pattern, known):
                raise ValueError(
                    f"unmatched documentation impact pattern: {pattern}"
                )


def validate_inventory() -> None:
    inventory_path = ROOT / "doc/migration/markdown-inventory.yml"
    schema_path = ROOT / "doc/migration/markdown-inventory.schema.json"
    inventory = load_yaml(inventory_path)
    schema = json.loads(schema_path.read_text(encoding="utf-8"))
    jsonschema.Draft202012Validator(schema).validate(inventory)
    if inventory["document_count"] != len(inventory["documents"]):
        raise ValueError("document_count does not match documents length")
    paths = [entry["original_path"] for entry in inventory["documents"]]
    if len(paths) != len(set(paths)):
        raise ValueError("duplicate Markdown path in inventory")
    if any(path == "obj-lua" or path.startswith("obj-lua/") for path in paths):
        raise ValueError("obj-lua must not be scanned or inventoried")
    stable_ids = [entry["stable_document_id"] for entry in inventory["documents"]]
    if len(stable_ids) != len(set(stable_ids)):
        raise ValueError("duplicate stable_document_id in Markdown inventory")
    action_counts = Counter(entry["action"] for entry in inventory["documents"])
    status_counts = Counter(
        entry["migration_status"] for entry in inventory["documents"]
    )
    summary = inventory["classification_summary"]
    if summary["review"] != action_counts.get("review", 0):
        raise ValueError("Markdown review count is stale")
    if summary["actions"] != dict(sorted(action_counts.items())):
        raise ValueError("Markdown action summary is stale")
    if summary["migration_statuses"] != dict(sorted(status_counts.items())):
        raise ValueError("Markdown migration-status summary is stale")
    known_paths = set(tracked_paths())
    for entry in inventory["documents"]:
        if any("obj-lua" in Path(path).parts for path in entry["source_paths"]):
            raise ValueError("obj-lua is forbidden in inventory source paths")
        for contributor in entry["contributors"]:
            reason = contributor_rejection_reason(contributor)
            if reason:
                raise ValueError(
                    f"unsafe contributor in {entry['original_path']}: {reason}"
                )
        missing_sources = sorted(
            path for path in entry["source_paths"] if path not in known_paths
        )
        if missing_sources:
            raise ValueError(
                f"missing source paths for {entry['original_path']}: "
                f"{missing_sources}"
            )
        source_text = "\n".join(
            (ROOT / path).read_text(encoding="utf-8", errors="replace")
            for path in entry["source_paths"]
        )
        missing_symbols = sorted(
            symbol
            for symbol in entry["source_symbols"]
            if symbol not in source_text
        )
        if missing_symbols:
            raise ValueError(
                f"missing source symbols for {entry['original_path']}: "
                f"{missing_symbols}"
            )

    anomaly_path = ROOT / "doc/migration/contributor-anomalies.yml"
    anomaly_schema_path = ROOT / "doc/migration/contributor-anomalies.schema.json"
    anomalies = load_yaml(anomaly_path)
    anomaly_schema = json.loads(anomaly_schema_path.read_text(encoding="utf-8"))
    jsonschema.Draft202012Validator(anomaly_schema).validate(anomalies)
    if anomalies["source_commit"] != inventory["source_commit"]:
        raise ValueError("contributor anomaly report uses another source commit")
    if anomalies["rejected_count"] != len(anomalies["entries"]):
        raise ValueError("contributor anomaly report count is stale")
    if any("value" in entry for entry in anomalies["entries"]):
        raise ValueError("raw rejected contributor identities must not be published")


def validate_documentation_registry() -> None:
    registry_path = ROOT / "ai/documentation-registry.yml"
    schema_path = ROOT / "ai/documentation-registry.schema.json"
    registry = load_yaml(registry_path)
    schema = json.loads(schema_path.read_text(encoding="utf-8"))
    jsonschema.Draft202012Validator(schema).validate(registry)
    if registry["entry_count"] != len(registry["entries"]):
        raise ValueError("documentation registry entry_count is stale")
    paths = [entry["path"] for entry in registry["entries"]]
    ids = [entry["id"] for entry in registry["entries"]]
    if len(paths) != len(set(paths)):
        raise ValueError("duplicate path in documentation registry")
    if len(ids) != len(set(ids)):
        raise ValueError("duplicate id in documentation registry")
    known = set(tracked_paths())
    missing = sorted(path for path in paths if path not in known)
    if missing:
        raise ValueError(f"untracked documentation registry paths: {missing}")
    if any("obj-lua" in Path(path).parts for path in paths):
        raise ValueError("obj-lua must not enter the documentation registry")
    for entry in registry["entries"]:
        if entry["generated"] != bool(entry["generated_by"]):
            raise ValueError(
                f"generated boundary mismatch for documentation {entry['id']}"
            )


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.parse_args()
    validate_context()
    validate_inventory()
    validate_documentation_registry()
    print("agent metadata and Markdown inventory are valid")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
