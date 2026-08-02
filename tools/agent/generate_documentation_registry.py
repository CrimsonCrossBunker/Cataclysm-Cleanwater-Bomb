#!/usr/bin/env python3
"""Generate the tracked documentation registry without walking the work tree."""

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
    "ai/context.schema.json",
    "ai/documentation-registry.schema.json",
    "ai/documentation-registry.yml",
    "ai/docs-impact.yml",
    "ai/generated-files.yml",
    "ai/project-map.yml",
    "ai/repository-settings.target.yml",
    "ai/test-matrix.yml",
}

API_CONTRACTS = {
    "data/lua/manifest.schema.json",
    "data/lua/types/ccb_api_v5.d.lua",
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
