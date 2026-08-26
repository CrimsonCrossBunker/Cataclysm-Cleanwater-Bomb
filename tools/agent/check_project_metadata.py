#!/usr/bin/env python3
"""Validate agent routing metadata and the frozen Markdown inventory."""

from __future__ import annotations

import argparse
import fnmatch
import json
import re
import subprocess
from collections import Counter
from functools import lru_cache
from pathlib import Path

import jsonschema
import yaml

from audit_repository_governance import validate_repository, validate_target
from check_lua_first_replacement_ledger import (
    check as check_lua_first_replacement_ledger,
)
from generate_markdown_inventory import contributor_rejection_reason


ROOT = Path(__file__).resolve().parents[2]
CONTEXT_FILES = (
    ROOT / "ai/project-map.yml",
    ROOT / "ai/test-matrix.yml",
    ROOT / "ai/generated-files.yml",
    ROOT / "ai/docs-impact.yml",
)
LUA_FIRST_ROADMAP = ROOT / "ai/lua-first-roadmap.yml"
LUA_FIRST_ROADMAP_SCHEMA = ROOT / "ai/lua-first-roadmap.schema.json"


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


@lru_cache(maxsize=None)
def historical_source_text(source_commit: str, path: str) -> str:
    """Read frozen inventory evidence from its recorded Git commit.

    Migration entries intentionally retain historical source paths even when
    the current Platform cleanup removes those files.  Keep validation tied to
    the inventory's recorded commit instead of requiring every historical path
    to remain in the current worktree.
    """
    if "obj-lua" in Path(path).parts:
        raise ValueError("obj-lua is forbidden in inventory source paths")
    result = subprocess.run(
        ["git", "show", f"{source_commit}:{path}"],
        cwd=ROOT,
        check=False,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )
    if result.returncode != 0:
        current_path = ROOT / path
        if current_path.is_file():
            return current_path.read_bytes().decode("utf-8", errors="replace")
        raise ValueError(
            f"missing source path {path} at inventory commit {source_commit} "
            "and in the current worktree"
        )
    return result.stdout.decode("utf-8", errors="replace")


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


def validate_lua_first_roadmap(roadmap: dict | None = None) -> None:
    """Validate the Lua-first plan without treating planned APIs as shipped."""
    if roadmap is None:
        roadmap = load_yaml(LUA_FIRST_ROADMAP)
    schema = json.loads(LUA_FIRST_ROADMAP_SCHEMA.read_text(encoding="utf-8"))
    jsonschema.Draft202012Validator(schema).validate(roadmap)

    authority = ROOT / roadmap["authority_path"]
    if not authority.is_file():
        raise ValueError(
            f"missing Lua-first authority: {roadmap['authority_path']}"
        )

    inventory_ids = [entry["id"] for entry in roadmap["legacy_inventories"]]
    if len(inventory_ids) != len(set(inventory_ids)):
        raise ValueError("duplicate legacy inventory id in Lua-first roadmap")
    for inventory in roadmap["legacy_inventories"]:
        inventory_path = ROOT / inventory["path"]
        data = json.loads(inventory_path.read_text(encoding="utf-8"))
        entries = data.get("entries")
        if not isinstance(entries, list):
            raise ValueError(
                f"Lua-first inventory has no entries: {inventory['path']}"
            )
        if inventory["entry_count"] != len(entries):
            raise ValueError(
                f"Lua-first inventory count is stale for {inventory['id']}"
            )
        selector = inventory["selector"]
        if any(selector not in entry for entry in entries):
            raise ValueError(
                f"Lua-first inventory selector {selector} is missing in "
                f"{inventory['id']}"
            )

    milestones = roadmap["milestones"]
    milestone_ids = [milestone["id"] for milestone in milestones]
    if len(milestone_ids) != len(set(milestone_ids)):
        raise ValueError("duplicate milestone id in Lua-first roadmap")
    known_milestones = set(milestone_ids)
    dependencies = {
        milestone["id"]: set(milestone["depends_on"])
        for milestone in milestones
    }
    for milestone in milestones:
        unknown = sorted(
            dependencies[milestone["id"]] - known_milestones
        )
        if unknown:
            raise ValueError(
                f"unknown Lua-first milestone dependencies in "
                f"{milestone['id']}: {unknown}"
            )
        if milestone["status"] == "complete" and not milestone["evidence"]:
            raise ValueError(
                f"complete Lua-first milestone needs evidence: "
                f"{milestone['id']}"
            )
        missing_evidence = sorted(
            path
            for path in milestone["evidence"]
            if not (ROOT / path).exists()
        )
        if missing_evidence:
            raise ValueError(
                f"missing Lua-first milestone evidence in {milestone['id']}: "
                f"{missing_evidence}"
            )

    visiting: set[str] = set()
    visited: set[str] = set()

    def visit(milestone_id: str) -> None:
        if milestone_id in visiting:
            raise ValueError("cycle in Lua-first milestone dependencies")
        if milestone_id in visited:
            return
        visiting.add(milestone_id)
        for dependency in dependencies[milestone_id]:
            visit(dependency)
        visiting.remove(milestone_id)
        visited.add(milestone_id)

    for milestone_id in milestone_ids:
        visit(milestone_id)

    capability_ids = [item["id"] for item in roadmap["capabilities"]]
    if len(capability_ids) != len(set(capability_ids)):
        raise ValueError("duplicate capability id in Lua-first roadmap")
    for capability in roadmap["capabilities"]:
        if (
            capability["status"] == "available" and
            capability["legacy_dependency"] == "public_legacy"
        ):
            raise ValueError(
                f"available Lua-first capability exposes public legacy "
                f"dependency: {capability['id']}"
            )


