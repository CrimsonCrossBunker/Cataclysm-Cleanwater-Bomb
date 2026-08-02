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

def split_first_argument(call: str) -> tuple[str, str]:
    depth = 0
    quote: str | None = None
    escaped = False
    for index, char in enumerate(call):
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
        elif char in "([{<":
            depth += 1
        elif char in ")]}>" and depth:
            depth -= 1
        elif char == "," and depth == 0:
            return call[:index].strip(), call[index + 1:].strip()
    raise RuntimeError("registration call has no handler argument")

def preprocessor_contexts(text: str) -> dict[int, list[str]]:
    contexts: dict[int, list[str]] = {}
    stack: list[str] = []
    for number, line in enumerate(text.splitlines(), 1):
        directive = re.match(
            r"#\s*(if|ifdef|ifndef|elif|else|endif)\b(.*)", line.strip()
        )
        if directive:
            kind = directive.group(1)
            expression = directive.group(2).strip()
            if kind in {"if", "ifdef", "ifndef"}:
                stack.append(f"{kind} {expression}".strip())
            elif kind == "elif":
                if not stack:
                    raise RuntimeError(f"orphan #elif at line {number}")
                stack[-1] = f"elif {expression}"
            elif kind == "else":
                if not stack:
                    raise RuntimeError(f"orphan #else at line {number}")
                stack[-1] = f"else ({stack[-1]})"
            elif kind == "endif":
                if not stack:
                    raise RuntimeError(f"orphan #endif at line {number}")
                stack.pop()
        contexts[number] = list(stack)
    if stack:
        raise RuntimeError("unterminated preprocessor conditional")
    return contexts

def handler_metadata(expression: str) -> tuple[str, str | None]:
    normalized = re.sub(r"\s+", " ", expression).strip()
    direct = re.match(r"&\s*([A-Za-z_][A-Za-z0-9_:]*)", normalized)
    if direct:
        return "direct_function", direct.group(1)
    if normalized.startswith("["):
        called = re.findall(r"\b([A-Za-z_][A-Za-z0-9_:]*)\s*\(", normalized)
        ignored = {"if", "for", "while", "switch"}
        return "lambda", next(
            (item for item in called if item not in ignored), None)
    callable_match = re.match(r"([A-Za-z_][A-Za-z0-9_:]*)", normalized)
    return "callable", callable_match.group(1) if callable_match else None

def parse_json_registrations(contents: str) -> list[dict[str, object]]:
    signature = "void DynamicDataLoader::initialize()"
    start = contents.find(signature)
    if start < 0:
        raise RuntimeError("DynamicDataLoader::initialize was not found")
    body_open = contents.find("{", start)
    body_close = find_matching(contents, body_open, "{", "}")
    section = contents[body_open + 1: body_close]
    masked = mask_comments(section)
    contexts = preprocessor_contexts(contents)
    registrations: list[dict[str, object]] = []
    for order, match in enumerate(re.finditer(r"\badd\s*\(", masked)):
        absolute = body_open + 1 + match.start()
        open_paren = contents.find("(", absolute)
        close_paren = find_matching(contents, open_paren, "(", ")")
        first, handler_expression = split_first_argument(
            contents[open_paren + 1: close_paren]
        )
        literal = re.fullmatch(r'"([^"\\]*(?:\\.[^"\\]*)*)"', first)
        if literal is None:
            raise RuntimeError(
                "non-literal DynamicDataLoader registration at "
                f"line {line_number(contents, absolute)}"
            )
        kind, symbol = handler_metadata(handler_expression)
        source_line = line_number(contents, absolute)
        normalized_handler = re.sub(r"\s+", " ", handler_expression).strip()
        registrations.append(
            {
                "registration_order": order,
                "type": json.loads(first),
                "handler_kind": kind,
                "handler_symbol": symbol,
                "handler_expression": normalized_handler,
                "compile_context": contexts[source_line],
                "source": {
                    "path": "src/init.cpp",
                    "line": source_line,
                    "symbol": "DynamicDataLoader::initialize",
                },
            }
        )
    if not registrations:
        raise RuntimeError("no DynamicDataLoader registrations were found")
    return registrations

