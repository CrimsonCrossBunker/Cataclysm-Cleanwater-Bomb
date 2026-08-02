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



if __name__ == "__main__":
    raise SystemExit(main())