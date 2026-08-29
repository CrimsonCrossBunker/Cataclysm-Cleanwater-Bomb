#!/usr/bin/env python3
"""Reject drift between Platform engine sources and the native inventory."""

from __future__ import annotations

import argparse
import json
from pathlib import Path

try:
    from .generate_platform_native_inventory import (
        DEFAULT_OUTPUT,
        DEFAULT_SCHEMA,
        build_native_inventory,
        validate_inventory_schema,
        validate_export_contract,
    )
except ImportError:
    from generate_platform_native_inventory import (  # type: ignore
        DEFAULT_OUTPUT,
        DEFAULT_SCHEMA,
        build_native_inventory,
        validate_inventory_schema,
        validate_export_contract,
    )


def load_native_inventory(path: Path) -> dict[str, object]:
    value = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(value, dict):
        raise RuntimeError(f"{path} must contain a JSON object")
    return value


def check(path: Path, schema: Path = DEFAULT_SCHEMA) -> dict[str, int]:
    schema = schema.resolve()
    expected = build_native_inventory(schema)
    actual = load_native_inventory(path)
    validate_inventory_schema(actual, schema)
    validate_export_contract(actual)
    if actual != expected:
        raise RuntimeError(
            "Platform native Lua inventory is stale; run "
            "python3 tools/lua_api/generate_platform_native_inventory.py"
        )
    surfaces = {
        str(surface["id"]): surface
        for surface in expected["export_surfaces"]
    }
    platform_v1_roots = set(surfaces["platform_v1"]["roots"])
    member_dispositions = sum(
        len(root["member_disposition"]["members"])
        for root in expected["export_roots"]
    )
    return {
        "id_kinds": len(expected["id_kinds"]),
        "json_types": len(expected["json_types"]),
        "event_types": len(expected["event_types"]),
        "native_domains": len(expected["native_domains"]),
        "export_roots": len(expected["export_roots"]),
        "platform_v1_roots": len(platform_v1_roots),
        "member_dispositions": member_dispositions,
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--inventory",
        type=Path,
        default=DEFAULT_OUTPUT,
        help="checked-in inventory to validate",
    )
    parser.add_argument(
        "--schema",
        type=Path,
        default=DEFAULT_SCHEMA,
        help="Platform native inventory schema",
    )
    arguments = parser.parse_args()
    summary = check(arguments.inventory, arguments.schema)
    print(
        "Platform native inventory: "
        f"{summary['id_kinds']} typed ids, "
        f"{summary['json_types']} JSON types, "
        f"{summary['event_types']} events, "
        f"{summary['native_domains']} runtime domains, "
        f"{summary['export_roots']} unique Platform export roots "
        f"({summary['platform_v1_roots']} Platform v1), and "
        f"{summary['member_dispositions']} member dispositions"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
