#!/usr/bin/env python3
"""Generate the Lua-first Platform v1 public contract.

The contract is derived from the checked-in LuaLS declarations, the Platform
native registration inventory, and the current workspace's lua_platform_* C++
registration files.  It intentionally has no JSON/EOC or historical-runtime
coverage model.
"""

from __future__ import annotations

import argparse
import json
import re
from pathlib import Path

from jsonschema import Draft202012Validator


REPOSITORY_ROOT = Path(__file__).resolve().parents[2]
DEFAULT_DECLARATIONS = REPOSITORY_ROOT / "data/lua/types/ccb_platform_v1.d.lua"
DEFAULT_NATIVE_INVENTORY = (
    REPOSITORY_ROOT / "data/lua/reference/ccb_platform_native_inventory.json"
)
DEFAULT_SCHEMA = REPOSITORY_ROOT / (
    "data/lua/reference/ccb_platform_api_v1.schema.json"
)
DEFAULT_OUTPUT = REPOSITORY_ROOT / (
    "data/lua/reference/ccb_platform_api_v1.json"
)

CLASS_PATTERN = re.compile(r"^---@class\s+(?P<name>[A-Za-z_][A-Za-z0-9_]*)")
FIELD_PATTERN = re.compile(
    r"^---@field\s+(?P<name>[A-Za-z_][A-Za-z0-9_]*)\??\s+(?P<type>[^\s]+)"
)
FUNCTION_PATTERN = re.compile(
    r"^function\s+(?P<owner>[A-Za-z_][A-Za-z0-9_]*)"
    r"(?P<separator>[.:])(?P<name>[A-Za-z_][A-Za-z0-9_]*)\s*"
    r"\((?P<parameters>[^)]*)\)"
)
FORBIDDEN_DECLARATION_TOKENS = (
    "ccb_api_v5",
    "api_version",
    "capabilities",
    "manifest.json",
    "game.",
)


def parse_luals_declarations(text: str) -> dict[str, object]:
    """Extract deterministic class, field, and method facts from LuaLS text."""
    classes: dict[str, dict[str, object]] = {}
    functions: list[dict[str, str]] = []
    current_class: str | None = None
    for line_number, line in enumerate(text.splitlines(), start=1):
        class_match = CLASS_PATTERN.match(line)
        if class_match:
            current_class = class_match.group("name")
            classes.setdefault(
                current_class, {"name": current_class, "fields": []}
            )
            continue

        field_match = FIELD_PATTERN.match(line)
        if field_match and current_class is not None:
            fields = classes[current_class]["fields"]
            assert isinstance(fields, list)
            fields.append(
                {
                    "name": field_match.group("name"),
                    "type": field_match.group("type"),
                    "line": line_number,
                }
            )
            continue

        function_match = FUNCTION_PATTERN.match(line)
        if function_match:
            functions.append(
                {
                    "owner": function_match.group("owner"),
                    "name": function_match.group("name"),
                    "parameters": function_match.group("parameters").strip(),
                    "line": str(line_number),
                }
            )

    for class_data in classes.values():
        fields = class_data["fields"]
        assert isinstance(fields, list)
        fields.sort(key=lambda field: (str(field["name"]), int(field["line"])))

    return {
        "class_count": len(classes),
        "function_count": len(functions),
        "classes": [classes[name] for name in sorted(classes)],
        "functions": sorted(
            functions,
            key=lambda function: (
                str(function["owner"]),
                str(function["name"]),
                int(str(function["line"])),
            ),
        ),
    }


def load_json(path: Path) -> dict[str, object]:
    value = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(value, dict):
        raise RuntimeError(f"{path} must contain a JSON object")
    return value


def repository_relative(path: Path) -> str:
    """Return a stable repository path for generated source metadata."""
    try:
        return path.resolve().relative_to(REPOSITORY_ROOT).as_posix()
    except ValueError:
        return path.as_posix()


def validate_schema_document(
    document: dict[str, object], schema_path: Path, label: str
) -> None:
    schema = load_json(schema_path)
    errors = sorted(
        Draft202012Validator(schema).iter_errors(document),
        key=lambda error: list(error.absolute_path),
    )
    if errors:
        location = ".".join(str(part) for part in errors[0].absolute_path)
        suffix = f" at {location}" if location else ""
        raise RuntimeError(
            f"{label} does not conform to {repository_relative(schema_path)}"
            f"{suffix}: {errors[0].message}"
        )


def validate_luals_declarations(declarations: dict[str, object]) -> None:
    classes = declarations.get("classes")
    if not isinstance(classes, list):
        raise RuntimeError("Platform LuaLS classes must be an array")
    root = next(
        (
            entry
            for entry in classes
            if (
                isinstance(entry, dict) and
                entry.get("name") == "CcbPlatformV1"
            )
        ),
        None,
    )
    if not isinstance(root, dict):
        raise RuntimeError("CcbPlatformV1 is missing from the LuaLS contract")
    fields = root.get("fields")
    if not isinstance(fields, list):
        raise RuntimeError("CcbPlatformV1 fields are missing")
    field_names = {
        str(field.get("name"))
        for field in fields
        if isinstance(field, dict)
    }
    required = {
        "platform_version",
        "content",
        "runtime",
        "dialogue",
        "state",
        "tasks",
        "presentation",
        "services",
    }
    missing = sorted(required - field_names)
    if missing:
        raise RuntimeError(f"CcbPlatformV1 is missing fields: {missing}")


def read_declarations(path: Path = DEFAULT_DECLARATIONS) -> dict[str, object]:
    text = path.read_text(encoding="utf-8")
    for token in FORBIDDEN_DECLARATION_TOKENS:
        if token in text:
            raise RuntimeError(
                "Platform LuaLS declarations retain forbidden token: "
                f"{token}"
            )
    declarations = parse_luals_declarations(text)
    validate_luals_declarations(declarations)
    return declarations


