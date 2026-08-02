#!/usr/bin/env python3
"""Generate the complete, machine-readable CCB Lua API v5 contract."""

from __future__ import annotations

import argparse
import hashlib
import json
import re
from collections import Counter, defaultdict
from pathlib import Path
from typing import Iterable

try:
    from .check_luals_declarations import (
        INTENTIONALLY_UNDECLARED_TABLES,
        TABLE_CLASSES,
        coordinate_factories,
    )
    from .generate_ccb_inventory import (
        build_inventory as build_native_inventory,
    )
except ImportError:
    from check_luals_declarations import (  # type: ignore
        INTENTIONALLY_UNDECLARED_TABLES,
        TABLE_CLASSES,
        coordinate_factories,
    )
    from generate_ccb_inventory import (  # type: ignore
        build_inventory as build_native_inventory,
    )


REPOSITORY_ROOT = Path(__file__).resolve().parents[2]

DECLARATIONS = REPOSITORY_ROOT / "data/lua/types/ccb_api_v5.d.lua"

MANIFEST_SCHEMA = REPOSITORY_ROOT / "data/lua/manifest.schema.json"

NATIVE_INVENTORY = (
    REPOSITORY_ROOT / "data/lua/reference/ccb_native_inventory.json"
)

DEFAULT_OUTPUT = (
    REPOSITORY_ROOT / "data/lua/reference/ccb_public_api_v5.json"
)

DEFAULT_COVERAGE = (
    REPOSITORY_ROOT / "data/lua/reference/ccb_public_api_v5_coverage.json"
)

CONTRACT_SCHEMA = (
    REPOSITORY_ROOT / "data/lua/reference/ccb_public_api_v5.schema.json"
)

COVERAGE_SCHEMA = (
    REPOSITORY_ROOT /
    "data/lua/reference/ccb_public_api_v5_coverage.schema.json"
)

CAPABILITY_TOKEN_MAP = {
    "require_actions": "game.actions",
    "require_action": "game.actions",
    "require_dangerous": "game.actions.dangerous",
    "require_callback": "game.callbacks",
    "require_hook": "game.hooks",
    "require_native_events": "events",
    "require_read": "game.read",
    "require_values": "game.read",
    "require_write": "game.write",
}

NAMESPACE_CAPABILITIES = {
    "events": ["events"],
    "game.action_menu": ["ui.pages"],
    "game.actions": ["game.actions"],
    "game.callbacks": ["game.callbacks"],
    "game.definitions": ["registry.read"],
    "game.hooks": ["game.hooks"],
    "game.mapgen": ["events", "game.hooks", "game.read"],
    "game.native_events": ["events", "game.read"],
    "game.relocation": ["game.actions.dangerous", "game.write"],
    "game.sidebar": ["ui.pages"],
    "game.state_get": ["state.character"],
    "game.state_set": ["state.character"],
    "game.targeting": ["game.actions"],
    "modules.import": ["modules.import"],
    "registry": ["registry.read"],
    "scheduler": ["scheduler"],
    "services.call": ["services.consume"],
    "services.provide": ["services.provide"],
    "sidebar": ["ui.pages"],
    "state.character": ["state.character"],
    "state.page": ["state.page"],
    "state.world": ["state.world"],
    "ui": ["ui.pages"],
}

META_FUNCTION_NAMES = {
    "addition": "__add",
    "division": "__div",
    "equal_to": "__eq",
    "less_than": "__lt",
    "less_than_or_equal_to": "__le",
    "multiplication": "__mul",
    "subtraction": "__sub",
    "to_string": "__tostring",
    "unary_minus": "__unm",
}

OPERATOR_SIGNATURES = {
    "__add": (["self", "other"], ["same type"]),
    "__div": (["self", "divisor"], ["same type"]),
    "__eq": (["self", "other"], ["boolean"]),
    "__le": (["self", "other"], ["boolean"]),
    "__lt": (["self", "other"], ["boolean"]),
    "__mul": (["self", "factor"], ["same type"]),
    "__sub": (["self", "other"], ["same type"]),
    "__tostring": (["self"], ["string"]),
    "__unm": (["self"], ["same type"]),
}

