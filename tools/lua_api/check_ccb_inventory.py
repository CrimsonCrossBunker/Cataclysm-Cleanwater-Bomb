#!/usr/bin/env python3
"""Reject drift between CCB engine sources and the native Lua inventory."""

from __future__ import annotations

import argparse
import json
from pathlib import Path

try:
    from .generate_ccb_inventory import DEFAULT_OUTPUT, build_inventory
except ImportError:
    from generate_ccb_inventory import DEFAULT_OUTPUT, build_inventory


def load_inventory(path: Path) -> dict[str, object]:
    value = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(value, dict):
        raise RuntimeError(f"{path} must contain a JSON object")
    return value


def check(path: Path) -> dict[str, int]:
    expected = build_inventory()
    actual = load_inventory(path)
    if actual != expected:
        raise RuntimeError(
            "CCB native Lua inventory is stale; run "
            "python3 tools/lua_api/generate_ccb_inventory.py"
        )
    return {
        "id_kinds": len(expected["id_kinds"]),
        "json_types": len(expected["json_types"]),
        "event_types": len(expected["event_types"]),
        "native_domains": len(expected["native_domains"]),
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--inventory",
        type=Path,
        default=DEFAULT_OUTPUT,
        help="checked-in inventory to validate",
    )
    arguments = parser.parse_args()
    summary = check(arguments.inventory)
    print(
        "CCB native inventory: "
        f"{summary['id_kinds']} typed ids, "
        f"{summary['json_types']} JSON types, "
        f"{summary['event_types']} events, "
        f"{summary['native_domains']} runtime domains"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
