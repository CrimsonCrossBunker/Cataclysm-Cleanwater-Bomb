#!/usr/bin/env python3
"""Generate deterministic, source-backed JSON and EOC contract inventories.

Only tracked files returned by ``git ls-files`` are considered.  The extractor
records unknown details instead of inferring required fields or semantics from
data frequency.
"""

from __future__ import annotations

import argparse
import collections
import hashlib
import json
import re
import subprocess
import sys
from pathlib import Path
from typing import Iterable


REPOSITORY_ROOT = Path(__file__).resolve().parents[2]

DEFAULT_OUTPUT_DIRECTORY = REPOSITORY_ROOT / "data/reference/json"

OUTPUT_NAMES = {
    "json_object_types": "ccb_json_object_types.json",
    "eoc_conditions": "ccb_eoc_conditions.json",
    "eoc_effects": "ccb_eoc_effects.json",
}

CONTRACT_ROOTS = ("data/core", "data/json", "data/mods", "data/sound")

VARIABLE_SCOPES = ("u_val", "npc_val", "global_val", "var_val", "context_val")

VALUE_HELPERS = (
    "value_or_var",
    "value_or_var_pair",
    "dbl_or_var",
    "duration_or_var",
    "str_or_var",
    "translation_or_var",
    "eoc_math",
)

def git_tracked_files(root: Path, *pathspecs: str) -> list[str]:
    """Return tracked paths without walking the checkout."""
    completed = subprocess.run(
        ["git", "ls-files", "-z", "--", *pathspecs],
        cwd=root,
        check=True,
        capture_output=True,
    )
    return sorted(
        item.decode("utf-8")
        for item in completed.stdout.split(b"\0")
        if item
    )

def read_text(root: Path, relative_path: str) -> str:
    return (root / relative_path).read_text(encoding="utf-8")

def line_number(text: str, offset: int) -> int:
    return text.count("\n", 0, offset) + 1

def source_reference(
    path: str, text: str, offset: int, symbol: str
) -> dict[str, object]:
    return {
        "path": path,
        "line": line_number(text, offset),
        "symbol": symbol,
    }