def relative(path: Path) -> str:
    try:
        return path.relative_to(REPOSITORY_ROOT).as_posix()
    except ValueError:
        # Parser regression tests intentionally use temporary files.
        return path.as_posix()

def line_number(contents: str, offset: int) -> int:
    return contents.count("\n", 0, offset) + 1

def source(
    path: Path, contents: str, offset: int, authority: str
) -> dict[str, object]:
    return {
        "path": relative(path),
        "line": line_number(contents, offset),
        "authority": authority,
    }

def sha256_bytes(value: bytes) -> str:
    return hashlib.sha256(value).hexdigest()

def documentation_id(section: str, identity: str) -> str:
    normalized = re.sub(r"[^A-Za-z0-9_.-]+", "-", identity).strip("-")
    return f"api.lua.v5.generated.{section}.{normalized}"

def documentation(section: str, identity: str) -> dict[str, str]:
    return {
        "id": documentation_id(section, identity),
        "status": "generated-contract-source",
    }

def extract_balanced(
    contents: str, opening: int, opener: str = "(", closer: str = ")"
) -> tuple[str, int]:
    """Return a balanced C++ region, ignoring comments and quoted strings."""
    if contents[opening] != opener:
        raise RuntimeError(f"expected {opener!r} at offset {opening}")
    depth = 0
    quote: str | None = None
    escaped = False
    line_comment = False
    block_comment = False
    index = opening
    while index < len(contents):
        char = contents[index]
        following = contents[index + 1] if index + 1 < len(contents) else ""
        if line_comment:
            if char == "\n":
                line_comment = False
            index += 1
            continue
        if block_comment:
            if char == "*" and following == "/":
                block_comment = False
                index += 2
            else:
                index += 1
            continue
        if quote is not None:
            if escaped:
                escaped = False
            elif char == "\\":
                escaped = True
            elif char == quote:
                quote = None
            index += 1
            continue
        if char == "/" and following == "/":
            line_comment = True
            index += 2
            continue
        if char == "/" and following == "*":
            block_comment = True
            index += 2
            continue
        if char in {'"', "'"}:
            quote = char
            index += 1
            continue
        if char == opener:
            depth += 1
        elif char == closer:
            depth -= 1
            if depth == 0:
                return contents[opening + 1:index], index + 1
        index += 1
    raise RuntimeError(f"unterminated {opener}{closer} region")

def split_top_level(contents: str) -> list[str]:
    """Split a C++ argument list without splitting nested expressions."""
    parts: list[str] = []
    start = 0
    round_depth = 0
    square_depth = 0
    brace_depth = 0
    quote: str | None = None
    escaped = False
    line_comment = False
    block_comment = False
    index = 0
    while index < len(contents):
        char = contents[index]
        following = contents[index + 1] if index + 1 < len(contents) else ""
        if line_comment:
            if char == "\n":
                line_comment = False
            index += 1
            continue
        if block_comment:
            if char == "*" and following == "/":
                block_comment = False
                index += 2
            else:
                index += 1
            continue
        if quote is not None:
            if escaped:
                escaped = False
            elif char == "\\":
                escaped = True
            elif char == quote:
                quote = None
            index += 1
            continue
        if char == "/" and following == "/":
            line_comment = True
            index += 2
            continue
        if char == "/" and following == "*":
            block_comment = True
            index += 2
            continue
        if char in {'"', "'"}:
            quote = char
        elif char == "(":
            round_depth += 1
        elif char == ")":
            round_depth -= 1
        elif char == "[":
            square_depth += 1
        elif char == "]":
            square_depth -= 1
        elif char == "{":
            brace_depth += 1
        elif char == "}":
            brace_depth -= 1
        elif (
            char == "," and
            round_depth == 0 and
            square_depth == 0 and
            brace_depth == 0
        ):
            parts.append(contents[start:index].strip())
            start = index + 1
        index += 1
    tail = contents[start:].strip()
    if tail:
        parts.append(tail)
    return parts

