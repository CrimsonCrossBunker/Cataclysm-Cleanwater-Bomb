#!/usr/bin/env python3
"""Validate agent routing metadata and the frozen Markdown inventory."""

from __future__ import annotations

import argparse
import fnmatch
import json
import subprocess
from pathlib import Path

import jsonschema
import yaml


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
        [
            "git",
            "ls-files",
            "-z",
            "--cached",
            "--others",
            "--exclude-standard",
        ],
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


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.parse_args()
    validate_context()
    validate_inventory()
    print("agent metadata and Markdown inventory are valid")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
