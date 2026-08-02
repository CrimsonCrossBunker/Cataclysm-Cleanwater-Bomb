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


def load_inventory(path: Path = INVENTORY) -> dict:
    return yaml.safe_load(path.read_text(encoding="utf-8"))


def counter_table(title: str, values: Counter) -> list[str]:
    lines = [f"## {title}", "", "| Value | Count |", "| --- | ---: |"]
    lines.extend(f"| `{key}` | {count} |" for key, count in sorted(values.items()))
    lines.append("")
    return lines


def render_report(data: dict) -> str:
    documents = data["documents"]
    actions = Counter(item["action"] for item in documents)
    statuses = Counter(item["migration_status"] for item in documents)
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
        target = item["target_path"] or item["replacement"] or "—"
        batch = item["migration_batch"] or "—"
        lines.append(
            f"| `{item['original_path']}` | `{item['stable_document_id']}` | "
            f"`{item['action']}` | `{item['migration_status']}` | "
            f"`{item['priority']}` | `{batch}` | `{target}` |"
        )
    lines.append("")
    return "\n".join(lines)



if __name__ == "__main__":
    raise SystemExit(main())