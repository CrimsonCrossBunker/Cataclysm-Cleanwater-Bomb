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

def legacy_alias_note(aliases: list[str]) -> dict[str, object]:
    if not any(item.startswith(("u_", "npc_")) for item in aliases):
        return {
            "status": "unknown",
            "talkers": [],
            "note": (
                "Concrete talker compatibility is not inferred from the "
                "parser key."
            ),
        }
    return {
        "status": "legacy_alpha_beta_alias",
        "talkers": [],
        "note": (
            "u_/npc_ identifies alpha/beta legacy routing; it does not prove "
            "that either talker is a concrete avatar or NPC."
        ),
    }

def aggregate_parser_entries(
    registrations: list[dict[str, object]], contract_kind: str
) -> list[dict[str, object]]:
    aggregate: dict[str, dict[str, object]] = {}
    for registration in registrations:
        keys = registration["keys"]
        if not isinstance(keys, list):
            raise RuntimeError("parser registration keys are invalid")
        for alias_index, key_value in enumerate(keys):
            key = str(key_value)
            entry = aggregate.setdefault(
                key,
                {
                    "syntaxes": set(),
                    "accepted_json_shapes": set(),
                    "handlers": set(),
                    "parser_registrations": [],
                    "alias_groups": set(),
                },
            )
            entry["syntaxes"].add(registration["syntax"])
            entry["accepted_json_shapes"].update(
                registration["accepted_json_shapes"])
            if registration.get("handler"):
                entry["handlers"].add(registration["handler"])
            alias_tuple = tuple(str(item) for item in keys)
            entry["alias_groups"].add(alias_tuple)
            detail = {
                "registration_order": registration["registration_order"],
                "alias_role": "alpha" if alias_index == 0 else "beta",
                "alias_group": list(alias_tuple),
                "source": registration["source"],
            }
            if "registration_kind" in registration:
                detail["registration_kind"] = registration["registration_kind"]
            entry["parser_registrations"].append(detail)

    result: list[dict[str, object]] = []
    for key in sorted(aggregate):
        raw = aggregate[key]
        alias_groups = sorted(raw["alias_groups"])
        aliases = sorted({item for group in alias_groups for item in group})
        result.append(
            {
                "key": key,
                "syntaxes": sorted(raw["syntaxes"]),
                "accepted_json_shapes": sorted(raw["accepted_json_shapes"]),
                "handlers": sorted(raw["handlers"]),
                "aliases": aliases,
                "parser_registrations": sorted(
                    raw["parser_registrations"],
                    key=lambda item: (
                        int(item["registration_order"]),
                        str(item["alias_role"]),
                    ),
                ),
                "parameters": {
                    "status": "unclassified",
                    "items": [],
                    "note": (
                        "Handler-specific members require source-backed "
                        "review."
                    ),
                },
                "value_types": {
                    "status": "partial",
                    "items": sorted(raw["accepted_json_shapes"]),
                    "note": "Only parser dispatch shapes are proven here.",
                },
                "defaults": {"status": "unclassified", "items": []},
                "nesting": {"status": "unclassified", "allows": []},
                "talker_semantics": legacy_alias_note(aliases),
                "variables": {
                    "status": "unclassified",
                    "scopes": [],
                    "known_global_scopes": list(VARIABLE_SCOPES),
                },
                "context": {"status": "unclassified", "requirements": []},
                "contract_status": "partial",
                "contract_kind": contract_kind,
            }
        )
    return result

