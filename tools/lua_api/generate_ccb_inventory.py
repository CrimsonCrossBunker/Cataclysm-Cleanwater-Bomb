#!/usr/bin/env python3
"""Generate the CCB-native Lua capability inventory from engine sources."""

from __future__ import annotations

import argparse
import json
import re
from pathlib import Path


REPOSITORY_ROOT = Path(__file__).resolve().parents[2]
DEFAULT_OUTPUT = (
    REPOSITORY_ROOT / "data/lua/reference/ccb_native_inventory.json"
)

ID_DEFINITION_PATTERN = re.compile(
    r'\{\s*"(?P<kind>[a-z0-9_]+)",\s*&valid_id<'
    r'(?P<native_type>[^>]+)>\s*\}'
)


def source_text(relative_path: str) -> str:
    return (REPOSITORY_ROOT / relative_path).read_text(encoding="utf-8")


def parse_id_kinds(contents: str) -> list[dict[str, str]]:
    """Extract the exact GameId kind-to-native-type map."""
    entries = [
        {
            "kind": match.group("kind"),
            "native_type": match.group("native_type"),
        }
        for match in ID_DEFINITION_PATTERN.finditer(contents)
    ]
    entries.sort(key=lambda entry: entry["kind"])
    kinds = [entry["kind"] for entry in entries]
    if not entries:
        raise RuntimeError("no GameId kinds were found")
    if len(kinds) != len(set(kinds)):
        raise RuntimeError("duplicate GameId kinds were found")
    return entries


def build_inventory() -> dict[str, object]:
    return {
        "schema_version": 1,
        "source": {
            "project": "Cataclysm-Cleanwater-Bomb",
            "id_registry": "src/catalua_bindings_values.cpp",
        },
        "id_kinds": parse_id_kinds(
            source_text("src/catalua_bindings_values.cpp")
        ),
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--output",
        type=Path,
        default=DEFAULT_OUTPUT,
        help="inventory destination",
    )
    arguments = parser.parse_args()
    arguments.output.parent.mkdir(parents=True, exist_ok=True)
    arguments.output.write_text(
        json.dumps(build_inventory(), ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
