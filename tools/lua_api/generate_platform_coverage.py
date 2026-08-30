#!/usr/bin/env python3
"""Generate Platform LuaLS/native-registration synchronization coverage."""

from __future__ import annotations

import argparse
import json
from pathlib import Path

try:
    from .generate_platform_contract import (
        DEFAULT_NATIVE_INVENTORY,
        DEFAULT_DECLARATIONS,
        DEFAULT_SCHEMA as DEFAULT_CONTRACT_SCHEMA,
        DEFAULT_OUTPUT as DEFAULT_CONTRACT_OUTPUT,
        build_contract,
        load_json,
        validate_schema_document,
    )
except ImportError:
    from generate_platform_contract import (  # type: ignore
        DEFAULT_NATIVE_INVENTORY,
        DEFAULT_DECLARATIONS,
        DEFAULT_SCHEMA as DEFAULT_CONTRACT_SCHEMA,
        DEFAULT_OUTPUT as DEFAULT_CONTRACT_OUTPUT,
        build_contract,
        load_json,
        validate_schema_document,
    )


REPOSITORY_ROOT = Path(__file__).resolve().parents[2]
DEFAULT_OUTPUT = REPOSITORY_ROOT / (
    "data/lua/reference/ccb_platform_api_v1_coverage.json"
)
DEFAULT_SCHEMA = REPOSITORY_ROOT / (
    "data/lua/reference/ccb_platform_api_v1_coverage.schema.json"
)


def build_coverage(
    contract: dict[str, object] | None = None,
    native_inventory: dict[str, object] | None = None,
    schema_path: Path = DEFAULT_SCHEMA,
) -> dict[str, object]:
    contract = contract if contract is not None else build_contract()
    native_inventory = (
        native_inventory
        if native_inventory is not None
        else load_json(DEFAULT_NATIVE_INVENTORY)
    )
    declarations = contract["lua_luals"]
    native = contract["native"]
    assert isinstance(declarations, dict)
    assert isinstance(native, dict)
    classes = {
        str(entry["name"])
        for entry in declarations["classes"]
        if isinstance(entry, dict) and isinstance(entry.get("name"), str)
    }
    contract_roots = native["export_roots"]
    inventory_roots = native_inventory.get("export_roots")
    if (
        not isinstance(contract_roots, list) or
        not isinstance(inventory_roots, list)
    ):
        raise RuntimeError("Platform export roots must be arrays")
    contract_root_names = {
        str(root["lua_name"])
        for root in contract_roots
        if isinstance(root, dict) and isinstance(root.get("lua_name"), str)
    }
    roots = [root for root in inventory_roots if isinstance(root, dict)]
    entries = []
    unmatched = []
    missing_from_inventory = sorted(
        contract_root_names -
        {
            str(root["lua_name"])
            for root in roots
            if isinstance(root.get("lua_name"), str)
        }
    )
    for root in roots:
        native_name = str(root.get("lua_name") or root.get("id"))
        declared_as = native_name if native_name in classes else None
        in_public_contract = native_name in contract_root_names
        synchronized = declared_as is not None and in_public_contract
        if not synchronized:
            unmatched.append(native_name)
        entries.append(
            {
                "native_name": native_name,
                "declared_class": declared_as,
                "in_public_contract": in_public_contract,
                "synchronized": synchronized,
            }
        )
    entries.sort(key=lambda entry: str(entry["native_name"]))
    coverage = {
        "schema_version": 1,
        "coverage_id": "ccb_platform_api_v1_coverage",
        "schema": DEFAULT_SCHEMA.relative_to(REPOSITORY_ROOT).as_posix(),
        "coverage_kind": (
            "platform_luals_native_registration_public_contract_"
            "synchronization"
        ),
        "source": {
            "public_contract": (
                DEFAULT_CONTRACT_OUTPUT.relative_to(REPOSITORY_ROOT).as_posix()
            ),
            "declarations": (
                DEFAULT_DECLARATIONS.relative_to(REPOSITORY_ROOT).as_posix()
            ),
            "native_inventory": (
                DEFAULT_NATIVE_INVENTORY.relative_to(
                    REPOSITORY_ROOT
                ).as_posix()
            ),
        },
        "platform_sync": {
            "luals_class_count": len(classes),
            "luals_function_count": int(declarations["function_count"]),
            "native_registration_file_count": len(
                native["registration_files"]
            ),
            "native_export_root_count": len(roots),
            "native_export_roots_declared": len(roots) - len(unmatched),
            "public_contract_export_root_count": len(contract_root_names),
            "native_export_roots_in_public_contract": len(roots) - len(
                [entry for entry in entries if not entry["in_public_contract"]]
            ),
            "unmatched_native_export_roots": sorted(unmatched),
            "contract_export_roots_missing_from_inventory": (
                missing_from_inventory
            ),
            "synchronized": not unmatched and not missing_from_inventory,
        },
        "entries": entries,
    }
    validate_schema_document(
        coverage,
        schema_path.resolve(),
        "Platform synchronization coverage",
    )
    return coverage


def serialize_coverage(coverage: dict[str, object]) -> str:
    return json.dumps(
        coverage, ensure_ascii=False, indent=2, sort_keys=True
    ) + "\n"


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    parser.add_argument(
        "--contract", type=Path, default=DEFAULT_CONTRACT_OUTPUT
    )
    parser.add_argument(
        "--native-inventory", type=Path, default=DEFAULT_NATIVE_INVENTORY
    )
    parser.add_argument("--schema", type=Path, default=DEFAULT_SCHEMA)
    parser.add_argument(
        "--check", action="store_true", help="check without writing"
    )
    arguments = parser.parse_args()
    contract_path = arguments.contract.resolve()
    inventory_path = arguments.native_inventory.resolve()
    contract = (
        load_json(contract_path)
        if contract_path.exists()
        else build_contract(
            native_inventory_path=inventory_path,
            schema_path=DEFAULT_CONTRACT_SCHEMA,
        )
    )
    coverage = build_coverage(
        contract=contract,
        native_inventory=load_json(inventory_path),
        schema_path=arguments.schema,
    )
    expected = serialize_coverage(coverage)
    if arguments.check:
        if not arguments.output.exists():
            raise SystemExit(
                "missing Platform synchronization coverage: "
                f"{arguments.output}"
            )
        if arguments.output.read_text(encoding="utf-8") != expected:
            raise SystemExit(
                "stale Platform synchronization coverage: "
                f"{arguments.output}"
            )
        return 0
    arguments.output.parent.mkdir(parents=True, exist_ok=True)
    arguments.output.write_text(expected, encoding="utf-8")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
