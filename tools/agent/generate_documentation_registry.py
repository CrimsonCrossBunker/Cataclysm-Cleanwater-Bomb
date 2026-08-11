#!/usr/bin/env python3
"""Generate the tracked documentation registry from the Git index."""

from __future__ import annotations

import argparse
import re
import subprocess
import sys
from pathlib import Path

import yaml


ROOT = Path(__file__).resolve().parents[2]
DEFAULT_OUTPUT = ROOT / "ai/documentation-registry.yml"
INVENTORY = ROOT / "doc/migration/markdown-inventory.yml"
ROOT_GOVERNANCE = {
    "AGENTS.md",
    "CODE_OF_CONDUCT.md",
    "CONTRIBUTING.md",
    "GOVERNANCE.md",
    "ISSUES.md",
    "LABELS.md",
    "OWNERSHIP.md",
    "README.md",
    "REPOSITORY_SETTINGS.md",
    "SECURITY.md",
    "SUPPORT.md",
    "SYNC_EXCLUDED_PRS.md",
}
AGENT_METADATA = {
    "ai/agent-benchmark-baseline.json",
    "ai/agent-benchmark.schema.json",
    "ai/agent-benchmark.yml",
    "ai/context.schema.json",
    "ai/context-pack.schema.json",
    "ai/documentation-registry.schema.json",
    "ai/documentation-registry.yml",
    "ai/docs-impact.yml",
    "ai/generated-files.yml",
    "ai/lua-first-replacement-ledger.schema.json",
    "ai/lua-first-replacement-ledger.yml",
    "ai/lua-first-roadmap.schema.json",
    "ai/lua-first-roadmap.yml",
    "ai/project-map.yml",
    "ai/repository-settings.target.schema.json",
    "ai/repository-settings.target.yml",
    "ai/test-matrix.yml",
    "ai/task-router.schema.json",
    "ai/task-router.yml",
}
API_CONTRACTS = {
    "data/lua/manifest.schema.json",
    "data/lua/reference/ccb_public_api_v5.schema.json",
    "data/lua/reference/ccb_public_api_v5_coverage.schema.json",
    "data/lua/types/ccb_api_v5.d.lua",
    "data/lua/types/ccb_platform_v1.d.lua",
    "tools/json_api/contract-inventory.schema.json",
}
ARCHITECTURE_CONTRACTS = {
    "data/lua/LUA_FIRST_PLATFORM.md",
}
CCB_DOCS_IDS = {
    "data/lua/LUA_FIRST_PLATFORM.md": [
        "architecture.lua-first-platform",
        "architecture.lua-first-glossary",
    ],
    "ai/lua-first-roadmap.yml": ["architecture.lua-first-roadmap"],
    "ai/lua-first-roadmap.schema.json": ["architecture.lua-first-roadmap"],
}


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


def tracked_paths() -> list[str]:
    output = subprocess.run(
        ["git", "ls-files", "-z", "--cached"],
        cwd=ROOT,
        check=True,
        stdout=subprocess.PIPE,
    ).stdout.decode("utf-8")
    paths = sorted(item for item in output.split("\0") if item)
    if any("obj-lua" in Path(path).parts for path in paths):
        raise RuntimeError("obj-lua must never enter documentation metadata")
    return paths


def is_documentation_path(path: str) -> bool:
    if path.lower().endswith(".md"):
        return True
    if path in AGENT_METADATA or path in API_CONTRACTS:
        return True
    if path.startswith("data/lua/reference/") and path.endswith(".json"):
        return True
    if path.startswith("data/reference/json/") and path.endswith(".json"):
        return True
    if path.startswith("doc/migration/") and path.endswith((".json", ".yml")):
        return True
    return False


def registry_id(path: str) -> str:
    slug = re.sub(r"[^a-z0-9]+", "-", path.lower()).strip("-")
    return "repo." + slug


def load_inventory() -> dict[str, dict]:
    data = yaml.safe_load(INVENTORY.read_text(encoding="utf-8"))
    return {entry["original_path"]: entry for entry in data["documents"]}


def generated_by(path: str) -> str | None:
    if path in API_CONTRACTS:
        return None
    if path == "ai/documentation-registry.yml":
        return "python3 tools/agent/generate_documentation_registry.py"
    if path == "ai/agent-benchmark-baseline.json":
        return "python3 tools/agent/benchmark_context_pack.py"
    if path == "ai/lua-first-replacement-ledger.yml":
        return "python3 tools/agent/generate_lua_first_replacement_ledger.py"
    if path in {
        "doc/migration/contributor-anomalies.yml",
        "doc/migration/markdown-inventory.yml",
    }:
        return "python3 tools/agent/generate_markdown_inventory.py"
    if path in {
        "doc/migration/classification-report.md",
        "doc/migration/migration-batches.yml",
    }:
        return "python3 tools/agent/generate_migration_reports.py"
    if path.startswith("data/lua/reference/"):
        generators = {
            "cbn_api_inventory": (
                "python3 tools/lua_api/generate_cbn_inventory.py"
            ),
            "cbn_coverage": "python3 tools/lua_api/generate_cbn_coverage.py",
            "ccb_native_inventory": (
                "python3 tools/lua_api/generate_ccb_inventory.py"
            ),
            "ccb_public_api_v5": (
                "python3 tools/lua_api/generate_public_contract.py"
            ),
            "ccb_public_api_v5_coverage": (
                "python3 tools/lua_api/generate_public_contract.py"
            ),
        }
        return generators.get(
            Path(path).stem,
            "Lua contract generator; see ai/generated-files.yml",
        )
    if path.startswith("data/reference/json/"):
        return "python3 tools/json_api/generate_contracts.py"
    return None