def cpp_sources() -> list[Path]:
    return sorted((REPOSITORY_ROOT / "src").glob("catalua*.cpp"))

def parse_luals(path: Path = DECLARATIONS) -> dict[str, object]:
    contents = path.read_text(encoding="utf-8")
    lines = contents.splitlines()
    classes: dict[str, dict[str, object]] = {}
    functions: dict[tuple[str, str], dict[str, object]] = {}

    for index, line in enumerate(lines):
        class_match = re.match(r"^---@class\s+(\w+)(.*)$", line)
        if class_match:
            name, declaration_tail = class_match.groups()
            fields: list[dict[str, object]] = []
            cursor = index + 1
            while cursor < len(lines):
                field_match = re.match(
                    r"^---@field\s+(\w+)(\?)?\s+(.+)$", lines[cursor]
                )
                if field_match is None:
                    break
                field_name, optional, declaration = field_match.groups()
                fields.append(
                    {
                        "name": field_name,
                        "optional": bool(optional),
                        "declaration": declaration,
                        "sources": [
                            {
                                "path": relative(path),
                                "line": cursor + 1,
                                "authority": "LuaLS declaration",
                            }
                        ],
                        "documentation": documentation(
                            "property", f"{name}.{field_name}"
                        ),
                    }
                )
                cursor += 1
            classes[name] = {
                "id": name,
                "kind": "record",
                "declaration": declaration_tail.strip(),
                "fields": fields,
                "sources": [
                    {
                        "path": relative(path),
                        "line": index + 1,
                        "authority": "LuaLS declaration",
                    }
                ],
                "documentation": documentation("class", name),
            }

        function_match = re.match(
            r"^function\s+(\w+)([:.])(\w+)\(([^)]*)\)\s+end$", line
        )
        if function_match is None:
            continue
        class_name, separator, name, raw_parameters = function_match.groups()
        block: list[str] = []
        cursor = index - 1
        while cursor >= 0 and lines[cursor].startswith("---"):
            block.append(lines[cursor])
            cursor -= 1
        block.reverse()
        parameters: list[dict[str, object]] = []
        returns: list[dict[str, str]] = []
        overloads: list[str] = []
        deprecated = False
        for annotation in block:
            parameter = re.match(
                r"^---@param\s+(\w+)(\?)?\s+(.+)$", annotation)
            if parameter:
                parameter_name, optional, declaration = parameter.groups()
                parameters.append(
                    {
                        "name": parameter_name,
                        "optional": bool(optional),
                        "declaration": declaration,
                    }
                )
                continue
            return_value = re.match(r"^---@return\s+(.+)$", annotation)
            if return_value:
                returns.append({"declaration": return_value.group(1)})
                continue
            overload = re.match(r"^---@overload\s+(.+)$", annotation)
            if overload:
                overloads.append(overload.group(1))
            if annotation.startswith("---@deprecated"):
                deprecated = True

        raw_names = [
            parameter.strip()
            for parameter in raw_parameters.split(",")
            if parameter.strip()
        ]
        annotated_names = [entry["name"] for entry in parameters]
        if raw_names != annotated_names:
            raise RuntimeError(
                f"LuaLS parameter metadata for {class_name}.{name} is "
                f"{annotated_names}, expected {raw_names}"
            )
        functions[(class_name, name)] = {
            "class": class_name,
            "name": name,
            "style": "method" if separator == ":" else "function",
            "parameters": parameters,
            "returns": returns,
            "overloads": overloads,
            "errors": {
                "mode": "lua-error",
                "message_stability": "not-guaranteed",
                "conditions": [
                    "capability, validation, lifecycle, or native "
                    "operation failure"
                ],
            },
            "api_version": 5,
            "since": "untracked-before-or-at-v5",
            "deprecated": deprecated,
            "deprecation_replacement": None,
            "sources": [
                {
                    "path": relative(path),
                    "line": index + 1,
                    "authority": "LuaLS declaration",
                }
            ],
        }

    if len(classes) != 260:
        raise RuntimeError(f"expected 260 LuaLS classes, found {len(classes)}")
    result = {"classes": classes, "functions": functions, "contents": contents}
    validate_confirmed_declaration_contracts(result)
    return result