def add_logical_conditions(
    entries: list[dict[str, object]], condition_contents: str
) -> None:
    by_key = {str(entry["key"]): entry for entry in entries}
    specifications = {
        "and": ("array", ["condition_object", "condition_string"]),
        "or": ("array", ["condition_object", "condition_string"]),
        "not": ("object_or_string", ["condition_object", "condition_string"]),
    }
    for key, (shape, nesting) in specifications.items():
        member_kind = "array" if key != "not" else "object"
        needle = f'jo.has_{member_kind}( "{key}" )'
        offset = condition_contents.find(needle)
        if offset < 0:
            raise RuntimeError(
                f"logical condition parser was not found: {key}")
        by_key[key] = {
            "key": key,
            "syntaxes": ["logical_operator"],
            "accepted_json_shapes": [shape],
            "handlers": ["conditional_t::conditional_t"],
            "aliases": [key],
            "parser_registrations": [
                {
                    "registration_order": -1,
                    "alias_role": "special",
                    "alias_group": [key],
                    "source": source_reference(
                        "src/condition.cpp",
                        condition_contents,
                        offset,
                        "conditional_t::conditional_t",
                    ),
                }
            ],
            "parameters": {"status": "complete", "items": []},
            "value_types": {"status": "complete", "items": [shape]},
            "defaults": {"status": "complete", "items": []},
            "nesting": {"status": "complete", "allows": nesting},
            "talker_semantics": legacy_alias_note([key]),
            "variables": {
                "status": "not_applicable",
                "scopes": [],
                "known_global_scopes": list(VARIABLE_SCOPES),
            },
            "context": {"status": "complete", "requirements": []},
            "contract_status": "complete",
            "contract_kind": "condition",
        }
    entries[:] = [by_key[key] for key in sorted(by_key)]

def walk_json(
        value: object, pointer: str = "") -> Iterable[tuple[object, str]]:
    yield value, pointer
    if isinstance(value, dict):
        for key, child in value.items():
            escaped = str(key).replace("~", "~0").replace("/", "~1")
            yield from walk_json(child, f"{pointer}/{escaped}")
    elif isinstance(value, list):
        for index, child in enumerate(value):
            yield from walk_json(child, f"{pointer}/{index}")

def tracked_json_scan(
    root: Path, condition_keys: set[str], effect_keys: set[str]
) -> dict[str, object]:
    paths = [
        path
        for path in git_tracked_files(root, *CONTRACT_ROOTS)
        if path.endswith(".json")
    ]
    type_counts: collections.Counter[str] = collections.Counter()
    type_examples: dict[str, dict[str, str]] = {}
    condition_counts: collections.Counter[str] = collections.Counter()
    condition_examples: dict[str, dict[str, str]] = {}
    effect_counts: collections.Counter[str] = collections.Counter()
    effect_examples: dict[str, dict[str, str]] = {}
    missing_type = 0
    top_level_objects = 0
    for path in paths:
        try:
            payload = json.loads(read_text(root, path))
        except (OSError, UnicodeError, json.JSONDecodeError) as error:
            raise RuntimeError(
                f"tracked JSON cannot be parsed: {path}: {error}") from error
        top_level = payload if isinstance(payload, list) else [payload]
        for index, item in enumerate(top_level):
            if not isinstance(item, dict):
                continue
            top_level_objects += 1
            pointer = f"/{index}" if isinstance(payload, list) else ""
            object_type = item.get("type")
            if isinstance(object_type, str):
                type_counts[object_type] += 1
                type_examples.setdefault(
                    object_type, {
                        "path": path, "pointer": pointer})
            else:
                missing_type += 1
        for item, pointer in walk_json(payload):
            if isinstance(item, dict):
                for key in item:
                    if key in condition_keys:
                        condition_counts[key] += 1
                        condition_examples.setdefault(
                            key, {"path": path, "pointer": f"{pointer}/{key}"}
                        )
                    if key in effect_keys:
                        effect_counts[key] += 1
                        effect_examples.setdefault(
                            key, {"path": path, "pointer": f"{pointer}/{key}"}
                        )
            elif isinstance(item, str):
                if item in condition_keys:
                    condition_counts[item] += 1
                    condition_examples.setdefault(
                        item, {"path": path, "pointer": pointer})
                if item in effect_keys:
                    effect_counts[item] += 1
                    effect_examples.setdefault(
                        item, {"path": path, "pointer": pointer})
    return {
        "tracked_json_files": len(paths),
        "top_level_objects": top_level_objects,
        "top_level_objects_without_string_type": missing_type,
        "type_counts": type_counts,
        "type_examples": type_examples,
        "condition_counts": condition_counts,
        "condition_examples": condition_examples,
        "effect_counts": effect_counts,
        "effect_examples": effect_examples,
        "paths": paths,
    }

