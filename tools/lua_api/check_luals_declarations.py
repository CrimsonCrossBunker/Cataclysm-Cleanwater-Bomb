#!/usr/bin/env python3
"""Check that LuaLS metadata names every registered public Lua API method."""

from __future__ import annotations

import argparse
import ast
import re
from collections import defaultdict
from pathlib import Path


REPOSITORY_ROOT = Path(__file__).resolve().parents[2]
DEFAULT_DECLARATIONS = Path("data/lua/types/ccb_api_v5.d.lua")
PLATFORM_DECLARATIONS = Path("data/lua/types/ccb_platform_v1.d.lua")
MIGRATION_TOOL = REPOSITORY_ROOT / "tools/migrate_lua_first.py"

TABLE_CLASSES = {
    "achievements": "CcbAchievementsApi",
    "action_menu": "CcbActionMenuApi",
    "actions": "CcbGameActionsApi",
    "addictions": "CcbAddictionsApi",
    "activities": "CcbActivitiesApi",
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
    "equipment": "CcbEquipmentApi",
    "enum_api": "CcbEnumsApi",
    "eocs": "CcbEocsApi",
    "events": "CcbEventsApi",
    "factions": "CcbFactionsApi",
    "followers": "CcbFollowersApi",
    "game": "CcbGameApi",
    "handles": "CcbHandlesApi",
    "hooks": "CcbHooksApi",
    "hordes": "CcbHordesApi",
    "grooming": "CcbGroomingApi",
    "i18n": "CcbI18nApi",
    "inventory": "CcbInventoryApi",
    "interaction": "CcbInteractionApi",
    "items": "CcbItemsApi",
    "item_categories": "CcbItemCategoriesApi",
    "mapgen": "CcbMapgenApi",
    "martial_arts": "CcbMartialArtsApi",
    "medical": "CcbMedicalApi",
    "messages": "CcbMessagesApi",
    "missions": "CcbMissionsApi",
    "modules": "CcbModulesApi",
    "mutations": "CcbMutationsApi",
    "mods": "CcbModsApi",
    "monsters": "CcbMonstersApi",
    "native_events": "CcbNativeEventsApi",
    "needs": "CcbNeedsApi",
    "npcs": "CcbNpcsApi",
    "orders": "CcbOrdersApi",
    "overmap": "CcbOvermapApi",
    "page_state": "CcbStateStore",
    "proficiencies": "CcbProficienciesApi",
    "random": "CcbRandomApi",
    "recipes": "CcbRecipesApi",
    "registry": "CcbRegistryApi",
    "relocation": "CcbRelocationApi",
    "requirements": "CcbRequirementsApi",
    "scheduler": "CcbSchedulerApi",
    "safety": "CcbSafetyApi",
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
    "trade": "CcbTradeApi",
    "training": "CcbTrainingApi",
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
DECLARED_ALIAS = re.compile(
    r"^---@alias\s+([A-Za-z_][A-Za-z0-9_]*)",
    re.MULTILINE,
)
DECLARED_GENERIC = re.compile(
    r"^---@generic\s+([A-Za-z_][A-Za-z0-9_]*)",
    re.MULTILINE,
)
CUSTOM_TYPE_REFERENCE = re.compile(r"\b[A-Z][A-Za-z0-9_]*\b")
NEW_USERTYPE = re.compile(
    r"new_usertype\s*<[^>]+>\s*\(\s*\"([^\"]+)\"",
    re.DOTALL,
)
QUOTED_MEMBER = re.compile(r'"([A-Za-z_][A-Za-z0-9_]*)"\s*,')
PLATFORM_PROPERTY = re.compile(
    r'"([A-Za-z_][A-Za-z0-9_]*)"\s*,\s*sol::property\s*\('
)
MIGRATION_CONTENT_METHOD = re.compile(
    r"\bcontent\.([A-Za-z_][A-Za-z0-9_]*)"
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
PLATFORM_PRIVATE_USERTYPE_ALIASES = {
    "_ModDefinitionNative": "ModDefinition",
}


def platform_public_usertype_name(name: str) -> str | None:
    if name in PLATFORM_PRIVATE_USERTYPE_ALIASES:
        return PLATFORM_PRIVATE_USERTYPE_ALIASES[name]
    return None if name.startswith("_") else name


def catalua_sources() -> list[Path]:
    # Platform v1 has an independent declaration and version contract.
    return sorted(
        path
        for path in (REPOSITORY_ROOT / "src").glob("catalua*.cpp")
        if not path.name.startswith("catalua_platform")
    )


def platform_sources() -> list[Path]:
    return [
        REPOSITORY_ROOT / "src/catalua_platform.cpp",
        REPOSITORY_ROOT / "src/catalua_platform_runtime.cpp",
        REPOSITORY_ROOT / "src/catalua_platform_world_content.cpp",
        # Activity services are shared with the v5 game layer but installed
        # directly into the Platform service table during bootstrap.
        REPOSITORY_ROOT / "src/catalua_ui_activities.cpp",
    ]


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


def platform_source_usertypes() -> set[str]:
    result: set[str] = set()
    for path in platform_sources():
        contents = path.read_text(encoding="utf-8", errors="replace")
        for native_name in NEW_USERTYPE.findall(contents):
            if public_name := platform_public_usertype_name(native_name):
                result.add(public_name)
    return result


def platform_usertype_members() -> dict[str, set[str]]:
    result: dict[str, set[str]] = defaultdict(set)
    for path in platform_sources():
        contents = path.read_text(encoding="utf-8", errors="replace")
        for match in NEW_USERTYPE.finditer(contents):
            usertype = platform_public_usertype_name(match.group(1))
            if usertype is None:
                continue
            opening = contents.find("(", match.start())
            depth = 0
            quoted = False
            escaped = False
            closing = opening
            for closing in range(opening, len(contents)):
                character = contents[closing]
                if quoted:
                    if escaped:
                        escaped = False
                    elif character == "\\":
                        escaped = True
                    elif character == '"':
                        quoted = False
                    continue
                if character == '"':
                    quoted = True
                elif character == "(":
                    depth += 1
                elif character == ")":
                    depth -= 1
                    if depth == 0:
                        break
            block = contents[match.end():closing]
            result[usertype].update(QUOTED_MEMBER.findall(block))
    return result


def platform_source_properties() -> set[str]:
    result: set[str] = set()
    # ModDefinition remains the only property-bearing bootstrap usertype in
    # catalua_platform.cpp. Runtime usertypes are checked by their declared
    # classes and registered method tables below.
    path = REPOSITORY_ROOT / "src/catalua_platform.cpp"
    contents = path.read_text(encoding="utf-8", errors="replace")
    result.update(PLATFORM_PROPERTY.findall(contents))
    return result


PLATFORM_TABLE_CLASSES = {
    "achievements": "CcbPlatformAchievementsApi",
    "activities": "CcbPlatformActivitiesApi",
    "bionics": "CcbPlatformBionicsApi",
    "content": "CcbPlatformContent",
    "dialogue_api": "CcbPlatformDialogueApi",
    "dialogue_services": "CcbPlatformDialogueServiceApi",
    "environment": "CcbPlatformEnvironmentQueries",
    "gameplay_options": "CcbPlatformGameplayOptionsApi",
    "inventory": "CcbPlatformInventoryApi",
    "lore": "CcbPlatformLoreApi",
    "math": "CcbPlatformMathApi",
    "mapgen": "CcbPlatformMapgenApi",
    "martial_arts": "CcbPlatformMartialArtsApi",
    "morale": "CcbPlatformMoraleApi",
    "mods": "CcbPlatformModQueries",
    "native_events": "CcbPlatformNativeEventsApi",
    "platform_messages": "CcbPlatformMessagesApi",
    "platform_sound": "CcbPlatformSoundApi",
    "random": "CcbPlatformRandomApi",
    "recipes": "CcbPlatformRecipesApi",
    "runtime_api": "CcbPlatformRuntime",
    "scope": "CcbPlatformStateScope",
    "snippets": "CcbPlatformSnippetsApi",
    "strings": "CcbPlatformStringPredicates",
    "tasks": "CcbPlatformTasks",
    "text_services": "CcbPlatformTextApi",
    "tileset": "CcbPlatformTilesetApi",
    "presentation": "CcbPlatformPresentation",
    "services": "CcbPlatformServices",
    "wounds": "CcbPlatformWoundsApi",
}

PLATFORM_INTENTIONALLY_UNDECLARED_TABLES = {
    "ccb",
    "lua",
}

PLATFORM_SERVICE_FIELDS = {
    "achievements",
    "activities",
    "addictions",
    "bionics",
    "camps",
    "characters",
    "constants",
    "coords",
    "crafting",
    "creatures",
    "dialogue",
    "effects",
    "enums",
    "factions",
    "followers",
    "gameplay",
    "handles",
    "hordes",
    "interaction",
    "inventory",
    "lore",
    "items",
    "mapgen",
    "martial_arts",
    "messages",
    "missions",
    "morale",
    "mutations",
    "needs",
    "native_events",
    "npcs",
    "overmap",
    "proficiencies",
    "random",
    "recipes",
    "registry",
    "relocation",
    "requirements",
    "serde",
    "skills",
    "sound",
    "snippets",
    "spawns",
    "spells",
    "statistics",
    "targeting",
    "text",
    "tileset",
    "time",
    "trade",
    "types",
    "units",
    "variables",
    "vehicles",
    "vitamins",
    "weather",
    "wounds",
    "world",
    "zones",
}


def platform_source_methods() -> dict[str, set[str]]:
    result: dict[str, set[str]] = defaultdict(set)
    for path in platform_sources():
        contents = path.read_text(encoding="utf-8", errors="replace")
        for table, method in SET_FUNCTION.findall(contents):
            result[table].add(method)
        # World-content aliases intentionally reuse one constructor and are
        # installed by table assignment rather than a second set_function
        # call.  Treat the alias as a registered public method as well.
        if 'content["CityBuilding"] = content["OvermapSpecial"]' in contents:
            result["content"].add("CityBuilding")
    unknown = sorted(
        set(result) - set(PLATFORM_TABLE_CLASSES) -
        PLATFORM_INTENTIONALLY_UNDECLARED_TABLES
    )
    if unknown:
        raise RuntimeError(
            "Platform LuaLS checker omits registered API table mappings: "
            f"{unknown}"
        )
    result = defaultdict(
        set,
        {
            table: methods
            for table, methods in result.items()
            if table in PLATFORM_TABLE_CLASSES
        },
    )
    # Platform installs this native snapshot layer directly into
    # `ccb.services`.  The implementation is shared with v5, while the table
    # membership is an independent Platform contract checked here.
    shared_services = REPOSITORY_ROOT / "src/catalua_ui_game.cpp"
    contents = shared_services.read_text(encoding="utf-8", errors="replace")
    for table, method in SET_FUNCTION.findall(contents):
        if table == "game":
            result["services"].add(method)
    return result


def migration_content_methods(path: Path = MIGRATION_TOOL) -> set[str]:
    """Return statically named content methods emitted by the migrator."""
    contents = path.read_text(encoding="utf-8")
    tree = ast.parse(contents, filename=str(path))
    result = set(MIGRATION_CONTENT_METHOD.findall(contents))

    def dynamic_variables(node: ast.AST) -> set[str]:
        variables: set[str] = set()
        for joined in (
            child for child in ast.walk(node)
            if isinstance(child, ast.JoinedStr)
        ):
            values = joined.values
            for index, value in enumerate(values[1:], start=1):
                previous = values[index - 1]
                if (
                    isinstance(previous, ast.Constant) and
                    isinstance(previous.value, str) and
                    previous.value.endswith("content.") and
                    isinstance(value, ast.FormattedValue) and
                    isinstance(value.value, ast.Name)
                ):
                    variables.add(value.value.id)
        return variables

    def string_values(node: ast.AST) -> set[str] | None:
        if isinstance(node, ast.Constant) and isinstance(node.value, str):
            return {node.value}
        if isinstance(node, ast.IfExp):
            left = string_values(node.body)
            right = string_values(node.orelse)
            return None if left is None or right is None else left | right
        if (
            isinstance(node, ast.Subscript) and
            isinstance(node.value, ast.Dict)
        ):
            values: set[str] = set()
            for entry in node.value.values:
                resolved = string_values(entry)
                if resolved is None:
                    return None
                values.update(resolved)
            return values
        return None

    function_nodes = [
        node for node in tree.body if isinstance(node, ast.FunctionDef)
    ]
    covered_dynamic_nodes: set[int] = set()
    for function in function_nodes:
        variables = dynamic_variables(function)
        if not variables:
            continue
        for node in ast.walk(function):
            if isinstance(node, ast.JoinedStr) and dynamic_variables(node):
                covered_dynamic_nodes.add(id(node))
        positional = [argument.arg for argument in function.args.args]
        keyword_only = [
            argument.arg for argument in function.args.kwonlyargs
        ]
        parameters = set(positional) | set(keyword_only)
        for variable in variables:
            # ``render_generic_platform_content`` receives its builder from
            # the closed ``PLATFORM_CONTENT_BUILDERS`` registry.  The value is
            # intentionally data-driven, so a call-site literal walk cannot
            # recover it without importing the migrator; the registry itself
            # is checked by the generated content inventory gate.
            if function.name == "render_generic_platform_content" and variable == "builder":
                continue
            resolved: set[str] = set()
            bounded = True
            if variable in parameters:
                for call in (
                    node for node in ast.walk(tree)
                    if isinstance(node, ast.Call) and
                    isinstance(node.func, ast.Name) and
                    node.func.id == function.name
                ):
                    values: set[str] | None = None
                    if variable in positional:
                        position = positional.index(variable)
                        if position < len(call.args):
                            values = string_values(call.args[position])
                    for keyword in call.keywords:
                        if keyword.arg == variable:
                            values = string_values(keyword.value)
                    if values is None:
                        bounded = False
                    else:
                        resolved.update(values)
            else:
                assignments = []
                for node in ast.walk(function):
                    if not isinstance(node, ast.Assign):
                        continue
                    if any(
                        isinstance(target, ast.Name) and
                        target.id == variable
                        for target in node.targets
                    ):
                        assignments.append(node.value)
                for assignment in assignments:
                    values = string_values(assignment)
                    if values is None:
                        bounded = False
                    else:
                        resolved.update(values)
            if not bounded or not resolved:
                raise RuntimeError(
                    "Lua-first migrator emits a dynamic content method "
                    f"through unbounded variable {function.name}.{variable}"
                )
            result.update(resolved)

    all_dynamic_nodes = {
        id(node)
        for node in ast.walk(tree)
        if isinstance(node, ast.JoinedStr) and dynamic_variables(node)
    }
    if all_dynamic_nodes - covered_dynamic_nodes:
        raise RuntimeError(
            "Lua-first migrator emits a dynamic content method outside a "
            "statically bounded function"
        )
    return result


def validate_migration_content_methods(
    registered: set[str], path: Path = MIGRATION_TOOL
) -> set[str]:
    referenced = migration_content_methods(path)
    missing = sorted(referenced - registered)
    if missing:
        raise RuntimeError(
            "Lua-first migrator references unregistered content methods: "
            f"{missing}"
        )
    return referenced


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


def class_methods(contents: str, class_name: str) -> list[str]:
    return [
        method
        for declared_class, method in DECLARED_METHOD.findall(contents)
        if declared_class == class_name
    ]


def declared_type_names(contents: str) -> set[str]:
    return (
        set(DECLARED_CLASS.findall(contents)) |
        set(DECLARED_ALIAS.findall(contents)) |
        set(DECLARED_GENERIC.findall(contents))
    )


def leading_type_expression(value: str) -> str:
    """Return the leading LuaLS type, without its prose description."""
    value = value.strip()
    depths = {"(": 0, "<": 0, "[": 0, "{": 0}
    closers = {")": "(", ">": "<", "]": "[", "}": "{"}
    quote: str | None = None
    escaped = False
    for index, character in enumerate(value):
        if quote is not None:
            if escaped:
                escaped = False
            elif character == "\\":
                escaped = True
            elif character == quote:
                quote = None
            continue
        if character in {"'", '"'}:
            quote = character
            continue
        if character in depths:
            depths[character] += 1
            continue
        if character in closers:
            opener = closers[character]
            depths[opener] = max(0, depths[opener] - 1)
            continue
        if not character.isspace() or any(depths.values()):
            continue
        previous = value[:index].rstrip()[-1:]
        following = value[index:].lstrip()[:1]
        if previous in {":", "|", "&", ","}:
            continue
        if following in {"|", "&", "<", "["}:
            continue
        return value[:index]
    return value


def split_return_declarations(value: str) -> list[str]:
    """Split a LuaLS return list without splitting generic arguments."""
    result: list[str] = []
    start = 0
    depths = {"(": 0, "<": 0, "[": 0, "{": 0}
    closers = {")": "(", ">": "<", "]": "[", "}": "{"}
    quote: str | None = None
    escaped = False
    for index, character in enumerate(value):
        if quote is not None:
            if escaped:
                escaped = False
            elif character == "\\":
                escaped = True
            elif character == quote:
                quote = None
            continue
        if character in {"'", '"'}:
            quote = character
            continue
        if character in depths:
            depths[character] += 1
            continue
        if character in closers:
            opener = closers[character]
            depths[opener] = max(0, depths[opener] - 1)
            continue
        if character == "," and not any(depths.values()):
            result.append(value[start:index].strip())
            start = index + 1
    result.append(value[start:].strip())
    return [entry for entry in result if entry]


def referenced_type_names(contents: str) -> dict[str, set[int]]:
    """Return custom LuaLS type references and their source lines."""
    result: dict[str, set[int]] = defaultdict(set)
    patterns = {
        "field": re.compile(
            r"^---@field\s+[A-Za-z_][A-Za-z0-9_]*\??\s+(.+)$"
        ),
        "param": re.compile(
            r"^---@param\s+[A-Za-z_][A-Za-z0-9_]*\??\s+(.+)$"
        ),
        "return": re.compile(r"^---@return\s+(.+)$"),
        "type": re.compile(r"^---@type\s+(.+)$"),
        "overload": re.compile(r"^---@overload\s+(.+)$"),
        "alias": re.compile(
            r"^---@alias\s+[A-Za-z_][A-Za-z0-9_]*(?:\s+(.+))?$"
        ),
        "class": re.compile(
            r"^---@class\s+[A-Za-z_][A-Za-z0-9_]*\s*:\s*(.+)$"
        ),
        "generic": re.compile(
            r"^---@generic\s+[A-Za-z_][A-Za-z0-9_]*\s*:\s*(.+)$"
        ),
    }
    for line_number, line in enumerate(contents.splitlines(), start=1):
        for kind, pattern in patterns.items():
            match = pattern.match(line)
            if match is None or match.group(1) is None:
                continue
            raw = match.group(1)
            if kind == "return":
                expressions = [
                    leading_type_expression(entry)
                    for entry in split_return_declarations(raw)
                ]
            elif kind in {"field", "param", "type"}:
                expressions = [leading_type_expression(raw)]
            else:
                expressions = [raw]
            for expression in expressions:
                without_literals = re.sub(
                    r"'(?:\\.|[^'\\])*'|\"(?:\\.|[^\"\\])*\"",
                    "",
                    expression,
                )
                for name in CUSTOM_TYPE_REFERENCE.findall(without_literals):
                    result[name].add(line_number)
            break
    return result


def validate_type_references(
    contents: str,
    additional_types: set[str] | None = None,
) -> None:
    """Reject LuaLS annotations that refer to undeclared custom types."""
    known = declared_type_names(contents)
    if additional_types is not None:
        known.update(additional_types)
    references = referenced_type_names(contents)
    missing = sorted(set(references) - known)
    if missing:
        details = ", ".join(
            f"{name} (lines {sorted(references[name])})"
            for name in missing
        )
        raise RuntimeError(
            f"LuaLS declarations reference undefined types: {details}"
        )


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
    validate_type_references(contents)
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


def check_platform(path: Path = PLATFORM_DECLARATIONS) -> dict[str, int]:
    contents = path.read_text(encoding="utf-8")
    if "Lua-first Platform v1" not in contents:
        raise RuntimeError("LuaLS declaration header is not Platform v1")
    validate_annotation_contracts(contents)
    classes = set(DECLARED_CLASS.findall(contents))
    usertypes = platform_source_usertypes()
    missing_types = sorted(usertypes - classes)
    if missing_types:
        raise RuntimeError(
            f"Platform LuaLS declarations omit usertypes: {missing_types}"
        )
    native_members = platform_usertype_members()
    for usertype, members in native_members.items():
        declared = set(class_fields(contents, usertype)) | set(
            class_methods(contents, usertype)
        )
        if members != declared:
            raise RuntimeError(
                f"Platform LuaLS members differ from native {usertype}: "
                f"declared={sorted(declared)}, native={sorted(members)}"
            )
    properties = platform_source_properties()
    declared_properties = set(class_fields(contents, "ModDefinition"))
    if properties != declared_properties:
        raise RuntimeError(
            "Platform LuaLS ModDefinition fields differ from native "
            f"properties: declared={sorted(declared_properties)}, "
            f"native={sorted(properties)}"
        )
    module_fields = class_fields(contents, "CcbPlatformV1")
    expected_module_fields = {
        "platform_version": "1",
        "content": "CcbPlatformContent",
        "runtime": "CcbPlatformRuntime",
        "dialogue": "CcbPlatformDialogueApi",
        "state": "CcbPlatformState",
        "tasks": "CcbPlatformTasks",
        "presentation": "CcbPlatformPresentation",
        "services": "CcbPlatformServices",
    }
    for field, expected_type in expected_module_fields.items():
        if module_fields.get(field) != expected_type:
            raise RuntimeError(
                f"Platform LuaLS module field {field} is "
                f"{module_fields.get(field) or 'missing'}, expected "
                f"{expected_type}"
            )
    constructor = module_fields.get("ModDefinition", "")
    if not constructor.startswith("fun("):
        raise RuntimeError(
            "Platform LuaLS ModDefinition constructor is missing"
        )
    declared_service_fields = set(
        class_fields(contents, "CcbPlatformServices")
    )
    if declared_service_fields != PLATFORM_SERVICE_FIELDS:
        raise RuntimeError(
            "Platform LuaLS service fields differ from the installed "
            f"domain set: declared={sorted(declared_service_fields)}, "
            f"expected={sorted(PLATFORM_SERVICE_FIELDS)}"
        )
    methods = platform_source_methods()
    if set(methods) != set(PLATFORM_TABLE_CLASSES):
        raise RuntimeError(
            "Platform native method tables differ from checker mappings: "
            f"native={sorted(methods)}, "
            f"mapped={sorted(PLATFORM_TABLE_CLASSES)}"
        )
    for table, native_methods in methods.items():
        declared = set(
            class_methods(contents, PLATFORM_TABLE_CLASSES[table])
        )
        if native_methods != declared:
            raise RuntimeError(
                "Platform LuaLS methods differ for "
                f"{PLATFORM_TABLE_CLASSES[table]}: "
                f"declared={sorted(declared)}, native={sorted(native_methods)}"
            )
    migration_methods = validate_migration_content_methods(
        methods["content"]
    )
    shared_contents = (
        REPOSITORY_ROOT / DEFAULT_DECLARATIONS
    ).read_text(encoding="utf-8")
    validate_type_references(
        contents,
        declared_type_names(shared_contents),
    )
    return {
        "usertypes": len(usertypes),
        "properties": len(properties),
        "methods": sum(len(value) for value in methods.values()),
        "migration_content_methods": len(migration_methods),
        "usertype_members": sum(
            len(value) for value in native_members.values()
        ),
    }


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--declarations", type=Path, default=DEFAULT_DECLARATIONS
    )
    args = parser.parse_args()
    result = check(args.declarations)
    platform_result = check_platform()
    print(
        "LuaLS declarations cover "
        f"{result['methods']} methods across {result['tables']} tables, "
        f"{result['game_tables']} game API domains, "
        f"{result['usertypes']} usertypes, and "
        f"{result['coordinate_factories']} coordinate factories; "
        "Platform v1 covers "
        f"{platform_result['usertypes']} usertypes and "
        f"{platform_result['properties']} properties."
    )


if __name__ == "__main__":
    main()