def initializer_entries(
    contents: str, marker: str, source_path: str
) -> list[tuple[str, int]]:
    marker_offset = contents.find(marker)
    if marker_offset < 0:
        raise RuntimeError(
            f"initializer marker not found in {source_path}: {
                marker!r}")
    opening = contents.find("{", marker_offset + len(marker))
    closing = find_matching(contents, opening, "{", "}")
    body = contents[opening + 1: closing]
    masked = mask_comments(body)
    entries: list[tuple[str, int]] = []
    depth = 0
    entry_start: int | None = None
    quote: str | None = None
    escaped = False
    for index, char in enumerate(masked):
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
        elif char == "{":
            if depth == 0:
                entry_start = index
            depth += 1
        elif char == "}":
            depth -= 1
            if depth < 0:
                raise RuntimeError(f"malformed initializer in {source_path}")
            if depth == 0 and entry_start is not None:
                absolute = opening + 1 + entry_start
                entries.append((body[entry_start: index + 1], absolute))
                entry_start = None
    if depth or not entries:
        raise RuntimeError(f"empty or malformed initializer in {source_path}")
    residue = mask_comments(body)
    for raw, absolute in reversed(entries):
        relative = absolute - opening - 1
        residue = residue[:relative] + " " * \
            len(raw) + residue[relative + len(raw):]
    if residue.replace(",", "").strip():
        raise RuntimeError(f"unparsed initializer content in {source_path}")
    return entries

def parse_parser_vector(
    contents: str,
    marker: str,
    source_path: str,
    syntax: str,
    order_offset: int = 0,
    source_symbol: str | None = None,
) -> list[dict[str, object]]:
    parsed: list[dict[str, object]] = []
    for local_order, (raw, offset) in enumerate(
        initializer_entries(contents, marker, source_path)
    ):
        strings = re.findall(r'"(?:\\.|[^"\\])*"', raw)
        keys = [json.loads(item) for item in strings]
        handler = re.search(r"&\s*([A-Za-z_][A-Za-z0-9_:]*)", raw)
        shapes = re.findall(r"jarg::([a-z_]+)", raw)
        if not 1 <= len(keys) <= 2 or handler is None:
            raise RuntimeError(
                f"unrecognized parser registration at {source_path}:"
                f"{line_number(contents, offset)}"
            )
        if syntax == "object_member" and not shapes:
            raise RuntimeError(
                f"parser registration lacks jarg shape at {source_path}:"
                f"{line_number(contents, offset)}"
            )
        if syntax == "condition_string" and shapes:
            raise RuntimeError(
                f"simple parser unexpectedly has jarg shape at {source_path}:"
                f"{line_number(contents, offset)}"
            )
        parsed.append(
            {
                "registration_order": order_offset +
                local_order,
                "keys": keys,
                "syntax": syntax,
                "accepted_json_shapes": shapes or ["condition_string"],
                "handler": handler.group(1),
                "source": source_reference(
                    source_path,
                    contents,
                    offset,
                    source_symbol or (
                        "parsers_simple"
                        if syntax == "condition_string"
                        else "parsers"
                    ),
                ),
            })
    return parsed

def function_body(contents: str, signature: str) -> tuple[str, int]:
    start = contents.find(signature)
    if start < 0:
        raise RuntimeError(f"function not found: {signature}")
    opening = contents.find("{", start + len(signature))
    closing = find_matching(contents, opening, "{", "}")
    return contents[opening + 1: closing], opening + 1

def parse_string_effects(contents: str) -> list[dict[str, object]]:
    body, base = function_body(
        contents, "void talk_effect_t::parse_string_effect")
    matches: list[tuple[int, str, str | None, str]] = []
    for match in re.finditer(
        r"\bWRAP\(\s*([A-Za-z_][A-Za-z0-9_]*)\s*\)",
            body):
        key = match.group(1)
        if key != "function":
            matches.append(
                (match.start(), key, f"talk_function::{key}", "static_map"))
    for match in re.finditer(r'effect_id\s*==\s*"([^"]+)"', body):
        matches.append(
            (match.start(),
             match.group(1),
             None,
             "explicit_branch"))
    if not matches:
        raise RuntimeError("no string effects were found")
    registrations: list[dict[str, object]] = []
    for order, (offset, key, handler, kind) in enumerate(sorted(matches)):
        registrations.append(
            {
                "registration_order": order,
                "keys": [key],
                "syntax": "effect_string",
                "accepted_json_shapes": ["effect_string"],
                "handler": handler,
                "registration_kind": kind,
                "source": source_reference(
                    "src/npctalk.cpp",
                    contents,
                    base + offset,
                    "talk_effect_t::parse_string_effect",
                ),
            }
        )
    return registrations