def validate_confirmed_declaration_contracts(luals: dict[str, object]) -> None:
    """Lock in declaration fixes that previously disagreed with runtime."""
    classes = luals["classes"]
    functions = luals["functions"]
    assert isinstance(classes, dict)
    assert isinstance(functions, dict)
    handle_fields = {entry["name"]
                     for entry in classes["GameHandle"]["fields"]}
    if ("locator" in handle_fields or
            ("GameHandle", "locator") not in functions):
        raise RuntimeError("GameHandle.locator must be declared as a method")
    if ("TripointCoord", "add_xy") in functions or (
        "TripointCoord",
        "subtract_xy",
    ) in functions:
        raise RuntimeError(
            "TripointCoord add_xy/subtract_xy are not runtime methods")
    for name in ("add", "subtract"):
        overloads = functions[("TripointCoord", name)]["overloads"]
        if not any("PointCoord" in value for value in overloads):
            raise RuntimeError(
                f"TripointCoord.{name} must declare its PointCoord overload"
            )
    callback_fields = {
        entry["name"]: entry["declaration"]
        for entry in classes["CcbCallbackMethodSpec"]["fields"]
    }
    if callback_fields.get("consuming") != "boolean":
        raise RuntimeError("CcbCallbackMethodSpec.consuming must be boolean")

def parse_table_paths() -> tuple[dict[str, set[str]], list[dict[str, object]]]:
    paths: dict[str, set[str]] = defaultdict(set)
    namespaces: dict[str, dict[str, object]] = {}
    assignments: list[tuple[str, str, str, Path, str, int]] = []
    named_pattern = re.compile(
        r"sol::table\s+(\w+)\s*=\s*(?:state\.)?lua\.create_named_table"
        r"\s*\(\s*\"([^\"]+)\"\s*\)",
        re.DOTALL,
    )
    assignment_pattern = re.compile(
        r"\b(\w+)\s*\[\s*\"([^\"]+)\"\s*\]\s*=\s*"
        r"(?:std::move\s*\(\s*)?(\w+)\s*\)?\s*;"
    )
    for path in cpp_sources():
        contents = path.read_text(encoding="utf-8", errors="replace")
        for match in named_pattern.finditer(contents):
            variable, public_name = match.groups()
            paths[variable].add(public_name)
            namespaces.setdefault(
                public_name,
                {
                    "id": public_name,
                    "kind": "global",
                    "class": TABLE_CLASSES.get(variable),
                    "sources": [
                        source(
                            path,
                            contents,
                            match.start(),
                            "native registration",
                        )
                    ],
                    "documentation": documentation("namespace", public_name),
                },
            )
        for match in assignment_pattern.finditer(contents):
            container, public_name, variable = match.groups()
            if variable not in TABLE_CLASSES:
                continue
            assignments.append(
                (
                    container,
                    public_name,
                    variable,
                    path,
                    contents,
                    match.start(),
                )
            )
    changed = True
    while changed:
        changed = False
        for (
            container,
            public_name,
            variable,
            path,
            contents,
            offset,
        ) in assignments:
            for container_path in sorted(paths.get(container, set())):
                public_path = f"{container_path}.{public_name}"
                if public_path not in paths[variable]:
                    paths[variable].add(public_path)
                    changed = True
                namespaces.setdefault(
                    public_path,
                    {
                        "id": public_path,
                        "kind": "child",
                        "class": TABLE_CLASSES.get(variable),
                        "sources": [
                            source(path, contents, offset,
                                   "native registration")
                        ],
                        "documentation": documentation(
                            "namespace", public_path
                        ),
                    },
                )
    return paths, [namespaces[key] for key in sorted(namespaces)]