def classify(path: str, legacy: dict[str, dict]) -> dict:
    historical = legacy.get(path)
    generator = generated_by(path)
    if path.endswith("AGENTS.md"):
        category = "agent_instruction"
        status = "active"
        authority = "governance_contract"
        source_of_truth = True
    elif path in ROOT_GOVERNANCE or path in AGENT_METADATA:
        category = "authoritative_document"
        status = "active"
        authority = "governance_contract"
        source_of_truth = True
    elif path in ARCHITECTURE_CONTRACTS:
        category = "authoritative_document"
        status = "active"
        authority = "architecture_contract"
        source_of_truth = True
    elif path in API_CONTRACTS:
        category = "api_contract"
        status = "active"
        authority = "api_contract"
        source_of_truth = True
    elif path.startswith("data/lua/templates/") and path.endswith(".md"):
        category = "maintained_document"
        status = "active"
        authority = "explanatory"
        source_of_truth = False
    elif generator:
        category = "generated_document"
        status = "generated"
        authority = "generated_contract"
        source_of_truth = True
    elif path.startswith("src/third-party/") or path == "src/lua/LICENSE.md":
        category = "third_party_document"
        status = "third_party"
        authority = "third_party"
        source_of_truth = False
    elif historical:
        migration_status = historical["migration_status"]
        if migration_status == "stubbed":
            category = "migration_entry"
            status = "moved_stub"
        elif migration_status == "archived":
            category = "historical_document"
            status = "archived"
        elif historical["action"] == "keep_in_repo":
            category = "maintained_document"
            status = "active"
            authority = "explanatory"
            source_of_truth = False
        else:
            category = "legacy_source"
            status = "legacy"
        if historical["action"] != "keep_in_repo":
            authority = "historical"
            source_of_truth = False
    else:
        category = "historical_document"
        status = "historical"
        authority = "historical"
        source_of_truth = False

    stable_document_id = (
        historical.get("stable_document_id") if historical else None
    )
    ccb_docs_ids = []
    if historical and historical["action"] not in {
        "keep_in_repo",
        "retain_third_party",
    }:
        target_id = (
            historical.get("merge_target") or historical["stable_document_id"]
        )
        ccb_docs_ids.append(target_id)
    ccb_docs_ids.extend(CCB_DOCS_IDS.get(path, []))
    return {
        "id": registry_id(path),
        "path": path,
        "category": category,
        "status": status,
        "authority": authority,
        "source_of_truth": source_of_truth,
        "stable_document_id": stable_document_id,
        "ccb_docs_ids": ccb_docs_ids,
        "generated": generator is not None,
        "generated_by": generator,
        "include_in_ai_index": bool(
            historical.get("include_in_ai_index", False)
            if historical
            else status == "active"
        ),
    }


def build_registry(source_commit: str) -> dict:
    legacy = load_inventory()
    entries = [
        classify(path, legacy)
        for path in tracked_paths()
        if is_documentation_path(path)
    ]
    return {
        "schema_version": 1,
        "kind": "documentation_registry",
        "source_commit": source_commit,
        "scope": (
            "Tracked documentation and machine contracts from the Git index; "
            "untracked build caches are never traversed."
        ),
        "entry_count": len(entries),
        "entries": entries,
    }


def render(data: dict) -> str:
    return yaml.safe_dump(data, allow_unicode=True, sort_keys=False, width=100)


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    parser.add_argument("--source-commit", default="HEAD")
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()

    output = args.output if args.output.is_absolute() else ROOT / args.output
    if args.check:
        existing = yaml.safe_load(output.read_text(encoding="utf-8"))
        source_commit = git(
            "rev-parse", "--verify", f"{existing['source_commit']}^{{commit}}"
        ).strip()
    else:
        source_commit = git(
            "rev-parse", "--verify", f"{args.source_commit}^{{commit}}"
        ).strip()
    data = build_registry(source_commit)
    rendered = render(data)

    if args.check:
        if output.read_text(encoding="utf-8") != rendered:
            print(
                f"stale documentation registry: {output.relative_to(ROOT)}",
                file=sys.stderr,
            )
            return 1
        print(f"documentation registry is current ({source_commit})")
        return 0

    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(rendered, encoding="utf-8")
    print(f"wrote {output.relative_to(ROOT)} ({len(data['entries'])} entries)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
