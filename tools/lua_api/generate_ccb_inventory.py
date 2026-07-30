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
JSON_LOADER_PATTERN = re.compile(
    r'\badd\(\s*"(?P<json_type>[^"]+)"\s*,'
)
EVENT_ENUM_PATTERN = re.compile(
    r"enum class event_type\s*:\s*int\s*\{(?P<body>.*?)"
    r"num_event_types\s*// last\s*\n\};",
    re.DOTALL,
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


def parse_json_types(contents: str) -> list[dict[str, object]]:
    """Extract every unique DynamicDataLoader JSON registration."""
    counts: dict[str, int] = {}
    for match in JSON_LOADER_PATTERN.finditer(contents):
        json_type = match.group("json_type")
        counts[json_type] = counts.get(json_type, 0) + 1
    if not counts:
        raise RuntimeError("no DynamicDataLoader JSON types were found")
    return [
        {
            "type": json_type,
            "registration_count": counts[json_type],
        }
        for json_type in sorted(counts)
    ]


def parse_event_types(contents: str) -> list[dict[str, str]]:
    """Extract every concrete native event bus event."""
    enum_match = EVENT_ENUM_PATTERN.search(contents)
    if enum_match is None:
        raise RuntimeError("the event_type enum was not found")
    body = re.sub(r"/\*.*?\*/", "", enum_match.group("body"), flags=re.DOTALL)
    body = re.sub(r"//[^\n]*", "", body)
    names: list[str] = []
    for candidate in body.split(","):
        token = candidate.strip()
        if not token:
            continue
        name = token.split("=", 1)[0].strip()
        if not re.fullmatch(r"[a-z][a-z0-9_]*", name):
            raise RuntimeError(f"invalid event_type enumerator {name!r}")
        names.append(name)
    if not names:
        raise RuntimeError("no native event types were found")
    if len(names) != len(set(names)):
        raise RuntimeError("duplicate native event types were found")
    return [{"type": name} for name in names]


def build_inventory() -> dict[str, object]:
    return {
        "schema_version": 1,
        "source": {
            "project": "Cataclysm-Cleanwater-Bomb",
            "id_registry": "src/catalua_bindings_values.cpp",
            "json_registry": "src/init.cpp",
            "event_registry": "src/event.h",
        },
        "id_kinds": parse_id_kinds(
            source_text("src/catalua_bindings_values.cpp")
        ),
        "json_types": parse_json_types(source_text("src/init.cpp")),
        "event_types": parse_event_types(source_text("src/event.h")),
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