def parse_set_functions(
    luals: dict[str, object], table_paths: dict[str, set[str]]
) -> list[dict[str, object]]:
    declarations = luals["functions"]
    assert isinstance(declarations, dict)
    functions: list[dict[str, object]] = []
    seen_registrations: set[tuple[str, str]] = set()
    pattern = re.compile(
        r"\b([A-Za-z_][A-Za-z0-9_]*)\.set_function\s*\(\s*\"([^\"]+)\""
    )
    for path in cpp_sources():
        contents = path.read_text(encoding="utf-8", errors="replace")
        for match in pattern.finditer(contents):
            table, name = match.groups()
            if table in INTENTIONALLY_UNDECLARED_TABLES:
                continue
            registration = (table, name)
            if registration in seen_registrations:
                raise RuntimeError(
                    f"duplicate native registration {table}.{name}")
            seen_registrations.add(registration)
            class_name = TABLE_CLASSES.get(table)
            if class_name is None:
                raise RuntimeError(f"unmapped public native table {table}")
            declaration = declarations.get((class_name, name))
            if declaration is None:
                raise RuntimeError(
                    f"native registration {table}.{name} lacks LuaLS "
                    "declaration "
                    f"{class_name}.{name}"
                )
            opening = contents.find("(", match.start())
            call_body, _ = extract_balanced(contents, opening)
            public_paths = sorted(table_paths.get(table, set()))
            if not public_paths:
                raise RuntimeError(
                    f"public native table {table} has no access path")
            for public_namespace in public_paths:
                identity = f"{public_namespace}.{name}"
                entry = dict(declaration)
                entry.update(
                    {
                        "id": identity,
                        "namespace": public_namespace,
                        "class": class_name,
                        "name": name,
                        "capabilities": capabilities_for_call(
                            identity, call_body
                        ),
                        "sources": [
                            source(path, contents, match.start(),
                                   "native registration"),
                            *declaration["sources"],
                        ],
                        "examples": examples_for_symbol(identity),
                        "documentation": documentation("function", identity),
                    }
                )
                functions.append(entry)

    require_match = re.search(
        r"state\.lua\.set_function\s*\(\s*\"require\"",
        (REPOSITORY_ROOT / "src/catalua_ui.cpp").read_text(encoding="utf-8"),
    )
    if require_match is None:
        raise RuntimeError(
            "native require(module_name) registration is missing")
    require_path = REPOSITORY_ROOT / "src/catalua_ui.cpp"
    require_contents = require_path.read_text(encoding="utf-8")
    functions.append(
        {
            "id": "require",
            "namespace": "_G",
            "class": None,
            "name": "require",
            "style": "function",
            "parameters": [
                {
                    "name": "module_name",
                    "optional": False,
                    "declaration": "string",
                }
            ],
            "returns": [{"declaration": "any exported_value"}],
            "overloads": [],
            "errors": {
                "mode": "lua-error",
                "message_stability": "not-guaranteed",
                "conditions": [
                    "invalid module name, source context, cycle, "
                    "or load failure"
                ],
            },
            "api_version": 5,
            "since": "untracked-before-or-at-v5",
            "deprecated": False,
            "deprecation_replacement": None,
            "capabilities": [],
            "sources": [
                source(
                    require_path,
                    require_contents,
                    require_match.start(),
                    "native registration",
                )
            ],
            "examples": examples_for_symbol("require"),
            "documentation": documentation("function", "require"),
        }
    )

    classes = luals["classes"]
    assert isinstance(classes, dict)
    coordinate_class = classes.get("CcbCoordsApi")
    if coordinate_class is None:
        raise RuntimeError("CcbCoordsApi declaration is missing")
    coordinate_fields = {
        entry["name"]: entry for entry in coordinate_class["fields"]
    }
    coord_path = REPOSITORY_ROOT / "src/catalua_bindings_coords.cpp"
    coord_contents = coord_path.read_text(encoding="utf-8")
    for factory in sorted(coordinate_factories()):
        coordinate_declaration = coordinate_fields.get(factory)
        if coordinate_declaration is None:
            raise RuntimeError(
                f"dynamic coordinate factory {factory} lacks LuaLS metadata"
            )
        needle = f'prefix + "_{factory.split("_", 1)[1]}"'
        offset = coord_contents.find(needle)
        if offset < 0:
            offset = coord_contents.find("coord_api[prefix +")
        identity = f"game.coords.{factory}"
        is_point = factory.startswith("point_")
        parameters = [
            {"name": "x", "optional": False, "declaration": "integer"},
            {"name": "y", "optional": False, "declaration": "integer"},
        ]
        if not is_point:
            parameters.append(
                {"name": "z", "optional": False, "declaration": "integer"}
            )
        entry = {
            "id": identity,
            "namespace": "game.coords",
            "class": "CcbCoordsApi",
            "name": factory,
            "style": "function",
            "parameters": parameters,
            "returns": [
                {
                    "declaration": (
                        "PointCoord" if is_point else "TripointCoord"
                    )
                }
            ],
            "overloads": [],
            "errors": {
                "mode": "lua-error",
                "message_stability": "not-guaranteed",
                "conditions": [
                    "invalid coordinate component or unavailable game state"
                ],
            },
            "api_version": 5,
            "since": "untracked-before-or-at-v5",
            "deprecated": False,
            "deprecation_replacement": None,
            "capabilities": ["game.read"],
            "sources": [
                source(coord_path, coord_contents,
                       offset, "native registration"),
                *coordinate_declaration["sources"],
            ],
            "examples": examples_for_symbol(identity),
            "documentation": documentation("function", identity),
        }
        functions.append(entry)
    return sorted(functions, key=lambda entry: str(entry["id"]))