def lexical_documentation(
    root: Path, keys: Iterable[str]
) -> dict[str, dict[str, object]]:
    paths = [path for path in git_tracked_files(
        root, "doc/JSON") if path.endswith(".md")]
    contents = {path: read_text(root, path) for path in paths}
    result: dict[str, dict[str, object]] = {}
    for key in keys:
        evidence: dict[str, object] | None = None
        pattern = re.compile(
            rf"(?<![A-Za-z0-9_]){re.escape(key)}(?![A-Za-z0-9_])")
        for path in paths:
            match = pattern.search(contents[path])
            if match:
                evidence = {
                    "path": path,
                    "line": line_number(
                        contents[path],
                        match.start())}
                break
        result[key] = {
            "status": "lexically_mentioned" if evidence else "not_found",
            "evidence": [evidence] if evidence else [],
            "confidence": "lexical_only",
        }
    return result

def attach_examples_and_docs(
    entries: list[dict[str, object]],
    counts: collections.Counter[str],
    examples: dict[str, dict[str, str]],
    documentation: dict[str, dict[str, object]],
) -> None:
    for entry in entries:
        key = str(entry["key"])
        evidence = examples.get(key)
        entry["example_evidence"] = {
            "status": "lexical_candidate" if evidence else "not_found",
            "occurrences": counts[key],
            "examples": [evidence] if evidence else [],
            "confidence": "lexical_only",
            "note": (
                "A lexical match is evidence of use, not proof that the full "
                "surrounding object is a minimal valid example."
            ),
        }
        entry["documentation"] = documentation[key]

def extract_eoc_base_fields(contents: str) -> list[dict[str, object]]:
    body, base = function_body(contents, "void effect_on_condition::load")
    results: dict[str, dict[str, object]] = {}
    pattern = re.compile(
        r"\b(mandatory|optional)\s*\(\s*jo\s*,\s*was_loaded\s*,\s*"
        r'"([^"]+)"(?P<tail>[^;]*)\);'
    )
    for match in pattern.finditer(body):
        kind, field = match.group(1), match.group(2)
        arguments = [part.strip() for part in match.group(
            "tail").split(",") if part.strip()]
        default_expression = arguments[-1] if kind == "optional" and len(
            arguments) > 1 else None
        results[field] = {
            "name": field,
            "required": kind == "mandatory",
            "requiredness_evidence": kind,
            "default_expression": default_expression,
            "source": source_reference(
                "src/effect_on_condition.cpp",
                contents,
                base + match.start(),
                "effect_on_condition::load",
            ),
        }
    for field in (
        "deactivate_condition",
        "condition",
        "effect",
            "false_effect"):
        match = re.search(re.escape(f'"{field}"'), body)
        if match and field not in results:
            results[field] = {
                "name": field,
                "required": False,
                "requiredness_evidence": "guarded_or_loader_optional_path",
                "default_expression": None,
                "source": source_reference(
                    "src/effect_on_condition.cpp",
                    contents,
                    base + match.start(),
                    "effect_on_condition::load",
                ),
            }
    return [results[key] for key in sorted(results)]

def source_fingerprint(root: Path, paths: Iterable[str]) -> str:
    digest = hashlib.sha256()
    for path in sorted(set(paths)):
        digest.update(path.encode("utf-8"))
        digest.update(b"\0")
        digest.update((root / path).read_bytes())
        digest.update(b"\0")
    return f"sha256:{digest.hexdigest()}"

