#!/usr/bin/env python3
"""Check the generated Lua-first Platform v1 public contract for source drift."""

from __future__ import annotations

import argparse
from pathlib import Path

try:
    from .generate_platform_contract import (
        DEFAULT_DECLARATIONS,
        DEFAULT_NATIVE_INVENTORY,
        DEFAULT_SCHEMA,
        DEFAULT_OUTPUT,
        build_contract,
        load_json,
        read_declarations,
        serialize_contract,
    )
except ImportError:
    from generate_platform_contract import (  # type: ignore
        DEFAULT_DECLARATIONS,
        DEFAULT_NATIVE_INVENTORY,
        DEFAULT_SCHEMA,
        DEFAULT_OUTPUT,
        build_contract,
        load_json,
        read_declarations,
        serialize_contract,
    )


def check(
    path: Path = DEFAULT_OUTPUT,
    native_inventory: Path = DEFAULT_NATIVE_INVENTORY,
    declarations: Path = DEFAULT_DECLARATIONS,
    schema: Path = DEFAULT_SCHEMA,
) -> dict[str, int]:
    path = path.resolve()
    native_inventory = native_inventory.resolve()
    declarations = declarations.resolve()
    schema = schema.resolve()
    expected = build_contract(
        declarations=read_declarations(declarations),
        native_inventory=load_json(native_inventory),
        declarations_path=declarations,
        native_inventory_path=native_inventory,
        schema_path=schema,
    )
    actual = load_json(path)
    if serialize_contract(actual) != serialize_contract(expected):
        raise RuntimeError(
            "Platform v1 public contract is stale; run "
            "python3 tools/lua_api/generate_platform_contract.py"
        )
    declarations = actual["lua_luals"]
    native = actual["native"]
    assert isinstance(declarations, dict)
    assert isinstance(native, dict)
    return {
        "classes": int(declarations["class_count"]),
        "functions": int(declarations["function_count"]),
        "registration_files": len(native["registration_files"]),
        "export_roots": len(native["export_roots"]),
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--contract", type=Path, default=DEFAULT_OUTPUT)
    parser.add_argument("--native-inventory", type=Path, default=DEFAULT_NATIVE_INVENTORY)
    parser.add_argument("--declarations", type=Path, default=DEFAULT_DECLARATIONS)
    parser.add_argument("--schema", type=Path, default=DEFAULT_SCHEMA)
    arguments = parser.parse_args()
    summary = check(
        arguments.contract,
        arguments.native_inventory,
        arguments.declarations,
        arguments.schema,
    )
    print(
        "Platform v1 public contract: "
        f"{summary['classes']} LuaLS classes, "
        f"{summary['functions']} LuaLS functions, "
        f"{summary['registration_files']} registration files, "
        f"{summary['export_roots']} native export roots"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
