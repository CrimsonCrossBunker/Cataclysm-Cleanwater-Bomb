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
    "achievements": "CcbAchievementsApi",
    "action_menu": "CcbActionMenuApi",
    "actions": "CcbGameActionsApi",
    "addictions": "CcbAddictionsApi",
    "bionics": "CcbBionicsApi",
    "callbacks": "CcbCallbacksApi",
    "camps": "CcbCampsApi",
    "handlers": "CcbHandlersApi",
    "character_state": "CcbStateStore",
    "characters": "CcbCharactersApi",
    "constants": "CcbConstantsApi",
    "coord_api": "CcbCoordsApi",
    "crafting": "CcbCraftingApi",
    "creatures": "CcbCreaturesApi",
    "definitions": "CcbDefinitionsApi",
    "diagnostics": "CcbDiagnosticsApi",
    "dialogue": "CcbDialogueApi",
    "effects": "CcbEffectsApi",
    "enum_api": "CcbEnumsApi",
    "eocs": "CcbEocsApi",
    "events": "CcbEventsApi",
    "factions": "CcbFactionsApi",
    "followers": "CcbFollowersApi",
    "game": "CcbGameApi",
    "handles": "CcbHandlesApi",
    "hooks": "CcbHooksApi",
    "hordes": "CcbHordesApi",
    "i18n": "CcbI18nApi",
    "inventory": "CcbInventoryApi",
    "items": "CcbItemsApi",
    "mapgen": "CcbMapgenApi",
    "martial_arts": "CcbMartialArtsApi",
    "messages": "CcbMessagesApi",
    "missions": "CcbMissionsApi",
    "modules": "CcbModulesApi",
    "mutations": "CcbMutationsApi",
    "native_events": "CcbNativeEventsApi",
    "needs": "CcbNeedsApi",
    "npcs": "CcbNpcsApi",
    "overmap": "CcbOvermapApi",
    "page_state": "CcbStateStore",
    "proficiencies": "CcbProficienciesApi",
    "random": "CcbRandomApi",
    "recipes": "CcbRecipesApi",
    "registry": "CcbRegistryApi",
    "relocation": "CcbRelocationApi",
    "requirements": "CcbRequirementsApi",
    "scheduler": "CcbSchedulerApi",
    "serde": "CcbSerdeApi",
    "services": "CcbServicesApi",
    "sidebar": "CcbSidebarApi",
    "skills": "CcbSkillsApi",
    "sound": "CcbSoundApi",
    "spawns": "CcbSpawnsApi",
    "spells": "CcbSpellsApi",
    "statistics": "CcbStatisticsApi",
    "targeting": "CcbTargetingApi",
    "time": "CcbTimeApi",
    "types": "CcbTypesApi",
    "ui": "CcbUiApi",
    "units": "CcbUnitsApi",
    "variables": "CcbVariablesApi",
    "vehicles_api": "CcbVehiclesApi",
    "vitamins": "CcbVitaminsApi",
    "weather": "CcbWeatherApi",
    "world": "CcbWorldApi",
    "world_state": "CcbStateStore",
    "zones": "CcbZonesApi",
}

# These functions are deliberately installed on the restricted Lua standard
# library rather than exposed as part of the CCB API.
INTENTIONALLY_UNDECLARED_TABLES = {"lua"}