def build_contracts(
        root: Path = REPOSITORY_ROOT) -> dict[str, dict[str, object]]:
    init_cpp = read_text(root, "src/init.cpp")
    condition_cpp = read_text(root, "src/condition.cpp")
    npctalk_cpp = read_text(root, "src/npctalk.cpp")
    eoc_cpp = read_text(root, "src/effect_on_condition.cpp")
    registrations = parse_json_registrations(init_cpp)
    grouped: dict[str, list[dict[str, object]]] = collections.defaultdict(list)
    for registration in registrations:
        grouped[str(registration["type"])].append(registration)

    complex_conditions = parse_parser_vector(
        condition_cpp,
        "std::vector<condition_parser>\nparsers =",
        "src/condition.cpp",
        "object_member",
        source_symbol="parsers",
    )
    simple_conditions = parse_parser_vector(
        condition_cpp,
        "std::vector<condition_parser>\nparsers_simple =",
        "src/condition.cpp",
        "condition_string",
        order_offset=len(complex_conditions),
        source_symbol="parsers_simple",
    )
    condition_entries = aggregate_parser_entries(
        complex_conditions + simple_conditions, "condition"
    )
    add_logical_conditions(condition_entries, condition_cpp)
    object_effects = parse_parser_vector(
        npctalk_cpp,
        "std::vector<sub_effect_parser>\nparsers =",
        "src/npctalk.cpp",
        "object_member",
        source_symbol="parsers",
    )
    string_effects = parse_string_effects(npctalk_cpp)
    for registration in string_effects:
        registration["registration_order"] = len(object_effects) + int(
            registration["registration_order"]
        )
    effect_entries = aggregate_parser_entries(
        object_effects + string_effects, "effect")

    condition_keys = {str(entry["key"]) for entry in condition_entries}
    effect_keys = {str(entry["key"]) for entry in effect_entries}
    scan = tracked_json_scan(root, condition_keys, effect_keys)
    observed_types = set(scan["type_counts"])
    registered_types = set(grouped)
    unknown_observed = sorted(observed_types - registered_types)
    if unknown_observed:
        raise RuntimeError(
            "top-level DynamicDataLoader types are not registered: " +
            ", ".join(unknown_observed)
        )

    json_docs = lexical_documentation(root, registered_types)
    condition_docs = lexical_documentation(root, condition_keys)
    effect_docs = lexical_documentation(root, effect_keys)
    eoc_fields = extract_eoc_base_fields(eoc_cpp)
    json_entries: list[dict[str, object]] = []
    for object_type in sorted(registered_types):
        type_registrations = grouped[object_type]
        evidence = scan["type_examples"].get(object_type)
        field_contract: dict[str, object] = {
            "status": "unclassified",
            "required_fields": [],
            "optional_fields": [],
            "inheritance": "unknown",
            "copy_from": "unknown",
            "validation": "unknown",
            "note": (
                "No field contract is inferred from instance frequency. Only "
                "mandatory()/optional() or validator-backed evidence may "
                "classify it."
            ),
        }
        if object_type == "effect_on_condition":
            field_contract = {
                "status": "partial",
                "fields": eoc_fields,
                "inheritance": "generic_factory_handle_inheritance",
                "copy_from": "supported_by_generic_factory",
                "validation": "partial",
                "note": (
                    "Only fields directly proven in "
                    "effect_on_condition::load are listed."
                ),
            }
        json_entries.append(
            {
                "type": object_type,
                "registrations": type_registrations,
                "compile_conditional_variants": len(type_registrations) > 1,
                "instance_evidence": {
                    "occurrences": scan["type_counts"][object_type],
                    "examples": [evidence] if evidence else [],
                    "contract_roots": list(CONTRACT_ROOTS),
                },
                "schema": {
                    "status": "none",
                    "paths": [],
                    "note": (
                        "No general validator-backed Schema exists for this "
                        "object type."
                    ),
                },
                "documentation": json_docs[object_type],
                "field_contract": field_contract,
                "contract_status": "partial",
            })

    attach_examples_and_docs(
        condition_entries,
        scan["condition_counts"],
        scan["condition_examples"],
        condition_docs,
    )
    attach_examples_and_docs(
        effect_entries,
        scan["effect_counts"],
        scan["effect_examples"],
        effect_docs,
    )
    input_paths = [
        "src/init.cpp",
        "src/condition.cpp",
        "src/npctalk.cpp",
        "src/effect_on_condition.cpp",
        *scan["paths"],
        *git_tracked_files(root, "doc/JSON"),
    ]
    fingerprint = source_fingerprint(root, input_paths)
    common_source = {
        "project": "Cataclysm-Cleanwater-Bomb",
        "source_fingerprint": fingerprint,
        "contract_roots": list(CONTRACT_ROOTS),
        "discovery": "git ls-files",
    }
    json_payload = {
        "$schema": "../../../tools/json_api/contract-inventory.schema.json",
        "schema_version": 1,
        "inventory_kind": "json_object_types",
        "source": {
            **common_source,
            "registrations": "src/init.cpp#DynamicDataLoader::initialize",
        },
        "summary": {
            "registration_calls": len(registrations),
            "registered_types": len(registered_types),
            "observed_types": len(observed_types),
            "registered_and_observed": len(registered_types & observed_types),
            "registered_not_observed": sorted(
                registered_types - observed_types
            ),
            "observed_not_registered": unknown_observed,
            "tracked_json_files": scan["tracked_json_files"],
            "top_level_objects": scan["top_level_objects"],
            "top_level_objects_without_string_type": scan[
                "top_level_objects_without_string_type"
            ],
            "schema_complete_types": 0,
        },
        "policy": {
            "requiredness": "explicit mandatory() or Schema evidence only",
            "data_frequency": "evidence of use only; never requiredness",
            "unknown_fields": "retained as unclassified",
        },
        "entries": json_entries,
    }
    condition_payload = {
        "$schema": "../../../tools/json_api/contract-inventory.schema.json",
        "schema_version": 1,
        "inventory_kind": "eoc_conditions",
        "source": {
            **common_source,
            "parser": "src/condition.cpp#conditional_t::conditional_t",
            "variable_parser": "src/condition.cpp#var_info::_deserialize",
        },
        "summary": {
            "complex_parser_registrations": len(complex_conditions),
            "simple_parser_registrations": len(simple_conditions),
            "public_keys": len(condition_entries),
            "keys_with_example_candidates": sum(
                bool(scan["condition_counts"][key]) for key in condition_keys
            ),
            "fully_classified_keys": sum(
                entry["contract_status"] == "complete"
                for entry in condition_entries
            ),
        },
        "global_contract": {
            "parser_order": "first matching parser wins",
            "unknown_object_condition": "JsonError",
            "unknown_string_condition": "predicate returning false",
            "variable_scopes": list(VARIABLE_SCOPES),
            "value_helpers": list(VALUE_HELPERS),
        },
        "entries": condition_entries,
    }
    effect_payload = {
        "$schema": "../../../tools/json_api/contract-inventory.schema.json",
        "schema_version": 1,
        "inventory_kind": "eoc_effects",
        "source": {
            **common_source,
            "object_parser": (
                "src/npctalk.cpp#talk_effect_t::parse_sub_effect"
            ),
            "string_parser": (
                "src/npctalk.cpp#talk_effect_t::parse_string_effect"
            ),
        },
        "summary": {
            "object_parser_registrations": len(object_effects),
            "string_parser_registrations": len(string_effects),
            "public_keys": len(effect_entries),
            "keys_with_example_candidates": sum(
                bool(scan["effect_counts"][key]) for key in effect_keys
            ),
            "fully_classified_keys": sum(
                entry["contract_status"] == "complete"
                for entry in effect_entries
            ),
        },
        "global_contract": {
            "parser_order": "first matching parser wins",
            "accepted_effect_container_shapes": ["string", "object", "array"],
            "unknown_effect": "JsonError",
            "variable_scopes": list(VARIABLE_SCOPES),
            "value_helpers": list(VALUE_HELPERS),
        },
        "entries": effect_entries,
    }
    payloads = {
        "json_object_types": json_payload,
        "eoc_conditions": condition_payload,
        "eoc_effects": effect_payload,
    }
    validate_contracts(payloads, root)
    return payloads