def capabilities_for_call(identity: str, call_body: str) -> list[str]:
    capabilities = set(
        re.findall(
            r"require_capability\s*\([^;]*?\"([^\"]+)\"", call_body, re.DOTALL
        )
    )
    for token, capability in CAPABILITY_TOKEN_MAP.items():
        if token in call_body:
            capabilities.add(capability)
    for prefix, values in NAMESPACE_CAPABILITIES.items():
        if identity == prefix or identity.startswith(prefix + "."):
            capabilities.update(values)
    return sorted(capabilities)

def example_files() -> list[Path]:
    return sorted((REPOSITORY_ROOT / "data/lua/examples").glob("**/*.lua"))

def examples_for_symbol(identity: str) -> list[dict[str, object]]:
    needles = {identity}
    if identity == "require":
        needles.add("require(")
    result: list[dict[str, object]] = []
    for path in example_files():
        contents = path.read_text(encoding="utf-8")
        offsets = [contents.find(needle) for needle in needles]
        offsets = [offset for offset in offsets if offset >= 0]
        if not offsets:
            continue
        offset = min(offsets)
        result.append(
            {
                "id": "lua-example." + relative(path).replace("/", "."),
                "path": relative(path),
                "line": line_number(contents, offset),
            }
        )
    return result

def parse_usertypes(
    luals: dict[str, object],
) -> tuple[
    list[dict[str, object]],
    list[dict[str, object]],
    list[dict[str, object]],
]:
    declarations = luals["functions"]
    classes = luals["classes"]
    assert isinstance(declarations, dict)
    assert isinstance(classes, dict)
    methods: list[dict[str, object]] = []
    properties: list[dict[str, object]] = []
    operators: list[dict[str, object]] = []
    usertype_names: set[str] = set()
    pattern = re.compile(r"new_usertype\s*<[^;]+?>\s*\(", re.DOTALL)
    for path in cpp_sources():
        contents = path.read_text(encoding="utf-8", errors="replace")
        for match in pattern.finditer(contents):
            opening = contents.find("(", match.start())
            body, _ = extract_balanced(contents, opening)
            arguments = split_top_level(body)
            if len(arguments) < 4 or len(arguments[2:]) % 2 != 0:
                raise RuntimeError(
                    f"cannot parse new_usertype registration at "
                    f"{relative(path)}:{line_number(contents, match.start())}"
                )
            name_match = re.fullmatch(r'"([^\"]+)"', arguments[0].strip())
            if name_match is None:
                raise RuntimeError(
                    "new_usertype public name is not a string literal")
            class_name = name_match.group(1)
            usertype_names.add(class_name)
            class_entry = classes.get(class_name)
            if class_entry is None:
                raise RuntimeError(
                    f"native usertype {class_name} lacks a LuaLS class")
            class_entry["kind"] = "native-usertype"
            class_entry["sources"].insert(
                0, source(path, contents, match.start(), "native registration")
            )
            fields = {entry["name"]: entry for entry in class_entry["fields"]}
            for key_expression, value_expression in zip(
                arguments[2::2], arguments[3::2]
            ):
                string_key = re.fullmatch(
                    r'"([^\"]+)"', key_expression.strip())
                if string_key:
                    member_name = string_key.group(1)
                    identity = f"{class_name}.{member_name}"
                    declaration = declarations.get((class_name, member_name))
                    field = fields.get(member_name)
                    if declaration is not None and field is not None:
                        raise RuntimeError(
                            f"{identity} is both a LuaLS method and field")
                    native_offset = contents.find(
                        key_expression.strip(), match.start())
                    native_source = source(
                        path, contents, native_offset, "native registration"
                    )
                    if declaration is not None:
                        entry = dict(declaration)
                        entry.update(
                            {
                                "id": identity,
                                "class": class_name,
                                "capabilities": capabilities_for_call(
                                    identity, value_expression
                                ),
                                "sources": [
                                    native_source,
                                    *declaration["sources"],
                                ],
                                "examples": examples_for_symbol(identity),
                                "documentation": documentation(
                                    "method", identity
                                ),
                            }
                        )
                        methods.append(entry)
                    elif field is not None:
                        properties.append(
                            {
                                **field,
                                "id": identity,
                                "class": class_name,
                                "name": member_name,
                                "read_only": (
                                    "sol::property" in value_expression
                                ),
                                "sources": [native_source, *field["sources"]],
                                "documentation": documentation(
                                    "property", identity
                                ),
                            }
                        )
                    else:
                        raise RuntimeError(
                            f"native usertype member {identity} lacks "
                            "LuaLS metadata"
                        )
                    continue
                meta_match = re.fullmatch(
                    r"sol::meta_function::(\w+)", key_expression.strip()
                )
                if meta_match is None:
                    raise RuntimeError(
                        f"unknown usertype registration key {key_expression!r}"
                    )
                native_name = meta_match.group(1)
                operator = META_FUNCTION_NAMES.get(native_name)
                if operator is None:
                    raise RuntimeError(
                        f"unmapped sol meta function {native_name}")
                parameters, returns = OPERATOR_SIGNATURES[operator]
                identity = f"{class_name}.{operator}"
                native_offset = contents.find(
                    key_expression.strip(), match.start())
                operators.append(
                    {
                        "id": identity,
                        "class": class_name,
                        "name": operator,
                        "parameters": [
                            {
                                "name": parameter,
                                "optional": False,
                                "declaration": (
                                    class_name
                                    if parameter in {"self", "other"}
                                    else "number"
                                ),
                            }
                            for parameter in parameters
                        ],
                        "returns": [
                            {
                                "declaration": (
                                    class_name
                                    if value == "same type"
                                    else value
                                )
                            }
                            for value in returns
                        ],
                        "errors": {
                            "mode": "lua-error",
                            "message_stability": "not-guaranteed",
                            "conditions": [
                                "invalid operand type or native value failure"
                            ],
                        },
                        "api_version": 5,
                        "since": "untracked-before-or-at-v5",
                        "deprecated": False,
                        "deprecation_replacement": None,
                        "capabilities": [],
                        "sources": [
                            source(
                                path,
                                contents,
                                native_offset,
                                "native registration",
                            )
                        ],
                        "examples": examples_for_symbol(identity),
                        "documentation": documentation("operator", identity),
                    }
                )

    declared_methods = {
        key
        for key, entry in declarations.items()
        if entry["style"] == "method"
    }
    native_methods = {(entry["class"], entry["name"]) for entry in methods}
    if declared_methods != native_methods:
        extra = sorted(declared_methods - native_methods)
        missing = sorted(native_methods - declared_methods)
        raise RuntimeError(
            f"native/LuaLS usertype method parity failed; "
            f"declaration-only={extra}, native-only={missing}"
        )
    if len(usertype_names) != 15:
        raise RuntimeError(
            f"expected 15 native usertypes, found {len(usertype_names)}")
    return (
        sorted(methods, key=lambda entry: str(entry["id"])),
        sorted(properties, key=lambda entry: str(entry["id"])),
        sorted(operators, key=lambda entry: str(entry["id"])),
    )

