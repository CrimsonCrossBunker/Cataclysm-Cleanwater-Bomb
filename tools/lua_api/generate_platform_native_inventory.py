#!/usr/bin/env python3
"""Generate the Platform native registration inventory from engine sources."""

from __future__ import annotations

import argparse
import json
import re
from collections import defaultdict, deque
from functools import lru_cache
from pathlib import Path

from jsonschema import Draft202012Validator


REPOSITORY_ROOT = Path(__file__).resolve().parents[2]
DEFAULT_OUTPUT = (
    REPOSITORY_ROOT / "data/lua/reference/ccb_platform_native_inventory.json"
)
DEFAULT_SCHEMA = REPOSITORY_ROOT / (
    "data/lua/reference/ccb_platform_native_inventory.schema.json"
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

USERTYPE_START_PATTERN = re.compile(r"\bnew_usertype\s*<")
PUBLIC_USERTYPE_ALIASES = {
    "_ModDefinitionNative": "ModDefinition",
}
META_FUNCTION_NAMES = {
    "addition": "__add",
    "division": "__div",
    "equal_to": "__eq",
    "less_than": "__lt",
    "less_than_or_equal_to": "__le",
    "multiplication": "__mul",
    "subtraction": "__sub",
    "to_string": "__tostring",
    "unary_minus": "__unm",
}

# Each installer is located independently so the inventory can prove which
# registrations are reachable from the sole Lua-first Platform surface.
INSTALLER_SPECS = (
    {
        "id": "platform_v1.initialize_state",
        "function": "initialize_state",
        "path": "src/lua_platform_loader.cpp",
        "signature": (
            "void initialize_state( sol::state &lua, "
            "const fs::path &requested_root,"
        ),
        "namespace": "ccb",
    },
    {
        "id": "platform_v1.install_mod_definition",
        "function": "install_mod_definition",
        "path": "src/lua_platform_loader.cpp",
        "signature": "void install_mod_definition( sol::table &ccb )",
        "namespace": "ccb",
    },
    {
        "id": "platform_v1.install_runtime_api",
        "function": "install_runtime_api",
        "path": "src/lua_platform_runtime_services.cpp",
        "signature": (
            "void install_runtime_api( "
            "const std::shared_ptr<runtime> &value,"
        ),
        "namespace": "ccb",
    },
    {
        "id": "platform_v1.install_runtime_callback_api",
        "function": "install_runtime_callback_api",
        "path": "src/lua_platform_runtime_hooks.cpp",
        "signature": "void install_runtime_callback_api(",
        "namespace": "ccb",
    },
    {
        "id": "platform_v1.install_runtime_dialogue_presentation_api",
        "function": "install_runtime_dialogue_presentation_api",
        "path": "src/lua_platform_runtime_dialogue.cpp",
        "signature": (
            "void detail::install_runtime_dialogue_presentation_api("
        ),
        "namespace": "ccb",
    },
    {
        "id": "platform_v1.install_runtime_state_task_api",
        "function": "install_runtime_state_task_api",
        "path": "src/lua_platform_runtime_lifecycle.cpp",
        "signature": "void detail::install_runtime_state_task_api(",
        "namespace": "ccb",
    },
    {
        "id": "platform_v1.content_transaction.install_lua_api",
        "function": "content_transaction::install_lua_api",
        "path": "src/lua_platform_runtime.cpp",
        "signature": (
            "void content_transaction::install_lua_api( "
            "sol::state &lua, sol::table &ccb,"
        ),
        "namespace": "ccb",
    },
    {
        "id": "platform_v1.items_content_transaction.install_lua_api",
        "function": "items_content_transaction::install_lua_api",
        "path": "src/lua_platform_content_items.cpp",
        "signature": "void items_content_transaction::install_lua_api(",
        "namespace": "ccb",
    },
    {
        "id": "platform_v1.creatures_content_transaction.install_lua_api",
        "function": "creatures_content_transaction::install_lua_api",
        "path": "src/lua_platform_content_creatures.cpp",
        "signature": "void creatures_content_transaction::install_lua_api(",
        "namespace": "ccb",
    },
    {
        "id": "platform_v1.character_content_transaction.install_lua_api",
        "function": "character_content_transaction::install_lua_api",
        "path": "src/lua_platform_content_character.cpp",
        "signature": "void character_content_transaction::install_lua_api(",
        "namespace": "ccb",
    },
    {
        "id": "platform_v1.presentation_content_transaction.install_lua_api",
        "function": "presentation_content_transaction::install_lua_api",
        "path": "src/lua_platform_content_presentation.cpp",
        "signature": "void presentation_content_transaction::install_lua_api(",
        "namespace": "ccb",
    },
    {
        "id": "platform_v1.worldgen_content_transaction.install_lua_api",
        "function": "worldgen_content_transaction::install_lua_api",
        "path": "src/lua_platform_content_worldgen.cpp",
        "signature": "void worldgen_content_transaction::install_lua_api(",
        "namespace": "ccb",
    },
    {
        "id": "platform_v1.world_content_transaction.install_lua_api",
        "function": "world_content_transaction::install_lua_api",
        "path": "src/lua_platform_world_content.cpp",
        "signature": (
            "void world_content_transaction::install_lua_api( "
            "sol::state &lua, sol::table &ccb,"
        ),
        "namespace": "ccb",
    },
    {
        "id": "shared.install_value_type_api",
        "function": "install_value_type_api",
        "path": "src/lua_platform_bindings_values.cpp",
        "signature": "void install_value_type_api(",
        "namespace": "global",
    },
    {
        "id": "shared.install_enum_value_api",
        "function": "install_enum_value_api",
        "path": "src/lua_platform_bindings_enums.cpp",
        "signature": "void install_enum_value_api(",
        "namespace": "global",
    },
    {
        "id": "shared.install_coordinate_value_api",
        "function": "install_coordinate_value_api",
        "path": "src/lua_platform_bindings_coords.cpp",
        "signature": "void install_coordinate_value_api(",
        "namespace": "global",
    },
    {
        "id": "shared.install_game_handle_api",
        "function": "install_game_handle_api",
        "path": "src/lua_platform_handle.cpp",
        "signature": "void install_game_handle_api(",
        "namespace": "global",
    },
    {
        "id": "shared.install_mission_api",
        "function": "install_mission_api",
        "path": "src/lua_platform_missions.cpp",
        "signature": "void install_mission_api(",
        "namespace": "global",
    },
    {
        "id": "shared.install_horde_api",
        "function": "install_horde_api",
        "path": "src/lua_platform_hordes.cpp",
        "signature": "void install_horde_api(",
        "namespace": "global",
    },
    {
        "id": "shared.install_script_mapgen_context_api",
        "function": "install_script_mapgen_context_api",
        "path": "src/lua_platform_mapgen.cpp",
        "signature": "void install_script_mapgen_context_api(",
        "namespace": "global",
    },
    {
        "id": "shared.install_mapgen_service_api",
        "function": "install_mapgen_service_api",
        "path": "src/lua_platform_mapgen.cpp",
        "signature": "void install_mapgen_service_api(",
        "namespace": "global",
    },
    {
        "id": "shared.install_overmap_api",
        "function": "install_overmap_api",
        "path": "src/lua_platform_overmap.cpp",
        "signature": "void install_overmap_api(",
        "namespace": "global",
    },
    {
        "id": "shared.install_trade_api",
        "function": "install_trade_api",
        "path": "src/lua_platform_trade.cpp",
        "signature": "void install_trade_api(",
        "namespace": "global",
    },
    {
        "id": "shared.install_map_api",
        "function": "install_map_api",
        "path": "src/lua_platform_world.cpp",
        "signature": "void install_map_api(",
        "namespace": "global",
    },
    {
        "id": "shared.install_camp_api",
        "function": "install_camp_api",
        "path": "src/lua_platform_camps.cpp",
        "signature": "void install_camp_api(",
        "namespace": "global",
    },
    {
        "id": "shared.install_zone_api",
        "function": "install_zone_api",
        "path": "src/lua_platform_zones.cpp",
        "signature": "void install_zone_api(",
        "namespace": "global",
    },
)

INSTALLER_EDGE_SPECS = (
    (
        "platform_v1.initialize_state",
        "platform_v1.install_mod_definition",
        "install_mod_definition(",
    ),
    (
        "platform_v1.initialize_state",
        "platform_v1.install_runtime_api",
        "install_runtime_api(",
    ),
    (
        "platform_v1.install_runtime_api",
        "platform_v1.content_transaction.install_lua_api",
        "content.install_lua_api(",
    ),
    (
        "platform_v1.install_runtime_api",
        "platform_v1.install_runtime_callback_api",
        "install_runtime_callback_api(",
    ),
    (
        "platform_v1.install_runtime_api",
        "platform_v1.install_runtime_dialogue_presentation_api",
        "install_runtime_dialogue_presentation_api(",
    ),
    (
        "platform_v1.install_runtime_api",
        "platform_v1.install_runtime_state_task_api",
        "install_runtime_state_task_api(",
    ),
    (
        "platform_v1.content_transaction.install_lua_api",
        "platform_v1.items_content_transaction.install_lua_api",
        "item_content.install_lua_api(",
    ),
    (
        "platform_v1.content_transaction.install_lua_api",
        "platform_v1.creatures_content_transaction.install_lua_api",
        "creatures.install_lua_api(",
    ),
    (
        "platform_v1.content_transaction.install_lua_api",
        "platform_v1.character_content_transaction.install_lua_api",
        "character.install_lua_api(",
    ),
    (
        "platform_v1.content_transaction.install_lua_api",
        "platform_v1.presentation_content_transaction.install_lua_api",
        "presentation.install_lua_api(",
    ),
    (
        "platform_v1.content_transaction.install_lua_api",
        "platform_v1.worldgen_content_transaction.install_lua_api",
        "worldgen.install_lua_api(",
    ),
    (
        "platform_v1.content_transaction.install_lua_api",
        "platform_v1.world_content_transaction.install_lua_api",
        "world.install_lua_api(",
    ),
    (
        "platform_v1.install_runtime_api",
        "shared.install_value_type_api",
        "install_value_type_api(",
    ),
    (
        "platform_v1.install_runtime_api",
        "shared.install_game_handle_api",
        "install_game_handle_api(",
    ),
    (
        "platform_v1.install_runtime_api",
        "shared.install_mission_api",
        "install_mission_api(",
    ),
    (
        "platform_v1.install_runtime_api",
        "shared.install_horde_api",
        "install_horde_api(",
    ),
    (
        "platform_v1.install_runtime_api",
        "shared.install_script_mapgen_context_api",
        "install_script_mapgen_context_api(",
    ),
    (
        "platform_v1.install_runtime_api",
        "shared.install_mapgen_service_api",
        "install_mapgen_service_api(",
    ),
    (
        "platform_v1.install_runtime_api",
        "shared.install_trade_api",
        "install_trade_api(",
    ),
    (
        "platform_v1.install_runtime_api",
        "shared.install_zone_api",
        "install_zone_api(",
    ),
    (
        "platform_v1.install_runtime_api",
        "shared.install_camp_api",
        "install_camp_api(",
    ),
    (
        "platform_v1.install_runtime_api",
        "shared.install_overmap_api",
        "install_overmap_api(",
    ),
    (
        "platform_v1.install_runtime_api",
        "shared.install_map_api",
        "install_map_api(",
    ),
    (
        "shared.install_value_type_api",
        "shared.install_enum_value_api",
        "install_enum_value_api(",
    ),
    (
        "shared.install_value_type_api",
        "shared.install_coordinate_value_api",
        "install_coordinate_value_api(",
    ),
)

EXPORT_SURFACES = (
    {
        "id": "platform_v1",
        "api_version": 1,
        "declarations": "data/lua/types/ccb_platform_v1.d.lua",
        "entrypoint": "platform_v1.initialize_state",
    },
)

NATIVE_DOMAINS = (
    ("achievements", "Inspect achievement definitions and world progress."),
    ("addictions", "Inspect and mutate character addictions."),
    ("bionics", "Inspect definitions and mutate installed bionics."),
    ("camps", "Inspect faction camps and their world locations."),
    ("characters", "Query, snapshot, and mutate active characters."),
    ("crafting", "Inspect requirements and start bounded crafting work."),
    ("definitions", "Validate and inspect stable native definition ids."),
    ("diagnostics", "Inspect bounded runtime health and errors."),
    ("effects", "Inspect and mutate native creature effects."),
    ("factions", "Inspect faction state and player relationships."),
    ("handles", "Reference live creatures, items, and vehicles safely."),
    ("hooks", "Observe and intercept documented native lifecycles."),
    ("hordes", "Inspect and mutate persistent overmap hordes."),
    ("inventory", "Traverse and mutate item inventories and pockets."),
    ("mapgen", "Inspect and post-process native map generation."),
    ("martial_arts", "Inspect and mutate known martial arts."),
    ("missions", "Inspect definitions and control mission instances."),
    ("mutations", "Inspect definitions and mutate character mutations."),
    ("native_events", "Subscribe to every typed native event bus event."),
    ("needs", "Inspect and adjust character physiological needs."),
    ("npcs", "Query and mutate NPC identity and relationships."),
    ("overmap", "Query and mutate existing overmap state."),
    ("proficiencies", "Inspect definitions and mutate character learning."),
    ("recipes", "Search recipes and evaluate native requirements."),
    ("skills", "Inspect definitions and mutate character skills."),
    ("spells", "Inspect definitions and mutate character spellbooks."),
    ("statistics", "Inspect native event statistics and score values."),
    ("time", "Inspect calendar values and control world time."),
    ("vehicles", "Query, snapshot, and control active vehicles."),
    ("vitamins", "Inspect definitions and mutate character vitamins."),
    ("weather", "Inspect forecasts and control weather overrides."),
    ("world", "Query and mutate the active map and world services."),
    ("zones", "Inspect and mutate loot and personal zones."),
)


@lru_cache(maxsize=None)
def source_text(relative_path: str) -> str:
    return (REPOSITORY_ROOT / relative_path).read_text(encoding="utf-8")


def line_number(contents: str, offset: int) -> int:
    return contents.count("\n", 0, offset) + 1


def source_location(
    path: str, contents: str, offset: int
) -> dict[str, object]:
    return {
        "path": path,
        "line": line_number(contents, offset),
    }


@lru_cache(maxsize=32)
def code_mask(contents: str) -> str:
    """Preserve code offsets while blanking comments and quoted strings."""
    result = list(contents)
    quote: str | None = None
    escaped = False
    line_comment = False
    block_comment = False
    index = 0
    while index < len(contents):
        char = contents[index]
        following = contents[index + 1] if index + 1 < len(contents) else ""
        if line_comment:
            if char == "\n":
                line_comment = False
            else:
                result[index] = " "
            index += 1
            continue
        if block_comment:
            if char == "*" and following == "/":
                result[index] = " "
                result[index + 1] = " "
                block_comment = False
                index += 2
            else:
                if char != "\n":
                    result[index] = " "
                index += 1
            continue
        if quote is not None:
            if char != "\n":
                result[index] = " "
            if escaped:
                escaped = False
            elif char == "\\":
                escaped = True
            elif char == quote:
                quote = None
            index += 1
            continue
        if char == "/" and following == "/":
            result[index] = " "
            result[index + 1] = " "
            line_comment = True
            index += 2
            continue
        if char == "/" and following == "*":
            result[index] = " "
            result[index + 1] = " "
            block_comment = True
            index += 2
            continue
        if char in {'"', "'"}:
            result[index] = " "
            quote = char
        index += 1
    return "".join(result)


def extract_balanced(
    contents: str, opening: int, opener: str = "(", closer: str = ")"
) -> tuple[str, int]:
    """Return a balanced C++ region, ignoring comments and strings."""
    if opening >= len(contents) or contents[opening] != opener:
        raise RuntimeError(f"expected {opener!r} at offset {opening}")
    depth = 0
    quote: str | None = None
    escaped = False
    line_comment = False
    block_comment = False
    index = opening
    while index < len(contents):
        char = contents[index]
        following = contents[index + 1] if index + 1 < len(contents) else ""
        if line_comment:
            if char == "\n":
                line_comment = False
            index += 1
            continue
        if block_comment:
            if char == "*" and following == "/":
                block_comment = False
                index += 2
            else:
                index += 1
            continue
        if quote is not None:
            if escaped:
                escaped = False
            elif char == "\\":
                escaped = True
            elif char == quote:
                quote = None
            index += 1
            continue
        if char == "/" and following == "/":
            line_comment = True
            index += 2
            continue
        if char == "/" and following == "*":
            block_comment = True
            index += 2
            continue
        if char in {'"', "'"}:
            quote = char
            index += 1
            continue
        if char == opener:
            depth += 1
        elif char == closer:
            depth -= 1
            if depth == 0:
                return contents[opening + 1:index], index + 1
        index += 1
    raise RuntimeError(f"unterminated {opener}{closer} region")


def split_top_level(contents: str) -> list[str]:
    """Split a C++ argument list without splitting nested expressions."""
    parts: list[str] = []
    start = 0
    depths = {"(": 0, "[": 0, "{": 0}
    matching = {")": "(", "]": "[", "}": "{"}
    quote: str | None = None
    escaped = False
    line_comment = False
    block_comment = False
    index = 0
    while index < len(contents):
        char = contents[index]
        following = contents[index + 1] if index + 1 < len(contents) else ""
        if line_comment:
            if char == "\n":
                line_comment = False
            index += 1
            continue
        if block_comment:
            if char == "*" and following == "/":
                block_comment = False
                index += 2
            else:
                index += 1
            continue
        if quote is not None:
            if escaped:
                escaped = False
            elif char == "\\":
                escaped = True
            elif char == quote:
                quote = None
            index += 1
            continue
        if char == "/" and following == "/":
            line_comment = True
            index += 2
            continue
        if char == "/" and following == "*":
            block_comment = True
            index += 2
            continue
        if char in {'"', "'"}:
            quote = char
        elif char in depths:
            depths[char] += 1
        elif char in matching:
            depths[matching[char]] -= 1
        elif char == "," and not any(depths.values()):
            parts.append(contents[start:index].strip())
            start = index + 1
        index += 1
    tail = contents[start:].strip()
    if tail:
        parts.append(tail)
    return parts


def function_region(
    contents: str, signature: str
) -> tuple[int, int, int]:
    signature_offset = contents.find(signature)
    if signature_offset < 0:
        raise RuntimeError(f"installer signature was not found: {signature}")
    opening = contents.find("{", signature_offset + len(signature))
    if opening < 0:
        raise RuntimeError(f"installer body was not found: {signature}")
    _, after = extract_balanced(contents, opening, "{", "}")
    return signature_offset, opening + 1, after - 1


def member_public_name(key_expression: str) -> tuple[str, str]:
    string_key = re.fullmatch(r'"([^"\\]*(?:\\.[^"\\]*)*)"', key_expression)
    if string_key is not None:
        return json.loads(f'"{string_key.group(1)}"'), "member"
    meta_key = re.fullmatch(
        r"sol::meta_function::([A-Za-z_][A-Za-z0-9_]*)",
        key_expression,
    )
    if meta_key is None or meta_key.group(1) not in META_FUNCTION_NAMES:
        raise RuntimeError(
            f"unsupported usertype member key {key_expression!r}"
        )
    return META_FUNCTION_NAMES[meta_key.group(1)], "operator"


def referenced_cpp_members(expression: str) -> list[str]:
    address_members = re.findall(
        r"&(?:[A-Za-z_][A-Za-z0-9_]*::)+"
        r"([A-Za-z_][A-Za-z0-9_]*)",
        expression,
    )
    adapted_members = re.findall(
        r"\bself\.([A-Za-z_][A-Za-z0-9_]*)",
        expression,
    )
    return sorted(set(address_members + adapted_members))


def parse_usertype_registrations(
    contents: str,
    path: str,
    start: int = 0,
    end: int | None = None,
) -> list[dict[str, object]]:
    """Parse registrations and only their top-level public member keys."""
    boundary = len(contents) if end is None else end
    masked = code_mask(contents)
    registrations: list[dict[str, object]] = []
    for match in USERTYPE_START_PATTERN.finditer(masked, start, boundary):
        angle_opening = masked.find("<", match.start(), boundary)
        cpp_type, after_angle = extract_balanced(
            contents, angle_opening, "<", ">"
        )
        opening = after_angle
        while opening < boundary and contents[opening].isspace():
            opening += 1
        if opening >= boundary or contents[opening] != "(":
            raise RuntimeError(
                f"cannot parse usertype call at "
                f"{path}:{line_number(contents, match.start())}"
            )
        body, after_call = extract_balanced(contents, opening)
        if after_call > boundary:
            raise RuntimeError(
                f"usertype registration escapes installer at "
                f"{path}:{line_number(contents, match.start())}"
            )
        arguments = split_top_level(body)
        if len(arguments) < 2 or len(arguments[2:]) % 2 != 0:
            raise RuntimeError(
                f"cannot parse usertype arguments at "
                f"{path}:{line_number(contents, match.start())}"
            )
        name_match = re.fullmatch(
            r'"([^"\\]*(?:\\.[^"\\]*)*)"', arguments[0]
        )
        if name_match is None:
            raise RuntimeError(
                f"usertype name is not a string literal at "
                f"{path}:{line_number(contents, match.start())}"
            )
        registration_name = json.loads(f'"{name_match.group(1)}"')
        lua_name = PUBLIC_USERTYPE_ALIASES.get(
            registration_name, registration_name
        )
        if lua_name.startswith("_"):
            raise RuntimeError(
                f"private usertype {registration_name} lacks a public alias"
            )
        members: list[dict[str, object]] = []
        search_offset = 0
        for key_expression, value_expression in zip(
            arguments[2::2], arguments[3::2]
        ):
            lua_member, kind = member_public_name(key_expression)
            relative_offset = body.find(key_expression, search_offset)
            if relative_offset < 0:
                raise RuntimeError(
                    f"cannot locate {lua_name}.{lua_member} registration"
                )
            search_offset = relative_offset + len(key_expression)
            if "sol::property" in value_expression:
                kind = "property"
            members.append(
                {
                    "id": lua_member,
                    "cpp_members": referenced_cpp_members(value_expression),
                    "cpp_kind": kind,
                    "lua_access": [f"{lua_name}.{lua_member}"],
                    "disposition": "bound",
                    "evidence": [
                        source_location(
                            path,
                            contents,
                            opening + 1 + relative_offset,
                        )
                    ],
                }
            )
        registrations.append(
            {
                "cpp_type": " ".join(cpp_type.split()),
                "lua_name": lua_name,
                "registration_name": registration_name,
                "members": members,
                "source": source_location(path, contents, match.start()),
                "_offset": match.start(),
            }
        )
    return registrations


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


def registration_identity(entry: dict[str, object]) -> tuple[str, int]:
    source = entry["source"]
    if not isinstance(source, dict):
        raise RuntimeError("usertype registration source must be an object")
    return str(source["path"]), int(entry["_offset"])


def build_installer_model() -> tuple[
    list[dict[str, object]],
    list[dict[str, object]],
    dict[str, list[dict[str, object]]],
]:
    contents_by_path: dict[str, str] = {}
    regions: dict[str, tuple[str, int, int]] = {}
    registrations_by_installer: dict[str, list[dict[str, object]]] = {}
    installers: list[dict[str, object]] = []

    for spec in INSTALLER_SPECS:
        installer_id = str(spec["id"])
        path = str(spec["path"])
        contents = contents_by_path.setdefault(path, source_text(path))
        signature_offset, body_start, body_end = function_region(
            contents, str(spec["signature"])
        )
        regions[installer_id] = (path, body_start, body_end)
        registrations = parse_usertype_registrations(
            contents, path, body_start, body_end
        )
        for registration in registrations:
            registration["_installer"] = installer_id
            registration["_namespace"] = str(spec["namespace"])
        registrations_by_installer[installer_id] = registrations
        installers.append(
            {
                "id": installer_id,
                "function": spec["function"],
                "namespace": spec["namespace"],
                "source": source_location(
                    path, contents, signature_offset
                ),
                "direct_roots": sorted(
                    str(entry["lua_name"]) for entry in registrations
                ),
            }
        )

    assigned = {
        registration_identity(registration)
        for registrations in registrations_by_installer.values()
        for registration in registrations
    }
    discovered: dict[tuple[str, int], dict[str, object]] = {}
    source_directory = REPOSITORY_ROOT / "src"
    for path_object in sorted(source_directory.glob("lua_platform*.cpp")):
        relative_path = path_object.relative_to(REPOSITORY_ROOT).as_posix()
        contents = contents_by_path.setdefault(
            relative_path,
            path_object.read_text(encoding="utf-8", errors="replace"),
        )
        for registration in parse_usertype_registrations(
            contents, relative_path
        ):
            discovered[registration_identity(registration)] = registration
    unassigned = sorted(set(discovered) - assigned)
    if unassigned:
        details = [
            f"{path}:{line_number(contents_by_path[path], offset)}"
            for path, offset in unassigned
        ]
        raise RuntimeError(
            f"registered export roots lack installer nodes: {details}"
        )
    missing = sorted(assigned - set(discovered))
    if missing:
        raise RuntimeError(
            f"installer nodes contain undiscovered registrations: {missing}"
        )

    edges: list[dict[str, object]] = []
    for caller, callee, call_token in INSTALLER_EDGE_SPECS:
        path, body_start, body_end = regions[caller]
        contents = contents_by_path[path]
        call_offset = code_mask(contents).find(
            call_token, body_start, body_end
        )
        if call_offset < 0:
            raise RuntimeError(
                f"installer edge {caller} -> {callee} lacks source evidence"
            )
        edges.append(
            {
                "caller": caller,
                "callee": callee,
                "source": source_location(path, contents, call_offset),
            }
        )
    return installers, edges, registrations_by_installer


def reachable_installer_paths(
    entrypoint: str, edges: list[dict[str, object]]
) -> dict[str, list[str]]:
    children: dict[str, list[str]] = defaultdict(list)
    for edge in edges:
        children[str(edge["caller"])].append(str(edge["callee"]))
    for values in children.values():
        values.sort()
    paths = {entrypoint: [entrypoint]}
    pending = deque([entrypoint])
    while pending:
        caller = pending.popleft()
        for callee in children[caller]:
            if callee in paths:
                continue
            paths[callee] = [*paths[caller], callee]
            pending.append(callee)
    return paths


def evidence_for(
    path: str, needle: str, start_needle: str | None = None
) -> dict[str, object]:
    contents = source_text(path)
    start = 0
    if start_needle is not None:
        start = contents.find(start_needle)
        if start < 0:
            raise RuntimeError(
                f"disposition evidence start {start_needle!r} was not found "
                f"in {path}"
            )
    offset = contents.find(needle, start)
    if offset < 0:
        raise RuntimeError(
            f"disposition evidence {needle!r} was not found in {path}"
        )
    return source_location(path, contents, offset)


def reviewed_member(
    identity: str,
    cpp_members: list[str],
    cpp_kind: str,
    disposition: str,
    evidence: dict[str, object],
    *,
    lua_access: list[str] | None = None,
    reason_code: str,
    reason: str,
) -> dict[str, object]:
    return {
        "id": identity,
        "cpp_members": cpp_members,
        "cpp_kind": cpp_kind,
        "lua_access": [] if lua_access is None else lua_access,
        "disposition": disposition,
        "reason_code": reason_code,
        "reason": reason,
        "evidence": [evidence],
    }


def append_reviewed_member(
    roots: dict[str, dict[str, object]],
    root_name: str,
    member: dict[str, object],
) -> None:
    root = roots[root_name]
    disposition = root["member_disposition"]
    if not isinstance(disposition, dict):
        raise RuntimeError(f"{root_name} member disposition is malformed")
    members = disposition["members"]
    if not isinstance(members, list):
        raise RuntimeError(f"{root_name} member list is malformed")
    members.append(member)


def add_reviewed_dispositions(
    roots: dict[str, dict[str, object]]
) -> None:
    values_header = "src/lua_platform_bindings_values.h"
    for method in (
        "canonical_integer",
        "canonical_number",
        "canonical_wide",
    ):
        append_reviewed_member(
            roots,
            "UnitValue",
            reviewed_member(
                f"native.{method}",
                [method],
                "method",
                "unbound",
                evidence_for(values_header, f" {method}() const"),
                reason_code="internal-canonical-storage",
                reason=(
                    "Canonical storage access stays native; Lua uses the "
                    "unit-aware value conversion method."
                ),
            ),
        )

    coords_header = "src/lua_platform_bindings_coords.h"
    for root_name, cpp_type in (
        ("PointCoord", "script_point_coord"),
        ("TripointCoord", "script_tripoint_coord"),
    ):
        append_reviewed_member(
            roots,
            root_name,
            reviewed_member(
                "native.line_to",
                ["line_to"],
                "method",
                "adapted",
                evidence_for(
                    coords_header,
                    " line_to(",
                    f"class {cpp_type}",
                ),
                lua_access=[
                    "ccb.services.coords.line",
                ],
                reason_code="bounded-service-adapter",
                reason=(
                    "Lua reaches line generation through the bounded "
                    "coordinate service so maximum output is enforced."
                ),
            ),
        )
        for method in ("to_native", "native_origin", "native_scale"):
            append_reviewed_member(
                roots,
                root_name,
                reviewed_member(
                    f"native.{method}",
                    [method],
                    "method",
                    "unbound",
                    evidence_for(
                        coords_header,
                        f" {method}() const",
                        f"class {cpp_type}",
                    ),
                    reason_code="native-coordinate-bridge",
                    reason=(
                        "Native coordinate representations are engine-only; "
                        "Lua uses checked coordinate values and services."
                    ),
                ),
            )

    handle_header = "src/lua_platform_handle.h"
    for method in ("resolve_creature", "resolve_item", "resolve_vehicle"):
        append_reviewed_member(
            roots,
            "GameHandle",
            reviewed_member(
                f"native.{method}",
                [method],
                "method",
                "unbound",
                evidence_for(
                    handle_header, f" {method}(", "class game_handle"
                ),
                reason_code="native-pointer-escape",
                reason=(
                    "The native resolver returns a raw engine pointer; Lua "
                    "must use audited handle-backed services instead."
                ),
            ),
        )
    append_reviewed_member(
        roots,
        "GameHandle",
        reviewed_member(
            "native.validation_error",
            ["validation_error"],
            "method",
            "adapted",
            evidence_for(
                handle_header, " validation_error(", "class game_handle"
            ),
            lua_access=["GameHandle.is_valid", "GameHandle.status"],
            reason_code="result-envelope-adapter",
            reason=(
                "Validation is exposed as a boolean and a detached result "
                "envelope instead of a native optional error object."
            ),
        ),
    )
    for method in ("runtime_generation", "world_generation"):
        append_reviewed_member(
            roots,
            "GameHandle",
            reviewed_member(
                f"native.{method}",
                [method],
                "method",
                "unbound",
                evidence_for(handle_header, f" {method}() const"),
                reason_code="lifetime-generation-internal",
                reason=(
                    "Generation counters are internal lifetime guards and "
                    "cannot be authored or inspected by Lua."
                ),
            ),
        )
    append_reviewed_member(
        roots,
        "GameHandle",
        reviewed_member(
            "native.runtime_owner",
            ["runtime_owner_"],
            "field",
            "unbound",
            evidence_for(handle_header, " runtime_owner_;"),
            reason_code="native-owner-state",
            reason=(
                "The weak runtime-owner identity is an internal stale-handle "
                "guard and cannot be observed or replaced by Lua."
            ),
        ),
    )

    platform_runtime = "src/lua_platform_runtime.cpp"
    for root in roots.values():
        cpp_type = str(root["cpp_type"])
        if not cpp_type.endswith("_definition_handle"):
            continue
        registration = root.get("registration")
        if not isinstance(registration, dict) or not isinstance(
            registration.get("path"), str
        ):
            raise RuntimeError(
                f"definition handle {root['lua_name']} lacks source evidence"
            )
        definition_path = str(registration["path"])
        struct_marker = f"struct {cpp_type}"
        for field, reason_code, reason in (
            (
                "definition",
                "native-definition-storage",
                "The transaction-owned definition payload is only reachable "
                "through audited builder methods.",
            ),
            (
                "token",
                "native-owner-state",
                "The owner token enforces transaction lifetime and is never "
                "public Lua state.",
            ),
        ):
            append_reviewed_member(
                roots,
                str(root["lua_name"]),
                reviewed_member(
                    f"native.{field}",
                    [field],
                    "field",
                    "unbound",
                    evidence_for(
                        definition_path, f" {field};", struct_marker
                    ),
                    reason_code=reason_code,
                    reason=reason,
                ),
            )

    for field in (
        "character",
        "used_item",
        "handle_runtime",
        "world_generation",
        "active",
        "require_active",
    ):
        needle = (
            " require_active()"
            if field == "require_active"
            else f" {field}"
        )
        append_reviewed_member(
            roots,
            "ItemUseContext",
            reviewed_member(
                f"native.{field}",
                [field],
                "method" if field == "require_active" else "field",
                "unbound",
                evidence_for(
                    platform_runtime,
                    needle,
                    "struct use_context_data",
                ),
                reason_code=(
                    "native-pointer-escape"
                    if field in {"character", "used_item"}
                    else "callback-lifetime-internal"
                ),
                reason=(
                    "Raw callback pointers cannot escape into Lua."
                    if field in {"character", "used_item"}
                    else "Callback lifetime guards are enforced internally."
                ),
            ),
        )
    for identity, cpp_member, cpp_kind, needle in (
        (
            "native.copy_constructor",
            "use_context_data(const&)",
            "constructor",
            "use_context_data( const use_context_data & ) = delete;",
        ),
        (
            "native.copy_assignment",
            "operator=(const&)",
            "operator",
            "operator=( const use_context_data & ) = delete;",
        ),
        (
            "native.move_constructor",
            "use_context_data(&&)",
            "constructor",
            "use_context_data( use_context_data && ) = delete;",
        ),
        (
            "native.move_assignment",
            "operator=(&&)",
            "operator",
            "operator=( use_context_data && ) = delete;",
        ),
    ):
        append_reviewed_member(
            roots,
            "ItemUseContext",
            reviewed_member(
                identity,
                [cpp_member],
                cpp_kind,
                "unbound",
                evidence_for(
                    platform_runtime,
                    needle,
                    "struct use_context_data",
                ),
                reason_code="callback-lifetime-internal",
                reason=(
                    "Callback userdata is pinned to one native scope lease "
                    "and cannot be copied or moved."
                ),
            ),
        )

    platform_header = "src/lua_platform_loader.h"
    for field in (
        "id_set",
        "name_set",
        "version_set",
        "entry_set",
        "dependencies_set",
        "core_set",
    ):
        append_reviewed_member(
            roots,
            "ModDefinition",
            reviewed_member(
                f"native.{field}",
                [field],
                "field",
                "unbound",
                evidence_for(platform_header, f" {field} ="),
                reason_code="parser-presence-state",
                reason=(
                    "Field-presence tracking belongs to native metadata "
                    "validation and is not Mod-authored state."
                ),
            ),
        )

    zones_source = "src/lua_platform_zones.cpp"
    for field in (
        "runtime",
        "world_generation",
        "personal_start",
        "personal_end",
        "lifetime_identity",
    ):
        append_reviewed_member(
            roots,
            "ZoneToken",
            reviewed_member(
                f"native.{field}",
                [field],
                "field",
                "unbound",
                evidence_for(
                    zones_source,
                    f" {field}",
                    "struct script_zone_token",
                ),
                reason_code="identity-or-lifetime-internal",
                reason=(
                    "Zone identity and lifetime internals are validated by "
                    "native token resolution rather than exposed to Lua."
                ),
            ),
        )

    transient_tokens = (
        (
            "MissionToken",
            "src/lua_platform_missions.h",
            "class mission_token",
            " runtime_;",
        ),
        (
            "HordeEntityToken",
            "src/lua_platform_hordes.cpp",
            "class horde_entity_token",
            " runtime_;",
        ),
        (
            "LegacyHordeToken",
            "src/lua_platform_hordes.cpp",
            "class legacy_horde_token",
            " runtime_;",
        ),
    )
    for root_name, path, marker, runtime_needle in transient_tokens:
        append_reviewed_member(
            roots,
            root_name,
            reviewed_member(
                "native.runtime_context",
                ["runtime_"],
                "field",
                "unbound",
                evidence_for(path, runtime_needle, marker),
                reason_code="native-owner-state",
                reason=(
                    "The complete runtime owner and generation context is an "
                    "internal stale-token guard."
                ),
            ),
        )
        append_reviewed_member(
            roots,
            root_name,
            reviewed_member(
                "native.belongs_to",
                ["belongs_to"],
                "method",
                "adapted",
                evidence_for(path, " belongs_to(", marker),
                lua_access=[f"{root_name}.is_valid"],
                reason_code="runtime-identity-adapter",
                reason=(
                    "Lua receives a validity predicate that combines runtime "
                    "owner identity with the token's other native guards."
                ),
            ),
        )


def lifetime_contract(root_name: str, cpp_type: str) -> dict[str, object]:
    if cpp_type.endswith("_definition_handle"):
        return {
            "policy": "transaction-owned",
            "guards": ["owner-token", "transaction-phase"],
        }
    if root_name == "ItemUseContext":
        return {
            "policy": "callback-borrowed",
            "guards": [
                "scope-lease",
                "active-flag",
                "noncopyable-nonmovable",
                "runtime-owner-identity",
                "runtime-generation",
                "world-generation",
            ],
        }
    if root_name == "GameHandle":
        return {
            "policy": "generation-checked-safe-reference",
            "guards": [
                "safe-reference",
                "runtime-owner-identity",
                "runtime-generation",
                "world-generation",
                "active-runtime-match",
            ],
        }
    if root_name == "ZoneToken":
        return {
            "policy": "generation-and-identity-checked-token",
            "guards": [
                "runtime-owner-identity",
                "runtime-generation",
                "world-generation",
                "native-lifetime-identity",
                "active-runtime-match",
            ],
        }
    if root_name == "MissionToken":
        return {
            "policy": "runtime-owner-and-generation-checked-token",
            "guards": [
                "runtime-owner-identity",
                "runtime-generation",
                "world-generation",
                "active-runtime-match",
                "native-token-resolution",
            ],
        }
    if root_name in {"HordeEntityToken", "LegacyHordeToken"}:
        return {
            "policy": "runtime-owner-and-identity-checked-token",
            "guards": [
                "runtime-owner-identity",
                "runtime-generation",
                "world-generation",
                "active-runtime-match",
                "native-entity-identity",
            ],
        }
    if root_name.endswith("Token"):
        return {
            "policy": "native-validated-token",
            "guards": ["native-token-resolution"],
        }
    return {"policy": "lua-owned-value", "guards": []}


def build_export_inventory() -> tuple[
    list[dict[str, object]],
    dict[str, object],
    list[dict[str, object]],
]:
    installers, edges, registrations_by_installer = build_installer_model()
    node_by_id = {str(node["id"]): node for node in installers}
    surface_paths: dict[str, dict[str, list[str]]] = {}
    export_surfaces: list[dict[str, object]] = []
    for surface_spec in EXPORT_SURFACES:
        surface_id = str(surface_spec["id"])
        paths = reachable_installer_paths(
            str(surface_spec["entrypoint"]), edges
        )
        surface_paths[surface_id] = paths
        roots = sorted(
            str(root)
            for installer_id in paths
            for root in node_by_id[installer_id]["direct_roots"]
        )
        export_surfaces.append({**surface_spec, "roots": roots})

    for edge in edges:
        edge["surfaces"] = sorted(
            surface_id
            for surface_id, paths in surface_paths.items()
            if all(
                (
                    str(edge["caller"]) in paths,
                    str(edge["callee"]) in paths,
                )
            )
        )

    roots: dict[str, dict[str, object]] = {}
    for installer_id, registrations in registrations_by_installer.items():
        installer = node_by_id[installer_id]
        for registration in registrations:
            root_name = str(registration["lua_name"])
            if root_name in roots:
                raise RuntimeError(
                    f"duplicate public usertype registration {root_name}"
                )
            installations: list[dict[str, object]] = []
            for surface_id, paths in surface_paths.items():
                if installer_id not in paths:
                    continue
                installations.append(
                    {
                        "surface": surface_id,
                        "namespace": installer["namespace"],
                        "installer_chain": paths[installer_id],
                    }
                )
            if not installations:
                raise RuntimeError(
                    f"registered export root {root_name} is unreachable"
                )
            source = registration["source"]
            if not isinstance(source, dict):
                raise RuntimeError(
                    f"registered export root {root_name} lacks source"
                )
            members = registration["members"]
            if not isinstance(members, list):
                raise RuntimeError(
                    f"registered export root {root_name} lacks members"
                )
            cpp_type = str(registration["cpp_type"])
            roots[root_name] = {
                "id": root_name,
                "cpp_type": cpp_type,
                "lua_name": root_name,
                "registration_name": registration["registration_name"],
                "registration": {
                    **source,
                    "installer": installer_id,
                    "namespace": installer["namespace"],
                },
                "surfaces": sorted(
                    str(entry["surface"]) for entry in installations
                ),
                "installations": installations,
                "lifetime": lifetime_contract(root_name, cpp_type),
                "member_disposition": {
                    "scope": (
                        "registered Lua members plus explicitly reviewed "
                        "native adaptations and exclusions"
                    ),
                    "members": members,
                },
            }
    add_reviewed_dispositions(roots)
    for root in roots.values():
        disposition = root["member_disposition"]
        assert isinstance(disposition, dict)
        members = disposition["members"]
        assert isinstance(members, list)
        members.sort(key=lambda entry: str(entry["id"]))

    graph = {
        "installers": installers,
        "edges": edges,
    }
    return export_surfaces, graph, [roots[name] for name in sorted(roots)]


def validate_export_contract(inventory: dict[str, object]) -> None:
    """Validate installation reachability and every member disposition."""
    graph = inventory.get("export_installation_graph")
    surfaces = inventory.get("export_surfaces")
    roots = inventory.get("export_roots")
    if not isinstance(graph, dict):
        raise RuntimeError("export installation graph must be an object")
    if not isinstance(surfaces, list) or not isinstance(roots, list):
        raise RuntimeError("export surfaces and roots must be arrays")
    installers = graph.get("installers")
    edges = graph.get("edges")
    if not isinstance(installers, list) or not isinstance(edges, list):
        raise RuntimeError("export installation graph arrays are missing")

    node_by_id: dict[str, dict[str, object]] = {}
    registration_owner: dict[str, str] = {}
    for node in installers:
        if not isinstance(node, dict) or not isinstance(node.get("id"), str):
            raise RuntimeError("export installer node is malformed")
        node_id = str(node["id"])
        if node_id in node_by_id:
            raise RuntimeError(f"duplicate export installer {node_id}")
        direct_roots = node.get("direct_roots")
        if not isinstance(direct_roots, list) or not all(
            isinstance(root, str) for root in direct_roots
        ):
            raise RuntimeError(
                f"installer {node_id} direct roots are malformed"
            )
        for root_name in direct_roots:
            if root_name in registration_owner:
                raise RuntimeError(
                    f"export root {root_name} has multiple registrations"
                )
            registration_owner[root_name] = node_id
        node_by_id[node_id] = node

    edge_pairs: set[tuple[str, str]] = set()
    for edge in edges:
        if not isinstance(edge, dict):
            raise RuntimeError("export installer edge is malformed")
        caller = edge.get("caller")
        callee = edge.get("callee")
        if caller not in node_by_id or callee not in node_by_id:
            raise RuntimeError(
                "export installer edge has unknown endpoint: "
                f"{caller} -> {callee}"
            )
        pair = str(caller), str(callee)
        if pair in edge_pairs:
            raise RuntimeError(f"duplicate export installer edge {pair}")
        edge_pairs.add(pair)

    expected_surface_roots: dict[str, set[str]] = {}
    surface_entrypoints: dict[str, str] = {}
    for surface in surfaces:
        if not isinstance(surface, dict):
            raise RuntimeError("export surface is malformed")
        surface_id = surface.get("id")
        entrypoint = surface.get("entrypoint")
        listed_roots = surface.get("roots")
        if not isinstance(surface_id, str) or entrypoint not in node_by_id:
            raise RuntimeError(
                "export surface identity or entrypoint is malformed"
            )
        if not isinstance(listed_roots, list) or not all(
            isinstance(root, str) for root in listed_roots
        ):
            raise RuntimeError(f"surface {surface_id} roots are malformed")
        if surface_id in expected_surface_roots:
            raise RuntimeError(f"duplicate export surface {surface_id}")
        paths = reachable_installer_paths(str(entrypoint), edges)
        reachable_roots = {
            str(root)
            for node_id in paths
            for root in node_by_id[node_id]["direct_roots"]
        }
        if set(listed_roots) != reachable_roots:
            missing = sorted(reachable_roots - set(listed_roots))
            extra = sorted(set(listed_roots) - reachable_roots)
            raise RuntimeError(
                f"{surface_id} installation root parity failed: "
                f"missing={missing}, extra={extra}"
            )
        expected_surface_roots[surface_id] = reachable_roots
        surface_entrypoints[surface_id] = str(entrypoint)

    root_by_name: dict[str, dict[str, object]] = {}
    for root in roots:
        if not isinstance(root, dict):
            raise RuntimeError("export root is malformed")
        root_name = root.get("lua_name")
        if not isinstance(root_name, str) or not root_name:
            raise RuntimeError("export root lacks a Lua name")
        if root_name in root_by_name:
            raise RuntimeError(f"duplicate export root {root_name}")
        if root.get("id") != root_name:
            raise RuntimeError(f"export root {root_name} has a stale id")
        if not isinstance(root.get("cpp_type"), str):
            raise RuntimeError(f"export root {root_name} lacks a C++ type")
        registration_name = root.get("registration_name")
        if not isinstance(registration_name, str) or not registration_name:
            raise RuntimeError(
                f"export root {root_name} lacks a registration name"
            )
        registration = root.get("registration")
        if not isinstance(registration, dict):
            raise RuntimeError(f"export root {root_name} lacks registration")
        registration_evidence_valid = all(
            (
                isinstance(registration.get("path"), str),
                isinstance(registration.get("line"), int),
                isinstance(registration.get("namespace"), str),
            )
        )
        if not registration_evidence_valid:
            raise RuntimeError(
                f"export root {root_name} registration evidence is malformed"
            )
        owner = registration_owner.get(root_name)
        if owner is None:
            raise RuntimeError(
                f"inventory export root is not registered: {root_name}"
            )
        if registration.get("installer") != owner:
            raise RuntimeError(
                f"export root {root_name} registration installer is stale"
            )
        lifetime = root.get("lifetime")
        lifetime_valid = isinstance(lifetime, dict)
        if lifetime_valid:
            lifetime_valid = all(
                (
                    isinstance(lifetime.get("policy"), str),
                    isinstance(lifetime.get("guards"), list),
                )
            )
        if lifetime_valid:
            lifetime_valid = all(
                isinstance(guard, str) and guard
                for guard in lifetime.get("guards", [])
            )
        if not lifetime_valid:
            raise RuntimeError(
                f"export root {root_name} lifetime contract is malformed"
            )
        disposition = root.get("member_disposition")
        if not isinstance(disposition, dict):
            raise RuntimeError(
                f"export root {root_name} lacks member disposition structure"
            )
        if not isinstance(disposition.get("scope"), str):
            raise RuntimeError(
                f"export root {root_name} lacks member disposition scope"
            )
        members = disposition.get("members")
        if not isinstance(members, list):
            raise RuntimeError(
                f"export root {root_name} lacks member dispositions"
            )
        member_ids: set[str] = set()
        for member in members:
            if not isinstance(member, dict) or not isinstance(
                member.get("id"), str
            ):
                raise RuntimeError(f"{root_name} member is malformed")
            member_id = str(member["id"])
            if member_id in member_ids:
                raise RuntimeError(
                    f"duplicate member disposition {root_name}.{member_id}"
                )
            member_ids.add(member_id)
            status = member.get("disposition")
            if status not in {"bound", "adapted", "unbound"}:
                raise RuntimeError(
                    f"{root_name}.{member_id} lacks a valid disposition"
                )
            cpp_members = member.get("cpp_members")
            if not isinstance(cpp_members, list) or not all(
                isinstance(name, str) and name for name in cpp_members
            ):
                raise RuntimeError(
                    f"{root_name}.{member_id} has malformed C++ members"
                )
            if not isinstance(member.get("cpp_kind"), str):
                raise RuntimeError(
                    f"{root_name}.{member_id} lacks a C++ member kind"
                )
            lua_access = member.get("lua_access")
            if not isinstance(lua_access, list) or not all(
                isinstance(path, str) and path for path in lua_access
            ):
                raise RuntimeError(
                    f"{root_name}.{member_id} has malformed Lua access"
                )
            evidence = member.get("evidence")
            if not isinstance(evidence, list) or not evidence:
                raise RuntimeError(
                    f"{root_name}.{member_id} lacks disposition evidence"
                )
            malformed_evidence = any(
                not isinstance(location, dict) for location in evidence
            )
            if not malformed_evidence:
                malformed_evidence = any(
                    not all(
                        (
                            isinstance(location.get("path"), str),
                            isinstance(location.get("line"), int),
                        )
                    )
                    for location in evidence
                )
            if malformed_evidence:
                raise RuntimeError(
                    f"{root_name}.{member_id} has malformed evidence"
                )
            if status in {"bound", "adapted"} and not lua_access:
                raise RuntimeError(
                    f"{root_name}.{member_id} {status} disposition "
                    "lacks Lua access"
                )
            if status == "unbound" and lua_access:
                raise RuntimeError(
                    f"{root_name}.{member_id} unbound disposition "
                    "exposes Lua access"
                )
            if status in {"adapted", "unbound"}:
                reason_code = member.get("reason_code")
                reason = member.get("reason")
                if not isinstance(reason_code, str) or not reason_code.strip():
                    raise RuntimeError(
                        f"{root_name}.{member_id} {status} disposition "
                        "lacks a reason code"
                    )
                if not isinstance(reason, str) or not reason.strip():
                    raise RuntimeError(
                        f"{root_name}.{member_id} {status} disposition "
                        "lacks a reason"
                    )

        installations = root.get("installations")
        if not isinstance(installations, list) or not installations:
            raise RuntimeError(f"export root {root_name} lacks installations")
        installed_surfaces: set[str] = set()
        for installation in installations:
            if not isinstance(installation, dict):
                raise RuntimeError(
                    f"export root {root_name} installation is malformed"
                )
            surface_id = installation.get("surface")
            chain = installation.get("installer_chain")
            if surface_id not in expected_surface_roots:
                raise RuntimeError(
                    f"export root {root_name} has unknown surface {surface_id}"
                )
            if installation.get("namespace") != registration.get("namespace"):
                raise RuntimeError(
                    f"export root {root_name} installation namespace is stale"
                )
            if not isinstance(chain, list) or not chain:
                raise RuntimeError(
                    f"export root {root_name} has an empty installer chain"
                )
            endpoints_match = all(
                (
                    chain[0] == surface_entrypoints[str(surface_id)],
                    chain[-1] == owner,
                )
            )
            if not endpoints_match:
                raise RuntimeError(
                    f"export root {root_name} installer chain endpoints "
                    "are stale"
                )
            if any(
                (str(caller), str(callee)) not in edge_pairs
                for caller, callee in zip(chain, chain[1:])
            ):
                raise RuntimeError(
                    f"export root {root_name} installer chain has a "
                    "missing edge"
                )
            installed_surfaces.add(str(surface_id))
        listed_surfaces = root.get("surfaces")
        surfaces_match = isinstance(listed_surfaces, list)
        if surfaces_match:
            surfaces_match = set(listed_surfaces) == installed_surfaces
        if not surfaces_match:
            raise RuntimeError(
                f"export root {root_name} surface disposition is stale"
            )
        expected = {
            surface_id
            for surface_id, surface_roots in expected_surface_roots.items()
            if root_name in surface_roots
        }
        if installed_surfaces != expected:
            raise RuntimeError(
                f"export root {root_name} installation surfaces are stale: "
                f"expected={sorted(expected)}, "
                f"actual={sorted(installed_surfaces)}"
            )
        root_by_name[root_name] = root

    missing_roots = sorted(set(registration_owner) - set(root_by_name))
    if missing_roots:
        raise RuntimeError(
            f"registered export roots missing from inventory: {missing_roots}"
        )


def validate_inventory_schema(
    inventory: dict[str, object], schema_path: Path = DEFAULT_SCHEMA
) -> None:
    schema = json.loads(schema_path.resolve().read_text(encoding="utf-8"))
    if not isinstance(schema, dict):
        raise RuntimeError(f"{schema_path} must contain a JSON object")
    errors = sorted(
        Draft202012Validator(schema).iter_errors(inventory),
        key=lambda error: list(error.absolute_path),
    )
    if errors:
        location = ".".join(str(part) for part in errors[0].absolute_path)
        suffix = f" at {location}" if location else ""
        raise RuntimeError(
            f"Platform native inventory does not conform to {schema_path}"
            f"{suffix}: {errors[0].message}"
        )


def build_native_inventory(
    schema_path: Path = DEFAULT_SCHEMA,
) -> dict[str, object]:
    export_surfaces, installation_graph, export_roots = (
        build_export_inventory()
    )
    inventory = {
        "schema_version": 2,
        "source": {
            "project": "Cataclysm-Cleanwater-Bomb",
            "id_registry": "src/lua_platform_bindings_values.cpp",
            "json_registry": "src/init.cpp",
            "event_registry": "src/event.h",
            "export_registry": "src/lua_platform*.cpp",
        },
        "id_kinds": parse_id_kinds(
            source_text("src/lua_platform_bindings_values.cpp")
        ),
        "json_types": parse_json_types(source_text("src/init.cpp")),
        "event_types": parse_event_types(source_text("src/event.h")),
        "native_domains": [
            {"id": domain, "requirement": requirement}
            for domain, requirement in NATIVE_DOMAINS
        ],
        "export_surfaces": export_surfaces,
        "export_installation_graph": installation_graph,
        "export_roots": export_roots,
    }
    validate_export_contract(inventory)
    validate_inventory_schema(inventory, schema_path)
    return inventory


def inline_object(entry: dict[str, object]) -> str:
    fields = (
        f"{json.dumps(key, ensure_ascii=False)}: "
        f"{json.dumps(value, ensure_ascii=False)}"
        for key, value in entry.items()
    )
    return "{ " + ", ".join(fields) + " }"


def append_named_json(
    lines: list[str], name: str, value: object, comma: bool
) -> None:
    encoded = json.dumps(value, ensure_ascii=False, indent=2).splitlines()
    lines.append(f'  {json.dumps(name)}: {encoded[0]}')
    lines.extend(f"  {line}" for line in encoded[1:])
    if comma:
        lines[-1] += ","


def serialize_native_inventory(inventory: dict[str, object]) -> str:
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

    compact_arrays = (
        "id_kinds",
        "json_types",
        "event_types",
        "native_domains",
    )
    for name in compact_arrays:
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
        lines.append("  ],")

    nested_names = (
        "export_surfaces",
        "export_installation_graph",
        "export_roots",
    )
    for index, name in enumerate(nested_names):
        append_named_json(
            lines,
            name,
            inventory[name],
            comma=index + 1 < len(nested_names),
        )
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
    parser.add_argument(
        "--check",
        action="store_true",
        help="check the destination without writing it",
    )
    parser.add_argument(
        "--schema",
        type=Path,
        default=DEFAULT_SCHEMA,
        help="Platform native inventory schema",
    )
    arguments = parser.parse_args()
    expected = serialize_native_inventory(
        build_native_inventory(arguments.schema)
    )
    if arguments.check:
        if not arguments.output.exists():
            raise SystemExit(
                f"missing Platform native inventory: {arguments.output}"
            )
        actual = arguments.output.read_text(encoding="utf-8")
        if actual != expected:
            raise SystemExit(
                f"stale Platform native inventory: {arguments.output}"
            )
        return 0
    arguments.output.parent.mkdir(parents=True, exist_ok=True)
    arguments.output.write_text(expected, encoding="utf-8")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