def resolve_json_pointer(value: object, pointer: str) -> object:
    """Resolve an RFC 6901 pointer and fail closed on malformed evidence."""
    if pointer == "":
        return value
    if not pointer.startswith("/"):
        raise RuntimeError(f"invalid JSON Pointer: {pointer!r}")
    current = value
    for raw_token in pointer[1:].split("/"):
        token = raw_token.replace("~1", "/").replace("~0", "~")
        if isinstance(current, list):
            try:
                current = current[int(token)]
            except (ValueError, IndexError) as error:
                raise RuntimeError(
                    f"unresolved JSON Pointer: {pointer!r}"
                ) from error
        elif isinstance(current, dict) and token in current:
            current = current[token]
        else:
            raise RuntimeError(f"unresolved JSON Pointer: {pointer!r}")
    return current

def validate_source_reference(
    evidence: object,
    token: str,
    tracked_sources: set[str],
    source_cache: dict[str, str],
    root: Path,
) -> None:
    if not isinstance(evidence, dict):
        raise RuntimeError(f"invalid source evidence: {evidence!r}")
    path = evidence.get("path")
    line = evidence.get("line")
    symbol = evidence.get("symbol")
    valid = (isinstance(path, str) and
             isinstance(line, int) and
             isinstance(symbol, str) and
             path in tracked_sources)
    if not valid:
        raise RuntimeError(f"invalid source evidence: {evidence!r}")
    if path not in source_cache:
        source_cache[path] = read_text(root, path)
    contents = source_cache[path]
    lines = contents.splitlines()
    if line < 1 or line > len(lines):
        raise RuntimeError(f"source evidence line is stale: {path}:{line}")
    if symbol not in contents:
        raise RuntimeError(
            f"source evidence symbol is stale: {path}#{symbol}"
        )
    if token not in lines[line - 1]:
        raise RuntimeError(
            f"source evidence token is stale: {path}:{line}: {token}"
        )