def validate_platform_entrypoint() -> None:
    """Prove the sole runtime entry is the package-loaded ``ccb`` table."""
    loader_path = REPOSITORY_ROOT / "src/lua_platform_loader.cpp"
    loader = loader_path.read_text(encoding="utf-8")
    required_markers = (
        'loaded["ccb"] = ccb',
        'lua.set_function( "require"',
    )
    missing = [marker for marker in required_markers if marker not in loader]
    if missing:
        raise RuntimeError(
            "Platform loader is missing sole ccb entrypoint markers: "
            f"{missing}"
        )
    forbidden_global_tables = (
        'loaded["game"]',
        'package["game"]',
        'lua["game"]',
        'lua.set( "game"',
    )
    found = [marker for marker in forbidden_global_tables if marker in loader]
    if found:
        raise RuntimeError(
            f"Platform loader exposes forbidden global Lua tables: {found}"
        )


def registration_files() -> list[str]:
    paths = sorted(
        path.relative_to(REPOSITORY_ROOT).as_posix()
        for pattern in ("src/lua_platform*.cpp", "src/lua_platform*.h")
        for path in REPOSITORY_ROOT.glob(pattern)
        if "obj-lua" not in path.parts
    )
    if not paths:
        raise RuntimeError("no lua_platform_* registration sources were found")
    return paths


def native_root_facts(inventory: dict[str, object]) -> list[dict[str, object]]:
    roots = inventory.get("export_roots")
    if not isinstance(roots, list):
        raise RuntimeError(
            "Platform native inventory export_roots must be an array"
        )
    result = []
    for root in roots:
        if not isinstance(root, dict):
            raise RuntimeError(
                "Platform native inventory export root is malformed"
            )
        surfaces = root.get("surfaces", [])
        if not isinstance(surfaces, list) or any(
            surface != "platform_v1" for surface in surfaces
        ):
            raise RuntimeError(
                "Platform native inventory contains a non-Platform export "
                "surface"
            )
        result.append(
            {
                "id": root.get("id"),
                "lua_name": root.get("lua_name"),
                "cpp_type": root.get("cpp_type"),
                "registration": root.get("registration"),
                "surfaces": root.get("surfaces", []),
            }
        )
    return sorted(
        result,
        key=lambda root: str(root.get("lua_name", root.get("id"))),
    )


def build_contract(
    declarations: dict[str, object] | None = None,
    native_inventory: dict[str, object] | None = None,
    declarations_path: Path = DEFAULT_DECLARATIONS,
    native_inventory_path: Path = DEFAULT_NATIVE_INVENTORY,
    schema_path: Path = DEFAULT_SCHEMA,
) -> dict[str, object]:
    declarations_path = declarations_path.resolve()
    native_inventory_path = native_inventory_path.resolve()
    schema_path = schema_path.resolve()
    declarations = (
        declarations
        if declarations is not None
        else read_declarations(declarations_path)
    )
    native_inventory = (
        native_inventory
        if native_inventory is not None
        else load_json(native_inventory_path)
    )
    validate_luals_declarations(declarations)
    validate_platform_entrypoint()
    roots = native_root_facts(native_inventory)
    classes = declarations["classes"]
    assert isinstance(classes, list)
    root_class = next(
        entry
        for entry in classes
        if isinstance(entry, dict) and entry.get("name") == "CcbPlatformV1"
    )
    contract = {
        "schema_version": 1,
        "contract_id": "ccb_platform_api_v1",
        "schema": repository_relative(schema_path),
        "source": {
            "declarations": repository_relative(declarations_path),
            "native_inventory": repository_relative(native_inventory_path),
            "native_registration_glob": "src/lua_platform*.cpp",
        },
        "entrypoint": {
            "module": "ccb",
            "require_expression": 'require("ccb")',
            "root_class": "CcbPlatformV1",
            "global_tables": [],
        },
        "lua_luals": declarations,
        "public_root": root_class,
        "native": {
            "registration_files": registration_files(),
            "export_roots": roots,
        },
    }
    validate_schema_document(
        contract,
        schema_path,
        "Platform v1 public contract",
    )
    return contract


def serialize_contract(contract: dict[str, object]) -> str:
    return json.dumps(
        contract, ensure_ascii=False, indent=2, sort_keys=True
    ) + "\n"


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    parser.add_argument(
        "--native-inventory",
        type=Path,
        default=DEFAULT_NATIVE_INVENTORY,
    )
    parser.add_argument(
        "--declarations",
        type=Path,
        default=DEFAULT_DECLARATIONS,
    )
    parser.add_argument("--schema", type=Path, default=DEFAULT_SCHEMA)
    parser.add_argument(
        "--check", action="store_true", help="check without writing"
    )
    arguments = parser.parse_args()
    declarations_path = arguments.declarations.resolve()
    native_inventory_path = arguments.native_inventory.resolve()
    schema_path = arguments.schema.resolve()
    contract = build_contract(
        declarations=read_declarations(declarations_path),
        native_inventory=load_json(native_inventory_path),
        declarations_path=declarations_path,
        native_inventory_path=native_inventory_path,
        schema_path=schema_path,
    )
    expected = serialize_contract(contract)
    if arguments.check:
        if not arguments.output.exists():
            raise SystemExit(
                f"missing Platform v1 public contract: {arguments.output}"
            )
        if arguments.output.read_text(encoding="utf-8") != expected:
            raise SystemExit(
                f"stale Platform v1 public contract: {arguments.output}"
            )
        return 0
    arguments.output.parent.mkdir(parents=True, exist_ok=True)
    arguments.output.write_text(expected, encoding="utf-8")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
