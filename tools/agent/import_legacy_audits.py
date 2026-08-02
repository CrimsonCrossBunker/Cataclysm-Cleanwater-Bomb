#!/usr/bin/env python3
"""Import reviewed JSONL shards into the frozen Markdown migration inventory."""

from __future__ import annotations

import argparse
import json
import subprocess
from collections import Counter
from pathlib import Path

import yaml

from generate_markdown_inventory import (
    default_record,
    render,
    render_anomaly_report,
    sanitize_contributors,
    stable_id_for,
)

ROOT = Path(__file__).resolve().parents[2]

DEFAULT_INVENTORY = ROOT / "doc/migration/markdown-inventory.yml"

DEFAULT_ANOMALIES = ROOT / "doc/migration/contributor-anomalies.yml"

RETAINED_IDS = {
    "CODE_OF_CONDUCT.md": ("governance.code-of-conduct", "governance", "P0"),
    "CONTRIBUTING.md": ("governance.contributing", "governance", "P0"),
    "ISSUES.md": ("governance.issue-workflow", "governance", "P0"),
    "README.md": ("project.readme", "governance", "P0"),
    "SYNC_EXCLUDED_PRS.md": ("upstream.excluded-prs", "upstream", "P1"),
    "TRANSLATION_CREDITS.md": ("translation.credits", "translation", "P2"),
}

AUDIT_CORRECTIONS = {
    "doc/IN_REPO_MODS.md": {
        "source_symbols": ["mod_manager::load_modfile"],
    },
    "doc/JSON/JSON_INHERITANCE.md": {
        "source_symbols": ["generic_factory::load"],
    },
    "doc/JSON/OBSOLETION_AND_MIGRATION.md": {
        "add_source_paths": ["src/init.cpp", "src/magic.cpp", "src/proficiency.cpp"],
    },
    "doc/TRANSLATING.md": {
        "add_source_paths": ["src/translation_manager.cpp"],
    },
}

def load_jsonl(paths: list[Path]) -> dict[str, dict]:
    records: dict[str, dict] = {}
    for path in paths:
        for line_number, line in enumerate(
            path.read_text(encoding="utf-8").splitlines(), 1
        ):
            if not line.strip():
                continue
            record = json.loads(line)
            original_path = record.get("original_path")
            if not isinstance(original_path, str):
                raise ValueError(f"{path}:{line_number} has no original_path")
            if original_path in records:
                raise ValueError(f"duplicate audit path: {original_path}")
            records[original_path] = record
    return records

def unique_strings(values: list[object]) -> list[str]:
    result = []
    for value in values:
        if isinstance(value, str):
            clean = " ".join(value.split())
            if clean and clean not in result:
                result.append(clean)
    return result

def site_target(value: object) -> str | None:
    if not isinstance(value, str) or not value.strip():
        return None
    clean = value.strip().lstrip("/")
    if clean.startswith("docs/"):
        return clean
    return "docs/zh_CN/" + clean

def evidence_list(value: object) -> list[str]:
    if isinstance(value, str):
        return [" ".join(value.split())]
    if isinstance(value, list):
        return unique_strings(value)
    return []

def anomaly_key(entry: dict) -> tuple[str, str]:
    return entry["original_path"], entry["fingerprint"]

def direct_path_contributors(commit: str, path: str) -> list[str]:
    """Return authors of commits that directly touched this exact path.

    Deliberately avoid ``--follow`` here: Git rename detection jumped between
    unrelated, byte-identical legacy documents and polluted the frozen v1
    inventory with cross-path identities.
    """
    result = subprocess.run(
        ["git", "log", commit, "--format=%aN", "--", path],
        cwd=ROOT,
        check=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
    )
    return result.stdout.splitlines()

def clean_identities(
    original_path: str,
    anomaly_values: list[object],
    authoritative_values: list[object],
    anomaly_sink: list[dict],
) -> tuple[list[str], int]:
    _, inherited_rejected = sanitize_contributors(anomaly_values)
    clean, direct_rejected = sanitize_contributors(authoritative_values)
    rejected = [*inherited_rejected, *direct_rejected]
    records_by_fingerprint = {
        entry["fingerprint"]: {"original_path": original_path, **entry}
        for entry in rejected
    }
    records = list(records_by_fingerprint.values())
    anomaly_sink.extend(records)
    return clean or ["Unknown (see source history)"], len(records)

def retained_record(
    base: dict,
    anomalies: list[dict],
    authoritative_contributors: list[object] | None = None,
) -> dict:
    path = base["original_path"]
    contributors, rejected_count = clean_identities(
        path,
        list(base.get("contributors", [])),
        authoritative_contributors or list(base.get("contributors", [])),
        anomalies,
    )
    if path in RETAINED_IDS:
        stable_id, domain, priority = RETAINED_IDS[path]
        action = "keep_in_repo"
        specificity = "ccb_project"
        relation = "fork_governance_or_project_entry"
        include_in_ai = True
        evidence = "Retained as a repository authority or project entry point."
    else:
        stable_id = "third-party." + stable_id_for(path).removeprefix("legacy.")
        domain = "third-party"
        priority = "P3"
        action = "retain_third_party"
        specificity = "third_party"
        relation = "vendored"
        include_in_ai = False
        evidence = "Retained in place under its file-specific third-party license."
    return {
        "original_path": path,
        "target_path": path,
        "source_commit": base["source_commit"],
        "contributors": contributors,
        "contributor_anomaly_count": rejected_count,
        "license": base["license"],
        "action": action,
        "archive_reason": None,
        "replacement": None,
        "migration_status": "verified",
        "history_strategy": base["history_strategy"],
        "stable_document_id": stable_id,
        "domain": domain,
        "priority": priority,
        "last_applicable_commit": base["source_commit"],
        "ccb_specificity": specificity,
        "upstream_relation": relation,
        "merge_target": None,
        "source_paths": [path],
        "source_symbols": [],
        "translation_required": False,
        "include_in_ai_index": include_in_ai,
        "blockers": [],
        "evidence": [evidence],
        "migration_batch": None,
    }
