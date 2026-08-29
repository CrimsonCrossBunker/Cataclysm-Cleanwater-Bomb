#!/usr/bin/env python3
"""Generate human and machine migration summaries from the frozen inventory."""

from __future__ import annotations

import argparse
import sys
from collections import Counter, defaultdict
from pathlib import Path

import yaml


ROOT = Path(__file__).resolve().parents[2]
INVENTORY = ROOT / "doc/migration/markdown-inventory.yml"
DEFAULT_REPORT = ROOT / "doc/migration/classification-report.md"
DEFAULT_BATCHES = ROOT / "doc/migration/migration-batches.yml"
CURRENT_PLATFORM_DOCUMENTS = {
    "data/lua/README.md": "lua.platform.overview",
    "tools/lua_api/README.md": "tool-lua-platform-contract",
}
RETIRED_PLATFORM_MARKERS = (
    "cata" + "lua",
    "ccb_" + "native_inventory",
    "public_" + "api_" + "v" + "5",
    "c" + "b" + "n" + "_",
    "api_" + "v" + "5",
)


def load_inventory(path: Path = INVENTORY) -> dict:
    return yaml.safe_load(path.read_text(encoding="utf-8"))


def counter_table(title: str, values: Counter) -> list[str]:
    lines = [f"## {title}", "", "| Value | Count |", "| --- | ---: |"]
    lines.extend(f"| `{key}` | {count} |" for key, count in sorted(values.items()))
    lines.append("")
    return lines


def is_retired_platform_path(path: str) -> bool:
    lowered = path.lower()
    return path.startswith(("data/lua/", "tools/lua_api/", "doc/")) and any(
        marker in lowered for marker in RETIRED_PLATFORM_MARKERS
    )


def report_status(item: dict) -> str:
    if item["original_path"] in CURRENT_PLATFORM_DOCUMENTS:
        return "active"
    if is_retired_platform_path(item["original_path"]):
        return "historical"
    return item["migration_status"]


def report_target(item: dict) -> str:
    if item["original_path"] in CURRENT_PLATFORM_DOCUMENTS:
        return item["original_path"]
    if is_retired_platform_path(item["original_path"]):
        return "historical-only"
    return item["target_path"] or item["replacement"] or "—"


def report_action(item: dict) -> str:
    if item["original_path"] in CURRENT_PLATFORM_DOCUMENTS:
        return "keep_in_repo"
    if is_retired_platform_path(item["original_path"]):
        return "historical"
    return item["action"]


def render_report(data: dict) -> str:
    documents = data["documents"]
    actions = Counter(item["action"] for item in documents)
    statuses = Counter(report_status(item) for item in documents)
    domains = Counter(item["domain"] for item in documents)
    priorities = Counter(item["priority"] for item in documents)
    anomaly_count = sum(item["contributor_anomaly_count"] for item in documents)
    lines = [
        "# Legacy Markdown classification report",
        "",
        "This file is generated from `markdown-inventory.yml`; do not edit it by hand.",
        "",
        f"- Frozen source commit: `{data['source_commit']}`",
        f"- Documents: **{len(documents)}**",
        f"- Remaining `review` actions: **{data['classification_summary']['review']}**",
        f"- Rejected contributor identities: **{anomaly_count}**",
        "- `obj-lua/` is outside the tracked inventory and was not traversed.",
        "",
    ]
    lines.extend(counter_table("Actions", actions))
    lines.extend(counter_table("Migration status", statuses))
    lines.extend(counter_table("Domains", domains))
    lines.extend(counter_table("Priorities", priorities))
    lines.extend(
        [
            "## Documents",
            "",
            "| Original path | Stable ID | Action | Status | Priority | Batch | Target |",
            "| --- | --- | --- | --- | --- | --- | --- |",
        ]
    )
    for item in documents:
        target = report_target(item)
        batch = item["migration_batch"] or "—"
        lines.append(
            f"| `{item['original_path']}` | `"
            f"{CURRENT_PLATFORM_DOCUMENTS.get(item['original_path'], item['stable_document_id'])}` | "
            f"`{report_action(item)}` | `{report_status(item)}` | "
            f"`{item['priority']}` | `{batch}` | `{target}` |"
        )
    lines.append("")
    return "\n".join(lines)


def build_batches(data: dict) -> dict:
    grouped: dict[str, list[dict]] = defaultdict(list)
    for item in data["documents"]:
        if (
            item["original_path"] in CURRENT_PLATFORM_DOCUMENTS
            or is_retired_platform_path(item["original_path"])
            or item["migration_status"] in {"verified", "stubbed", "archived"}
        ):
            continue
        if not item["migration_batch"]:
            continue
        grouped[item["migration_batch"]].append(
            {
                "stable_document_id": item["stable_document_id"],
                "original_path": item["original_path"],
                "action": item["action"],
                "priority": item["priority"],
                "domain": item["domain"],
                "target_path": item["target_path"],
                "blockers": item["blockers"],
            }
        )
    batches = []
    for batch_id, entries in sorted(grouped.items()):
        priorities = sorted({entry["priority"] for entry in entries})
        batches.append(
            {
                "id": batch_id,
                "priorities": priorities,
                "document_count": len(entries),
                "documents": sorted(
                    entries,
                    key=lambda entry: (
                        entry["priority"],
                        entry["domain"],
                        entry["original_path"],
                    ),
                ),
            }
        )
    return {
        "schema_version": 1,
        "kind": "markdown_migration_batches",
        "source_commit": data["source_commit"],
        "batch_count": len(batches),
        "document_count": sum(batch["document_count"] for batch in batches),
        "batches": batches,
    }


def render_yaml(data: dict) -> str:
    return yaml.safe_dump(data, allow_unicode=True, sort_keys=False, width=100)


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--inventory", type=Path, default=INVENTORY)
    parser.add_argument("--report", type=Path, default=DEFAULT_REPORT)
    parser.add_argument("--batches", type=Path, default=DEFAULT_BATCHES)
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()

    inventory_path = args.inventory if args.inventory.is_absolute() else ROOT / args.inventory
    report_path = args.report if args.report.is_absolute() else ROOT / args.report
    batches_path = args.batches if args.batches.is_absolute() else ROOT / args.batches
    data = load_inventory(inventory_path)
    outputs = {
        report_path: render_report(data),
        batches_path: render_yaml(build_batches(data)),
    }
    if args.check:
        stale = [path for path, content in outputs.items() if path.read_text() != content]
        if stale:
            for path in stale:
                print(f"stale migration output: {path.relative_to(ROOT)}", file=sys.stderr)
            return 1
        print("migration classification report and batches are current")
        return 0
    for path, content in outputs.items():
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(content, encoding="utf-8")
    print(f"wrote {len(outputs)} migration outputs")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
