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
