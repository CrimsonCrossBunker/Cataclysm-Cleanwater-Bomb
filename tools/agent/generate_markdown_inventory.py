#!/usr/bin/env python3
"""Generate tracked Markdown inventory without walking the work tree."""

from __future__ import annotations

import argparse
import hashlib
import re
import subprocess
import sys
import unicodedata
from collections import Counter
from copy import deepcopy
from pathlib import Path

import yaml


ROOT = Path(__file__).resolve().parents[2]
DEFAULT_OUTPUT = ROOT / "doc/migration/markdown-inventory.yml"
def git(*args: str) -> str:
    result = subprocess.run(
        ["git", *args],
        cwd=ROOT,
        check=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
    )
    return result.stdout
def resolve_commit(value: str) -> str:
    return git("rev-parse", "--verify", f"{value}^{{commit}}").strip()
def tracked_markdown(commit: str) -> list[str]:
    """Return the migration scope from Git, never from a filesystem walk."""
    output = subprocess.run(
        ["git", "ls-tree", "-r", "-z", "--name-only", commit],
        cwd=ROOT,
        check=True,
        stdout=subprocess.PIPE,
    ).stdout.decode("utf-8")
    paths = []
    for path in output.split("\0"):
        if not path or not path.lower().endswith(".md"):
            continue
        if path.split("/", 1)[0].startswith("."):
            continue
        if path == "obj-lua" or path.startswith("obj-lua/"):
            raise RuntimeError(
                "obj-lua must never enter the documentation inventory"
            )
        paths.append(path)
    return sorted(paths)
def contributors(commit: str, path: str) -> list[str]:
    names = git(
        "log", commit, "--follow", "--format=%aN", "--", path
    ).splitlines()
    unique: list[str] = []
    for name in names:
        clean = name.strip()
        if clean and clean not in unique:
            unique.append(clean)
    return unique or ["Unknown (see source history)"]
def classification(path: str) -> tuple[str, str, str]:
    if path.startswith("src/third-party/"):
        return (
            "retain_third_party",
            "file-specific third-party license",
            "retain_in_place",
        )
    if path == "src/lua/LICENSE.md":
        return "retain_third_party", "MIT", "retain_in_place"
    if path in {
        "README.md",
        "CONTRIBUTING.md",
        "CODE_OF_CONDUCT.md",
        "ISSUES.md",
        "SYNC_EXCLUDED_PRS.md",
        "TRANSLATION_CREDITS.md",
    }:
        return "keep_in_repo", "CC-BY-SA-3.0", "keep_in_repo"
    return "review", "CC-BY-SA-3.0", "evaluate_filtered_history"
def build_inventory(
    commit: str,
    contributor_snapshot: dict[str, list[str]] | None = None,
) -> dict:
    recorded_contributors = contributor_snapshot or {}
    documents = []
    for path in tracked_markdown(commit):
        action, license_name, history_strategy = classification(path)
        documents.append(
            {
                "original_path": path,
                "target_path": (
                    path
                    if action in {"keep_in_repo", "retain_third_party"}
                    else None
                ),
                "source_commit": commit,
                "contributors": list(recorded_contributors[path])
                if path in recorded_contributors
                else contributors(commit, path),
                "license": license_name,
                "action": action,
                "archive_reason": None,
                "replacement": None,
                "migration_status": "inventoried",
                "history_strategy": history_strategy,
            }
        )
    return {
        "schema_version": 1,
        "kind": "markdown_inventory",
        "source_commit": commit,
        "document_count": len(documents),
        "scope": (
            "Tracked Markdown at source_commit, excluding dot-prefixed "
            "tool/config paths; "
            "filesystem caches are never traversed."
        ),
        "documents": documents,
    }
def render(data: dict) -> str:
    return yaml.safe_dump(data, allow_unicode=True, sort_keys=False, width=100)
def inventory_for_check(output: Path) -> tuple[str, dict[str, list[str]]]:
    """Load the frozen commit and history snapshot used by check mode.

    Contributor history depends on clone depth and mailmap availability.  A
    fresh generation records that provenance, while check mode preserves it
    and validates all deterministic inventory fields around it.
    """
    if not output.exists():
        raise FileNotFoundError(f"inventory does not exist: {output}")
    data = yaml.safe_load(output.read_text(encoding="utf-8"))
    contributor_snapshot = {
        item["original_path"]: item["contributors"]
        for item in data.get("documents", [])
        if isinstance(item.get("original_path"), str) and isinstance(
            item.get("contributors"), list
        )
    }
    return (
        resolve_commit(str(data["source_commit"])),
        contributor_snapshot,
    )
def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    parser.add_argument("--source-commit", default="HEAD")
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()

    output = args.output if args.output.is_absolute() else ROOT / args.output
    if args.check:
        commit, contributor_snapshot = inventory_for_check(output)
    else:
        commit = resolve_commit(args.source_commit)
        contributor_snapshot = None
    rendered = render(build_inventory(commit, contributor_snapshot))

    if args.check:
        if output.read_text(encoding="utf-8") != rendered:
            print(
                f"stale Markdown inventory: {output.relative_to(ROOT)}",
                file=sys.stderr,
            )
            return 1
        print(f"Markdown inventory is current at {commit}")
        return 0

    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(rendered, encoding="utf-8")
    print(f"wrote {output.relative_to(ROOT)} at {commit}")
    return 0
DEFAULT_ANOMALY_REPORT = ROOT / "doc/migration/contributor-anomalies.yml"
def sanitize_contributors(values: list[object]) -> tuple[list[str], list[dict]]:
    """Normalize identities and keep rejected values out of publishable data."""
    clean_names: list[str] = []
    anomalies: list[dict] = []
    for value in values:
        reason = contributor_rejection_reason(value)
        if reason:
            encoded = repr(value).encode("utf-8", errors="backslashreplace")
            anomalies.append(
                {
                    "fingerprint": "sha256:" + hashlib.sha256(encoded).hexdigest(),
                    "reason": reason,
                    "value_type": type(value).__name__,
                }
            )
            continue
        clean = " ".join(value.split())
        if clean not in clean_names:
            clean_names.append(clean)
    return clean_names, anomalies
UNSAFE_CONTRIBUTOR_PATTERNS = (
    re.compile(r"\bgit\s+config\b", re.IGNORECASE),
    re.compile(r"(?:\$\(|`|&&|\|\||[;<>])"),
    re.compile(r"(?:^|\s)-(?:c|e|x)(?:\s|$)"),
)
MAX_CONTRIBUTOR_LENGTH = 160
KEEP_IN_REPO = {
    "README.md",
    "CONTRIBUTING.md",
    "CODE_OF_CONDUCT.md",
    "ISSUES.md",
    "SYNC_EXCLUDED_PRS.md",
    "TRANSLATION_CREDITS.md",
}
def contributor_rejection_reason(value: object) -> str | None:
    if not isinstance(value, str):
        return "identity is not a string"
    if any(unicodedata.category(character) == "Cc" for character in value):
        return "identity contains a control character"
    clean = " ".join(value.split())
    if not clean:
        return "identity is empty after whitespace normalization"
    if len(clean) > MAX_CONTRIBUTOR_LENGTH:
        return "identity exceeds the safe display length"
    if any(pattern.search(clean) for pattern in UNSAFE_CONTRIBUTOR_PATTERNS):
        return "identity contains a command fragment or control syntax"
    return None