def parse_event_specs() -> list[dict[str, object]]:
    path = REPOSITORY_ROOT / "src/event.h"
    contents = path.read_text(encoding="utf-8")
    field_pattern = re.compile(
        r'\{\s*"([^\"]+)"\s*,\s*cata_variant_type::(\w+)\s*\}'
    )

    def fields_from_body(
        body: str, body_offset: int
    ) -> list[dict[str, object]]:
        result = []
        for match in field_pattern.finditer(body):
            result.append(
                {
                    "name": match.group(1),
                    "type": match.group(2),
                    "sources": [
                        source(
                            path,
                            contents,
                            body_offset + match.start(),
                            "native event specification",
                        )
                    ],
                }
            )
        return result

    helper_fields: dict[str, list[dict[str, object]]] = {}
    helper_pattern = re.compile(r"struct\s+(event_spec_\w+)\s*\{")
    for match in helper_pattern.finditer(contents):
        opening = contents.find("{", match.start())
        body, _ = extract_balanced(contents, opening, "{", "}")
        helper_fields[match.group(1)] = fields_from_body(body, opening + 1)

    events: list[dict[str, object]] = []
    specialization = re.compile(
        r"struct\s+event_spec<event_type::(\w+)>\s*(?::\s*(\w+))?\s*\{"
    )
    for match in specialization.finditer(contents):
        event_name, base = match.groups()
        opening = contents.find("{", match.start())
        body, _ = extract_balanced(contents, opening, "{", "}")
        fields = fields_from_body(body, opening + 1)
        if base:
            fields = [dict(entry) for entry in helper_fields.get(base, [])]
        for field in fields:
            field["documentation"] = documentation(
                "event-field", f"{event_name}.{field['name']}"
            )
        events.append(
            {
                "id": event_name,
                "fields": fields,
                "capabilities": ["events", "game.read"],
                "sources": [
                    source(path, contents, match.start(),
                           "native event specification")
                ],
                "documentation": documentation("event", event_name),
            }
        )
    events.sort(key=lambda entry: str(entry["id"]))
    native_names = {
        entry["type"] for entry in build_native_inventory()["event_types"]
    }
    parsed_names = {entry["id"] for entry in events}
    if parsed_names != native_names:
        raise RuntimeError(
            "event specification parity failed; "
            f"missing={sorted(native_names - parsed_names)}, "
            f"extra={sorted(parsed_names - native_names)}"
        )
    field_count = sum(len(entry["fields"]) for entry in events)
    if field_count != 242:
        raise RuntimeError(f"expected 242 event fields, found {field_count}")
    return events