def validate_context() -> None:
    schema_path = ROOT / "ai/context.schema.json"
    schema = json.loads(schema_path.read_text(encoding="utf-8"))
    documents = {path.name: load_yaml(path) for path in CONTEXT_FILES}
    check_lua_first_replacement_ledger()
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
    project_ids = unique_ids(project, "project-map.yml")
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
    if impact.get("enforcement") != "staged":
        raise ValueError("documentation impact must use staged enforcement")
    for entry in impact["entries"]:
        enforcement = entry.get("enforcement")
        if enforcement not in {"advisory", "required"}:
            raise ValueError(
                f"invalid documentation enforcement for {entry['id']}"
            )
        documentation_ids = entry.get("documentation_ids", [])
        if len(documentation_ids) != len(set(documentation_ids)):
            raise ValueError(
                f"duplicate documentation ID in impact {entry['id']}"
            )
        required_checks = entry.get("required_check_ids", [])
        unknown_checks = sorted(set(required_checks) - test_ids)
        if unknown_checks:
            raise ValueError(
                f"unknown required checks in {entry['id']}: {unknown_checks}"
            )
        for pattern in entry.get("patterns", []):
            if not path_pattern_exists(pattern, known):
                raise ValueError(
                    f"unmatched documentation impact pattern: {pattern}"
                )
        if enforcement != "required":
            continue
        if not documentation_ids:
            raise ValueError(
                f"required impact {entry['id']} needs documentation IDs"
            )
        if not required_checks:
            raise ValueError(
                f"required impact {entry['id']} needs validation checks"
            )
        if entry.get("risk_level") != "high":
            raise ValueError(
                f"required impact {entry['id']} must be high risk"
            )
        readiness = entry.get("documentation_readiness")
        if not isinstance(readiness, dict):
            raise ValueError(
                f"required impact {entry['id']} needs docs provenance"
            )
        if readiness.get("state") not in {"bilingual_draft", "active"}:
            raise ValueError(
                f"required impact {entry['id']} has invalid docs readiness"
            )
        if set(readiness.get("languages", [])) != {"zh_CN", "en"}:
            raise ValueError(
                f"required impact {entry['id']} needs zh_CN and en docs"
            )
        if readiness.get("repository") != "CrimsonCrossBunker/CCB-Docs":
            raise ValueError(
                f"required impact {entry['id']} has invalid docs repository"
            )
        if not readiness.get("ref"):
            raise ValueError(
                f"required impact {entry['id']} needs a docs ref"
            )
        if not re.fullmatch(r"[0-9a-f]{40}", readiness.get("commit", "")):
            raise ValueError(
                f"required impact {entry['id']} needs a docs commit"
            )
        if not re.fullmatch(
            r"[0-9a-f]{40}", readiness.get("source_commit", "")
        ):
            raise ValueError(
                f"required impact {entry['id']} needs a source commit"
            )
        if readiness["state"] == "bilingual_draft" and not readiness.get(
            "activation_gate"
        ):
            raise ValueError(
                f"draft documentation for {entry['id']} needs an "
                "activation gate"
            )

    router = load_yaml(ROOT / "ai/task-router.yml")
    router_schema = json.loads(
        (ROOT / "ai/task-router.schema.json").read_text(encoding="utf-8")
    )
    jsonschema.Draft202012Validator(router_schema).validate(router)
    route_ids = [entry["id"] for entry in router["entries"]]
    if len(route_ids) != len(set(route_ids)):
        raise ValueError("duplicate id in task-router.yml")
    for entry in router["entries"]:
        unknown_projects = sorted(set(entry["project_ids"]) - project_ids)
        if unknown_projects:
            raise ValueError(
                f"unknown project ids in {entry['id']}: {unknown_projects}"
            )
        unknown_tests = sorted(set(entry["validation_ids"]) - test_ids)
        if unknown_tests:
            raise ValueError(
                f"unknown validation ids in {entry['id']}: {unknown_tests}"
            )
        for pattern in entry["paths"]:
            if not path_pattern_exists(pattern, known):
                raise ValueError(f"unmatched task-router path: {pattern}")

    benchmark = load_yaml(ROOT / "ai/agent-benchmark.yml")
    benchmark_schema = json.loads(
        (ROOT / "ai/agent-benchmark.schema.json").read_text(encoding="utf-8")
    )
    jsonschema.Draft202012Validator(benchmark_schema).validate(benchmark)
    case_ids = [case["id"] for case in benchmark["cases"]]
    if len(case_ids) != len(set(case_ids)):
        raise ValueError("duplicate id in agent-benchmark.yml")
    for case in benchmark["cases"]:
        unknown_routes = sorted(set(case["expected_routes"]) - set(route_ids))
        if unknown_routes:
            raise ValueError(
                f"unknown benchmark routes in {case['id']}: {unknown_routes}"
            )
        unknown_tests = sorted(
            set(case["expected_validation_ids"]) - test_ids
        )
        if unknown_tests:
            raise ValueError(
                f"unknown benchmark validation ids in {case['id']}: "
                f"{unknown_tests}"
            )
        for path in case["files"]:
            if path not in known:
                raise ValueError(
                    f"untracked benchmark file in {case['id']}: {path}"
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
    stable_ids = [
        entry["stable_document_id"] for entry in inventory["documents"]
    ]
    if len(stable_ids) != len(set(stable_ids)):
        raise ValueError("duplicate stable_document_id in Markdown inventory")
    action_counts = Counter(
        entry["action"] for entry in inventory["documents"]
    )
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
    for entry in inventory["documents"]:
        if any(
            "obj-lua" in Path(path).parts
            for path in entry["source_paths"]
        ):
            raise ValueError("obj-lua is forbidden in inventory source paths")
        for contributor in entry["contributors"]:
            reason = contributor_rejection_reason(contributor)
            if reason:
                raise ValueError(
                    f"unsafe contributor in {entry['original_path']}: {reason}"
                )
        source_text = "\n".join(
            historical_source_text(inventory["source_commit"], path)
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
    anomaly_schema_path = (
        ROOT / "doc/migration/contributor-anomalies.schema.json"
    )
    anomalies = load_yaml(anomaly_path)
    anomaly_schema = json.loads(
        anomaly_schema_path.read_text(encoding="utf-8")
    )
    jsonschema.Draft202012Validator(anomaly_schema).validate(anomalies)
    if anomalies["source_commit"] != inventory["source_commit"]:
        raise ValueError(
            "contributor anomaly report uses another source commit"
        )
    if anomalies["rejected_count"] != len(anomalies["entries"]):
        raise ValueError("contributor anomaly report count is stale")
    if any("value" in entry for entry in anomalies["entries"]):
        raise ValueError(
            "raw rejected contributor identities must not be published"
        )

    batches_path = ROOT / "doc/migration/migration-batches.yml"
    batches_schema_path = ROOT / "doc/migration/migration-batches.schema.json"
    batches = load_yaml(batches_path)
    batches_schema = json.loads(
        batches_schema_path.read_text(encoding="utf-8")
    )
    jsonschema.Draft202012Validator(batches_schema).validate(batches)
    batch_documents = [
        document
        for batch in batches["batches"]
        for document in batch["documents"]
    ]
    if batches["batch_count"] != len(batches["batches"]):
        raise ValueError("migration batch_count is stale")
    if batches["document_count"] != len(batch_documents):
        raise ValueError("migration batch document_count is stale")
    expected_batched = {
        entry["stable_document_id"]
        for entry in inventory["documents"]
        if entry["migration_batch"]
        if entry["migration_status"] not in {"verified", "stubbed", "archived"}
    }
    actual_batched = {
        entry["stable_document_id"] for entry in batch_documents
    }
    if actual_batched != expected_batched:
        raise ValueError("migration batches do not match the inventory")


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


def validate_repository_settings(settings: dict | None = None) -> None:
    if settings is None:
        _target, errors = validate_repository()
    else:
        errors = validate_target(settings)
    if errors:
        details = "\n- ".join(errors)
        raise ValueError(
            f"repository governance metadata is invalid:\n- {details}"
        )


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.parse_args()
    validate_context()
    validate_lua_first_roadmap()
    validate_inventory()
    validate_documentation_registry()
    validate_repository_settings()
    print("agent metadata and Markdown inventory are valid")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
