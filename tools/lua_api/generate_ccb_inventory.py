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
    r"num_event_types\b[^\n]*\n\s*\};",
    re.DOTALL,
)

NATIVE_DOMAINS = (
    ("achievements", "Inspect achievement definitions and world progress."),
    ("actions", "Queue safe player and input-context actions."),
    ("addictions", "Inspect and mutate character addictions."),
    ("bionics", "Inspect definitions and mutate installed bionics."),
    ("callbacks", "Attach Lua methods to native JSON callback actors."),
    ("camps", "Inspect faction camps and their world locations."),
    ("characters", "Query, snapshot, and mutate active characters."),
    ("crafting", "Inspect requirements and start bounded crafting work."),
    ("definitions", "Validate and inspect stable native definition ids."),
    ("diagnostics", "Inspect bounded runtime health and errors."),
    ("effects", "Inspect and mutate native creature effects."),
    ("eocs", "Test and activate authored effect-on-condition programs."),
    ("factions", "Inspect faction state and player relationships."),
    ("handles", "Reference live creatures, items, and vehicles safely."),
    ("hooks", "Observe and intercept documented native lifecycles."),
    ("hordes", "Inspect and mutate persistent overmap hordes."),
    ("inventory", "Traverse and mutate item inventories and pockets."),
    ("mapgen", "Inspect and post-process native map generation."),
    ("martial_arts", "Inspect and mutate known martial arts."),
    ("missions", "Inspect definitions and control mission instances."),
    ("modules", "Compose source-scoped Lua modules and services."),
    ("mutations", "Inspect definitions and mutate character mutations."),
    ("native_events", "Subscribe to every typed native event bus event."),
    ("needs", "Inspect and adjust character physiological needs."),
    ("npcs", "Query and mutate NPC identity and relationships."),
    ("overmap", "Query and mutate existing overmap state."),
    ("proficiencies", "Inspect definitions and mutate character learning."),
    ("recipes", "Search recipes and evaluate native requirements."),
    ("scheduler", "Run bounded source-owned deferred callbacks."),
    ("skills", "Inspect definitions and mutate character skills."),
    ("spells", "Inspect definitions and mutate character spellbooks."),
    ("statistics", "Inspect native event statistics and score values."),
    ("time", "Inspect calendar values and control world time."),
    ("ui", "Build portable pages, menus, sidebars, and navigation."),
    ("vehicles", "Query, snapshot, and control active vehicles."),
    ("vitamins", "Inspect definitions and mutate character vitamins."),
    ("weather", "Inspect forecasts and control weather overrides."),
    ("world", "Query and mutate the active map and world services."),
    ("zones", "Inspect and mutate loot and personal zones."),
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
        "native_domains": [
            {"id": domain, "requirement": requirement}
            for domain, requirement in NATIVE_DOMAINS
        ],
    }


def inline_object(entry: dict[str, object]) -> str:
    fields = (
        f"{json.dumps(key, ensure_ascii=False)}: "
        f"{json.dumps(value, ensure_ascii=False)}"
        for key, value in entry.items()
    )
    return "{ " + ", ".join(fields) + " }"


def serialize_inventory(inventory: dict[str, object]) -> str:
    """Serialize the inventory in the repository's canonical JSON style."""
    source = inventory["source"]
    if not isinstance(source, dict):
        raise RuntimeError("inventory source must be an object")

    lines = [
        "{",
        f'  "schema_version": {inventory["schema_version"]},',
        '  "source": {',
    ]
    source_items = list(source.items())
    for index, (key, value) in enumerate(source_items):
        comma = "," if index + 1 < len(source_items) else ""
        lines.append(
            f"    {json.dumps(key, ensure_ascii=False)}: "
            f"{json.dumps(value, ensure_ascii=False)}{comma}"
        )
    lines.append("  },")

    array_names = (
        "id_kinds",
        "json_types",
        "event_types",
        "native_domains",
    )
    for array_index, name in enumerate(array_names):
        entries = inventory[name]
        if not isinstance(entries, list):
            raise RuntimeError(f"inventory {name} must be an array")
        lines.append(f'  "{name}": [')
        for entry_index, entry in enumerate(entries):
            if not isinstance(entry, dict):
                raise RuntimeError(
                    f"inventory {name} entries must be objects"
                )
            comma = "," if entry_index + 1 < len(entries) else ""
            lines.append(f"    {inline_object(entry)}{comma}")
        comma = "," if array_index + 1 < len(array_names) else ""
        lines.append(f"  ]{comma}")
    lines.append("}")
    return "\n".join(lines) + "\n"


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
        serialize_inventory(build_inventory()),
        encoding="utf-8",
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