SET_FUNCTION = re.compile(
    r"\b([A-Za-z_][A-Za-z0-9_]*)"
    r"\.set_function\s*\(\s*\"([^\"]+)\""
)
GAME_TABLE_ASSIGNMENT = re.compile(
    r"\bgame\s*\[\s*\"([^\"]+)\"\s*\]\s*=\s*"
    r"(?:std::move\s*\(\s*)?([A-Za-z_][A-Za-z0-9_]*)"
)
DECLARED_METHOD = re.compile(
    r"^function\s+([A-Za-z_][A-Za-z0-9_]*)"
    r"[:.]([A-Za-z_][A-Za-z0-9_]*)",
    re.MULTILINE,
)
FUNCTION_STUB = re.compile(
    r"^function\s+([A-Za-z_][A-Za-z0-9_]*)"
    r"[:.]([A-Za-z_][A-Za-z0-9_]*)"
    r"\(([^)]*)\)\s+end$"
)
PARAM_ANNOTATION = re.compile(
    r"^---@param\s+([A-Za-z_][A-Za-z0-9_]*)\??(?:\s|$)"
)
FIELD_ANNOTATION = re.compile(
    r"^---@field\s+([A-Za-z_][A-Za-z0-9_]*)\??(?:\s|$)"
)
FIELD_TYPE_ANNOTATION = re.compile(
    r"^---@field\s+([A-Za-z_][A-Za-z0-9_]*)\??\s+"
    r"(\S+)"
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
LUA_RESERVED_WORDS = {
    "and",
    "break",
    "do",
    "else",
    "elseif",
    "end",
    "false",
    "for",
    "function",
    "goto",
    "if",
    "in",
    "local",
    "nil",
    "not",
    "or",
    "repeat",
    "return",
    "then",
    "true",
    "until",
    "while",
}


def catalua_sources() -> list[Path]:
    return sorted((REPOSITORY_ROOT / "src").glob("catalua*.cpp"))


def source_methods() -> dict[str, set[str]]:
    result: dict[str, set[str]] = defaultdict(set)
    for path in catalua_sources():
        contents = path.read_text(encoding="utf-8", errors="replace")
        for table, method in SET_FUNCTION.findall(contents):
            result[table].add(method)
    return result


def source_usertypes() -> set[str]:
    result: set[str] = set()
    for path in catalua_sources():
        contents = path.read_text(encoding="utf-8", errors="replace")
        result.update(NEW_USERTYPE.findall(contents))
    return result


def source_game_tables() -> dict[str, str]:
    result: dict[str, str] = {}
    for path in catalua_sources():
        contents = path.read_text(encoding="utf-8", errors="replace")
        for public_name, table in GAME_TABLE_ASSIGNMENT.findall(contents):
            if table in TABLE_CLASSES:
                result[public_name] = table
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


def annotation_block(lines: list[str], function_index: int) -> list[str]:
    result: list[str] = []
    index = function_index - 1
    while index >= 0 and lines[index].startswith("---"):
        result.append(lines[index])
        index -= 1
    result.reverse()
    return result


def class_fields(contents: str, class_name: str) -> dict[str, str]:
    lines = contents.splitlines()
    marker = f"---@class {class_name}"
    try:
        class_index = lines.index(marker)
    except ValueError:
        return {}

    result: dict[str, str] = {}
    cursor = class_index + 1
    while cursor < len(lines):
        match = FIELD_TYPE_ANNOTATION.match(lines[cursor])
        if match is None:
            break
        field_name, field_type = match.groups()
        result[field_name] = field_type
        cursor += 1
    return result


def validate_table_mappings(
    registered: dict[str, set[str]],
) -> dict[str, set[str]]:
    unknown = sorted(
        set(registered) - set(TABLE_CLASSES) -
        INTENTIONALLY_UNDECLARED_TABLES
    )
    if unknown:
        raise RuntimeError(
            "LuaLS checker omits registered API table mappings: "
            f"{unknown}"
        )
    return {
        table: methods
        for table, methods in registered.items()
        if table in TABLE_CLASSES
    }


def validate_annotation_contracts(contents: str) -> None:
    lines = contents.splitlines()
    declared_methods: set[tuple[str, str]] = set()
    for index, line in enumerate(lines):
        function = FUNCTION_STUB.match(line)
        if function is None:
            continue
        class_name, method, raw_parameters = function.groups()
        identity = (class_name, method)
        if identity in declared_methods:
            raise RuntimeError(
                f"LuaLS declarations repeat method "
                f"{class_name}.{method}"
            )
        declared_methods.add(identity)

        parameters = [
            value.strip()
            for value in raw_parameters.split(",")
            if value.strip()
        ]
        reserved_parameters = sorted(
            set(parameters) & LUA_RESERVED_WORDS
        )
        if reserved_parameters:
            raise RuntimeError(
                f"LuaLS declarations use reserved Lua parameter names for "
                f"{class_name}.{method}: {reserved_parameters}"
            )
        annotations = [
            match.group(1)
            for annotation in annotation_block(lines, index)
            if (match := PARAM_ANNOTATION.match(annotation)) is not None
        ]
        if len(annotations) != len(set(annotations)):
            raise RuntimeError(
                f"LuaLS declarations repeat a parameter annotation for "
                f"{class_name}.{method}"
            )
        if parameters != annotations:
            raise RuntimeError(
                f"LuaLS parameter annotations for {class_name}.{method} "
                f"are {annotations}, expected {parameters}"
            )

    for index, line in enumerate(lines):
        class_match = re.match(
            r"^---@class\s+([A-Za-z_][A-Za-z0-9_]*)", line
        )
        if class_match is None:
            continue
        fields: list[str] = []
        cursor = index + 1
        while cursor < len(lines):
            field = FIELD_ANNOTATION.match(lines[cursor])
            if field is None:
                break
            fields.append(field.group(1))
            cursor += 1
        if len(fields) != len(set(fields)):
            raise RuntimeError(
                f"LuaLS declarations repeat a field in "
                f"{class_match.group(1)}"
            )

    if re.search(
        r"^---@param\s+options\??\s+table(?:\s|$)",
        contents,
        re.MULTILINE,
    ):
        raise RuntimeError(
            "LuaLS declarations use an untyped options table"
        )


def check(path: Path) -> dict[str, int]:
    contents = path.read_text(encoding="utf-8")
    if "Lua Mod API v5" not in contents:
        raise RuntimeError("LuaLS declaration header is not API v5")
    if re.search(r"---@field api_version\s+5\b", contents) is None:
        raise RuntimeError("CcbGameApi.api_version is not declared as 5")

    validate_annotation_contracts(contents)

    methods: dict[str, set[str]] = defaultdict(set)
    for class_name, method in DECLARED_METHOD.findall(contents):
        methods[class_name].add(method)

    missing: list[str] = []
    registered = validate_table_mappings(source_methods())
    for table, expected_methods in sorted(registered.items()):
        class_name = TABLE_CLASSES[table]
        for method in sorted(expected_methods - methods[class_name]):
            missing.append(f"{table}.{method} -> {class_name}.{method}")
    if missing:
        details = "\n".join(missing)
        raise RuntimeError(
            f"LuaLS declarations omit registered methods:\n{details}"
        )

    game_fields = class_fields(contents, "CcbGameApi")
    missing_game_fields: list[str] = []
    game_tables = source_game_tables()
    for public_name, table in sorted(game_tables.items()):
        class_name = TABLE_CLASSES[table]
        actual = game_fields.get(public_name)
        if actual != class_name:
            missing_game_fields.append(
                f"{public_name} is {actual or 'undeclared'}, "
                f"expected {class_name}"
            )
    if missing_game_fields:
        raise RuntimeError(
            "LuaLS CcbGameApi fields use the wrong API class:\n" +
            "\n".join(missing_game_fields)
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
        "game_tables": len(game_tables),
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
        f"{result['game_tables']} game API domains, "
        f"{result['usertypes']} usertypes, and "
        f"{result['coordinate_factories']} coordinate factories."
    )


if __name__ == "__main__":
    main()
