#!/usr/bin/env python3
"""Check Platform LuaLS/native-registration synchronization coverage."""

from __future__ import annotations

import argparse
from pathlib import Path

try:
    from .generate_platform_contract import DEFAULT_NATIVE_INVENTORY, load_json
    from .generate_platform_coverage import (
        DEFAULT_CONTRACT_OUTPUT,
        DEFAULT_OUTPUT,
        DEFAULT_SCHEMA,
        build_coverage,
        serialize_coverage,
    )
except ImportError:
    from generate_platform_contract import DEFAULT_NATIVE_INVENTORY, load_json  # type: ignore
    from generate_platform_coverage import (  # type: ignore
        DEFAULT_CONTRACT_OUTPUT,
        DEFAULT_OUTPUT,
        DEFAULT_SCHEMA,
        build_coverage,
        serialize_coverage,
    )


def check(
    path: Path = DEFAULT_OUTPUT,
    native_inventory: Path = DEFAULT_NATIVE_INVENTORY,
    contract: Path = DEFAULT_CONTRACT_OUTPUT,
    schema: Path = DEFAULT_SCHEMA,
    expected: dict[str, object] | None = None,
) -> dict[str, int]:
    actual = load_json(path)
    expected = expected or build_coverage(
        contract=load_json(contract),
        native_inventory=load_json(native_inventory),
        schema_path=schema,
    )
    if serialize_coverage(actual) != serialize_coverage(expected):
        raise RuntimeError(
            "Platform synchronization coverage is stale; run "
            "python3 tools/lua_api/generate_platform_coverage.py"
        )
    sync = actual.get("platform_sync")
    if not isinstance(sync, dict) or not sync.get("synchronized", False):
        raise RuntimeError("Platform LuaLS/native/public-contract synchronization is incomplete")
    return {
        "luals_classes": int(sync["luals_class_count"]),
        "luals_functions": int(sync["luals_function_count"]),
        "native_files": int(sync["native_registration_file_count"]),
        "native_roots": int(sync["native_export_root_count"]),
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--coverage", type=Path, default=DEFAULT_OUTPUT)
    parser.add_argument("--native-inventory", type=Path, default=DEFAULT_NATIVE_INVENTORY)
    parser.add_argument("--contract", type=Path, default=DEFAULT_CONTRACT_OUTPUT)
    parser.add_argument("--schema", type=Path, default=DEFAULT_SCHEMA)
    arguments = parser.parse_args()
    summary = check(
        arguments.coverage,
        arguments.native_inventory,
        arguments.contract,
        arguments.schema,
    )
    print(
        "Platform synchronization coverage: "
        f"{summary['luals_classes']} LuaLS classes, "
        f"{summary['luals_functions']} LuaLS functions, "
        f"{summary['native_files']} registration files, "
        f"{summary['native_roots']} synchronized native roots"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
