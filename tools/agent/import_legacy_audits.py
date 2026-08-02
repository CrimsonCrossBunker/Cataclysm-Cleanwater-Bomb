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


def reviewed_record(
    base: dict,
    audit: dict,
    anomalies: list[dict],
    authoritative_contributors: list[object] | None = None,
) -> dict:
    path = base["original_path"]
    if authoritative_contributors:
        contributor_source = authoritative_contributors
    elif audit.get("contributors"):
        contributor_source = list(audit["contributors"])
    else:
        contributor_source = list(base.get("contributors", []))
    contributors, rejected_count = clean_identities(
        path,
        list(base.get("contributors", [])),
        contributor_source,
        anomalies,
    )
    action = audit.get("action", audit.get("recommended_action"))
    evidence = evidence_list(audit.get("evidence"))
    if not evidence:
        raise ValueError(f"audit has no evidence: {path}")
    archive_reason = audit.get("archive_reason")
    if action == "archive_public" and not archive_reason:
        archive_reason = evidence[0]
    priority = audit["priority"]
    domain = audit["domain"]
    target_path = site_target(audit.get("target_path"))
    if action in {"keep_in_repo", "retain_third_party"}:
        target_path = path
    source_paths = unique_strings(list(audit.get("source_paths", [])))
    if not source_paths:
        source_paths = [path]
    if any("obj-lua" in Path(item).parts for item in source_paths):
        raise ValueError(f"obj-lua is forbidden in source_paths for {path}")
    correction = AUDIT_CORRECTIONS.get(path, {})
    source_paths = unique_strings(
        [*source_paths, *correction.get("add_source_paths", [])]
    )
    source_symbols = unique_strings(
        list(
            correction.get(
                "source_symbols",
                audit.get("source_symbols", []),
            )
        )
    )
    if correction:
        evidence.append(
            "Import-time source-symbol correction was verified against the "
            "tracked implementation."
        )
    return {
        "original_path": path,
        "target_path": target_path,
        "source_commit": base["source_commit"],
        "contributors": contributors,
        "contributor_anomaly_count": rejected_count,
        "license": audit.get("license", base["license"]),
        "action": action,
        "archive_reason": archive_reason,
        "replacement": audit.get("replacement"),
        "migration_status": "classified",
        "history_strategy": audit["history_strategy"],
        "stable_document_id": audit["stable_document_id"],
        "domain": domain,
        "priority": priority,
        "last_applicable_commit": audit.get("last_applicable_commit"),
        "ccb_specificity": audit["ccb_specificity"],
        "upstream_relation": audit["upstream_relation"],
        "merge_target": audit.get("merge_target"),
        "source_paths": source_paths,
        "source_symbols": source_symbols,
        "translation_required": bool(audit["translation_required"]),
        "include_in_ai_index": bool(audit["include_in_ai_index"]),
        "blockers": unique_strings(list(audit.get("blockers", []))),
        "evidence": evidence,
        "migration_batch": f"phase-{priority[1:]}-{domain}",
    }


def import_audits(inventory: dict, audits: dict[str, dict]) -> tuple[dict, list[dict]]:
    expected = {
        item["original_path"]
        for item in inventory["documents"]
        if item["action"] == "review"
    }
    if set(audits) != expected:
        missing = sorted(expected - set(audits))
        extra = sorted(set(audits) - expected)
        raise ValueError(f"audit coverage mismatch; missing={missing}, extra={extra}")
    anomalies: list[dict] = []
    documents = []
    for base in inventory["documents"]:
        path = base["original_path"]
        direct_contributors = direct_path_contributors(
            base["source_commit"], path
        )
        if path in audits:
            documents.append(
                reviewed_record(
                    base,
                    audits[path],
                    anomalies,
                    direct_contributors,
                )
            )
        else:
            documents.append(
                retained_record(base, anomalies, direct_contributors)
            )
    grouped_ids: dict[str, list[dict]] = {}
    for item in documents:
        grouped_ids.setdefault(item["stable_document_id"], []).append(item)
    for shared_id, items in grouped_ids.items():
        if len(items) < 2:
            continue
        keepers = [item for item in items if item["action"] != "merge_into"]
        keeper = keepers[0] if len(keepers) == 1 else None
        for item in items:
            if item is keeper:
                continue
            if item["action"] == "merge_into" and not item["merge_target"]:
                item["merge_target"] = shared_id
            item["stable_document_id"] = stable_id_for(item["original_path"])
    stable_ids = [item["stable_document_id"] for item in documents]
    if len(stable_ids) != len(set(stable_ids)):
        duplicates = sorted(
            stable_id
            for stable_id, count in Counter(stable_ids).items()
            if count > 1
        )
        raise ValueError(f"duplicate stable document IDs: {duplicates}")
    deduplicated_anomalies = {
        anomaly_key(entry): entry for entry in anomalies
    }
    anomalies = list(deduplicated_anomalies.values())
    action_counts = Counter(item["action"] for item in documents)
    status_counts = Counter(item["migration_status"] for item in documents)
    result = {
        "schema_version": 2,
        "kind": "markdown_inventory",
        "source_commit": inventory["source_commit"],
        "document_count": len(documents),
        "scope": inventory["scope"],
        "classification_summary": {
            "review": 0,
            "actions": dict(sorted(action_counts.items())),
            "migration_statuses": dict(sorted(status_counts.items())),
        },
        "documents": documents,
    }
    return result, anomalies