def validate_data_reference(
    evidence: object,
    key: str,
    contract_kind: str,
    tracked_data: set[str],
    data_cache: dict[str, object],
    root: Path,
) -> None:
    if not isinstance(evidence, dict):
        raise RuntimeError(f"invalid data evidence: {evidence!r}")
    path = evidence.get("path")
    pointer = evidence.get("pointer")
    valid = (isinstance(path, str) and
             isinstance(pointer, str) and
             path in tracked_data)
    if not valid:
        raise RuntimeError(f"invalid data evidence: {evidence!r}")
    if path not in data_cache:
        data_cache[path] = json.loads(read_text(root, path))
    value = resolve_json_pointer(data_cache[path], pointer)
    if contract_kind == "json_object_types":
        if not isinstance(value, dict) or value.get("type") != key:
            raise RuntimeError(
                f"JSON type example does not resolve to {key}: "
                f"{path}#{pointer}"
            )
        return
    pointer_token = (
        pointer.rsplit("/", 1)[-1].replace("~1", "/").replace("~0", "~")
        if pointer
        else ""
    )
    if pointer_token != key and value != key:
        raise RuntimeError(
            f"EOC example does not resolve to {key}: {path}#{pointer}"
        )

def validate_documentation_reference(
    documentation: object,
    key: str,
    tracked_docs: set[str],
    documentation_cache: dict[str, str],
    root: Path,
) -> None:
    if not isinstance(documentation, dict):
        raise RuntimeError(f"invalid documentation evidence for {key}")
    status = documentation.get("status")
    evidence = documentation.get("evidence")
    if not isinstance(evidence, list):
        raise RuntimeError(f"invalid documentation evidence for {key}")
    if status == "not_found":
        if evidence:
            raise RuntimeError(f"unexpected documentation evidence for {key}")
        return
    if status != "lexically_mentioned" or len(evidence) != 1:
        raise RuntimeError(f"invalid documentation status for {key}")
    reference = evidence[0]
    if not isinstance(reference, dict):
        raise RuntimeError(f"invalid documentation evidence for {key}")
    path = reference.get("path")
    line = reference.get("line")
    valid = (isinstance(path, str) and
             isinstance(line, int) and
             path in tracked_docs)
    if not valid:
        raise RuntimeError(f"invalid documentation evidence for {key}")
    if path not in documentation_cache:
        documentation_cache[path] = read_text(root, path)
    contents = documentation_cache[path]
    lines = contents.splitlines()
    if line < 1 or line > len(lines) or key not in lines[line - 1]:
        raise RuntimeError(
            f"documentation evidence is stale: {path}:{line}: {key}"
        )
