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

def mask_comments(text: str) -> str:
    """Replace C++ comments with spaces while retaining offsets and strings."""
    result = list(text)
    quote: str | None = None
    escaped = False
    index = 0
    while index < len(text):
        char = text[index]
        following = text[index + 1] if index + 1 < len(text) else ""
        if quote is not None:
            if escaped:
                escaped = False
            elif char == "\\":
                escaped = True
            elif char == quote:
                quote = None
            index += 1
            continue
        if char in {'"', "'"}:
            quote = char
            index += 1
            continue
        if char == "/" and following == "/":
            end = text.find("\n", index)
            if end < 0:
                end = len(text)
            for position in range(index, end):
                result[position] = " "
            index = end
            continue
        if char == "/" and following == "*":
            end = text.find("*/", index + 2)
            if end < 0:
                raise RuntimeError("unterminated C++ block comment")
            for position in range(index, end + 2):
                if result[position] != "\n":
                    result[position] = " "
            index = end + 2
            continue
        index += 1
    return "".join(result)

def find_matching(text: str, opening: int, left: str, right: str) -> int:
    """Find a balanced delimiter while ignoring strings and comments."""
    masked = mask_comments(text)
    depth = 0
    quote: str | None = None
    escaped = False
    for index in range(opening, len(masked)):
        char = masked[index]
        if quote is not None:
            if escaped:
                escaped = False
            elif char == "\\":
                escaped = True
            elif char == quote:
                quote = None
            continue
        if char in {'"', "'"}:
            quote = char
        elif char == left:
            depth += 1
        elif char == right:
            depth -= 1
            if depth == 0:
                return index
    raise RuntimeError(f"unbalanced {left}{right} delimiters")