def upgrade_baseline(inventory: dict) -> tuple[dict, list[dict]]:
    """Upgrade the frozen v1 inventory without making review decisions."""
    anomalies: list[dict] = []
    documents = []
    for base in inventory["documents"]:
        path = base["original_path"]
        direct_contributors = direct_path_contributors(
            base["source_commit"], path
        )
        if base["action"] != "review":
            documents.append(
                retained_record(base, anomalies, direct_contributors)
            )
            continue
        record, direct_anomalies = default_record(
            base["source_commit"], path, direct_contributors
        )
        _, inherited_anomalies = sanitize_contributors(
            list(base.get("contributors", []))
        )
        rejected = {
            entry["fingerprint"]: {"original_path": path, **entry}
            for entry in [*inherited_anomalies, *direct_anomalies]
        }
        anomaly_records = list(rejected.values())
        anomalies.extend(anomaly_records)
        record["contributor_anomaly_count"] = len(anomaly_records)
        documents.append(record)
    anomalies = list(
        {anomaly_key(entry): entry for entry in anomalies}.values()
    )
    action_counts = Counter(item["action"] for item in documents)
    status_counts = Counter(item["migration_status"] for item in documents)
    return (
        {
            "schema_version": 2,
            "kind": "markdown_inventory",
            "source_commit": inventory["source_commit"],
            "document_count": len(documents),
            "scope": inventory["scope"],
            "classification_summary": {
                "review": action_counts.get("review", 0),
                "actions": dict(sorted(action_counts.items())),
                "migration_statuses": dict(sorted(status_counts.items())),
            },
            "documents": documents,
        },
        anomalies,
    )


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("audit", nargs="*", type=Path)
    parser.add_argument("--inventory", type=Path, default=DEFAULT_INVENTORY)
    parser.add_argument("--anomaly-report", type=Path, default=DEFAULT_ANOMALIES)
    parser.add_argument(
        "--baseline-ref",
        help="Read the pre-classification inventory from this Git ref.",
    )
    parser.add_argument(
        "--upgrade-only",
        action="store_true",
        help="Upgrade the frozen baseline without importing review decisions.",
    )
    args = parser.parse_args()

    inventory_path = args.inventory if args.inventory.is_absolute() else ROOT / args.inventory
    anomaly_path = (
        args.anomaly_report
        if args.anomaly_report.is_absolute()
        else ROOT / args.anomaly_report
    )
    if args.baseline_ref:
        relative_inventory = inventory_path.relative_to(ROOT)
        baseline_text = subprocess.run(
            ["git", "show", f"{args.baseline_ref}:{relative_inventory}"],
            cwd=ROOT,
            check=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
        ).stdout
        inventory = yaml.safe_load(baseline_text)
    else:
        inventory = yaml.safe_load(inventory_path.read_text(encoding="utf-8"))
    if args.upgrade_only:
        if args.audit:
            parser.error("--upgrade-only does not accept audit shards")
        result, anomalies = upgrade_baseline(inventory)
        imported_count = 0
    else:
        if not args.audit:
            parser.error("at least one audit shard is required")
        audits = load_jsonl(args.audit)
        result, anomalies = import_audits(inventory, audits)
        imported_count = len(audits)
    inventory_path.write_text(render(result), encoding="utf-8")
    anomaly_path.write_text(
        render_anomaly_report(result["source_commit"], anomalies),
        encoding="utf-8",
    )
    print(
        f"imported {imported_count} reviews; rejected "
        f"{len(anomalies)} unsafe contributor identities"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
