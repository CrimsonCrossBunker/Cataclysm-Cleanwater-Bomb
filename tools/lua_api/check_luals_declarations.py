#!/usr/bin/env python3
"""Check that LuaLS metadata names every registered public Lua API method."""

from __future__ import annotations

import argparse
import re
from collections import defaultdict
from pathlib import Path


REPOSITORY_ROOT = Path(__file__).resolve().parents[2]
DEFAULT_DECLARATIONS = Path("data/lua/types/ccb_api_v5.d.lua")

TABLE_CLASSES = {
    "action_menu": "CcbActionMenuApi",
    "actions": "CcbGameActionsApi",
    "bionics": "CcbBionicsApi",
    "callbacks": "CcbCallbacksApi",
    "character_state": "CcbStateStore",
    "characters": "CcbCharactersApi",
    "constants": "CcbConstantsApi",
    "coord_api": "CcbCoordsApi",
    "crafting": "CcbCraftingApi",
    "creatures": "CcbCreaturesApi",
    "definitions": "CcbDefinitionsApi",
    "diagnostics": "CcbDiagnosticsApi",
    "effects": "CcbEffectsApi",
    "enum_api": "CcbEnumsApi",
    "events": "CcbEventsApi",
    "followers": "CcbFollowersApi",
    "game": "CcbGameApi",
    "handles": "CcbHandlesApi",
    "hooks": "CcbHooksApi",
    "hordes": "CcbHordesApi",
    "i18n": "CcbI18nApi",
    "inventory": "CcbInventoryApi",
    "items": "CcbItemsApi",
    "mapgen": "CcbMapgenApi",
    "messages": "CcbMessagesApi",
    "missions": "CcbMissionsApi",
    "modules": "CcbModulesApi",
    "mutations": "CcbMutationsApi",
    "overmap": "CcbOvermapApi",
    "page_state": "CcbStateStore",
    "random": "CcbRandomApi",
    "recipes": "CcbRecipesApi",
    "registry": "CcbRegistryApi",
    "relocation": "CcbRelocationApi",
    "requirements": "CcbRequirementsApi",
    "scheduler": "CcbSchedulerApi",
    "serde": "CcbSerdeApi",
    "services": "CcbServicesApi",
    "sidebar": "CcbSidebarApi",
    "sound": "CcbSoundApi",
    "spawns": "CcbSpawnsApi",
    "spells": "CcbSpellsApi",
    "targeting": "CcbTargetingApi",
    "time": "CcbTimeApi",
    "types": "CcbTypesApi",
    "ui": "CcbUiApi",
    "units": "CcbUnitsApi",
    "world": "CcbWorldApi",
    "world_state": "CcbStateStore",
}

SET_FUNCTION = re.compile(
    r"\b([A-Za-z_][A-Za-z0-9_]*)"
    r"\.set_function\s*\(\s*\"([^\"]+)\""
)
DECLARED_METHOD = re.compile(
    r"^function\s+([A-Za-z_][A-Za-z0-9_]*)"
    r"[:.]([A-Za-z_][A-Za-z0-9_]*)",
    re.MULTILINE,
)
DECLARED_CLASS = re.compile(
    r"^---@class\s+([A-Za-z_][A-Za-z0-9_]*)",
    re.MULTILINE,
)
NEW_USERTYPE = re.compile(
    r"new_usertype\s*<[^>]+>\s*\(\s*\"([^\"]+)\"",
    re.DOTALL,
)
COORDINATE_KIND = re.compile(
    r'\{\s*"([a-z]+_[a-z]+)"\s*,\s*coords::origin::'
)


def catalua_sources() -> list[Path]:
    return sorted((REPOSITORY_ROOT / "src").glob("catalua*.cpp"))


def source_methods() -> dict[str, set[str]]:
    result: dict[str, set[str]] = defaultdict(set)
    for path in catalua_sources():
        contents = path.read_text(encoding="utf-8", errors="replace")
        for table, method in SET_FUNCTION.findall(contents):
            if table in TABLE_CLASSES:
                result[table].add(method)
    return result


def source_usertypes() -> set[str]:
    result: set[str] = set()
    for path in catalua_sources():
        contents = path.read_text(encoding="utf-8", errors="replace")
        result.update(NEW_USERTYPE.findall(contents))
    return result


def coordinate_factories() -> set[str]:
    path = REPOSITORY_ROOT / "src/catalua_bindings_coords.cpp"
    contents = path.read_text(encoding="utf-8")
    kinds = COORDINATE_KIND.findall(contents)
    if not kinds:
        raise RuntimeError("no CCB coordinate kinds were found")
    return {
        f"{prefix}_{kind}"
        for kind in kinds
        for prefix in ("point", "tripoint")
    }


def check(path: Path) -> dict[str, int]:
    contents = path.read_text(encoding="utf-8")
    if "Lua Mod API v5" not in contents:
        raise RuntimeError("LuaLS declaration header is not API v5")
    if re.search(r"---@field api_version\s+5\b", contents) is None:
        raise RuntimeError("CcbGameApi.api_version is not declared as 5")

    methods: dict[str, set[str]] = defaultdict(set)
    for class_name, method in DECLARED_METHOD.findall(contents):
        methods[class_name].add(method)

    missing: list[str] = []
    registered = source_methods()
    for table, expected_methods in sorted(registered.items()):
        class_name = TABLE_CLASSES[table]
        for method in sorted(expected_methods - methods[class_name]):
            missing.append(f"{table}.{method} -> {class_name}.{method}")
    if missing:
        raise RuntimeError(
            "LuaLS declarations omit registered methods:\n"
            + "\n".join(missing)
        )

    classes = set(DECLARED_CLASS.findall(contents))
    missing_types = sorted(source_usertypes() - classes)
    if missing_types:
        raise RuntimeError(
            f"LuaLS declarations omit usertypes: {missing_types}"
        )

    coordinate_fields = set(
        re.findall(
            r"^---@field\s+((?:point|tripoint)_[a-z]+_[a-z]+)\s+fun",
            contents,
            re.MULTILINE,
        )
    )
    missing_factories = sorted(
        coordinate_factories() - coordinate_fields
    )
    if missing_factories:
        raise RuntimeError(
            f"LuaLS declarations omit coordinate factories: "
            f"{missing_factories}"
        )

    old_path = path.with_name("ccb_api_v4.d.lua")
    if old_path.exists():
        raise RuntimeError(
            "stale ccb_api_v4.d.lua remains beside the v5 declarations"
        )
    if re.search(r"^---@type CcbSidebarApi\nsidebar = \{\}$", contents,
                 re.MULTILINE) is None:
        raise RuntimeError("the global CBN-compatible sidebar is undeclared")

    return {
        "tables": len(registered),
        "methods": sum(len(value) for value in registered.values()),
        "usertypes": len(source_usertypes()),
        "coordinate_factories": len(coordinate_factories()),
    }


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--declarations", type=Path, default=DEFAULT_DECLARATIONS
    )
    args = parser.parse_args()
    result = check(args.declarations)
    print(
        "LuaLS declarations cover "
        f"{result['methods']} methods across {result['tables']} tables, "
        f"{result['usertypes']} usertypes, and "
        f"{result['coordinate_factories']} coordinate factories."
    )


if __name__ == "__main__":
    main()
