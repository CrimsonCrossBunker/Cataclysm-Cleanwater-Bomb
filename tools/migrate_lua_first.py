#!/usr/bin/env python3
"""Extract legacy CCB content into auditable Lua-first Platform source.

The tool never emits JSON loaders, EOC activation calls, or raw legacy
objects.  It translates every implemented native Platform content slice and
simple Lua control flow, then records every unresolved semantic field as a
TODO.
"""

from __future__ import annotations

import argparse
import copy
import functools
import json
import math
import os
import re
import shutil
import struct
import sys
import tempfile
import unicodedata
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any, Iterable

from generate_builtin_mods import strip_jsonc_comments, strip_trailing_commas


ITEM_TYPES = {
    "ITEM",
    "GENERIC",
    "ARMOR",
    "TOOL",
    "PET_ARMOR",
    "GUN",
    "GUNMOD",
    "AMMO",
    "MAGAZINE",
    "COMESTIBLE",
    "BOOK",
    "BIONIC_ITEM",
    "TOOLMOD",
    "ENGINE",
    "WHEEL",
    "SEED",
    "BREWABLE",
    "COMPOSTABLE",
    "MILLING",
    "ARTIFACT",
}
EOC_TYPES = {"effect_on_condition"}
RECIPE_TYPES = {"recipe", "uncraft", "practice"}
COMMON_ITEM_FIELDS = {
    "type",
    "id",
    "abstract",
    "copy-from",
    "name",
    "description",
    "symbol",
    "weight",
    "volume",
    "price",
    "material",
    "qualities",
    "flags",
}
COMMON_RECIPE_FIELDS = {
    "type",
    "id",
    "result",
    "category",
    "subcategory",
    "skill_used",
    "difficulty",
    "time",
    "autolearn",
    "reversible",
    "components",
    "tools",
    "skills_required",
    "using",
}
NATIVE_INT_MIN = -(1 << 31)
NATIVE_INT_MAX = (1 << 31) - 1
NATIVE_INT64_MAX = (1 << 63) - 1
NATIVE_MASS_GRAMS_MAX = NATIVE_INT64_MAX // 1000
NATIVE_FLOAT_MAX = float.fromhex("0x1.fffffep+127")
PLATFORM_ID_MAX_BYTES = 256
WOUND_NAME_MAX_BYTES = 1024
WOUND_DESCRIPTION_MAX_BYTES = 32768
MAX_EFFECT_DURATION_TURNS = 365 * 24 * 60 * 60
MAX_ACTIVITY_DURATION_TURNS = 2147483647 // 100
NATIVE_MAX_EFFECT_INTENSITY = 1000
MAX_CHARACTER_DAMAGE = 1000000.0
MAX_CHARACTER_DAMAGE_MULTIPLIER = 1000.0
MAX_CHARACTER_HIT_OPTION = 1000000
MAX_CHARACTER_PART_TEMPERATURE = 1000000.0
MAX_MUTATION_RANDOM_CHANCE = 1000000
NATIVE_MAX_SKILL = 10
REPOSITORY_ROOT = Path(__file__).resolve().parents[1]
EXPECTED_GAME_START_SENDER_SITES = (("src/game.cpp", "send"),)
# These native item-event contracts always name the legacy alpha/u Character
# as `actors.character`.  An item talker is optional because ordinary event
# sends do not carry the positional talker used by send_with_talker().  Keep
# this allowlist closed so unrelated events and dialogue contexts never gain
# an inferred legacy actor.
PROVEN_ITEM_ACTOR_EVENTS = frozenset({
    "character_wields_item",
    "character_wears_item",
    "character_takeoff_item",
    "character_armor_destroyed",
})

EMIT_REPLACE_CONTENT = False

REGIONAL_INHERITANCE_LABELS = {
    "region_settings_ravine": "region settings ravine",
    "region_settings_lake": "region settings lake",
    "region_settings_ocean": "region settings ocean",
    "region_settings_forest": "region settings forest",
    "region_settings_river": "region settings river",
    "region_settings_forest_mapgen": "region settings forest mapgen",
    "region_settings_map_extras": "region settings map extras",
    "region_settings_terrain_furniture": "region settings terrain furniture",
    "region_settings_forest_trail": "region settings forest trail",
    "region_settings_highway": "region settings highway",
    "region_settings": "region settings",
    "region_settings_city": "region settings city",
    "region_terrain_furniture": "region terrain furniture",
    "forest_biome_component": "forest biome component",
    "forest_biome_mapgen": "forest biome mapgen",
}

# Only members loaded through a container reader support legacy extend/delete.
# Other regional members are scalar, fixed-size, or use a reader that replaces
# the complete value.  Keep this table closed so the migration tool never
# guesses that an unsupported legacy patch was applied.
REGIONAL_INHERITANCE_CONTAINER_FIELDS = {
    "region_settings_ravine": frozenset(),
    "region_settings_lake": frozenset({"shore_extendable_overmap_terrain"}),
    "region_settings_ocean": frozenset(),
    "region_settings_forest": frozenset(),
    "region_settings_river": frozenset(),
    "region_settings_forest_mapgen": frozenset({"biomes"}),
    "region_settings_map_extras": frozenset({"extras"}),
    "region_settings_terrain_furniture": frozenset({"ter_furn"}),
    "region_settings_forest_trail": frozenset({"trailheads"}),
    "region_settings_highway": frozenset({
        "four_way_intersections", "three_way_intersections", "bends",
        "road_connections", "interchanges",
    }),
    "region_settings": frozenset({"default_groundcover"}),
    "region_settings_city": frozenset({"houses", "shops", "parks"}),
    "region_terrain_furniture": frozenset({
        "replace_with_terrain", "replace_with_furniture",
    }),
    "forest_biome_component": frozenset({"types"}),
    "forest_biome_mapgen": frozenset({"terrains", "components", "groundcover"}),
}

REGIONAL_INHERITANCE_WEIGHTED_FIELDS = {
    "region_settings_forest_trail": frozenset({"trailheads"}),
    "region_settings_highway": frozenset({
        "four_way_intersections", "three_way_intersections", "bends",
        "road_connections", "interchanges",
    }),
    "region_settings": frozenset({"default_groundcover"}),
    "region_settings_city": frozenset({"houses", "shops", "parks"}),
    "region_terrain_furniture": frozenset({
        "replace_with_terrain", "replace_with_furniture",
    }),
    "forest_biome_component": frozenset({"types"}),
    "forest_biome_mapgen": frozenset({"groundcover"}),
}

REGIONAL_INHERITANCE_NESTED_FIELDS = {
    "region_settings": frozenset({"feature_flag_settings", "connections"}),
}

PROVEN_NPC_ACTOR_EVENTS = frozenset({
    "npc_becomes_hostile",
})


@functools.lru_cache(maxsize=1)
def game_start_sender_sites() -> tuple[tuple[str, str], ...]:
    """Find canonical game-start construction sites without entering caches."""
    sites: list[tuple[str, str]] = []
    source_root = REPOSITORY_ROOT / "src"
    for suffix in ("*.cpp", "*.h"):
        for path in sorted(source_root.glob(suffix)):
            text = path.read_text(encoding="utf-8")
            for kind in ("send", "make"):
                pattern = rf"\b{kind}\s*<\s*event_type::game_start\s*>"
                sites.extend(
                    (path.relative_to(REPOSITORY_ROOT).as_posix(), kind)
                    for _ in re.finditer(pattern, text)
                )
    return tuple(sorted(sites))


def game_start_avatar_actor_is_proven() -> bool:
    """Fail closed if the reviewed canonical sender set ever changes."""
    return game_start_sender_sites() == EXPECTED_GAME_START_SENDER_SITES


def render_static_item_fault_effect(
    effect: dict[str, Any],
    key: str,
) -> list[str] | None:
    """Render the bounded item-event form of a native fault mutation.

    The legacy handler receives the item through the item-event actor and the
    owning Character through the same event's character actor.  Only literal
    fault/type strings and literal force/message flags are safe to lower; all
    variable-backed shapes remain explicit migration TODOs.
    """
    if set(effect) - {key, "force", "message"}:
        return None
    raw_value = effect.get(key)
    if (
        not isinstance(raw_value, str) or
        not safe_platform_id(raw_value) or
        not bounded_utf8_string(raw_value, PLATFORM_ID_MAX_BYTES)
    ):
        return None
    force = effect.get("force", False)
    message = effect.get("message", True)
    if not isinstance(force, bool) or not isinstance(message, bool):
        return None
    options: list[str] = ["holder = actor"]
    if force:
        options.append("force = true")
    if not message:
        options.append("message = false")
        options = [option for option in options if option != "holder = actor"]
    return [
        "    if context.actors.item ~= nil then",
        f"        services.items.{ 'set_fault' if key in {'npc_set_fault', 'u_set_fault'} else 'set_random_fault' }(",
        "            context.actors.item,",
        f"            {lua_quote(raw_value)}," if key in {"npc_set_random_fault_of_type", "u_set_random_fault_of_type"} else
        "            services.types.id(\"fault\", " + lua_quote(raw_value) + "),",
        "            { " + ", ".join(options) + " })" if options else
        "            {})",
        "    end",
    ]


def render_static_item_activation_effect(
    effect: dict[str, Any],
    key: str,
) -> list[str] | None:
    """Render an explicit item use method for a proven item event.

    The native EOC handler may resolve a method from dialogue/context
    variables and may open an interactive picker when the method is empty.
    Platform callbacks are deliberately non-interactive, so only a bounded
    literal method with no dynamic target is lowered here.
    """
    if set(effect) != {key}:
        return None
    method = effect.get(key)
    if not isinstance(method, str) or not safe_platform_id(method):
        return None
    if not bounded_utf8_string(method, PLATFORM_ID_MAX_BYTES):
        return None
    return [
        "    if context.actors.item ~= nil and actor ~= nil then",
        "        services.items.activate(",
        "            context.actors.item, actor, " + lua_quote(method) + ")",
        "    end",
    ]


def render_static_light_override(effect: dict[str, Any]) -> list[str] | None:
    """Render the finite literal custom-light timed-event shape."""
    if set(effect) - {"custom_light_level", "length", "key"}:
        return None
    if "length" not in effect:
        return None
    level = effect.get("custom_light_level")
    if (
        not isinstance(level, int) or isinstance(level, bool) or
        not 0 <= level <= 125
    ):
        return None
    duration = parse_turns(effect.get("length"))
    if duration is None or not 0 <= duration <= 31536000:
        return None
    key = effect.get("key", "")
    if not bounded_utf8_string(key, PLATFORM_ID_MAX_BYTES, allow_empty=True):
        return None
    call = [
        "    services.gameplay.environment.set_light_override(",
        f"        {level}, services.time.duration({duration}, \"turn\")",
    ]
    if key:
        call[-1] += f", {lua_quote(key)})"
    else:
        call[-1] += ")"
    return call


def lua_boolean(value: bool) -> str:
    return "true" if value else "false"


def content_submit_expression() -> str:
    return "content.replace(definition)" if EMIT_REPLACE_CONTENT else \
        "content.add(definition)"


def lua_quote(value: str) -> str:
    escapes = {
        "\\": "\\\\",
        '"': '\\"',
        "\a": "\\a",
        "\b": "\\b",
        "\f": "\\f",
        "\n": "\\n",
        "\r": "\\r",
        "\t": "\\t",
        "\v": "\\v",
    }
    escaped: list[str] = []
    for character in value:
        if character in escapes:
            escaped.append(escapes[character])
        elif ord(character) < 32 or ord(character) == 127:
            escaped.append(f"\\{ord(character):03d}")
        else:
            escaped.append(character)
    return '"' + "".join(escaped) + '"'


def lua_number(value: int | float) -> str:
    if isinstance(value, int):
        return str(value)
    return format(value, ".17g")


def finite_number_literal(value: Any) -> int | float | None:
    if not isinstance(value, (int, float)) or isinstance(value, bool):
        return None
    try:
        if math.isfinite(float(value)):
            return value
    except (OverflowError, ValueError):
        pass
    return None


def positive_native_float_literal(value: Any) -> int | float | None:
    """Return a literal that remains positive after the native float cast."""
    literal = finite_number_literal(value)
    if literal is None:
        return None
    converted = float(literal)
    if converted <= 0.0 or converted > NATIVE_FLOAT_MAX:
        return None
    try:
        native = struct.unpack("=f", struct.pack("=f", converted))[0]
    except (OverflowError, struct.error):
        return None
    return literal if math.isfinite(native) and native > 0.0 else None


def display_text(value: Any, fallback: str = "") -> str:
    if isinstance(value, str):
        return value
    if isinstance(value, dict):
        text = value.get("str")
        if isinstance(text, str):
            return text
    return fallback


def parse_integral_unit(value: Any, units: dict[str, float]) -> int | None:
    if isinstance(value, int) and not isinstance(value, bool):
        return value
    if not isinstance(value, str):
        return None
    match = re.fullmatch(r"\s*([+-]?\d+(?:\.\d+)?)\s*([A-Za-z]+)\s*", value)
    if match is None or match.group(2).lower() not in units:
        return None
    converted = float(match.group(1)) * units[match.group(2).lower()]
    return int(converted) if converted.is_integer() else None


def parse_moves(value: Any) -> int | None:
    return parse_integral_unit(
        value,
        {
            "move": 1,
            "moves": 1,
            "s": 100,
            "sec": 100,
            "second": 100,
            "seconds": 100,
            "m": 6000,
            "min": 6000,
            "minute": 6000,
            "minutes": 6000,
            "h": 360000,
            "hour": 360000,
            "hours": 360000,
        },
    )


def parse_seconds(value: Any) -> int | None:
    return parse_integral_unit(
        value,
        {
            "s": 1,
            "sec": 1,
            "second": 1,
            "seconds": 1,
            "m": 60,
            "min": 60,
            "minute": 60,
            "minutes": 60,
            "h": 3600,
            "hour": 3600,
            "hours": 3600,
        },
    )


def parse_turns(value: Any) -> int | None:    return parse_integral_unit(
        value,
        {
            "turn": 1,
            "turns": 1,
            "s": 1,
            "sec": 1,
            "second": 1,
            "seconds": 1,
            "m": 60,
            "min": 60,
            "minute": 60,
            "minutes": 60,
            "h": 3600,
            "hour": 3600,
            "hours": 3600,
            "d": 86400,
            "day": 86400,
            "days": 86400,
        },
    )


def parse_vitamin_micrograms(value: Any) -> int | None:
    if not isinstance(value, str):
        return None
    tokens = re.findall(r"([+-]?\d+(?:\.\d+)?)\s*(ug|μg|mcg|mg|g)", value)
    if not tokens:
        return None
    without_tokens = re.sub(
        r"([+-]?\d+(?:\.\d+)?)\s*(ug|μg|mcg|mg|g)", "", value
    )
    if without_tokens.strip():
        return None
    scales = {"ug": 1.0, "μg": 1.0, "mcg": 1.0, "mg": 1000.0, "g": 1000000.0}
    total = sum(float(amount) * scales[unit] for amount, unit in tokens)
    return int(total) if total.is_integer() else None


def stable_id(value: dict[str, Any], fallback: str) -> str:
    for key in ("id", "abstract", "result"):
        candidate = value.get(key)
        if isinstance(candidate, str) and candidate:
            return candidate
    return fallback


def safe_platform_id(value: Any) -> bool:
    return (
        isinstance(value, str) and
        bool(value) and
        "#" not in value and
        "\0" not in value
    )


def bounded_utf8_string(
    value: Any, maximum: int, *, allow_empty: bool = False
) -> bool:
    if (
        not isinstance(value, str) or
        (not allow_empty and not value) or
        "\0" in value
    ):
        return False
    try:
        length = len(value.encode("utf-8"))
    except UnicodeEncodeError:
        return False
    return (allow_empty or length > 0) and length <= maximum


def bounded_platform_id(value: Any) -> bool:
    return (
        safe_platform_id(value) and
        bounded_utf8_string(value, PLATFORM_ID_MAX_BYTES)
    )


@dataclass(frozen=True)
class SourceObject:
    path: Path
    index: int
    value: dict[str, Any]

    @property
    def location(self) -> str:
        return f"{self.path.as_posix()}#{self.index}"


@dataclass
class MigrationResult:
    files: dict[Path, str] = field(default_factory=dict)
    converted: list[str] = field(default_factory=list)
    partial: list[str] = field(default_factory=list)
    todos: list[str] = field(default_factory=list)


def render_mod_definition(
    source: SourceObject, result: MigrationResult, mod_id: str
) -> str:
    value = source.value
    complete = True
    raw_id = value.get("id")
    if (
        not safe_platform_id(raw_id) or
        len(raw_id.encode("utf-8")) > 256 or
        raw_id != mod_id
    ):
        complete = False
        result.todos.append(
            f"{source.location}: MOD_INFO id {raw_id!r} does not match the resolved Platform id {mod_id!r}"
        )

    lines = [
        'local ccb = require("ccb")',
        "",
        "return ccb.ModDefinition {",
        f"    id = {lua_quote(mod_id)},",
    ]

    if "name" in value:
        name = value["name"]
        if (
            isinstance(name, str) and
            0 < len(name.encode("utf-8")) <= 512 and
            "\0" not in name
        ):
            lines.append(f"    name = {lua_quote(name)},")
        else:
            complete = False
            result.todos.append(
                f"{source.location}: MOD_INFO name needs a bounded plain-string conversion"
            )
    else:
        complete = False
        result.todos.append(
            f"{source.location}: MOD_INFO without a plain name has different legacy fallback presentation"
        )

    if "version" in value:
        version = value["version"]
        if (
            isinstance(version, str) and
            0 < len(version.encode("utf-8")) <= 128 and
            "\0" not in version
        ):
            lines.append(f"    version = {lua_quote(version)},")
        else:
            complete = False
            result.todos.append(
                f"{source.location}: MOD_INFO version needs a bounded string conversion"
            )

    if "dependencies" in value:
        dependencies = value["dependencies"]
        valid_dependencies = (
            isinstance(dependencies, list) and
            len(dependencies) <= 256 and
            all(
                safe_platform_id(dependency) and
                len(dependency.encode("utf-8")) <= 256
                for dependency in dependencies
            ) and
            len(set(dependencies)) == len(dependencies) and
            mod_id not in dependencies
        )
        if valid_dependencies:
            rendered = ", ".join(lua_quote(value) for value in dependencies)
            lines.append(f"    dependencies = {{ {rendered} }},")
        else:
            complete = False
            result.todos.append(
                f"{source.location}: MOD_INFO dependencies need a unique bounded string-array conversion"
            )

    if "core" in value:
        core = value["core"]
        if isinstance(core, bool):
            lines.append(f"    core = {'true' if core else 'false'},")
        else:
            complete = False
            result.todos.append(
                f"{source.location}: MOD_INFO core must be a boolean"
            )

    unresolved = sorted(
        set(value) - {"type", "id", "name", "version", "dependencies", "core"}
    )
    if unresolved:
        complete = False
        result.todos.append(
            f"{source.location}: MOD_INFO unresolved fields: {', '.join(unresolved)}"
        )

    label = f"{source.location}: MOD_INFO {raw_id or '<invalid id>'}"
    if complete:
        result.converted.append(label)
    else:
        result.partial.append(label)
    lines.extend(("}", ""))
    return "\n".join(lines)


def iter_json_files(inputs: Iterable[Path]) -> list[Path]:
    files: set[Path] = set()
    ignored_directories = {".git", ".gradle", "build", "obj-lua"}
    for requested in inputs:
        path = requested.resolve()
        if path.is_dir():
            for directory, children, names in os.walk(path, followlinks=False):
                children[:] = sorted(
                    child
                    for child in children
                    if child not in ignored_directories
                )
                base = Path(directory)
                files.update(
                    base / name for name in names if name.endswith(".json")
                )
        elif path.is_file():
            files.add(path)
        else:
            raise ValueError(f"input does not exist: {requested}")
    return sorted(files)


def load_objects(inputs: Iterable[Path]) -> list[SourceObject]:
    objects: list[SourceObject] = []
    for path in iter_json_files(inputs):
        try:
            document = json.loads(
                strip_trailing_commas(
                    strip_jsonc_comments(path.read_text(encoding="utf-8"))
                )
            )
        except (OSError, UnicodeError, json.JSONDecodeError) as error:
            raise ValueError(f"cannot read {path}: {error}") from error
        values = document if isinstance(document, list) else [document]
        for index, value in enumerate(values):
            if not isinstance(value, dict):
                raise ValueError(f"{path}#{index} is not an object")
            objects.append(SourceObject(path, index, value))
    return objects


def render_materials(lines: list[str], raw: Any, todos: list[str], location: str) -> None:
    values = raw if isinstance(raw, list) else [raw]
    for entry in values:
        if isinstance(entry, str) and entry:
            lines.append(f"definition:material({lua_quote(entry)}, 1)")
        elif (
            isinstance(entry, list) and
            len(entry) == 2 and
            isinstance(entry[0], str) and
            bool(entry[0]) and
            isinstance(entry[1], int) and
            not isinstance(entry[1], bool) and
            entry[1] > 0 and
            entry[1] <= NATIVE_INT_MAX
        ):
            lines.append(f"definition:material({lua_quote(entry[0])}, {entry[1]})")
        else:
            todos.append(f"{location}: item material entry needs manual conversion")


def render_pairs(
    lines: list[str], raw: Any, method: str, todos: list[str], location: str
) -> None:
    if not isinstance(raw, list):
        todos.append(f"{location}: {method} must be reviewed manually")
        return
    for entry in raw:
        if (
            isinstance(entry, list) and
            len(entry) >= 2 and
            isinstance(entry[0], str) and
            bool(entry[0]) and
            isinstance(entry[1], int) and
            not isinstance(entry[1], bool) and
            0 < entry[1] <= NATIVE_INT_MAX
        ):
            lines.append(f"definition:{method}({lua_quote(entry[0])}, {entry[1]})")
        else:
            todos.append(f"{location}: malformed {method} entry needs manual conversion")


def render_item(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    item_id = stable_id(value, f"todo_item_{source.index}")
    if not isinstance(value.get("id"), str) or not value["id"]:
        result.partial.append(f"{source.location}: item {item_id}")
        result.todos.append(
            f"{source.location}: item {item_id} has no concrete stable id"
        )
        if "copy-from" in value or "abstract" in value:
            result.todos.append(
                f"{source.location}: item {item_id} inheritance must become a Lua constructor/composition function"
            )
        return None
    if not safe_platform_id(value["id"]):
        result.partial.append(f"{source.location}: item {item_id}")
        result.todos.append(
            f"{source.location}: item {item_id} is not a safe native Platform id"
        )
        return None
    todo_count = len(result.todos)
    item_kind = value.get("type")
    forced_partial = False
    if item_kind not in {"ITEM", "GENERIC"}:
        result.todos.append(
            f"{source.location}: item {item_id} keeps only shared fields; "
            f"the {item_kind} subtype needs a native Platform registrar"
        )
        forced_partial = True
    if "copy-from" in value or "abstract" in value:
        result.todos.append(
            f"{source.location}: item {item_id} inheritance must become a Lua constructor/composition function"
        )
        forced_partial = True
        if "id" not in value:
            return None
    name = display_text(value.get("name"), item_id)
    description = display_text(value.get("description"), "")
    symbol = value.get("symbol") if isinstance(value.get("symbol"), str) else "?"
    if not name:
        name = item_id
        result.todos.append(
            f"{source.location}: item {item_id} name cannot be empty"
        )
    if not symbol:
        symbol = "?"
        result.todos.append(
            f"{source.location}: item {item_id} symbol cannot be empty"
        )
    for field_name in ("name", "description"):
        raw_text = value.get(field_name)
        if isinstance(raw_text, dict) and (
            set(raw_text) != {"str"} or not isinstance(raw_text.get("str"), str)
        ):
            result.todos.append(
                f"{source.location}: item {item_id} {field_name} translation metadata needs review"
            )
        elif field_name in value and not isinstance(raw_text, (str, dict)):
            result.todos.append(
                f"{source.location}: item {item_id} {field_name} needs review"
            )
    if "symbol" in value and not isinstance(value["symbol"], str):
        result.todos.append(
            f"{source.location}: item {item_id} symbol needs review"
        )
    lines = [
        "local definition = content.Item {",
        f"    id = {lua_quote(item_id)},",
        f"    name = {lua_quote(name)},",
        f"    description = {lua_quote(description)},",
        f"    symbol = {lua_quote(symbol)},",
        "}",
    ]
    weight = parse_integral_unit(value.get("weight"), {"mg": 0.001, "g": 1, "kg": 1000})
    if "weight" in value:
        if weight is None or not 0 <= weight <= NATIVE_MASS_GRAMS_MAX:
            result.todos.append(f"{source.location}: item {item_id} weight needs unit review")
        else:
            lines.append(f"definition:mass_grams({weight})")
    volume = parse_integral_unit(value.get("volume"), {"ml": 1, "l": 1000})
    if "volume" in value:
        if volume is None or not 0 <= volume <= NATIVE_INT_MAX:
            result.todos.append(f"{source.location}: item {item_id} volume needs unit review")
        else:
            lines.append(f"definition:volume_ml({volume})")
    price = value.get("price")
    if (
        isinstance(price, int) and
        not isinstance(price, bool) and
        0 <= price <= NATIVE_INT_MAX
    ):
        lines.append(f"definition:price_cents({price})")
    elif "price" in value:
        result.todos.append(f"{source.location}: item {item_id} price needs unit review")
    if "material" in value:
        render_materials(lines, value["material"], result.todos, source.location)
    if "qualities" in value:
        render_pairs(lines, value["qualities"], "quality", result.todos, source.location)
    flags = value.get("flags", [])
    if isinstance(flags, list) and all(
        isinstance(entry, str) and bool(entry) for entry in flags
    ):
        for flag_name in flags:
            lines.append(f"definition:flag({lua_quote(flag_name)})")
    elif "flags" in value:
        result.todos.append(f"{source.location}: item {item_id} flags need manual conversion")
    unresolved = sorted(set(value) - COMMON_ITEM_FIELDS)
    if unresolved or forced_partial or len(result.todos) != todo_count:
        result.partial.append(f"{source.location}: item {item_id}")
        if unresolved:
            result.todos.append(
                f"{source.location}: item {item_id} unresolved fields: {', '.join(unresolved)}"
            )
    else:
        result.converted.append(f"{source.location}: item {item_id}")
    lines.extend((content_submit_expression(), ""))
    return "\n".join(lines)


def requirement_choices(raw: Any, *, tools: bool = False) -> list[tuple[str, int]] | None:
    if not isinstance(raw, list):
        return None
    result: list[tuple[str, int]] = []
    for entry in raw:
        if (
            not isinstance(entry, list) or
            len(entry) < 2 or
            not isinstance(entry[0], str) or
            not entry[0] or
            not isinstance(entry[1], int) or
            isinstance(entry[1], bool) or
            entry[1] == 0 or
            abs(entry[1]) > NATIVE_INT_MAX or
            (entry[1] < 0 and not tools)
        ):
            return None
        result.append((entry[0], entry[1]))
    return result or None


def render_requirement_groups(
    lines: list[str], raw: Any, singular: str, alternatives: str,
    todos: list[str], location: str, *, tools: bool = False, owner: str = "recipe"
) -> None:
    if not isinstance(raw, list):
        todos.append(f"{location}: {owner} {singular} requirements need manual conversion")
        return
    for group in raw:
        choices = requirement_choices(group, tools=tools)
        if choices is None:
            todos.append(f"{location}: {owner} {singular} group needs manual conversion")
        elif len(choices) == 1:
            item_id, count = choices[0]
            if tools and count > 0:
                lines.append(f"definition:tool_charges({lua_quote(item_id)}, {count})")
            else:
                lines.append(
                    f"definition:{singular}({lua_quote(item_id)}, {abs(count)})"
                )
        else:
            rendered = ", ".join(
                (
                    f"{{ id = {lua_quote(item_id)}, charges = {count} }}"
                    if tools and count > 0
                    else f"{{ id = {lua_quote(item_id)}, count = {abs(count)} }}"
                )
                for item_id, count in choices
            )
            lines.append(f"definition:{alternatives} {{ {rendered} }}")


def render_recipe(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    recipe_id = stable_id(value, f"todo_recipe_{source.index}")
    todo_count = len(result.todos)
    forced_partial = False
    if "copy-from" in value or "abstract" in value:
        result.todos.append(
            f"{source.location}: recipe {recipe_id} inheritance must become a Lua constructor/composition function"
        )
        forced_partial = True
    product = value.get("result")
    if not safe_platform_id(product):
        result.todos.append(f"{source.location}: recipe {recipe_id} has no stable result")
        result.partial.append(f"{source.location}: recipe {recipe_id}")
        return None
    if not safe_platform_id(recipe_id):
        result.todos.append(
            f"{source.location}: recipe {recipe_id} is not a safe native Platform id"
        )
        result.partial.append(f"{source.location}: recipe {recipe_id}")
        return None
    if value.get("type") == "uncraft":
        result.todos.append(
            f"{source.location}: uncraft {recipe_id} native disassembly registration is bounded"
        )
    category = value.get("category", "CC_MISC")
    subcategory = value.get("subcategory", "CSC_MISC")
    if (
        not isinstance(category, str) or
        not category or
        not isinstance(subcategory, str) or
        not subcategory
    ):
        result.todos.append(
            f"{source.location}: recipe {recipe_id} category ids need review"
        )
        category = "CC_MISC"
        subcategory = "CSC_MISC"
    lines = [
        "local definition = content.Recipe {",
        f"    id = {lua_quote(recipe_id)},",
        f"    result = {lua_quote(product)},",
        f"    category = {lua_quote(category)},",
        f"    subcategory = {lua_quote(subcategory)},",
    ]
    if value.get("type") == "practice":
        lines.append("    practice = true,")
        for member in ("practice_data", "book_learn", "proficiencies"):
            if member in value:
                result.todos.append(
                    f"{source.location}: practice {recipe_id} {member} needs review"
                )
    elif value.get("type") == "uncraft":
        lines.append("    uncraft = true,")
    skill = value.get("skill_used")
    if isinstance(skill, str) and skill:
        lines.append(f"    skill = {lua_quote(skill)},")
    elif "skill_used" in value and skill not in (None, ""):
        result.todos.append(
            f"{source.location}: recipe {recipe_id} primary skill needs review"
        )
    difficulty = value.get("difficulty", 0)
    if (
        isinstance(difficulty, int) and
        not isinstance(difficulty, bool) and
        0 <= difficulty <= NATIVE_MAX_SKILL
    ):
        lines.append(f"    difficulty = {difficulty},")
    else:
        lines.append("    difficulty = 0,")
        result.todos.append(f"{source.location}: recipe {recipe_id} difficulty needs review")
    duration = parse_moves(value.get("time", 100))
    if duration is None or not 0 < duration <= NATIVE_INT64_MAX:
        duration = 100
        result.todos.append(f"{source.location}: recipe {recipe_id} time needs unit review")
    lines.append(f"    duration_moves = {duration},")
    autolearn = value.get("autolearn", True)
    if isinstance(autolearn, bool):
        lines.append(f"    autolearn = {'true' if autolearn else 'false'},")
    else:
        lines.append("    autolearn = false,")
        result.todos.append(f"{source.location}: recipe {recipe_id} conditional autolearn needs Lua logic")
    reversible = value.get("reversible", False)
    if not isinstance(reversible, bool):
        result.todos.append(
            f"{source.location}: recipe {recipe_id} reversible flag needs review"
        )
        reversible = False
    lines.extend((f"    reversible = {'true' if reversible else 'false'},", "}"))
    render_requirement_groups(
        lines, value.get("components", []), "component", "component_any",
        result.todos, source.location
    )
    render_requirement_groups(
        lines, value.get("tools", []), "tool", "tool_any",
        result.todos, source.location, tools=True
    )
    skills = value.get("skills_required", [])
    if isinstance(skills, list):
        for entry in skills:
            if (
                isinstance(entry, list) and
                len(entry) >= 2 and
                isinstance(entry[0], str) and
                bool(entry[0]) and
                isinstance(entry[1], int) and
                not isinstance(entry[1], bool) and
                0 <= entry[1] <= NATIVE_MAX_SKILL
            ):
                lines.append(f"definition:requires_skill({lua_quote(entry[0])}, {entry[1]})")
            else:
                result.todos.append(f"{source.location}: recipe {recipe_id} required skill needs review")
    else:
        result.todos.append(
            f"{source.location}: recipe {recipe_id} required skills need review"
        )
    external = value.get("using", [])
    if isinstance(external, list):
        for entry in external:
            if (
                isinstance(entry, list) and
                len(entry) == 2 and
                safe_platform_id(entry[0]) and
                isinstance(entry[1], int) and
                not isinstance(entry[1], bool) and
                0 < entry[1] <= NATIVE_INT_MAX
            ):
                lines.append(
                    f"definition:requirement({lua_quote(entry[0])}, {entry[1]})"
                )
            else:
                result.todos.append(
                    f"{source.location}: recipe {recipe_id} external requirement needs review"
                )
    else:
        result.todos.append(
            f"{source.location}: recipe {recipe_id} external requirements need review"
        )
    unresolved = sorted(set(value) - COMMON_RECIPE_FIELDS)
    if unresolved or forced_partial or len(result.todos) != todo_count:
        result.partial.append(f"{source.location}: recipe {recipe_id}")
        if unresolved:
            result.todos.append(
                f"{source.location}: recipe {recipe_id} unresolved fields: {', '.join(unresolved)}"
            )
    else:
        result.converted.append(f"{source.location}: recipe {recipe_id}")
    lines.extend((content_submit_expression(), ""))
    return "\n".join(lines)


def unresolved_fields(value: dict[str, Any], supported: set[str]) -> list[str]:
    return sorted(
        key for key in set(value) - supported if not key.startswith("//")
    )


def finish_catalog(
    source: SourceObject,
    result: MigrationResult,
    label: str,
    object_id: str,
    lines: list[str],
    supported: set[str],
    todo_count: int,
) -> str:
    unresolved = unresolved_fields(source.value, supported)
    if unresolved:
        result.todos.append(
            f"{source.location}: {label} {object_id} unresolved fields: " +
            ", ".join(unresolved)
        )
    status = result.partial if unresolved or len(result.todos) != todo_count else result.converted
    status.append(f"{source.location}: {label} {object_id}")
    lines.extend((content_submit_expression(), ""))
    return "\n".join(lines)


def render_requirement(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    requirement_id = value.get("id")
    if not safe_platform_id(requirement_id):
        result.partial.append(f"{source.location}: requirement <invalid id>")
        result.todos.append(f"{source.location}: requirement needs a stable native id")
        return None
    todo_count = len(result.todos)
    lines = ["local definition = content.Requirement {", f"    id = {lua_quote(requirement_id)},"]
    name = value.get("name")
    if name is not None:
        text = display_text(name)
        if text:
            lines.append(f"    name = {lua_quote(text)},")
        else:
            result.todos.append(f"{source.location}: requirement {requirement_id} name needs review")
    lines.append("}")
    render_requirement_groups(
        lines,
        value.get("components", []),
        "component",
        "component_any",
        result.todos,
        source.location,
        owner=f"requirement {requirement_id}",
    )
    render_requirement_groups(
        lines,
        value.get("tools", []),
        "tool",
        "tool_any",
        result.todos,
        source.location,
        tools=True,
        owner=f"requirement {requirement_id}",
    )
    qualities = value.get("qualities", [])
    if isinstance(qualities, list):
        for group in qualities:
            if not isinstance(group, list) or not group:
                result.todos.append(
                    f"{source.location}: requirement {requirement_id} quality group needs review"
                )
                continue
            converted: list[tuple[str, int, int]] = []
            for entry in group:
                if (
                    isinstance(entry, list) and
                    2 <= len(entry) <= 3 and
                    safe_platform_id(entry[0]) and
                    isinstance(entry[1], int) and
                    not isinstance(entry[1], bool) and
                    0 < entry[1] <= NATIVE_INT_MAX and
                    (len(entry) == 2 or (
                        isinstance(entry[2], int) and
                        not isinstance(entry[2], bool) and
                        0 < entry[2] <= NATIVE_INT_MAX
                    ))
                ):
                    converted.append((entry[0], entry[1], entry[2] if len(entry) == 3 else 1))
                else:
                    converted = []
                    break
            if not converted:
                result.todos.append(
                    f"{source.location}: requirement {requirement_id} quality group needs review"
                )
            elif len(converted) == 1:
                quality_id, level, count = converted[0]
                lines.append(
                    f"definition:quality({lua_quote(quality_id)}, {level}, {count})"
                )
            else:
                rendered = ", ".join(
                    f"{{ id = {lua_quote(quality_id)}, level = {level}, count = {count} }}"
                    for quality_id, level, count in converted
                )
                lines.append(f"definition:quality_any {{ {rendered} }}")
    else:
        result.todos.append(
            f"{source.location}: requirement {requirement_id} qualities need review"
        )
    return finish_catalog(
        source,
        result,
        "requirement",
        requirement_id,
        lines,
        {"type", "id", "name", "components", "tools", "qualities"},
        todo_count,
    )


def render_recipe_group(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    group_id = value.get("id")
    if not safe_platform_id(group_id):
        result.partial.append(f"{source.location}: recipe group <invalid id>")
        result.todos.append(f"{source.location}: recipe group needs a stable native id")
        return None
    todo_count = len(result.todos)
    building_type = value.get("building_type", "NONE")
    if not isinstance(building_type, str) or not building_type:
        building_type = "NONE"
        result.todos.append(f"{source.location}: recipe group {group_id} building type needs review")
    lines = [
        "local definition = content.RecipeGroup {",
        f"    id = {lua_quote(group_id)},",
        f"    building_type = {lua_quote(building_type)},",
        "}",
    ]
    recipes = value.get("recipes", [])
    if isinstance(recipes, list):
        for recipe in recipes:
            if not isinstance(recipe, dict) or not safe_platform_id(recipe.get("id")):
                result.todos.append(
                    f"{source.location}: recipe group {group_id} recipe entry needs review"
                )
                continue
            recipe_id = recipe["id"]
            description = display_text(recipe.get("description"), recipe_id)
            lines.append(
                f"definition:recipe({lua_quote(recipe_id)}, {lua_quote(description)})"
            )
            terrains = recipe.get("om_terrains", [])
            if not isinstance(terrains, list):
                result.todos.append(
                    f"{source.location}: recipe group {group_id} recipe {recipe_id} terrains need review"
                )
                continue
            for terrain in terrains:
                terrain_id: Any
                match_type: Any = "TYPE"
                parameters: Any = {}
                if isinstance(terrain, str):
                    terrain_id = terrain
                elif isinstance(terrain, dict):
                    terrain_id = terrain.get("om_terrain")
                    match_type = terrain.get("om_terrain_match_type", "TYPE")
                    parameters = terrain.get("parameters", {})
                else:
                    terrain_id = None
                if not isinstance(terrain_id, str) or not terrain_id or not isinstance(match_type, str) or match_type.upper() not in {"EXACT", "TYPE", "SUBTYPE", "PREFIX", "CONTAINS"}:
                    result.todos.append(
                        f"{source.location}: recipe group {group_id} recipe {recipe_id} terrain needs review"
                    )
                    continue
                lines.append(
                    f"definition:terrain({lua_quote(recipe_id)}, {lua_quote(terrain_id)}, {lua_quote(match_type.upper())})"
                )
                if not isinstance(parameters, dict):
                    result.todos.append(
                        f"{source.location}: recipe group {group_id} recipe {recipe_id} terrain parameters need review"
                    )
                    continue
                for parameter, accepted in parameters.items():
                    if isinstance(parameter, str) and parameter and isinstance(accepted, list) and accepted and all(isinstance(entry, str) and entry for entry in accepted):
                        rendered_values = "{ " + ", ".join(lua_quote(entry) for entry in accepted) + " }"
                        lines.append(
                            f"definition:terrain_parameter({lua_quote(recipe_id)}, {lua_quote(parameter)}, {rendered_values})"
                        )
                    else:
                        result.todos.append(
                            f"{source.location}: recipe group {group_id} recipe {recipe_id} terrain parameter needs review"
                        )
    else:
        result.todos.append(f"{source.location}: recipe group {group_id} recipes need review")
    return finish_catalog(
        source,
        result,
        "recipe group",
        group_id,
        lines,
        {"type", "id", "building_type", "recipes"},
        todo_count,
    )


def render_scenario(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    scenario_id = value.get("id")
    if not safe_platform_id(scenario_id):
        result.partial.append(f"{source.location}: scenario <invalid id>")
        result.todos.append(f"{source.location}: scenario needs a stable native id")
        return None
    todo_count = len(result.todos)
    name = display_text(value.get("name"), scenario_id)
    description = display_text(value.get("description"), "")
    start_name = display_text(value.get("start_name"), "")

    def integer_option(field: str, default: int) -> int:
        raw = value.get(field, default)
        if (
            isinstance(raw, int) and
            not isinstance(raw, bool) and
            NATIVE_INT_MIN <= raw <= NATIVE_INT_MAX
        ):
            return raw
        result.todos.append(
            f"{source.location}: scenario {scenario_id} {field} needs review"
        )
        return default

    def boolean_option(field: str, default: bool) -> bool:
        raw = value.get(field, default)
        if isinstance(raw, bool):
            return raw
        result.todos.append(
            f"{source.location}: scenario {scenario_id} {field} needs review"
        )
        return default

    lines = [
        "local definition = content.Scenario {",
        f"    id = {lua_quote(scenario_id)},",
        f"    name = {lua_quote(name)},",
        f"    description = {lua_quote(description)},",
        f"    start_name = {lua_quote(start_name)},",
        f"    points = {integer_option('points', 0)},",
        f"    blacklist = {'true' if boolean_option('blacklist', False) else 'false'},",
        "    extra_professions = "
        f"{'true' if boolean_option('add_professions', False) else 'false'},",
        f"    reveal_locale = {'true' if boolean_option('reveal_locale', True) else 'false'},",
        "    distance_initial_visibility = "
        f"{integer_option('distance_initial_visibility', 15)},",
        "}",
    ]

    def render_id_list(field: str, method: str) -> None:
        raw = value.get(field, [])
        if not isinstance(raw, list) or any(
            not isinstance(entry, str) or not entry for entry in raw
        ):
            result.todos.append(
                f"{source.location}: scenario {scenario_id} {field} needs review"
            )
            return
        for entry in raw:
            lines.append(f"definition:{method}({lua_quote(entry)})")

    render_id_list("allowed_locs", "location")
    render_id_list("professions", "profession")
    render_id_list("traits", "allowed_trait")
    render_id_list("forced_traits", "forced_trait")
    render_id_list("forbidden_traits", "forbidden_trait")
    render_id_list("flags", "flag")
    requirement = value.get("requirement")
    if requirement is None:
        pass
    elif isinstance(requirement, str) and requirement:
        lines.append(f"definition:requirement({lua_quote(requirement)})")
    else:
        result.todos.append(
            f"{source.location}: scenario {scenario_id} requirement needs review"
        )
    return finish_catalog(
        source,
        result,
        "scenario",
        scenario_id,
        lines,
        {
            "type", "id", "name", "description", "start_name", "points",
            "blacklist", "add_professions", "reveal_locale",
            "distance_initial_visibility", "allowed_locs", "professions",
            "traits", "forced_traits", "forbidden_traits", "flags",
            "requirement",
        },
        todo_count,
    )


def render_vehicle_color_palette(
    source: SourceObject, result: MigrationResult
) -> str | None:
    value = source.value
    palette_id = value.get("id")
    if not safe_platform_id(palette_id):
        result.partial.append(f"{source.location}: vehicle color palette <invalid id>")
        result.todos.append(
            f"{source.location}: vehicle color palette needs a stable native id"
        )
        return None
    todo_count = len(result.todos)
    lines = [
        "local definition = content.VehicleColorPalette {",
        f"    id = {lua_quote(palette_id)},",
        "}",
    ]
    raw_groups = value.get("palette")
    if isinstance(raw_groups, list) and raw_groups:
        for raw_group in raw_groups:
            if not isinstance(raw_group, dict):
                result.todos.append(
                    f"{source.location}: vehicle color palette {palette_id} "
                    "group needs review"
                )
                continue
            fuzzy_ids = raw_group.get("fuzzy_ids", [])
            raw_colors = raw_group.get("colors", [])
            if not isinstance(fuzzy_ids, list) or not fuzzy_ids or any(
                not isinstance(entry, str) or not entry for entry in fuzzy_ids
            ) or not isinstance(raw_colors, list) or not raw_colors or any(
                not isinstance(entry, dict) or
                not isinstance(entry.get("color"), str) or
                not entry.get("color") or
                not isinstance(entry.get("weight"), int) or
                isinstance(entry.get("weight"), bool) or
                entry.get("weight", 0) <= 0
                for entry in raw_colors
            ):
                result.todos.append(
                    f"{source.location}: vehicle color palette {palette_id} "
                    "group needs review"
                )
                continue
            lines.append(
                "definition:group("
                + "{ " + ", ".join(
                    lua_quote(entry) for entry in fuzzy_ids
                ) + " }, {"
            )
            for entry in raw_colors:
                lines.append(
                    "    { "
                    f"{lua_quote(entry['color'])}, {entry['weight']} }},"
                )
            lines[-1] = lines[-1][:-1]
            lines.append("})")
    else:
        result.todos.append(
            f"{source.location}: vehicle color palette {palette_id} "
            "palette needs review"
        )
    return finish_catalog(
        source,
        result,
        "vehicle color palette",
        palette_id,
        lines,
        {"type", "id", "palette", "//"},
        todo_count,
    )


def render_overmap_connection(
    source: SourceObject, result: MigrationResult
) -> str | None:
    value = source.value
    connection_id = value.get("id")
    if not safe_platform_id(connection_id):
        result.partial.append(f"{source.location}: overmap connection <invalid id>")
        result.todos.append(
            f"{source.location}: overmap connection needs a stable native id"
        )
        return None
    todo_count = len(result.todos)
    lines = [
        "local definition = content.OvermapConnection {",
        f"    id = {lua_quote(connection_id)},",
        "}",
    ]
    raw_subtypes = value.get("subtypes")
    if isinstance(raw_subtypes, list) and raw_subtypes:
        for raw_subtype in raw_subtypes:
            if not isinstance(raw_subtype, dict):
                result.todos.append(
                    f"{source.location}: overmap connection {connection_id} "
                    "subtype needs review"
                )
                continue
            terrain = raw_subtype.get("terrain")
            basic_cost = raw_subtype.get("basic_cost", 0)
            locations = raw_subtype.get("locations", [])
            raw_flags = raw_subtype.get("flags", [])
            flags_valid = (
                isinstance(raw_flags, list) and
                all(
                    isinstance(flag, str) and
                    flag in {"ORTHOGONAL", "PERPENDICULAR_CROSSING"}
                    for flag in raw_flags
                )
            )
            if not isinstance(terrain, str) or not terrain or \
                    not isinstance(basic_cost, int) or \
                    isinstance(basic_cost, bool) or \
                    not 0 <= basic_cost <= NATIVE_INT_MAX or \
                    not isinstance(locations, list) or \
                    any(
                        not isinstance(location, str) or not location
                        for location in locations
                    ) or not flags_valid or any(
                        field in raw_subtype
                        for field in set(raw_subtype) -
                        {"terrain", "basic_cost", "locations", "flags"}
                    ):
                result.todos.append(
                    f"{source.location}: overmap connection {connection_id} "
                    "subtype needs review"
                )
                continue
            lines.append(
                f"definition:subtype({lua_quote(terrain)}, {basic_cost}, "
                + "{ " + ", ".join(
                    lua_quote(location) for location in locations
                ) + " }, "
                + f"{'true' if 'ORTHOGONAL' in raw_flags else 'false'}, "
                + f"{'true' if 'PERPENDICULAR_CROSSING' in raw_flags else 'false'})"
            )
    else:
        result.todos.append(
            f"{source.location}: overmap connection {connection_id} "
            "subtypes need review"
        )
    return finish_catalog(
        source,
        result,
        "overmap connection",
        connection_id,
        lines,
        {"type", "id", "subtypes", "//"},
        todo_count,
    )


def render_monster_group(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    group_id = value.get("id")
    if not safe_platform_id(group_id):
        result.partial.append(f"{source.location}: monster group <invalid id>")
        result.todos.append(f"{source.location}: monster group needs a stable native id")
        return None
    todo_count = len(result.todos)
    lines = [
        "local definition = content.MonsterGroup {",
        f"    id = {lua_quote(group_id)},",
    ]
    default_monster = value.get("default")
    if default_monster is None:
        pass
    elif isinstance(default_monster, str) and default_monster:
        lines.append(f"    default_monster = {lua_quote(default_monster)},")
    else:
        result.todos.append(
            f"{source.location}: monster group {group_id} default needs review"
        )
    is_animal = value.get("is_animal")
    if is_animal is None:
        pass
    elif isinstance(is_animal, bool):
        lines.append(f"    is_animal = {'true' if is_animal else 'false'},")
    else:
        result.todos.append(
            f"{source.location}: monster group {group_id} is_animal needs review"
        )
    lines.append("}")
    raw_monsters = value.get("monsters")
    if isinstance(raw_monsters, list) and raw_monsters:
        for raw_entry in raw_monsters:
            if not isinstance(raw_entry, dict):
                result.todos.append(
                    f"{source.location}: monster group {group_id} entry needs review"
                )
                continue
            entry_id = raw_entry.get("monster", raw_entry.get("group"))
            if not isinstance(entry_id, str) or not entry_id:
                result.todos.append(
                    f"{source.location}: monster group {group_id} entry needs review"
                )
                continue
            weight = raw_entry.get("weight", raw_entry.get("freq", 1))
            cost = raw_entry.get("cost_multiplier", 1)
            raw_pack = raw_entry.get("pack_size", [1, 1])
            pack_valid = (
                isinstance(raw_pack, list) and len(raw_pack) == 2 and
                all(
                    isinstance(part, int) and not isinstance(part, bool) and
                    1 <= part <= NATIVE_INT_MAX
                    for part in raw_pack
                ) and raw_pack[0] <= raw_pack[1]
            )
            if any(
                field in raw_entry
                for field in ("starts", "ends", "conditions", "event", "spawn_data")
            ) or not (
                isinstance(weight, int) and not isinstance(weight, bool) and
                weight >= 1
            ) or not (
                isinstance(cost, int) and not isinstance(cost, bool) and
                cost >= 0
            ) or not pack_valid:
                result.todos.append(
                    f"{source.location}: monster group {group_id} entry "
                    f"{entry_id} needs review"
                )
                continue
            method = "monster" if "monster" in raw_entry else "group"
            lines.append(
                f"definition:{method}({lua_quote(entry_id)}, "
                f"{weight}, {cost}, {raw_pack[0]}, {raw_pack[1]})"
            )
    else:
        result.todos.append(
            f"{source.location}: monster group {group_id} monsters need review"
        )
    return finish_catalog(
        source,
        result,
        "monster group",
        group_id,
        lines,
        {
            "type", "id", "default", "is_animal", "monsters", "//", "//2",
        },
        todo_count,
    )


def render_item_action(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    action_id = value.get("id")
    if not safe_platform_id(action_id):
        result.partial.append(f"{source.location}: item action <invalid id>")
        result.todos.append(f"{source.location}: item action needs a stable id")
        return None
    todo_count = len(result.todos)
    name = display_text(value.get("name"), action_id)
    lines = [
        "local definition = content.ItemAction {",
        f"    id = {lua_quote(action_id)},",
        f"    name = {lua_quote(name)},",
        "}",
    ]
    return finish_catalog(
        source,
        result,
        "item action",
        action_id,
        lines,
        {"type", "id", "name", "//"},
        todo_count,
    )


def render_butchery_requirement(
    source: SourceObject, result: MigrationResult
) -> str | None:
    value = source.value
    requirement_id = value.get("id")
    if not safe_platform_id(requirement_id):
        result.partial.append(f"{source.location}: butchery requirement <invalid id>")
        result.todos.append(
            f"{source.location}: butchery requirement needs a stable native id"
        )
        return None
    todo_count = len(result.todos)
    size_names = ("TINY", "SMALL", "MEDIUM", "LARGE", "HUGE")
    butcher_names = (
        "BLEED", "QUICK", "FULL", "FIELD_DRESS", "SKIN", "QUARTER",
        "DISMEMBER", "DISSECT",
    )
    lines = [
        "local definition = content.ButcheryRequirement {",
        f"    id = {lua_quote(requirement_id)},",
        "}",
    ]
    raw_rows = value.get("requirements")
    if isinstance(raw_rows, dict):
        for raw_speed, raw_sizes in raw_rows.items():
            try:
                speed = float(raw_speed)
            except (TypeError, ValueError):
                speed = float("nan")
            if not math.isfinite(speed) or speed < 0 or \
                    not isinstance(raw_sizes, list) or \
                    len(raw_sizes) != len(size_names):
                valid = False
                result.todos.append(
                    f"{source.location}: butchery requirement {requirement_id} "
                    f"speed row {raw_speed!r} needs review"
                )
                continue
            for size_index, raw_size in enumerate(raw_sizes):
                if not isinstance(raw_size, dict) or any(
                    name not in raw_size or
                    not isinstance(raw_size[name], str) or
                    not raw_size[name]
                    for name in butcher_names
                ):
                    result.todos.append(
                        f"{source.location}: butchery requirement {requirement_id} "
                        f"size row {size_names[size_index]} needs review"
                    )
                    continue
                for name in butcher_names:
                    lines.append(
                        "definition:requirement("
                        f"{lua_number(speed)}, {lua_quote(size_names[size_index])}, "
                        f"{lua_quote(name)}, {lua_quote(raw_size[name])})"
                    )
    else:
        result.todos.append(
            f"{source.location}: butchery requirement {requirement_id} "
            "requirements need review"
        )
    return finish_catalog(
        source,
        result,
        "butchery requirement",
        requirement_id,
        lines,
        {"type", "id", "requirements"},
        todo_count,
    )


def render_scent_type(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    scent_id = value.get("id")
    if not safe_platform_id(scent_id):
        result.partial.append(f"{source.location}: scent type <invalid id>")
        result.todos.append(f"{source.location}: scent type needs a stable native id")
        return None
    todo_count = len(result.todos)
    lines = [
        "local definition = content.ScentType {",
        f"    id = {lua_quote(scent_id)},",
        "}",
    ]
    species = value.get("receptive_species")
    if isinstance(species, list) and species and all(safe_platform_id(entry) for entry in species):
        lines.extend(
            f"definition:receptive_species({lua_quote(entry)})" for entry in species
        )
    else:
        result.todos.append(
            f"{source.location}: scent type {scent_id} receptive species need review"
        )
    return finish_catalog(
        source,
        result,
        "scent type",
        scent_id,
        lines,
        {"type", "id", "receptive_species"},
        todo_count,
    )


def render_technique(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    technique_id = value.get("id")
    if not safe_platform_id(technique_id):
        result.partial.append(f"{source.location}: technique <invalid id>")
        result.todos.append(
            f"{source.location}: technique needs a stable native id"
        )
        return None
    todo_count = len(result.todos)
    if "copy-from" in value:
        result.todos.append(
            f"{source.location}: technique {technique_id} inheritance must become a Lua constructor/composition function"
        )
    name = value.get("name")
    if not isinstance(name, str) or not name:
        result.todos.append(
            f"{source.location}: technique {technique_id} name needs review"
        )
        name = technique_id
    lines = [
        "local definition = content.Technique {",
        f"    id = {lua_quote(technique_id)},",
        f"    name = {lua_quote(name)},",
    ]
    description = value.get("description")
    if isinstance(description, str) and description:
        lines.append(f"    description = {lua_quote(description)},")
    messages = value.get("messages")
    if isinstance(messages, list) and len(messages) >= 2 and all(
        isinstance(entry, str) for entry in messages[:2]
    ):
        lines.append(f"    avatar_message = {lua_quote(messages[0])},")
        lines.append(f"    npc_message = {lua_quote(messages[1])},")
    elif "messages" in value:
        result.todos.append(
            f"{source.location}: technique {technique_id} messages need review"
        )
    bool_fields = (
        "crit_tec", "crit_ok", "wall_adjacent", "reach_tec", "reach_ok",
        "needs_ammo", "defensive", "disarms", "take_weapon", "side_switch",
        "dummy", "dodge_counter", "block_counter", "miss_recovery",
        "grab_break", "knockback_follow",
    )
    for field in bool_fields:
        entry = value.get(field)
        if isinstance(entry, bool):
            lines.append(
                f"    {field} = {lua_boolean(entry)},"
            )
        elif field in value:
            result.todos.append(
                f"{source.location}: technique {technique_id} {field} needs review"
            )
    int_fields = (
        ("weighting", 1, 0, None),
        ("repeat_min", 1, 1, None),
        ("repeat_max", 1, 1, None),
        ("down_dur", 0, 0, None),
        ("stun_dur", 0, 0, None),
        ("knockback_dist", 0, 0, None),
    )
    for field, default, minimum, _ in int_fields:
        entry = value.get(field, default)
        if isinstance(entry, int) and not isinstance(entry, bool) and \
                minimum <= entry <= NATIVE_INT_MAX:
            lines.append(f"    {field} = {entry},")
        else:
            lines.append(f"    {field} = {default},")
            result.todos.append(
                f"{source.location}: technique {technique_id} {field} needs review"
            )
    spread = value.get("knockback_spread", 0)
    if isinstance(spread, (int, float)) and not isinstance(spread, bool) and \
            spread >= 0:
        lines.append(f"    knockback_spread = {spread},")
    else:
        lines.append("    knockback_spread = 0,")
        result.todos.append(
            f"{source.location}: technique {technique_id} knockback_spread needs review"
        )
    aoe = value.get("aoe")
    if isinstance(aoe, str):
        lines.append(f"    aoe = {lua_quote(aoe)},")
    for field in ("unarmed_allowed", "melee_allowed", "strictly_unarmed"):
        entry = value.get(field)
        if isinstance(entry, bool):
            lines.append(f"    {field} = {lua_boolean(entry)},")
        elif field in value:
            result.todos.append(
                f"{source.location}: technique {technique_id} {field} needs review"
            )
    lines.append("}")
    flags = value.get("flags")
    if isinstance(flags, list) and all(
        isinstance(entry, str) and entry for entry in flags
    ):
        for flag in flags:
            lines.append(f"definition:flag({lua_quote(flag)})")
    elif "flags" in value:
        result.todos.append(
            f"{source.location}: technique {technique_id} flags need review"
        )
    vectors = value.get("attack_vectors")
    if isinstance(vectors, list) and all(
        isinstance(entry, str) and entry for entry in vectors
    ):
        for vector in vectors:
            lines.append(f"definition:attack_vector({lua_quote(vector)})")
    elif "attack_vectors" in value:
        result.todos.append(
            f"{source.location}: technique {technique_id} attack vectors need review"
        )
    skills = value.get("skill_requirements")
    if isinstance(skills, list) and all(
        isinstance(entry, dict) and isinstance(entry.get("name"), str) and
        isinstance(entry.get("level"), int) and
        not isinstance(entry.get("level"), bool)
        for entry in skills
    ):
        for entry in skills:
            lines.append(
                f"definition:requires_skill({lua_quote(entry['name'])}, "
                f"{entry['level']})"
            )
    elif "skill_requirements" in value:
        result.todos.append(
            f"{source.location}: technique {technique_id} skill requirements need review"
        )
    for member in ("tech_effects", "eocs", "condition", "bonuses",
                   "weighting_skill", "req_buffs", "forbidden_buffs"):
        if member in value:
            result.todos.append(
                f"{source.location}: technique {technique_id} {member} needs review"
            )
    status = (
        result.partial if len(result.todos) != todo_count else result.converted
    )
    status.append(f"{source.location}: technique {technique_id}")
    lines.extend((content_submit_expression(), ""))
    return "\n".join(lines)


def render_martial_art(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    art_id = value.get("id")
    if not safe_platform_id(art_id):
        result.partial.append(f"{source.location}: martial art <invalid id>")
        result.todos.append(
            f"{source.location}: martial art needs a stable native id"
        )
        return None
    todo_count = len(result.todos)
    if "copy-from" in value:
        result.todos.append(
            f"{source.location}: martial art {art_id} inheritance must become a Lua constructor/composition function"
        )
    name = value.get("name")
    if isinstance(name, dict):
        name = name.get("str")
    if not isinstance(name, str) or not name:
        result.todos.append(
            f"{source.location}: martial art {art_id} name needs review"
        )
        name = art_id
    lines = [
        "local definition = content.MartialArt {",
        f"    id = {lua_quote(art_id)},",
        f"    name = {lua_quote(name)},",
    ]
    description = value.get("description")
    if isinstance(description, str) and description:
        lines.append(f"    description = {lua_quote(description)},")
    initiate = value.get("initiate")
    if isinstance(initiate, list) and len(initiate) >= 2 and all(
        isinstance(entry, str) for entry in initiate[:2]
    ):
        lines.append(f"    initiate_avatar = {lua_quote(initiate[0])},")
        lines.append(f"    initiate_npc = {lua_quote(initiate[1])},")
    elif "initiate" in value:
        result.todos.append(
            f"{source.location}: martial art {art_id} initiate messages need review"
        )
    int_fields = (
        ("priority", 0), ("learn_difficulty", 0),
        ("arm_block", 0), ("leg_block", 0),
    )
    for field, default in int_fields:
        entry = value.get(field, default)
        if isinstance(entry, int) and not isinstance(entry, bool) and \
                NATIVE_INT_MIN <= entry <= NATIVE_INT_MAX:
            lines.append(f"    {field} = {entry},")
        else:
            lines.append(f"    {field} = {default},")
            result.todos.append(
                f"{source.location}: martial art {art_id} {field} needs review"
            )
    primary = value.get("primary_skill")
    if isinstance(primary, str) and primary:
        lines.append(f"    primary_skill = {lua_quote(primary)},")
    bool_fields = (
        "teachable", "arm_block_with_bio_armor_arms",
        "leg_block_with_bio_armor_legs", "strictly_unarmed", "strictly_melee",
        "allow_all_weapons", "force_unarmed", "prevent_weapon_blocking",
    )
    for field in bool_fields:
        entry = value.get(field)
        if isinstance(entry, bool):
            lines.append(f"    {field} = {lua_boolean(entry)},")
        elif field in value:
            result.todos.append(
                f"{source.location}: martial art {art_id} {field} needs review"
            )
    lines.append("}")
    autolearn = value.get("autolearn")
    if isinstance(autolearn, list) and all(
        isinstance(entry, list) and len(entry) == 2 and
        isinstance(entry[0], str) and isinstance(entry[1], int) and
        not isinstance(entry[1], bool)
        for entry in autolearn
    ):
        for entry in autolearn:
            lines.append(
                f"definition:autolearn({lua_quote(entry[0])}, {entry[1]})"
            )
    elif "autolearn" in value:
        result.todos.append(
            f"{source.location}: martial art {art_id} autolearn needs review"
        )
    techniques = value.get("techniques")
    if isinstance(techniques, list) and all(
        isinstance(entry, str) and entry for entry in techniques
    ):
        for entry in techniques:
            lines.append(f"definition:technique({lua_quote(entry)})")
    elif "techniques" in value:
        result.todos.append(
            f"{source.location}: martial art {art_id} techniques need review"
        )
    weapons = value.get("weapons")
    if isinstance(weapons, list) and all(
        isinstance(entry, str) and entry for entry in weapons
    ):
        for entry in weapons:
            lines.append(f"definition:weapon({lua_quote(entry)})")
    elif "weapons" in value:
        result.todos.append(
            f"{source.location}: martial art {art_id} weapons need review"
        )
    categories = value.get("weapon_categories")
    if isinstance(categories, list) and all(
        isinstance(entry, str) and entry for entry in categories
    ):
        for entry in categories:
            lines.append(f"definition:weapon_category({lua_quote(entry)})")
    elif "weapon_categories" in value:
        result.todos.append(
            f"{source.location}: martial art {art_id} weapon categories need review"
        )
    for member in (
        "static_buffs", "onmove_buffs", "onpause_buffs", "onhit_buffs",
        "onattack_buffs", "ondodge_buffs", "onblock_buffs", "ongethit_buffs",
        "onmiss_buffs", "oncrit_buffs", "onkill_buffs", "static_eocs",
        "onmove_eocs", "onpause_eocs", "onhit_eocs", "onattack_eocs",
        "ondodge_eocs", "onblock_eocs", "ongethit_eocs", "onmiss_eocs",
        "oncrit_eocs", "onkill_eocs", "weapon_damage",
    ):
        if member in value:
            result.todos.append(
                f"{source.location}: martial art {art_id} {member} needs review"
            )
    status = (
        result.partial if len(result.todos) != todo_count else result.converted
    )
    status.append(f"{source.location}: martial art {art_id}")
    lines.extend((content_submit_expression(), ""))
    return "\n".join(lines)


def render_trap(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    trap_id = value.get("id")
    if not safe_platform_id(trap_id):
        result.partial.append(f"{source.location}: trap <invalid id>")
        result.todos.append(
            f"{source.location}: trap needs a stable native id"
        )
        return None
    todo_count = len(result.todos)
    name = value.get("name")
    if isinstance(name, dict):
        name = name.get("str")
    if not isinstance(name, str) or not name:
        result.todos.append(f"{source.location}: trap {trap_id} name needs review")
        name = trap_id
    color = value.get("color")
    if not isinstance(color, str) or not color:
        result.todos.append(f"{source.location}: trap {trap_id} color needs review")
        color = "white"
    symbol = value.get("symbol")
    if not isinstance(symbol, str) or len(symbol) != 1:
        result.todos.append(f"{source.location}: trap {trap_id} symbol needs review")
        symbol = "^"
    action = value.get("action")
    if not isinstance(action, str) or not action:
        result.todos.append(f"{source.location}: trap {trap_id} action needs review")
        action = "none"
    lines = [
        "local definition = content.Trap {",
        f"    id = {lua_quote(trap_id)},",
        f"    name = {lua_quote(name)},",
        f"    color = {lua_quote(color)},",
        f"    symbol = {lua_quote(symbol)},",
        f"    action = {lua_quote(action)},",
    ]
    int_fields = (
        ("visibility", 1), ("avoidance", 0), ("difficulty", 0),
        ("trap_radius", 0), ("funnel_radius", 0), ("comfort", 0),
        ("trigger_weight_grams", 500), ("sound_threshold_min", 0),
        ("sound_threshold_max", 0),
    )
    for field, default in int_fields:
        entry = value.get(field, default)
        if isinstance(entry, int) and not isinstance(entry, bool) and \
                entry >= 0:
            lines.append(f"    {field} = {entry},")
        else:
            lines.append(f"    {field} = {default},")
            result.todos.append(
                f"{source.location}: trap {trap_id} {field} needs review"
            )
    for field in ("benign", "always_invisible"):
        entry = value.get(field)
        if isinstance(entry, bool):
            lines.append(f"    {field} = {lua_boolean(entry)},")
        elif field in value:
            result.todos.append(
                f"{source.location}: trap {trap_id} {field} needs review"
            )
    memorials = [value.get("memorial_male"), value.get("memorial_female")]
    if all(isinstance(entry, str) and entry for entry in memorials):
        lines.append(f"    memorial_male = {lua_quote(memorials[0])},")
        lines.append(f"    memorial_female = {lua_quote(memorials[1])},")
    elif any(entry is not None for entry in memorials):
        result.todos.append(
            f"{source.location}: trap {trap_id} memorial messages need review"
        )
    if isinstance(value.get("trigger_message_u"), str):
        lines.append(
            f"    trigger_message_u = {lua_quote(value['trigger_message_u'])},"
        )
    if isinstance(value.get("trigger_message_npc"), str):
        lines.append(
            f"    trigger_message_npc = {lua_quote(value['trigger_message_npc'])},"
        )
    lines.append("}")
    flags = value.get("flags")
    if isinstance(flags, list) and all(
        isinstance(entry, str) and entry for entry in flags
    ):
        for flag in flags:
            lines.append(f"definition:flag({lua_quote(flag)})")
    elif "flags" in value:
        result.todos.append(f"{source.location}: trap {trap_id} flags need review")
    drops = value.get("drops")
    if isinstance(drops, list):
        for drop in drops:
            if isinstance(drop, dict) and isinstance(drop.get("item"), str):
                quantity = drop.get("quantity", 1)
                charges = drop.get("charges", 1)
                if isinstance(quantity, int) and not isinstance(quantity, bool) \
                        and quantity > 0 and isinstance(charges, int) and \
                        not isinstance(charges, bool) and charges > 0:
                    lines.append(
                        f"definition:drop({lua_quote(drop['item'])}, "
                        f"{quantity}, {charges})"
                    )
                    continue
            result.todos.append(
                f"{source.location}: trap {trap_id} drops need review"
            )
    elif "drops" in value:
        result.todos.append(f"{source.location}: trap {trap_id} drops need review")
    for member in ("spell_data", "eocs", "vehicle_data", "map_regen",
                   "floor_bedding_warmth"):
        if member in value:
            result.todos.append(
                f"{source.location}: trap {trap_id} {member} needs review"
            )
    status = (
        result.partial if len(result.todos) != todo_count else result.converted
    )
    status.append(f"{source.location}: trap {trap_id}")
    lines.extend((content_submit_expression(), ""))
    return "\n".join(lines)


def render_construction(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    construction_id = value.get("id")
    if not safe_platform_id(construction_id):
        result.partial.append(f"{source.location}: construction <invalid id>")
        result.todos.append(
            f"{source.location}: construction needs a stable native id"
        )
        return None
    todo_count = len(result.todos)
    if "copy-from" in value:
        result.todos.append(
            f"{source.location}: construction {construction_id} inheritance must become a Lua constructor/composition function"
        )
    group = value.get("group")
    if not isinstance(group, str) or not group:
        result.todos.append(
            f"{source.location}: construction {construction_id} group needs review"
        )
        group = "dig_channel"
    category = value.get("category", "OTHER")
    if not isinstance(category, str) or not category:
        result.todos.append(
            f"{source.location}: construction {construction_id} category needs review"
        )
        category = "OTHER"
    lines = [
        "local definition = content.Construction {",
        f"    id = {lua_quote(construction_id)},",
        f"    group = {lua_quote(group)},",
        f"    category = {lua_quote(category)},",
    ]
    duration = parse_moves(value.get("time", 0))
    if duration is None or duration < 0:
        duration = 0
        result.todos.append(
            f"{source.location}: construction {construction_id} time needs unit review"
        )
    lines.append(f"    duration_moves = {duration},")
    activity = value.get("activity_level")
    if isinstance(activity, str):
        # legacy activity level names map to native multipliers; keep partial
        result.todos.append(
            f"{source.location}: construction {construction_id} activity_level needs review"
        )
        activity = 1.0
    if isinstance(activity, (int, float)) and not isinstance(activity, bool) \
            and activity >= 0:
        lines.append(f"    activity_level = {activity},")
    if isinstance(value.get("pre_note"), str) and value["pre_note"]:
        lines.append(f"    pre_note = {lua_quote(value['pre_note'])},")
    post_terrain = value.get("post_terrain")
    if isinstance(post_terrain, str) and post_terrain:
        lines.append(f"    post_terrain = {lua_quote(post_terrain)},")
    elif "post_terrain" in value:
        result.todos.append(
            f"{source.location}: construction {construction_id} post_terrain needs review"
        )
    lines.append("}")
    skills = value.get("required_skills")
    if isinstance(skills, dict):
        for skill, level in skills.items():
            if isinstance(skill, str) and isinstance(level, int) and \
                    not isinstance(level, bool) and level >= 0:
                lines.append(
                    f"definition:requires_skill({lua_quote(skill)}, {level})"
                )
            else:
                result.todos.append(
                    f"{source.location}: construction {construction_id} required skills need review"
                )
                break
    elif "required_skills" in value:
        result.todos.append(
            f"{source.location}: construction {construction_id} required skills need review"
        )
    legacy_skill = value.get("skill")
    legacy_difficulty = value.get("difficulty")
    if "required_skills" not in value and isinstance(legacy_skill, str) and \
            isinstance(legacy_difficulty, int) and \
            not isinstance(legacy_difficulty, bool) and legacy_difficulty >= 0:
        lines.append(
            f"definition:requires_skill({lua_quote(legacy_skill)}, {legacy_difficulty})"
        )
    elif "required_skills" not in value and ("skill" in value or "difficulty" in value):
        result.todos.append(
            f"{source.location}: construction {construction_id} legacy skill needs review"
        )
    using = value.get("using")
    if isinstance(using, str) and using:
        lines.append(f"definition:using_requirement({lua_quote(using)}, 1)")
    elif isinstance(using, list) and all(
        isinstance(entry, list) and len(entry) == 2 and
        isinstance(entry[0], str) and isinstance(entry[1], int) and
        not isinstance(entry[1], bool) and entry[1] > 0
        for entry in using
    ):
        for entry in using:
            lines.append(
                f"definition:using_requirement({lua_quote(entry[0])}, {entry[1]})"
            )
    elif "using" in value:
        result.todos.append(
            f"{source.location}: construction {construction_id} using requirements need review"
        )
    pre_terrain = value.get("pre_terrain")
    if isinstance(pre_terrain, str):
        lines.append(f"definition:pre_terrain({lua_quote(pre_terrain)})")
    elif isinstance(pre_terrain, list) and all(
        isinstance(entry, str) and entry for entry in pre_terrain
    ):
        for entry in pre_terrain:
            lines.append(f"definition:pre_terrain({lua_quote(entry)})")
    elif "pre_terrain" in value:
        result.todos.append(
            f"{source.location}: construction {construction_id} pre_terrain needs review"
        )
    pre_flags = value.get("pre_flags")
    if isinstance(pre_flags, list):
        for flag in pre_flags:
            if isinstance(flag, str) and flag:
                lines.append(f"definition:pre_flag({lua_quote(flag)}, false)")
                continue
            if isinstance(flag, dict) and isinstance(flag.get("flag"), str) and \
                    isinstance(flag.get("force_terrain"), bool):
                lines.append(
                    f"definition:pre_flag({lua_quote(flag['flag'])}, "
                    f"{lua_boolean(flag['force_terrain'])})"
                )
                continue
            result.todos.append(
                f"{source.location}: construction {construction_id} pre_flags need review"
            )
            break
    elif "pre_flags" in value:
        result.todos.append(
            f"{source.location}: construction {construction_id} pre_flags need review"
        )
    post_flags = value.get("post_flags")
    if isinstance(post_flags, list) and all(
        isinstance(entry, str) and entry for entry in post_flags
    ):
        for entry in post_flags:
            lines.append(f"definition:post_flag({lua_quote(entry)})")
    elif "post_flags" in value:
        result.todos.append(
            f"{source.location}: construction {construction_id} post_flags need review"
        )
    for member in ("components", "tools", "qualities", "byproducts",
                   "pre_special", "post_special", "dark_craftable",
                   "vehicle_start", "on_display", "deconstruct_recipe"):
        if member in value:
            result.todos.append(
                f"{source.location}: construction {construction_id} {member} needs review"
            )
    status = (
        result.partial if len(result.todos) != todo_count else result.converted
    )
    status.append(f"{source.location}: construction {construction_id}")
    lines.extend((content_submit_expression(), ""))
    return "\n".join(lines)


def render_furniture(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    furniture_id = value.get("id")
    if not safe_platform_id(furniture_id):
        result.partial.append(f"{source.location}: furniture <invalid id>")
        result.todos.append(
            f"{source.location}: furniture needs a stable native id"
        )
        return None
    todo_count = len(result.todos)
    if "copy-from" in value:
        result.todos.append(
            f"{source.location}: furniture {furniture_id} inheritance must become a Lua constructor/composition function"
        )
    name = value.get("name")
    if isinstance(name, dict):
        name = name.get("str")
    if not isinstance(name, str) or not name:
        result.todos.append(f"{source.location}: furniture {furniture_id} name needs review")
        name = furniture_id
    description = value.get("description")
    if not isinstance(description, str):
        description = ""
        if "description" in value:
            result.todos.append(
                f"{source.location}: furniture {furniture_id} description needs review"
            )
    color = value.get("color")
    if not isinstance(color, str) or not color:
        result.todos.append(f"{source.location}: furniture {furniture_id} color needs review")
        color = "white"
    symbol = value.get("symbol")
    if not isinstance(symbol, str) or len(symbol) != 1:
        result.todos.append(f"{source.location}: furniture {furniture_id} symbol needs review")
        symbol = "#"
    lines = [
        "local definition = content.Furniture {",
        f"    id = {lua_quote(furniture_id)},",
        f"    name = {lua_quote(name)},",
        f"    color = {lua_quote(color)},",
        f"    symbol = {lua_quote(symbol)},",
    ]
    if description:
        lines.append(f"    description = {lua_quote(description)},")
    int_fields = (
        ("move_cost_mod", 0), ("required_str", 0), ("light_emitted", 0),
        ("comfort", 0), ("max_volume_ml", 0), ("mass_grams", 0),
        ("keg_capacity_ml", 0),
    )
    for field, default in int_fields:
        entry = value.get(field, default)
        if isinstance(entry, int) and not isinstance(entry, bool) and \
                entry >= 0:
            lines.append(f"    {field} = {entry},")
        else:
            lines.append(f"    {field} = {default},")
            result.todos.append(
                f"{source.location}: furniture {furniture_id} {field} needs review"
            )
    transparent = value.get("transparent")
    if isinstance(transparent, bool):
        lines.append(f"    transparent = {lua_boolean(transparent)},")
    elif "transparent" in value:
        result.todos.append(
            f"{source.location}: furniture {furniture_id} transparent needs review"
        )
    for field in ("open", "close", "lockpick_result", "crafting_pseudo_item",
                  "deployed_item"):
        entry = value.get(field)
        if isinstance(entry, str) and entry:
            lines.append(f"    {field} = {lua_quote(entry)},")
        elif field in value:
            result.todos.append(
                f"{source.location}: furniture {furniture_id} {field} needs review"
            )
    lines.append("}")
    flags = value.get("flags")
    if isinstance(flags, list) and all(
        isinstance(entry, str) and entry for entry in flags
    ):
        for flag in flags:
            lines.append(f"definition:flag({lua_quote(flag)})")
    elif "flags" in value:
        result.todos.append(
            f"{source.location}: furniture {furniture_id} flags need review"
        )
    for member in ("bash", "deconstruct", "workbench", "examine_action",
                   "plant_data", "oxytorch", "boltcut", "hacksaw", "prying",
                   "emissions", "harvest_by_season", "bonus_fire_warmth_feet",
                   "coverage", "curtain_transform", "looks_like",
                   "surgery_skill_multiplier"):
        if member in value:
            result.todos.append(
                f"{source.location}: furniture {furniture_id} {member} needs review"
            )
    status = (
        result.partial if len(result.todos) != todo_count else result.converted
    )
    status.append(f"{source.location}: furniture {furniture_id}")
    lines.extend((content_submit_expression(), ""))
    return "\n".join(lines)


def render_terrain(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    terrain_id = value.get("id")
    if not safe_platform_id(terrain_id):
        result.partial.append(f"{source.location}: terrain <invalid id>")
        result.todos.append(
            f"{source.location}: terrain needs a stable native id"
        )
        return None
    todo_count = len(result.todos)
    if "copy-from" in value:
        result.todos.append(
            f"{source.location}: terrain {terrain_id} inheritance must become a Lua constructor/composition function"
        )
    name = value.get("name")
    if isinstance(name, dict):
        name = name.get("str")
    if not isinstance(name, str) or not name:
        result.todos.append(f"{source.location}: terrain {terrain_id} name needs review")
        name = terrain_id
    description = value.get("description")
    if not isinstance(description, str):
        description = ""
        if "description" in value:
            result.todos.append(
                f"{source.location}: terrain {terrain_id} description needs review"
            )
    color = value.get("color")
    if not isinstance(color, str) or not color:
        result.todos.append(f"{source.location}: terrain {terrain_id} color needs review")
        color = "white"
    symbol = value.get("symbol")
    if not isinstance(symbol, str) or len(symbol) != 1:
        result.todos.append(f"{source.location}: terrain {terrain_id} symbol needs review")
        symbol = "."
    lines = [
        "local definition = content.Terrain {",
        f"    id = {lua_quote(terrain_id)},",
        f"    name = {lua_quote(name)},",
        f"    color = {lua_quote(color)},",
        f"    symbol = {lua_quote(symbol)},",
    ]
    if description:
        lines.append(f"    description = {lua_quote(description)},")
    int_fields = (
        ("move_cost", 0), ("light_emitted", 0), ("comfort", 0),
        ("max_volume_ml", 0), ("heat_radiation", 0),
    )
    for field, default in int_fields:
        entry = value.get(field, default)
        if isinstance(entry, int) and not isinstance(entry, bool) and \
                entry >= 0:
            lines.append(f"    {field} = {entry},")
        else:
            lines.append(f"    {field} = {default},")
            result.todos.append(
                f"{source.location}: terrain {terrain_id} {field} needs review"
            )
    transparent = value.get("transparent")
    if isinstance(transparent, bool):
        lines.append(f"    transparent = {lua_boolean(transparent)},")
    elif "transparent" in value:
        result.todos.append(
            f"{source.location}: terrain {terrain_id} transparent needs review"
        )
    for field in ("open", "close", "transforms_into", "roof",
                  "lockpick_result", "trap"):
        entry = value.get(field)
        if isinstance(entry, str) and entry:
            lines.append(f"    {field} = {lua_quote(entry)},")
        elif field in value:
            result.todos.append(
                f"{source.location}: terrain {terrain_id} {field} needs review"
            )
    lines.append("}")
    flags = value.get("flags")
    if isinstance(flags, list) and all(
        isinstance(entry, str) and entry for entry in flags
    ):
        for flag in flags:
            lines.append(f"definition:flag({lua_quote(flag)})")
    elif "flags" in value:
        result.todos.append(
            f"{source.location}: terrain {terrain_id} flags need review"
        )
    for member in ("bash", "deconstruct", "examine_action", "emissions",
                   "harvest_by_season", "coverage", "curtain_transform",
                   "looks_like", "connects_to", "connect_groups",
                   "rotate_to", "phase_targets", "road_cost_multiplier",
                   "signpost_items", "smoke_field_intensity"):
        if member in value:
            result.todos.append(
                f"{source.location}: terrain {terrain_id} {member} needs review"
            )
    status = (
        result.partial if len(result.todos) != todo_count else result.converted
    )
    status.append(f"{source.location}: terrain {terrain_id}")
    lines.extend((content_submit_expression(), ""))
    return "\n".join(lines)


def render_gate(
    source: SourceObject,
    result: MigrationResult,
    *,
    inheritance_corpus: dict[str, dict[str, Any]] | None = None,
) -> str | None:
    value = source.value
    if "copy-from" in value:
        if inheritance_corpus is None:
            result.partial.append(
                f"{source.location}: gate {value.get('id') or '<invalid id>'}"
            )
            result.todos.append(
                f"{source.location}: gate inheritance needs the migration corpus"
            )
            return None
        resolved, todos = resolve_copy_from(
            value,
            inheritance_corpus,
            label=f"gate {value.get('id') or '<invalid id>'}",
            location=source.location,
        )
        for todo in todos:
            result.todos.append(todo)
        if todos:
            result.partial.append(
                f"{source.location}: gate {value.get('id') or '<invalid id>'}"
            )
            return None
        value = resolved
        source = SourceObject(source.path, source.index, resolved)
    gate_id = value.get("id")
    if not safe_platform_id(gate_id):
        result.partial.append(f"{source.location}: gate <invalid id>")
        result.todos.append(
            f"{source.location}: gate needs a stable native id"
        )
        return None
    todo_count = len(result.todos)
    door = value.get("door")
    floor = value.get("floor")
    if not isinstance(door, str) or not door or not isinstance(floor, str) \
            or not floor:
        result.todos.append(
            f"{source.location}: gate {gate_id} door/floor need review"
        )
        door = door if isinstance(door, str) and door else "t_door_o"
        floor = floor if isinstance(floor, str) and floor else "t_floor"
    lines = [
        "local definition = content.Gate {",
        f"    id = {lua_quote(gate_id)},",
        f"    door = {lua_quote(door)},",
        f"    floor = {lua_quote(floor)},",
    ]
    for field in ("moves", "bashing_damage"):
        entry = value.get(field, 0)
        if isinstance(entry, int) and not isinstance(entry, bool) and \
                entry >= 0:
            lines.append(f"    {field} = {entry},")
        else:
            lines.append(f"    {field} = 0,")
            result.todos.append(
                f"{source.location}: gate {gate_id} {field} needs review"
            )
    messages = value.get("messages")
    if isinstance(messages, dict):
        for key, field in (("pull", "pull_message"), ("open", "open_message"),
                           ("close", "close_message"), ("fail", "fail_message")):
            entry = messages.get(key)
            if isinstance(entry, str) and entry:
                lines.append(f"    {field} = {lua_quote(entry)},")
            elif key in messages:
                result.todos.append(
                    f"{source.location}: gate {gate_id} {key} message needs review"
                )
    elif "messages" in value:
        result.todos.append(
            f"{source.location}: gate {gate_id} messages need review"
        )
    lines.append("}")
    walls = value.get("walls")
    if isinstance(walls, list) and all(
        isinstance(entry, str) and entry for entry in walls
    ):
        for wall in walls:
            lines.append(f"definition:wall({lua_quote(wall)})")
    else:
        result.todos.append(
            f"{source.location}: gate {gate_id} walls need review"
        )
    status = (
        result.partial if len(result.todos) != todo_count else result.converted
    )
    status.append(f"{source.location}: gate {gate_id}")
    lines.extend((content_submit_expression(), ""))
    return "\n".join(lines)


def render_fault(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    fault_id = value.get("id")
    if not safe_platform_id(fault_id):
        result.partial.append(f"{source.location}: fault <invalid id>")
        result.todos.append(
            f"{source.location}: fault needs a stable native id"
        )
        return None
    todo_count = len(result.todos)
    name = value.get("name")
    if isinstance(name, dict):
        name = name.get("str")
    if not isinstance(name, str) or not name:
        result.todos.append(f"{source.location}: fault {fault_id} name needs review")
        name = fault_id
    # Legacy faults default to an empty fault_type, never "generic".
    fault_type = value.get("fault_type", "")
    if not isinstance(fault_type, str):
        result.todos.append(f"{source.location}: fault {fault_id} fault_type needs review")
        fault_type = ""
    lines = [
        "local definition = content.Fault {",
        f"    id = {lua_quote(fault_id)},",
        f"    fault_type = {lua_quote(fault_type)},",
        f"    name = {lua_quote(name)},",
    ]
    for field in ("description", "item_prefix", "item_suffix", "message",
                  "color"):
        entry = value.get(field)
        if isinstance(entry, str) and entry:
            lines.append(f"    {field} = {lua_quote(entry)},")
        elif field in value:
            result.todos.append(
                f"{source.location}: fault {fault_id} {field} needs review"
            )
    for source_field, field, default in (
        ("degradation_mod", "degradation_mod", 0),
        ("instant_damage", "instant_damage", 0),
        # Legacy defaults to no vehicle move penalty.
        ("vehicle_move_penalty_mod", "vehicle_move_penalty_mod", 0),
        # Legacy JSON names the encumbrance fields differently.
        ("encumbrance_add", "encumbrance_mod_flat", 0),
    ):
        entry = value.get(source_field, default)
        if isinstance(entry, int) and not isinstance(entry, bool):
            lines.append(f"    {field} = {entry},")
        else:
            lines.append(f"    {field} = {default},")
            result.todos.append(
                f"{source.location}: fault {fault_id} {source_field} needs review"
            )
    for source_field, field, default in (
        ("price_modifier", "price_modifier", 1.0),
        ("contact_area_mod", "contact_area_mod", 1.0),
        ("rolling_resistance_mod", "rolling_resistance_mod", 1.0),
        ("encumbrance_mult", "encumbrance_mod_mult", 1.0),
    ):
        entry = value.get(source_field, default)
        if isinstance(entry, (int, float)) and not isinstance(entry, bool) and \
                entry >= 0:
            lines.append(f"    {field} = {entry},")
        else:
            lines.append(f"    {field} = {default},")
            result.todos.append(
                f"{source.location}: fault {fault_id} {source_field} needs review"
            )
    degradation = value.get("affected_by_degradation")
    if isinstance(degradation, bool):
        lines.append(f"    affected_by_degradation = {lua_boolean(degradation)},")
    elif "affected_by_degradation" in value:
        result.todos.append(
            f"{source.location}: fault {fault_id} affected_by_degradation needs review"
        )
    lines.append("}")
    flags = value.get("flags")
    if isinstance(flags, list) and all(
        isinstance(entry, str) and entry for entry in flags
    ):
        for flag in flags:
            lines.append(f"definition:flag({lua_quote(flag)})")
    elif "flags" in value:
        result.todos.append(f"{source.location}: fault {fault_id} flags need review")
    for member, method in (("block_faults", "block_fault"), ("fixes", "fix")):
        entries = value.get(member)
        if isinstance(entries, list) and all(
            isinstance(entry, str) and entry for entry in entries
        ):
            for entry in entries:
                lines.append(f"definition:{method}({lua_quote(entry)})")
        elif member in value:
            result.todos.append(
                f"{source.location}: fault {fault_id} {member} needs review"
            )
    for member in ("melee_damage_mod", "armor_mod"):
        if member in value:
            result.todos.append(
                f"{source.location}: fault {fault_id} {member} needs review"
            )
    status = (
        result.partial if len(result.todos) != todo_count else result.converted
    )
    status.append(f"{source.location}: fault {fault_id}")
    lines.extend((content_submit_expression(), ""))
    return "\n".join(lines)


def render_fault_fix(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    fix_id = value.get("id")
    if not safe_platform_id(fix_id):
        result.partial.append(f"{source.location}: fault fix <invalid id>")
        result.todos.append(
            f"{source.location}: fault fix needs a stable native id"
        )
        return None
    todo_count = len(result.todos)
    name = value.get("name")
    if isinstance(name, dict):
        name = name.get("str")
    if not isinstance(name, str) or not name:
        result.todos.append(f"{source.location}: fault fix {fix_id} name needs review")
        name = fix_id
    lines = [
        "local definition = content.FaultFix {",
        f"    id = {lua_quote(fix_id)},",
        f"    name = {lua_quote(name)},",
    ]
    if isinstance(value.get("success_msg"), str) and value["success_msg"]:
        lines.append(f"    success_msg = {lua_quote(value['success_msg'])},")
    elif "success_msg" in value:
        result.todos.append(
            f"{source.location}: fault fix {fix_id} success message needs review"
        )
    time_entry = value.get("time")
    if isinstance(time_entry, str):
        seconds = parse_seconds(time_entry)
        if seconds is None:
            seconds = 0
            result.todos.append(
                f"{source.location}: fault fix {fix_id} time needs unit review"
            )
    else:
        seconds = 0
        if "time" in value:
            result.todos.append(
                f"{source.location}: fault fix {fix_id} time needs unit review"
            )
    lines.append(f"    time_seconds = {seconds},")
    for field, default in (("mod_damage", 0), ("mod_degradation", 0)):
        entry = value.get(field, default)
        if isinstance(entry, int) and not isinstance(entry, bool):
            lines.append(f"    {field} = {entry},")
        else:
            lines.append(f"    {field} = {default},")
            result.todos.append(
                f"{source.location}: fault fix {fix_id} {field} needs review"
            )
    lines.append("}")
    skills = value.get("skills")
    if isinstance(skills, dict):
        valid = True
        for skill, level in skills.items():
            if not isinstance(skill, str) or not isinstance(level, int) or \
                    isinstance(level, bool) or level < 0:
                valid = False
                break
        if valid:
            for skill, level in skills.items():
                lines.append(
                    f"definition:requires_skill({lua_quote(skill)}, {level})"
                )
        else:
            result.todos.append(
                f"{source.location}: fault fix {fix_id} skills need review"
            )
    elif isinstance(skills, list) and all(
        isinstance(entry, list) and len(entry) == 2 and
        isinstance(entry[0], str) and isinstance(entry[1], int) and
        not isinstance(entry[1], bool)
        for entry in skills
    ):
        for entry in skills:
            lines.append(
                f"definition:requires_skill({lua_quote(entry[0])}, {entry[1]})"
            )
    elif "skills" in value:
        result.todos.append(
            f"{source.location}: fault fix {fix_id} skills need review"
        )
    for member, method in (("faults_removed", "removes_fault"),
                           ("faults_added", "adds_fault")):
        entries = value.get(member)
        if isinstance(entries, list) and all(
            isinstance(entry, str) and entry for entry in entries
        ):
            for entry in entries:
                lines.append(f"definition:{method}({lua_quote(entry)})")
        elif member in value:
            result.todos.append(
                f"{source.location}: fault fix {fix_id} {member} needs review"
            )
    for member in ("set_variables", "adjust_variables_multiply",
                   "requirements", "using", "time_save_profs",
                   "time_save_flags"):
        if member in value:
            result.todos.append(
                f"{source.location}: fault fix {fix_id} {member} needs review"
            )
    status = (
        result.partial if len(result.todos) != todo_count else result.converted
    )
    status.append(f"{source.location}: fault fix {fix_id}")
    lines.extend((content_submit_expression(), ""))
    return "\n".join(lines)


def render_dream(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    todo_count = len(result.todos)
    category = value.get("category")
    if not isinstance(category, str) or not category:
        result.todos.append(
            f"{source.location}: dream category needs review"
        )
        category = "NONE"
    strength = value.get("strength", 0)
    if not isinstance(strength, int) or isinstance(strength, bool) or \
            strength < 0:
        strength = 0
        result.todos.append(
            f"{source.location}: dream strength needs review"
        )
    lines = [
        "local definition = content.Dream {",
        f"    category = {lua_quote(category)},",
        f"    strength = {strength},",
        "}",
    ]
    messages = value.get("messages")
    if isinstance(messages, list) and all(
        isinstance(entry, str) and entry for entry in messages
    ):
        for message in messages:
            lines.append(f"definition:message({lua_quote(message)})")
    else:
        result.todos.append(
            f"{source.location}: dream messages need review"
        )
    status = (
        result.partial if len(result.todos) != todo_count else result.converted
    )
    status.append(f"{source.location}: dream {category}")
    lines.extend((content_submit_expression(), ""))
    return "\n".join(lines)


def render_achievement(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    achievement_id = value.get("id")
    if not safe_platform_id(achievement_id):
        result.partial.append(f"{source.location}: achievement <invalid id>")
        result.todos.append(
            f"{source.location}: achievement needs a stable native id"
        )
        return None
    todo_count = len(result.todos)
    name = value.get("name")
    if isinstance(name, dict):
        name = name.get("str")
    if not isinstance(name, str) or not name:
        result.todos.append(
            f"{source.location}: achievement {achievement_id} name needs review"
        )
        name = achievement_id
    is_conduct = value.get("type") == "conduct"
    constructor = "Conduct" if is_conduct else "Achievement"
    lines = [
        f"local definition = content.{constructor} {{",
        f"    id = {lua_quote(achievement_id)},",
        f"    name = {lua_quote(name)},",
    ]
    description = value.get("description")
    if isinstance(description, str) and description:
        lines.append(f"    description = {lua_quote(description)},")
    elif "description" in value:
        result.todos.append(
            f"{source.location}: achievement {achievement_id} description needs review"
        )
    lines.append("}")
    hidden_by = value.get("hidden_by")
    if isinstance(hidden_by, list) and all(
        isinstance(entry, str) and entry for entry in hidden_by
    ):
        for entry in hidden_by:
            lines.append(f"definition:hidden_by({lua_quote(entry)})")
    elif "hidden_by" in value:
        result.todos.append(
            f"{source.location}: achievement {achievement_id} hidden_by needs review"
        )
    for member in ("requirements", "time_constraint", "conduct_group",
                   "completion", "event_statistic"):
        if member in value:
            result.todos.append(
                f"{source.location}: achievement {achievement_id} {member} needs review"
            )
    status = (
        result.partial if len(result.todos) != todo_count else result.converted
    )
    status.append(f"{source.location}: achievement {achievement_id}")
    lines.extend((content_submit_expression(), ""))
    return "\n".join(lines)


def render_option_slider(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    slider_id = value.get("id")
    if not bounded_platform_id(slider_id):
        result.partial.append(f"{source.location}: option slider <invalid id>")
        result.todos.append(
            f"{source.location}: option slider needs a stable native id"
        )
        return None
    todo_count = len(result.todos)
    name = display_text(value.get("name"))
    if not name:
        result.todos.append(
            f"{source.location}: option slider {slider_id} name needs review"
        )
        name = slider_id
    context = value.get("context", "")
    if not isinstance(context, str) or "\0" in context:
        result.todos.append(
            f"{source.location}: option slider {slider_id} context needs review"
        )
        context = ""
    default_level = native_integer(value.get("default", 0), 0)
    if default_level is None:
        result.todos.append(
            f"{source.location}: option slider {slider_id} default needs review"
        )
        default_level = 0

    lines = [
        "local definition = content.OptionSlider {",
        f"    id = {lua_quote(slider_id)},",
        f"    name = {lua_quote(name)},",
    ]
    if context:
        lines.append(f"    context = {lua_quote(context)},")
    lines.append(f"    default_level = {default_level},")
    lines.append("    levels = {")

    levels = value.get("levels")
    if not isinstance(levels, list) or not levels:
        result.todos.append(
            f"{source.location}: option slider {slider_id} levels need review"
        )
        levels = []
    for level_index, raw_level in enumerate(levels):
        if not isinstance(raw_level, dict):
            result.todos.append(
                f"{source.location}: option slider {slider_id} level #{level_index} needs review"
            )
            continue
        level = native_integer(raw_level.get("level"), 0)
        level_name = display_text(raw_level.get("name"))
        if level is None or not level_name:
            result.todos.append(
                f"{source.location}: option slider {slider_id} level #{level_index} needs review"
            )
            continue
        unknown_level = unresolved_fields(
            raw_level, {"level", "name", "description", "options"}
        )
        if unknown_level:
            result.todos.append(
                f"{source.location}: option slider {slider_id} level {level} unresolved fields: "
                + ", ".join(unknown_level)
            )
        lines.extend((
            "        {",
            f"            level = {level},",
            f"            name = {lua_quote(level_name)},",
        ))
        description = display_text(raw_level.get("description"))
        if description:
            lines.append(f"            description = {lua_quote(description)},")
        elif "description" in raw_level:
            result.todos.append(
                f"{source.location}: option slider {slider_id} level {level} description needs review"
            )

        raw_options = raw_level.get("options", [])
        if not isinstance(raw_options, list):
            result.todos.append(
                f"{source.location}: option slider {slider_id} level {level} options need review"
            )
            raw_options = []
        lines.append("            options = {")
        for option_index, raw_option in enumerate(raw_options):
            if not isinstance(raw_option, dict):
                result.todos.append(
                    f"{source.location}: option slider {slider_id} level {level} option #{option_index} needs review"
                )
                continue
            option_id = raw_option.get("option")
            option_type = raw_option.get("type")
            option_value = raw_option.get("val")
            valid_value = (
                option_type == "int" and
                native_integer(option_value) is not None
            ) or (
                option_type == "float" and
                finite_number_literal(option_value) is not None
            ) or (
                option_type == "bool" and isinstance(option_value, bool)
            ) or (
                option_type == "string" and isinstance(option_value, str)
            )
            if (
                not isinstance(option_id, str) or not option_id or
                option_type not in {"int", "float", "bool", "string"} or
                not valid_value
            ):
                result.todos.append(
                    f"{source.location}: option slider {slider_id} level {level} option #{option_index} needs review"
                )
                continue
            unknown_option = unresolved_fields(
                raw_option, {"option", "type", "val"}
            )
            if unknown_option:
                result.todos.append(
                    f"{source.location}: option slider {slider_id} level {level} option {option_id} unresolved fields: "
                    + ", ".join(unknown_option)
                )
            literal = lua_scalar_literal(option_value)
            assert literal is not None
            lines.append(
                "                { "
                f"option = {lua_quote(option_id)}, type = {lua_quote(option_type)}, "
                f"value = {literal} "
                "},"
            )
        lines.extend(("            },", "        },"))
    lines.extend(("    },", "}"))
    return finish_catalog(
        source,
        result,
        "option slider",
        slider_id,
        lines,
        {"type", "id", "name", "context", "default", "levels"},
        todo_count,
    )


def render_dimension_region_layout(
    source: SourceObject, result: MigrationResult
) -> str | None:
    value = source.value
    layout_id = value.get("id")
    if not bounded_platform_id(layout_id):
        result.partial.append(
            f"{source.location}: dimension region layout <invalid id>"
        )
        result.todos.append(
            f"{source.location}: dimension region layout needs a stable native id"
        )
        return None
    todo_count = len(result.todos)
    generation_mode = value.get("generation_mode")
    uniform_region = value.get("uniform_region")
    if generation_mode != "UNIFORM":
        result.todos.append(
            f"{source.location}: dimension region layout {layout_id} generation_mode needs review"
        )
        generation_mode = "UNIFORM"
    if not bounded_platform_id(uniform_region):
        result.todos.append(
            f"{source.location}: dimension region layout {layout_id} uniform_region needs review"
        )
        uniform_region = "default"
    lines = [
        "local definition = content.DimensionRegionLayout {",
        f"    id = {lua_quote(layout_id)},",
        f"    generation_mode = {lua_quote(generation_mode)},",
        f"    uniform_region = {lua_quote(uniform_region)},",
        "}",
    ]
    return finish_catalog(
        source,
        result,
        "dimension region layout",
        layout_id,
        lines,
        {"type", "id", "generation_mode", "uniform_region"},
        todo_count,
    )


def render_dimension(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    dimension_id = value.get("id")
    if not bounded_platform_id(dimension_id):
        result.partial.append(f"{source.location}: dimension <invalid id>")
        result.todos.append(
            f"{source.location}: dimension needs a stable native id"
        )
        return None
    todo_count = len(result.todos)
    region_layout = value.get("region_layout")
    if not bounded_platform_id(region_layout):
        result.todos.append(
            f"{source.location}: dimension {dimension_id} region_layout needs review"
        )
        region_layout = "default"
    lines = [
        "local definition = content.Dimension {",
        f"    id = {lua_quote(dimension_id)},",
        f"    region_layout = {lua_quote(region_layout)},",
        "}",
    ]
    return finish_catalog(
        source,
        result,
        "dimension",
        dimension_id,
        lines,
        {"type", "id", "region_layout"},
        todo_count,
    )


def render_omt_placeholder(
    source: SourceObject, result: MigrationResult
) -> str | None:
    value = source.value
    placeholder_id = value.get("id")
    if not bounded_platform_id(placeholder_id):
        result.partial.append(
            f"{source.location}: overmap terrain placeholder <invalid id>"
        )
        result.todos.append(
            f"{source.location}: overmap terrain placeholder needs a stable native id"
        )
        return None
    todo_count = len(result.todos)
    grid = value.get("grid")
    if (
        not isinstance(grid, list) or len(grid) != 24 or
        not all(
            isinstance(row, str) and len(row) == 24 and
            set(row).issubset({"0", "1"})
            for row in grid
        )
    ):
        result.todos.append(
            f"{source.location}: overmap terrain placeholder {placeholder_id} grid needs review"
        )
        grid = []
    lines = [
        "local definition = content.OmtPlaceholder {",
        f"    id = {lua_quote(placeholder_id)},",
        "    grid = {",
    ]
    lines.extend(f"        {lua_quote(row)}," for row in grid)
    lines.extend(("    },", "}"))
    return finish_catalog(
        source,
        result,
        "overmap terrain placeholder",
        placeholder_id,
        lines,
        {"type", "id", "grid"},
        todo_count,
    )


UNREGISTERED_CONTENT_TYPES = frozenset({
    "jmath_function",
    "event_statistic",
    "event_transformation",
    "widget",
    "palette",
    "ter_furn_transform",
    "profession_item_substitutions",
    "relic_procgen_data",
    "city_building",
    "pp_generator",
    "mod_tileset",
    "enchantment",
    "SPELL",
    "bionic",
    "faction",
    "mapgen",
    "mission_definition",
    "mutation",
    "npc",
    "npc_class",
    "overmap_special",
    "overmap_terrain",
    "profession",
    "talk_topic",
    "vehicle",
    "vehicle_part",
    "vehicle_placement",
    "vehicle_spawn",
})


def report_missing_content_registrar(
    source: SourceObject, result: MigrationResult
) -> None:
    kind = source.value.get("type")
    object_id = stable_id(source.value, "<no stable id>")
    label = (
        f"{source.location}: {kind or '<missing type>'} {object_id} "
        "has no native Platform registrar"
    )
    result.partial.append(label)
    result.todos.append(label)


def render_blacklist(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    kind = {
        "ITEM_BLACKLIST": "item",
        "TRAIT_BLACKLIST": "trait",
        "MONSTER_BLACKLIST": "monster",
        "MONSTER_WHITELIST": "monster",
        "SCENARIO_BLACKLIST": "scenario",
        "profession_blacklist": "profession",
        "charge_removal_blacklist": "charge_removal",
        "temperature_removal_blacklist": "temperature_removal",
    }.get(value.get("type", ""))
    if kind is None:
        result.todos.append(
            f"{source.location}: blacklist type needs review"
        )
        return None
    if kind not in ("item", "trait", "monster", "scenario", "profession",
                    "charge_removal", "temperature_removal"):
        result.partial.append(
            f"{source.location}: blacklist kind '{kind}' needs a native registrar"
        )
        result.todos.append(
            f"{source.location}: blacklist kind '{kind}' needs a native registrar"
        )
        return None
    todo_count = len(result.todos)
    # Blacklists are append-style registries: the native registrar forbids
    # edit/replace operations, so these definitions always submit through
    # content.add even in --replace mode.
    blacklist_submit = "content.add(definition)"
    whitelist = value.get("type") == "MONSTER_WHITELIST" or bool(
        value.get("whitelist")
    )
    if kind == "trait":
        entries_key = "traits"
    elif kind == "monster":
        entries_key = "monsters"
    elif kind in ("charge_removal", "temperature_removal"):
        entries_key = "list"
    elif kind == "profession":
        entries_key = "professions"
    elif kind == "scenario":
        entries_key = "scenarios"
    else:
        entries_key = "items"
    entries = value.get(entries_key, value.get("items", []))
    # An empty blacklist is a deliberate legacy value (e.g. the core
    # MONSTER_BLACKLIST starts with no entries) and must render as a
    # zero-entry definition, not as a review TODO.
    if not isinstance(entries, list):
        result.todos.append(
            f"{source.location}: blacklist entries need review"
        )
        return None
    lines = [
        "local definition = content.Blacklist {",
        f"    kind = {lua_quote(kind)},",
        f"    whitelist = {lua_boolean(whitelist)},",
        "}",
    ]
    for entry in entries:
        if isinstance(entry, str) and entry:
            lines.append(f"definition:entry({lua_quote(entry)})")
        else:
            result.todos.append(
                f"{source.location}: blacklist entry needs review"
            )
            break
    status = (
        result.partial if len(result.todos) != todo_count else result.converted
    )
    status.append(f"{source.location}: blacklist {kind}")
    lines.extend((blacklist_submit, ""))
    return "\n".join(lines)


def render_map_extra(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    extra_id = value.get("id")
    if not safe_platform_id(extra_id):
        result.partial.append(f"{source.location}: map extra <invalid id>")
        result.todos.append(
            f"{source.location}: map extra needs a stable native id"
        )
        return None
    todo_count = len(result.todos)
    name = value.get("name")
    if isinstance(name, dict):
        name = name.get("str")
    if not isinstance(name, str) or not name:
        result.todos.append(
            f"{source.location}: map extra {extra_id} name needs review"
        )
        name = extra_id
    lines = [
        "local definition = content.MapExtra {",
        f"    id = {lua_quote(extra_id)},",
        f"    name = {lua_quote(name)},",
    ]
    description = value.get("description")
    if isinstance(description, str) and description:
        lines.append(f"    description = {lua_quote(description)},")
    generator = value.get("generator")
    if isinstance(generator, dict):
        generator_id = generator.get("generator_id")
        if isinstance(generator_id, str) and generator_id:
            lines.append(f"    generator_id = {lua_quote(generator_id)},")
        else:
            result.todos.append(
                f"{source.location}: map extra {extra_id} generator needs review"
            )
    elif "generator" in value:
        result.todos.append(
            f"{source.location}: map extra {extra_id} generator needs review"
        )
    symbol = value.get("sym")
    if isinstance(symbol, str) and symbol:
        lines.append(f"    symbol = {lua_quote(symbol)},")
    elif "sym" in value:
        result.todos.append(
            f"{source.location}: map extra {extra_id} symbol needs review"
        )
    color = value.get("color")
    if isinstance(color, str) and color:
        lines.append(f"    color = {lua_quote(color)},")
    elif "color" in value:
        result.todos.append(
            f"{source.location}: map extra {extra_id} color needs review"
        )
    lines.append("}")
    flags = value.get("flags")
    if isinstance(flags, list) and all(
        isinstance(entry, str) and entry for entry in flags
    ):
        for flag in flags:
            lines.append(f"definition:flag({lua_quote(flag)})")
    elif "flags" in value:
        result.todos.append(
            f"{source.location}: map extra {extra_id} flags need review"
        )
    for member in ("min_max_zlevel", "autonote_visibility"):
        if member in value:
            result.todos.append(
                f"{source.location}: map extra {extra_id} {member} needs review"
            )
    status = (
        result.partial if len(result.todos) != todo_count else result.converted
    )
    status.append(f"{source.location}: map extra {extra_id}")
    lines.extend((content_submit_expression(), ""))
    return "\n".join(lines)


def render_weather_generator(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    generator_id = value.get("id")
    if not safe_platform_id(generator_id):
        result.partial.append(
            f"{source.location}: weather generator <invalid id>"
        )
        result.todos.append(
            f"{source.location}: weather generator needs a stable native id"
        )
        return None
    todo_count = len(result.todos)
    lines = [
        "local definition = content.WeatherGenerator {",
        f"    id = {lua_quote(generator_id)},",
    ]
    for field, default in (
        ("base_temperature", 0.0), ("base_humidity", 0.0),
        ("base_pressure", 0.0), ("base_wind", 0.0),
    ):
        entry = value.get(field, default)
        if isinstance(entry, (int, float)) and not isinstance(entry, bool):
            lines.append(f"    {field} = {entry},")
        else:
            lines.append(f"    {field} = {default},")
            result.todos.append(
                f"{source.location}: weather generator {generator_id} {field} needs review"
            )
    for field in (
        "base_wind_distrib_peaks", "summer_temp_manual_mod",
        "spring_temp_manual_mod", "autumn_temp_manual_mod",
        "winter_temp_manual_mod", "spring_humidity_manual_mod",
        "summer_humidity_manual_mod", "autumn_humidity_manual_mod",
        "winter_humidity_manual_mod",
    ):
        entry = value.get(field, 0)
        if isinstance(entry, int) and not isinstance(entry, bool):
            lines.append(f"    {field} = {entry},")
        elif field in value:
            result.todos.append(
                f"{source.location}: weather generator {generator_id} {field} needs review"
            )
    lines.append("}")
    for member, method in (("weather_black_list", "blacklisted_weather"),
                           ("weather_white_list", "whitelisted_weather")):
        entries = value.get(member)
        if isinstance(entries, list) and all(
            isinstance(entry, str) and entry for entry in entries
        ):
            for entry in entries:
                lines.append(f"definition:{method}({lua_quote(entry)})")
        elif member in value:
            result.todos.append(
                f"{source.location}: weather generator {generator_id} {member} needs review"
            )
    for member in ("weather_types", "initial_weather"):
        if member in value:
            result.todos.append(
                f"{source.location}: weather generator {generator_id} {member} needs review"
            )
    status = (
        result.partial if len(result.todos) != todo_count else result.converted
    )
    status.append(f"{source.location}: weather generator {generator_id}")
    lines.extend((content_submit_expression(), ""))
    return "\n".join(lines)


def render_migration(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    kind_map = {
        "MIGRATION": "item",
        "migration": "item",
        "item_migration": "item",
        "TRAIT_MIGRATION": "mutation",
        "spell_migration": "spell",
        "camp_migration": "camp",
        "mod_migration": "mod",
        "bionic_migration": "bionic",
        "effect_migration": "effect",
        "field_type_migration": "field_type",
        "oter_id_migration": "oter",
        "overmap_special_migration": "overmap_special",
        "proficiency_migration": "proficiency",
        "ter_furn_migration": "terrain",
        "trap_migration": "trap",
        "var_migration": "var",
        "vehicle_part_migration": "vehicle_part",
    }
    kind = kind_map.get(value.get("type", ""))
    if kind is None:
        result.partial.append(f"{source.location}: migration type needs review")
        result.todos.append(
            f"{source.location}: migration type needs a native registrar"
        )
        return None
    todo_count = len(result.todos)
    # Migrations are append-style registries: the native registrar forbids
    # edit/replace operations, and its apply overwrites by from id, so these
    # definitions always submit through content.add even in --replace mode.
    migration_submit = "content.add(definition)"
    if kind == "terrain" or kind == "furniture":
        from_field = "from_ter" if kind == "terrain" else "from_furn"
        from_id = value.get(from_field)
        to_id = value.get("to_ter") if kind == "terrain" else value.get("to_furn")
        if kind == "terrain" and not isinstance(from_id, str):
            kind = "furniture"
            from_field = "from_furn"
            from_id = value.get(from_field)
            to_id = value.get("to_furn")
        if not isinstance(from_id, str) or not from_id:
            result.todos.append(
                f"{source.location}: migration from id needs review"
            )
            from_id = ""
        if not isinstance(to_id, str) or not to_id:
            result.todos.append(
                f"{source.location}: migration to id needs review"
            )
            to_id = ""
    elif kind == "oter":
        pairs = value.get("oter_ids")
        if isinstance(pairs, dict) and pairs:
            lines = []
            for from_id, to_id in pairs.items():
                if not isinstance(from_id, str) or not isinstance(to_id, str):
                    result.todos.append(
                        f"{source.location}: migration oter_ids entry needs review"
                    )
                    continue
                # Each pair is wrapped in its own do/end block: a single
                # oter_ids object expands to hundreds of definitions and must
                # not exhaust the 200-local Lua limit.
                lines.extend(
                    (
                        "do",
                        "local definition = content.Migration {",
                        f"    kind = {lua_quote(kind)},",
                        f"    from = {lua_quote(from_id)},",
                        f"    to = {lua_quote(to_id)},",
                        "}",
                        migration_submit,
                        "end",
                        "",
                    )
                )
            status = (
                result.partial if len(result.todos) != todo_count
                else result.converted
            )
            status.append(f"{source.location}: migration {kind}")
            return "\n".join(lines)
        result.partial.append(
            f"{source.location}: migration oter_ids needs review"
        )
        result.todos.append(
            f"{source.location}: migration oter_ids needs review"
        )
        return None
    elif kind == "overmap_special":
        from_id = value.get("id")
        to_id = value.get("new_id", "")
    elif kind == "trap":
        from_id = value.get("from_trap")
        to_id = value.get("to_trap")
    elif kind == "field_type":
        from_id = value.get("from_field_type")
        to_id = value.get("to_field_type")
    elif kind in {"item", "mutation", "spell", "camp", "mod"}:
        from_id = value.get("id") or value.get("from") or value.get("from_id")
        to_id = value.get("replace") or value.get("to") or value.get("to_id") or ""
    else:
        from_id = value.get("from")
        to_id = value.get("to", "")
    if not isinstance(from_id, str) or not from_id:
        result.todos.append(f"{source.location}: migration from id needs review")
        from_id = ""
    if not isinstance(to_id, str):
        result.todos.append(f"{source.location}: migration to id needs review")
        to_id = ""
    # do/end wrapper keeps every definition from counting against the
    # 200-local limit in a file with hundreds of migration pairs.
    lines = [
        "do",
        "local definition = content.Migration {",
        f"    kind = {lua_quote(kind)},",
        f"    from = {lua_quote(from_id)},",
        f"    to = {lua_quote(to_id)},",
        "}",
        migration_submit,
        "end",
        "",
    ]
    status = (
        result.partial if len(result.todos) != todo_count else result.converted
    )
    status.append(f"{source.location}: migration {kind}")
    return "\n".join(lines)


def render_shopkeeper(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    rule_id = value.get("id")
    if not safe_platform_id(rule_id):
        result.partial.append(f"{source.location}: shopkeeper rule <invalid id>")
        result.todos.append(
            f"{source.location}: shopkeeper rule needs a stable native id"
        )
        return None
    todo_count = len(result.todos)
    kind = value.get("type")
    builder = {
        "shopkeeper_blacklist": "ShopkeeperBlacklist",
        "shopkeeper_whitelist": "ShopkeeperWhitelist",
        "shopkeeper_consumption_rates": "ShopkeeperConsumptionRates",
    }[kind]
    lines = [
        f"local definition = content.{builder} {{",
        f"    id = {lua_quote(rule_id)},",
    ]
    if kind == "shopkeeper_consumption_rates":
        default_rate = value.get("default_rate", 0)
        if isinstance(default_rate, int) and not isinstance(default_rate, bool):
            lines.append(f"    default_rate = {default_rate},")
        else:
            lines.append("    default_rate = 0,")
            result.todos.append(
                f"{source.location}: shopkeeper rule {rule_id} default_rate needs review"
            )
    elif kind == "shopkeeper_whitelist" and isinstance(value.get("message"), str):
        lines.append(f"    message = {lua_quote(value['message'])},")
    lines.append("}")
    entries = value.get("entries")
    if isinstance(entries, list) and entries:
        for entry in entries:
            if not isinstance(entry, dict):
                result.todos.append(
                    f"{source.location}: shopkeeper rule {rule_id} entry needs review"
                )
                continue
            if "condition" in entry:
                result.todos.append(
                    f"{source.location}: shopkeeper rule {rule_id} entry condition needs review"
                )
            if "rate" in entry:
                result.todos.append(
                    f"{source.location}: shopkeeper rule {rule_id} entry rate needs review"
                )
            item = entry.get("item", "")
            category = entry.get("category", "")
            item_group = entry.get("group", "")
            message = entry.get("message", "")
            fields = (item, category, item_group, message)
            if not all(isinstance(field, str) for field in fields):
                result.todos.append(
                    f"{source.location}: shopkeeper rule {rule_id} entry fields need review"
                )
                continue
            lines.append(
                f"definition:entry({lua_quote(item)}, {lua_quote(category)}, "
                f"{lua_quote(item_group)}, {lua_quote(message)})"
            )
    elif "entries" in value:
        result.todos.append(
            f"{source.location}: shopkeeper rule {rule_id} entries need review"
        )
    status = (
        result.partial if len(result.todos) != todo_count else result.converted
    )
    status.append(f"{source.location}: shopkeeper rule {rule_id}")
    lines.extend((content_submit_expression(), ""))
    return "\n".join(lines)


def render_monster_adjustment(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    todo_count = len(result.todos)
    species = value.get("species")
    if not isinstance(species, str) or not species:
        result.partial.append(
            f"{source.location}: monster adjustment species needs review"
        )
        result.todos.append(
            f"{source.location}: monster adjustment species needs review"
        )
        return None
    lines = [
        "local definition = content.MonsterAdjustment {",
        f"    species = {lua_quote(species)},",
    ]
    stat_entry = value.get("stat")
    if isinstance(stat_entry, dict):
        stat_name = stat_entry.get("name")
        stat_adjust = stat_entry.get("modifier", 1.0)
        if isinstance(stat_name, str) and isinstance(stat_adjust, (int, float)) and \
                not isinstance(stat_adjust, bool):
            lines.append(f"    stat = {lua_quote(stat_name)},")
            lines.append(f"    stat_adjust = {stat_adjust},")
        else:
            result.todos.append(
                f"{source.location}: monster adjustment stat needs review"
            )
    elif "stat" in value:
        result.todos.append(
            f"{source.location}: monster adjustment stat needs review"
        )
    flag_entry = value.get("flag")
    if isinstance(flag_entry, dict):
        flag_name = flag_entry.get("name")
        flag_val = flag_entry.get("value", False)
        if isinstance(flag_name, str) and isinstance(flag_val, bool):
            lines.append(f"    flag = {lua_quote(flag_name)},")
            lines.append(f"    flag_val = {lua_boolean(flag_val)},")
        else:
            result.todos.append(
                f"{source.location}: monster adjustment flag needs review"
            )
    elif "flag" in value:
        result.todos.append(
            f"{source.location}: monster adjustment flag needs review"
        )
    special = value.get("special")
    if isinstance(special, str) and special:
        lines.append(f"    special = {lua_quote(special)},")
    elif "special" in value:
        result.todos.append(
            f"{source.location}: monster adjustment special needs review"
        )
    lines.append("}")
    status = (
        result.partial if len(result.todos) != todo_count else result.converted
    )
    status.append(f"{source.location}: monster adjustment {species}")
    lines.extend((content_submit_expression(), ""))
    return "\n".join(lines)


def render_sound_effect(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    sound_id = value.get("id")
    if not safe_platform_id(sound_id):
        result.partial.append(f"{source.location}: sound effect <invalid id>")
        result.todos.append(
            f"{source.location}: sound effect needs a stable native id"
        )
        return None
    todo_count = len(result.todos)
    variants = value.get("variant", "default")
    if isinstance(variants, str):
        variants = [variants]
    if not isinstance(variants, list) or not variants or not all(
        safe_platform_id(entry) for entry in variants
    ):
        result.todos.append(
            f"{source.location}: sound effect {sound_id} variants need review"
        )
        variants = ["default"]
    files = value.get("files")
    if not isinstance(files, list) or not all(
        isinstance(entry, str) and entry for entry in files
    ):
        result.todos.append(
            f"{source.location}: sound effect {sound_id} files need review"
        )
        files = []
    volume = value.get("volume", 100)
    if not isinstance(volume, int) or isinstance(volume, bool):
        result.todos.append(
            f"{source.location}: sound effect {sound_id} volume needs review"
        )
        volume = 100
    season = value.get("season", "")
    if not isinstance(season, str):
        result.todos.append(
            f"{source.location}: sound effect {sound_id} season needs review"
        )
        season = ""
    indoors = value.get("is_indoors")
    night = value.get("is_night")
    if indoors is not None and not isinstance(indoors, bool):
        result.todos.append(
            f"{source.location}: sound effect {sound_id} is_indoors needs review"
        )
        indoors = None
    if night is not None and not isinstance(night, bool):
        result.todos.append(
            f"{source.location}: sound effect {sound_id} is_night needs review"
        )
        night = None
    lines: list[str] = []
    for variant in variants:
        lines.extend(
            (
                "local definition = content.SoundEffect {",
                f"    id = {lua_quote(sound_id)},",
                f"    variant = {lua_quote(variant)},",
            )
        )
        if season:
            lines.append(f"    season = {lua_quote(season)},")
        if indoors is not None:
            lines.append(f"    is_indoors = {lua_boolean(indoors)},")
        if night is not None:
            lines.append(f"    is_night = {lua_boolean(night)},")
        lines.append(f"    volume = {volume},")
        lines.append("}")
        for file in files:
            lines.append(f"definition:file({lua_quote(file)})")
        lines.extend((content_submit_expression(), ""))
    status = (
        result.partial if len(result.todos) != todo_count else result.converted
    )
    status.append(f"{source.location}: sound effect {sound_id}")
    return "\n".join(lines)


def render_sound_effect_preload(
    source: SourceObject, result: MigrationResult
) -> str | None:
    value = source.value
    entries = value.get("preload")
    if not isinstance(entries, list) or not entries:
        result.partial.append(
            f"{source.location}: sound effect preload list needs review"
        )
        result.todos.append(
            f"{source.location}: sound effect preload list needs review"
        )
        return None
    todo_count = len(result.todos)
    lines: list[str] = []
    for entry in entries:
        if not isinstance(entry, dict):
            result.todos.append(
                f"{source.location}: sound effect preload entry needs review"
            )
            continue
        preload_id = entry.get("id")
        if not safe_platform_id(preload_id):
            result.todos.append(
                f"{source.location}: sound effect preload needs a stable native id"
            )
            continue
        variants = entry.get("variant", "default")
        if isinstance(variants, str):
            variants = [variants]
        if not isinstance(variants, list) or not variants or not all(
            safe_platform_id(variant) for variant in variants
        ):
            result.todos.append(
                f"{source.location}: sound effect preload {preload_id} variants need review"
            )
            variants = ["default"]
        season = entry.get("season", "")
        if not isinstance(season, str):
            season = ""
        indoors = entry.get("is_indoors")
        night = entry.get("is_night")
        if indoors is not None and not isinstance(indoors, bool):
            indoors = None
        if night is not None and not isinstance(night, bool):
            night = None
        for variant in variants:
            lines.extend(
                (
                    "local preload = content.SoundEffectPreload {",
                    f"    id = {lua_quote(preload_id)},",
                    f"    variant = {lua_quote(variant)},",
                )
            )
            if season:
                lines.append(f"    season = {lua_quote(season)},")
            if indoors is not None:
                lines.append(f"    is_indoors = {lua_boolean(indoors)},")
            if night is not None:
                lines.append(f"    is_night = {lua_boolean(night)},")
            lines.extend(("}", "content.add(preload)", ""))
    status = (
        result.partial if len(result.todos) != todo_count else result.converted
    )
    status.append(f"{source.location}: sound effect preload")
    return "\n".join(lines)


def render_speed_description(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    description_id = value.get("id")
    if not safe_platform_id(description_id):
        result.partial.append(f"{source.location}: speed description <invalid id>")
        result.todos.append(
            f"{source.location}: speed description needs a stable native id"
        )
        return None
    todo_count = len(result.todos)
    lines = [
        "local definition = content.SpeedDescription {",
        f"    id = {lua_quote(description_id)},",
        "}",
    ]
    values = value.get("values")
    if not isinstance(values, list) or not values:
        result.todos.append(
            f"{source.location}: speed description {description_id} values need review"
        )
    else:
        for entry in values:
            if not isinstance(entry, dict):
                result.todos.append(
                    f"{source.location}: speed description {description_id} value needs review"
                )
                continue
            threshold = entry.get("value")
            raw_descriptions = entry.get("descriptions")
            description_values = (
                raw_descriptions if isinstance(raw_descriptions, list) else [raw_descriptions]
            )
            descriptions = [display_text(text) for text in description_values]
            if (
                not isinstance(threshold, (int, float)) or
                isinstance(threshold, bool) or
                not math.isfinite(threshold) or
                threshold < 0 or
                not descriptions or
                any(not text for text in descriptions)
            ):
                result.todos.append(
                    f"{source.location}: speed description {description_id} value needs review"
                )
                continue
            rendered = "{ " + ", ".join(lua_quote(text) for text in descriptions) + " }"
            lines.append(f"definition:value({threshold!r}, {rendered})")
    return finish_catalog(
        source,
        result,
        "speed description",
        description_id,
        lines,
        {"type", "id", "values"},
        todo_count,
    )


def render_harvest_drop_type(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    drop_id = value.get("id")
    if not safe_platform_id(drop_id):
        result.partial.append(f"{source.location}: harvest drop type <invalid id>")
        result.todos.append(
            f"{source.location}: harvest drop type needs a stable native id"
        )
        return None
    todo_count = len(result.todos)
    lines = [
        "local definition = content.HarvestDropType {",
        f"    id = {lua_quote(drop_id)},",
    ]
    text_fields = {
        "msg_fielddress_success": "field_dress_success",
        "msg_fielddress_fail": "field_dress_failure",
        "msg_butcher_success": "butcher_success",
        "msg_butcher_fail": "butcher_failure",
        "msg_dissect_success": "dissect_success",
        "msg_dissect_fail": "dissect_failure",
    }
    for source_name, target_name in text_fields.items():
        if source_name not in value:
            continue
        raw = value[source_name]
        if isinstance(raw, str):
            lines.append(f"    {target_name} = {lua_quote(raw)},")
        else:
            result.todos.append(
                f"{source.location}: harvest drop type {drop_id} {source_name} needs review"
            )
    for source_name, target_name in (("group", "item_group"), ("dissect_only", "dissect_only")):
        raw = value.get(source_name, False)
        if isinstance(raw, bool):
            lines.append(f"    {target_name} = {'true' if raw else 'false'},")
        else:
            result.todos.append(
                f"{source.location}: harvest drop type {drop_id} {source_name} needs review"
            )
    lines.append("}")
    skills = value.get("harvest_skills")
    if isinstance(skills, str) and skills:
        lines.append(f"definition:skill({lua_quote(skills)})")
    elif isinstance(skills, list) and skills and all(safe_platform_id(skill) for skill in skills):
        lines.extend(f"definition:skill({lua_quote(skill)})" for skill in skills)
    elif skills is not None:
        result.todos.append(
            f"{source.location}: harvest drop type {drop_id} harvest skills need review"
        )
    return finish_catalog(
        source,
        result,
        "harvest drop type",
        drop_id,
        lines,
        {"type", "id", "group", "dissect_only", "harvest_skills", *text_fields.keys()},
        todo_count,
    )


def render_harvest(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    harvest_id = value.get("id")
    if not safe_platform_id(harvest_id):
        result.partial.append(f"{source.location}: harvest <invalid id>")
        result.todos.append(f"{source.location}: harvest needs a stable native id")
        return None
    todo_count = len(result.todos)
    lines = [
        "local definition = content.Harvest {",
        f"    id = {lua_quote(harvest_id)},",
    ]
    if "message" in value:
        message = display_text(value["message"])
        if message:
            lines.append(f"    message = {lua_quote(message)},")
        else:
            result.todos.append(
                f"{source.location}: harvest {harvest_id} message needs review"
            )
    for source_name, target_name, default in (
        ("leftovers", "leftovers", "ruined_chunks"),
        ("butchery_requirements", "butchery_requirements", "default"),
    ):
        raw = value.get(source_name, default)
        if safe_platform_id(raw):
            lines.append(f"    {target_name} = {lua_quote(raw)},")
        else:
            lines.append(f"    {target_name} = {lua_quote(default)},")
            result.todos.append(
                f"{source.location}: harvest {harvest_id} {source_name} needs review"
            )
    lines.append("}")

    def finite_number(raw: Any) -> bool:
        return (
            isinstance(raw, (int, float)) and
            not isinstance(raw, bool) and
            math.isfinite(raw) and
            abs(raw) <= 3.402823466e38
        )

    def number_pair(raw: Any, default: tuple[float, float], field_name: str) -> tuple[Any, Any]:
        if (
            isinstance(raw, list) and
            len(raw) == 2 and
            finite_number(raw[0]) and
            finite_number(raw[1]) and
            raw[0] <= raw[1]
        ):
            return raw[0], raw[1]
        result.todos.append(
            f"{source.location}: harvest {harvest_id} {field_name} needs review"
        )
        return default

    entries = value.get("entries", [])
    if not isinstance(entries, list):
        result.todos.append(
            f"{source.location}: harvest {harvest_id} entries need review"
        )
        entries = []
    outputs: set[str] = set()
    for index, raw_entry in enumerate(entries):
        if not isinstance(raw_entry, dict):
            result.todos.append(
                f"{source.location}: harvest {harvest_id} drop {index} needs review"
            )
            continue
        unresolved_entry = sorted(
            key
            for key in raw_entry
            if key
            not in {
                "drop",
                "type",
                "base_num",
                "scale_num",
                "max",
                "mass_ratio",
                "flags",
                "faults",
            } and
            not key.startswith("//")
        )
        if unresolved_entry:
            result.todos.append(
                f"{source.location}: harvest {harvest_id} drop {index} unresolved fields: " +
                ", ".join(unresolved_entry)
            )
        output = raw_entry.get("drop")
        if not safe_platform_id(output) or output in outputs:
            result.todos.append(
                f"{source.location}: harvest {harvest_id} drop {index} needs a unique native output id"
            )
            continue
        outputs.add(output)
        base_minimum, base_maximum = number_pair(
            raw_entry.get("base_num", [1, 1]), (1, 1), f"drop {output} base_num"
        )
        skill_minimum, skill_maximum = number_pair(
            raw_entry.get("scale_num", [0, 0]), (0, 0), f"drop {output} scale_num"
        )
        maximum = raw_entry.get("max", 1000)
        if (
            not isinstance(maximum, int) or
            isinstance(maximum, bool) or
            not 0 < maximum <= NATIVE_INT_MAX
        ):
            result.todos.append(
                f"{source.location}: harvest {harvest_id} drop {output} max needs review"
            )
            maximum = 1000
        mass_ratio = raw_entry.get("mass_ratio", 0)
        if not finite_number(mass_ratio) or not 0 <= mass_ratio <= 1:
            result.todos.append(
                f"{source.location}: harvest {harvest_id} drop {output} mass_ratio needs review"
            )
            mass_ratio = 0
        lines.extend(
            (
                "definition:drop {",
                f"    output = {lua_quote(output)},",
            )
        )
        category = raw_entry.get("type")
        if category is not None:
            if safe_platform_id(category):
                lines.append(f"    category = {lua_quote(category)},")
            else:
                result.todos.append(
                    f"{source.location}: harvest {harvest_id} drop {output} type needs review"
                )
        lines.extend(
            (
                f"    base_minimum = {lua_number(base_minimum)},",
                f"    base_maximum = {lua_number(base_maximum)},",
                f"    skill_minimum = {lua_number(skill_minimum)},",
                f"    skill_maximum = {lua_number(skill_maximum)},",
                f"    maximum = {maximum},",
                f"    mass_ratio = {lua_number(mass_ratio)},",
                "}",
            )
        )
        for source_name, method in (("flags", "item_flag"), ("faults", "item_fault")):
            raw_values = raw_entry.get(source_name, [])
            if not isinstance(raw_values, list):
                result.todos.append(
                    f"{source.location}: harvest {harvest_id} drop {output} {source_name} need review"
                )
                continue
            for raw_value in raw_values:
                if safe_platform_id(raw_value):
                    lines.append(
                        f"definition:{method}({lua_quote(output)}, {lua_quote(raw_value)})"
                    )
                else:
                    result.todos.append(
                        f"{source.location}: harvest {harvest_id} drop {output} {source_name} need review"
                    )
    return finish_catalog(
        source,
        result,
        "harvest",
        harvest_id,
        lines,
        {"type", "id", "message", "leftovers", "butchery_requirements", "entries"},
        todo_count,
    )


def render_behavior(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    behavior_id = value.get("id")
    if not safe_platform_id(behavior_id):
        result.partial.append(f"{source.location}: behavior <invalid id>")
        result.todos.append(f"{source.location}: behavior needs a stable native id")
        return None
    todo_count = len(result.todos)
    lines = [
        "local definition = content.Behavior {",
        f"    id = {lua_quote(behavior_id)},",
    ]

    raw_children = value.get("children")
    children: list[str] = []
    if raw_children is not None:
        if (
            isinstance(raw_children, list) and
            bool(raw_children) and
            all(safe_platform_id(child) for child in raw_children) and
            len(set(raw_children)) == len(raw_children)
        ):
            children = raw_children
        else:
            result.todos.append(
                f"{source.location}: behavior {behavior_id} children need review"
            )

    raw_goal = value.get("goal")
    goal = (
        raw_goal
        if isinstance(raw_goal, str) and bool(raw_goal) and "\0" not in raw_goal
        else None
    )
    if raw_goal is not None and goal is None:
        result.todos.append(
            f"{source.location}: behavior {behavior_id} goal needs review"
        )
    if children and goal is not None:
        result.todos.append(
            f"{source.location}: behavior {behavior_id} has both children and goal; goal was preserved as a TODO"
        )
        goal = None
    if not children and goal is None:
        goal = f"TODO_{behavior_id}_goal"
        result.todos.append(
            f"{source.location}: behavior {behavior_id} needs exactly one goal or child graph"
        )

    raw_strategy = value.get("strategy")
    if children:
        if safe_platform_id(raw_strategy):
            lines.append(f"    strategy = {lua_quote(raw_strategy)},")
        else:
            lines.append('    strategy = "fallback",')
            result.todos.append(
                f"{source.location}: behavior {behavior_id} branch strategy needs review"
            )
    elif raw_strategy is not None:
        if safe_platform_id(raw_strategy):
            lines.append(f"    strategy = {lua_quote(raw_strategy)},")
        else:
            result.todos.append(
                f"{source.location}: behavior {behavior_id} strategy needs review"
            )
    if goal is not None:
        lines.append(f"    goal = {lua_quote(goal)},")
    lines.append("}")
    lines.extend(f"definition:child({lua_quote(child)})" for child in children)

    raw_conditions = value.get("conditions", [])
    if not isinstance(raw_conditions, list):
        result.todos.append(
            f"{source.location}: behavior {behavior_id} conditions need review"
        )
        raw_conditions = []
    for index, raw_condition in enumerate(raw_conditions):
        if not isinstance(raw_condition, dict):
            result.todos.append(
                f"{source.location}: behavior {behavior_id} condition {index} needs review"
            )
            continue
        unknown = unresolved_fields(
            raw_condition, {"predicate", "argument", "invert_result"}
        )
        if unknown:
            result.todos.append(
                f"{source.location}: behavior {behavior_id} condition {index} unresolved fields: " +
                ", ".join(unknown)
            )
        predicate = raw_condition.get("predicate")
        argument = raw_condition.get("argument", "")
        inverted = raw_condition.get("invert_result", False)
        if (
            not safe_platform_id(predicate) or
            not isinstance(argument, str) or
            "\0" in argument or
            not isinstance(inverted, bool)
        ):
            result.todos.append(
                f"{source.location}: behavior {behavior_id} condition {index} needs review"
            )
            continue
        lines.append(
            "definition:when_native("
            f"{lua_quote(predicate)}, {lua_quote(argument)}, "
            f"{'true' if inverted else 'false'})"
        )

    raw_score = value.get("score")
    if raw_score is not None:
        argument = value.get("score_argument", "")
        if safe_platform_id(raw_score) and isinstance(argument, str) and "\0" not in argument:
            lines.append(
                f"definition:score_native({lua_quote(raw_score)}, {lua_quote(argument)})"
            )
        else:
            result.todos.append(
                f"{source.location}: behavior {behavior_id} score needs review"
            )
    elif "score_argument" in value:
        result.todos.append(
            f"{source.location}: behavior {behavior_id} score_argument has no score"
        )

    return finish_catalog(
        source,
        result,
        "behavior",
        behavior_id,
        lines,
        {
            "type",
            "id",
            "strategy",
            "children",
            "conditions",
            "goal",
            "score",
            "score_argument",
        },
        todo_count,
    )


def display_texts(value: Any) -> list[str] | None:
    values = value if isinstance(value, list) else [value]
    rendered: list[str] = []
    for entry in values:
        text = display_text(entry)
        if not text:
            return None
        rendered.append(text)
    return rendered


def string_ids(value: Any) -> list[str] | None:
    if not isinstance(value, list) or not all(safe_platform_id(entry) for entry in value):
        return None
    return value


def lua_string_table(values: list[str]) -> str:
    return "{ " + ", ".join(lua_quote(value) for value in values) + " }"


def finite_number(value: Any, minimum: float | None = None,
                  maximum: float | None = None) -> int | float | None:
    literal = finite_number_literal(value)
    if literal is None:
        return None
    if minimum is not None and literal < minimum:
        return None
    if maximum is not None and literal > maximum:
        return None
    return literal


def native_integer(value: Any, minimum: int = NATIVE_INT_MIN,
                   maximum: int = NATIVE_INT_MAX) -> int | None:
    if (
        not isinstance(value, int) or
        isinstance(value, bool) or
        value < minimum or
        value > maximum
    ):
        return None
    return value


def pair_range(value: Any, parser: Any) -> tuple[Any, Any] | None:
    values = value if isinstance(value, list) else [value, value]
    if len(values) != 2:
        return None
    minimum = parser(values[0])
    maximum = parser(values[1])
    if minimum is None or maximum is None or maximum < minimum:
        return None
    return minimum, maximum


def append_numeric_map(
    lines: list[str], raw: Any, method: str, result: MigrationResult,
    source: SourceObject, label: str, *, non_negative: bool = True,
) -> None:
    if not isinstance(raw, dict):
        result.todos.append(f"{source.location}: {label} needs review")
        return
    for raw_id, raw_value in raw.items():
        value = finite_number(raw_value, 0.0 if non_negative else None)
        if not safe_platform_id(raw_id) or value is None:
            result.todos.append(f"{source.location}: {label} entry needs review")
            continue
        lines.append(
            f"definition:{method}({lua_quote(raw_id)}, {lua_number(value)})"
        )


def render_monster_attack(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    attack_id = value.get("id")
    if not safe_platform_id(attack_id):
        result.partial.append(f"{source.location}: monster attack <invalid id>")
        result.todos.append(f"{source.location}: monster attack needs a stable native id")
        return None
    todo_count = len(result.todos)
    cooldown = finite_number(value.get("cooldown", 1), 0.0, NATIVE_INT_MAX)
    if cooldown is None:
        cooldown = 1
        result.todos.append(
            f"{source.location}: monster attack {attack_id} cooldown needs review"
        )
    handler_id = f"migrated.monster_attack.{attack_id}"
    lines = [
        f"runtime.handler({lua_quote(handler_id)}, function(payload)",
        "    -- TODO: rewrite the legacy attack actor with native Lua services.",
        "    return false",
        "end, 1)",
        "local definition = content.MonsterAttack {",
        f"    id = {lua_quote(attack_id)},",
        f"    cooldown = {lua_number(cooldown)},",
        "}",
        f"definition:policy({lua_quote(handler_id)})",
    ]
    result.todos.append(
        f"{source.location}: monster attack {attack_id} needs its legacy actor rewritten as a named Lua handler"
    )
    return finish_catalog(
        source,
        result,
        "monster attack",
        attack_id,
        lines,
        {"type", "id", "cooldown"},
        todo_count,
    )


def render_effect_type(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    effect_id = value.get("id")
    if not safe_platform_id(effect_id):
        result.partial.append(f"{source.location}: effect type <invalid id>")
        result.todos.append(f"{source.location}: effect type needs a stable native id")
        return None
    todo_count = len(result.todos)
    names = display_texts(value.get("name"))
    descriptions = display_texts(value.get("desc"))
    if names is None:
        names = [effect_id]
        result.todos.append(f"{source.location}: effect type {effect_id} names need review")
    if descriptions is None:
        descriptions = [effect_id]
        result.todos.append(
            f"{source.location}: effect type {effect_id} descriptions need review"
        )
    lines = ["local definition = content.EffectType {", f"    id = {lua_quote(effect_id)},"]
    integer_options = {
        "max_intensity": "maximum_intensity",
        "dur_add_perc": "duration_add_percent",
        "int_add_val": "intensity_add_value",
        "int_decay_step": "intensity_decay_step",
        "int_decay_tick": "intensity_decay_tick",
    }
    for source_name, target_name in integer_options.items():
        if source_name not in value:
            continue
        number = native_integer(value[source_name], -1 if source_name == "int_decay_step" else NATIVE_INT_MIN)
        if number is None:
            result.todos.append(
                f"{source.location}: effect type {effect_id} {source_name} needs review"
            )
        else:
            lines.append(f"    {target_name} = {number},")
    for source_name, target_name in (
        ("max_duration", "maximum_duration_turns"),
        ("int_dur_factor", "intensity_duration_turns"),
    ):
        if source_name not in value:
            continue
        turns = parse_turns(value[source_name])
        if turns is None or not 0 <= turns <= NATIVE_INT_MAX:
            result.todos.append(
                f"{source.location}: effect type {effect_id} {source_name} needs unit review"
            )
        else:
            lines.append(f"    {target_name} = {turns},")
    text_options = {
        "remove_message": "remove_message",
        "apply_memorial_log": "apply_memorial_log",
        "remove_memorial_log": "remove_memorial_log",
        "blood_analysis_description": "blood_analysis_description",
    }
    for source_name, target_name in text_options.items():
        if source_name not in value:
            continue
        text = display_text(value[source_name])
        if not text:
            result.todos.append(
                f"{source.location}: effect type {effect_id} {source_name} needs review"
            )
        else:
            lines.append(f"    {target_name} = {lua_quote(text)},")
    boolean_options = {
        "int_decay_remove": "intensity_decay_removes",
        "main_parts_only": "main_parts_only",
        "show_in_info": "show_in_info",
        "show_intensity": "show_intensity",
        "part_descs": "part_descriptions",
    }
    for source_name, target_name in boolean_options.items():
        if source_name not in value:
            continue
        state = value[source_name]
        if not isinstance(state, bool):
            result.todos.append(
                f"{source.location}: effect type {effect_id} {source_name} needs review"
            )
        else:
            lines.append(f"    {target_name} = {'true' if state else 'false'},")
    lines.append("}")
    lines.extend(f"definition:name({lua_quote(text)})" for text in names)
    lines.extend(f"definition:description({lua_quote(text)})" for text in descriptions)
    reduced = value.get("reduced_desc")
    if reduced is not None:
        reduced_texts = display_texts(reduced)
        if reduced_texts is None:
            result.todos.append(
                f"{source.location}: effect type {effect_id} reduced descriptions need review"
            )
        else:
            lines.extend(
                f"definition:reduced_description({lua_quote(text)})"
                for text in reduced_texts
            )
    list_methods = {
        "flags": "flag",
        "immune_flags": "immune_character_flag",
        "immune_bp_flags": "immune_bodypart_flag",
        "resist_traits": "resist_trait",
        "resist_effects": "resist_effect",
        "removes_effects": "removes_effect",
        "blocks_effects": "blocks_effect",
    }
    for source_name, method in list_methods.items():
        if source_name not in value:
            continue
        ids = string_ids(value[source_name])
        if ids is None:
            result.todos.append(
                f"{source.location}: effect type {effect_id} {source_name} needs review"
            )
        else:
            lines.extend(f"definition:{method}({lua_quote(entry)})" for entry in ids)
    return finish_catalog(
        source,
        result,
        "effect type",
        effect_id,
        lines,
        {
            "type", "id", "name", "desc", "reduced_desc", "remove_message",
            "apply_memorial_log", "remove_memorial_log", "blood_analysis_description",
            *integer_options.keys(), "max_duration", "int_dur_factor",
            *boolean_options.keys(), *list_methods.keys(),
        },
        todo_count,
    )


def render_weakpoint_set(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    set_id = value.get("id")
    if not safe_platform_id(set_id):
        result.partial.append(f"{source.location}: weakpoint set <invalid id>")
        result.todos.append(f"{source.location}: weakpoint set needs a stable native id")
        return None
    todo_count = len(result.todos)
    lines = ["local definition = content.WeakpointSet {", f"    id = {lua_quote(set_id)},", "}"]
    points = value.get("weakpoints")
    if not isinstance(points, list) or not points:
        points = []
        result.todos.append(f"{source.location}: weakpoint set {set_id} points need review")
    rendered_points = 0
    for index, point in enumerate(points):
        if not isinstance(point, dict):
            result.todos.append(
                f"{source.location}: weakpoint set {set_id} point {index} needs review"
            )
            continue
        point_id = point.get("id", point.get("name"))
        if not safe_platform_id(point_id):
            result.todos.append(
                f"{source.location}: weakpoint set {set_id} point {index} needs a stable id"
            )
            continue
        name = display_text(point.get("name"), point_id)
        coverage = finite_number(point.get("coverage", 100), 0.0)
        good = point.get("is_good", True)
        head = point.get("is_head", False)
        if coverage is None or not isinstance(good, bool) or not isinstance(head, bool):
            result.todos.append(
                f"{source.location}: weakpoint set {set_id} point {point_id} metadata needs review"
            )
            coverage, good, head = 100, True, False
        lines.extend((
            "definition:weakpoint {",
            f"    id = {lua_quote(point_id)},",
            f"    name = {lua_quote(name)},",
            f"    coverage = {lua_number(coverage)},",
            f"    good = {'true' if good else 'false'},",
            f"    head = {'true' if head else 'false'},",
            "}",
        ))
        rendered_points += 1
        for source_name, method, non_negative in (
            ("armor_mult", "armor_multiplier", True),
            ("armor_penalty", "armor_penalty", False),
            ("damage_mult", "damage_multiplier", True),
            ("crit_mult", "critical_multiplier", True),
        ):
            if source_name not in point:
                continue
            raw_map = point[source_name]
            if not isinstance(raw_map, dict):
                result.todos.append(
                    f"{source.location}: weakpoint set {set_id} point {point_id} {source_name} needs review"
                )
                continue
            for damage_id, raw_amount in raw_map.items():
                amount = finite_number(raw_amount, 0.0 if non_negative else None)
                if not safe_platform_id(damage_id) or amount is None:
                    result.todos.append(
                        f"{source.location}: weakpoint set {set_id} point {point_id} {source_name} entry needs review"
                    )
                    continue
                lines.append(
                    f"definition:{method}({lua_quote(point_id)}, "
                    f"{lua_quote(damage_id)}, {lua_number(amount)})"
                )
        effects = point.get("effects", [])
        if not isinstance(effects, list):
            result.todos.append(
                f"{source.location}: weakpoint set {set_id} point {point_id} effects need review"
            )
            effects = []
        for effect_index, effect in enumerate(effects):
            if not isinstance(effect, dict) or not safe_platform_id(effect.get("effect")):
                result.todos.append(
                    f"{source.location}: weakpoint set {set_id} point {point_id} effect {effect_index} needs review"
                )
                continue
            options = [f"    effect = {lua_quote(effect['effect'])},"]
            chance = finite_number(effect.get("chance", 100), 0.0, 100.0)
            permanent = effect.get("permanent", False)
            if chance is None or not isinstance(permanent, bool):
                result.todos.append(
                    f"{source.location}: weakpoint set {set_id} point {point_id} effect {effect_index} bounds need review"
                )
                chance, permanent = 100, False
            options.append(f"    chance = {lua_number(chance)},")
            options.append(f"    permanent = {'true' if permanent else 'false'},")
            for field_name, parser, lua_min, lua_max in (
                ("duration", parse_turns, "duration_min_turns", "duration_max_turns"),
                ("intensity", lambda raw: native_integer(raw, 1), "intensity_min", "intensity_max"),
                ("damage_required", lambda raw: finite_number(raw, 0.0, 100.0), "damage_required_min", "damage_required_max"),
            ):
                if field_name not in effect:
                    continue
                bounds = pair_range(effect[field_name], parser)
                if bounds is None:
                    result.todos.append(
                        f"{source.location}: weakpoint set {set_id} point {point_id} {field_name} needs review"
                    )
                else:
                    options.append(f"    {lua_min} = {lua_number(bounds[0])},")
                    options.append(f"    {lua_max} = {lua_number(bounds[1])},")
            if "message" in effect:
                message = display_text(effect["message"])
                if message:
                    options.append(f"    message = {lua_quote(message)},")
                else:
                    result.todos.append(
                        f"{source.location}: weakpoint set {set_id} point {point_id} effect message needs review"
                    )
            unknown_effect = unresolved_fields(
                effect,
                {"effect", "chance", "permanent", "duration", "intensity", "damage_required", "message"},
            )
            if unknown_effect:
                result.todos.append(
                    f"{source.location}: weakpoint set {set_id} point {point_id} effect unresolved fields: " +
                    ", ".join(unknown_effect)
                )
            lines.extend((
                f"definition:effect({lua_quote(point_id)}, {{",
                *options,
                "})",
            ))
        unknown_point = unresolved_fields(
            point,
            {
                "id", "name", "coverage", "is_good", "is_head", "armor_mult",
                "armor_penalty", "damage_mult", "crit_mult", "effects",
            },
        )
        if unknown_point:
            result.todos.append(
                f"{source.location}: weakpoint set {set_id} point {point_id} unresolved fields: " +
                ", ".join(unknown_point)
            )
    if rendered_points == 0:
        lines.extend((
            "definition:weakpoint {",
            '    id = "TODO_weakpoint",',
            f"    name = {lua_quote(set_id)},",
            "    coverage = 100,",
            "    good = true,",
            "    head = false,",
            "}",
        ))
        result.todos.append(
            f"{source.location}: weakpoint set {set_id} emitted a safe placeholder because no legacy weakpoint was usable"
        )
    return finish_catalog(
        source, result, "weakpoint set", set_id, lines,
        {"type", "id", "weakpoints"}, todo_count,
    )


def render_field_type(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    field_id = value.get("id")
    if not safe_platform_id(field_id):
        result.partial.append(f"{source.location}: field type <invalid id>")
        result.todos.append(f"{source.location}: field type needs a stable native id")
        return None
    todo_count = len(result.todos)
    lines = ["local definition = content.FieldType {", f"    id = {lua_quote(field_id)},"]
    duration_options = {
        "underwater_age_speedup": "underwater_age_speedup_turns",
        "outdoor_age_speedup": "outdoor_age_speedup_turns",
        "gas_absorption_factor": "gas_absorption_turns",
        "half_life": "half_life_turns",
    }
    for source_name, target_name in duration_options.items():
        if source_name not in value:
            continue
        turns = parse_turns(value[source_name])
        minimum_turns = 0 if source_name in {"gas_absorption_factor", "half_life"} else NATIVE_INT_MIN
        if turns is None or not minimum_turns <= turns <= NATIVE_INT_MAX:
            result.todos.append(
                f"{source.location}: field type {field_id} {source_name} needs unit review"
            )
        else:
            lines.append(f"    {target_name} = {turns},")
    integer_options = {
        "decay_amount_factor": "decay_amount_factor",
        "percent_spread": "percent_spread",
        "priority": "priority",
    }
    for source_name, target_name in integer_options.items():
        if source_name not in value:
            continue
        number = native_integer(value[source_name])
        if number is None:
            result.todos.append(
                f"{source.location}: field type {field_id} {source_name} needs review"
            )
        else:
            lines.append(f"    {target_name} = {number},")
    string_options = {
        "phase": "phase",
        "description_affix": "description_affix",
        "wandering_field": "wandering_field",
        "looks_like": "looks_like",
    }
    for source_name, target_name in string_options.items():
        if source_name not in value:
            continue
        raw = value[source_name]
        if not isinstance(raw, str) or "\0" in raw:
            result.todos.append(
                f"{source.location}: field type {field_id} {source_name} needs review"
            )
        else:
            lines.append(f"    {target_name} = {lua_quote(raw)},")
    boolean_options = {
        "is_splattering": "splattering",
        "has_fire": "has_fire",
        "has_acid": "has_acid",
        "has_elec": "has_electricity",
        "has_fume": "has_fume",
        "moppable": "moppable",
        "accelerated_decay": "accelerated_decay",
        "display_items": "display_items",
        "display_field": "display_field",
        "linear_half_life": "linear_half_life",
        "indestructible": "indestructible",
        "mopsafe": "mopsafe",
        "decrease_intensity_on_contact": "decrease_intensity_on_contact",
    }
    for source_name, target_name in boolean_options.items():
        if source_name not in value:
            continue
        state = value[source_name]
        if not isinstance(state, bool):
            result.todos.append(
                f"{source.location}: field type {field_id} {source_name} needs review"
            )
        else:
            lines.append(f"    {target_name} = {'true' if state else 'false'},")
    lines.append("}")

    levels = value.get("intensity_levels")
    if not isinstance(levels, list) or not levels:
        levels = [{"name": f"TODO {field_id}"}]
        result.todos.append(f"{source.location}: field type {field_id} intensities need review")
    intensity_supported = {
        "name", "sym", "color", "dangerous", "transparent", "move_cost",
        "intensity_upgrade_chance", "intensity_upgrade_duration", "light_emitted",
        "light_override", "translucency", "concentration",
        "convection_temperature_mod", "scent_neutralization", "effects",
    }
    rendered_intensities = 0
    for index, level in enumerate(levels, start=1):
        if not isinstance(level, dict):
            result.todos.append(
                f"{source.location}: field type {field_id} intensity {index} needs review"
            )
            continue
        name = display_text(level.get("name"), f"TODO {field_id} {index}")
        symbol = level.get("sym", "%")
        color = level.get("color", "white")
        if not name or not isinstance(symbol, str) or not symbol or not isinstance(color, str):
            name, symbol, color = f"TODO {field_id} {index}", "%", "white"
            result.todos.append(
                f"{source.location}: field type {field_id} intensity {index} presentation needs review"
            )
        options = [
            f"    name = {lua_quote(name)},",
            f"    symbol = {lua_quote(symbol)},",
            f"    color = {lua_quote(color)},",
        ]
        for source_name, target_name in (
            ("dangerous", "dangerous"),
            ("transparent", "transparent"),
        ):
            if source_name in level:
                state = level[source_name]
                if isinstance(state, bool):
                    options.append(f"    {target_name} = {'true' if state else 'false'},")
                else:
                    result.todos.append(
                        f"{source.location}: field type {field_id} intensity {index} {source_name} needs review"
                    )
        for source_name, target_name in (
            ("move_cost", "move_cost"),
            ("intensity_upgrade_chance", "upgrade_chance"),
            ("concentration", "concentration"),
            ("convection_temperature_mod", "convection_temperature_modifier"),
            ("scent_neutralization", "scent_neutralization"),
        ):
            if source_name in level:
                number = native_integer(level[source_name])
                if number is None:
                    result.todos.append(
                        f"{source.location}: field type {field_id} intensity {index} {source_name} needs review"
                    )
                else:
                    options.append(f"    {target_name} = {number},")
        if "intensity_upgrade_duration" in level:
            turns = parse_turns(level["intensity_upgrade_duration"])
            if turns is None or not 0 <= turns <= NATIVE_INT_MAX:
                result.todos.append(
                    f"{source.location}: field type {field_id} intensity {index} upgrade duration needs review"
                )
            else:
                options.append(f"    upgrade_duration_turns = {turns},")
        for source_name, target_name in (
            ("light_emitted", "light_emitted"),
            ("light_override", "local_light_override"),
            ("translucency", "translucency"),
        ):
            if source_name in level:
                number = finite_number(level[source_name])
                if number is None:
                    result.todos.append(
                        f"{source.location}: field type {field_id} intensity {index} {source_name} needs review"
                    )
                else:
                    options.append(f"    {target_name} = {lua_number(number)},")
        rendered_intensities += 1
        native_index = rendered_intensities
        lines.extend(("definition:intensity {", *options, "}"))

        effects = level.get("effects", [])
        if not isinstance(effects, list):
            effects = []
            result.todos.append(
                f"{source.location}: field type {field_id} intensity {index} effects need review"
            )
        for effect_index, effect in enumerate(effects):
            effect_id = effect.get("effect_id") if isinstance(effect, dict) else None
            if not isinstance(effect, dict) or not safe_platform_id(effect_id):
                result.todos.append(
                    f"{source.location}: field type {field_id} intensity {index} effect {effect_index} needs review"
                )
                continue
            effect_options = [f"    effect = {lua_quote(effect_id)},"]
            minimum = parse_turns(effect.get("min_duration", 0))
            maximum = parse_turns(effect.get("max_duration", effect.get("min_duration", 0)))
            intensity = native_integer(effect.get("intensity", 1), 1)
            if minimum is None or maximum is None or maximum < minimum or intensity is None:
                result.todos.append(
                    f"{source.location}: field type {field_id} intensity {index} effect {effect_index} bounds need review"
                )
            else:
                effect_options.extend((
                    f"    duration_min_turns = {minimum},",
                    f"    duration_max_turns = {maximum},",
                    f"    intensity = {intensity},",
                ))
            for source_name, target_name in (
                ("body_part", "body_part"),
                ("message", "message"),
                ("message_npc", "npc_message"),
            ):
                if source_name not in effect:
                    continue
                text = display_text(effect[source_name])
                if text:
                    effect_options.append(f"    {target_name} = {lua_quote(text)},")
                else:
                    result.todos.append(
                        f"{source.location}: field type {field_id} intensity {index} effect {source_name} needs review"
                    )
            if "is_environmental" in effect:
                state = effect["is_environmental"]
                if isinstance(state, bool):
                    effect_options.append(
                        f"    environmental = {'true' if state else 'false'},"
                    )
                else:
                    result.todos.append(
                        f"{source.location}: field type {field_id} intensity {index} environmental flag needs review"
                    )
            unknown_effect = unresolved_fields(
                effect,
                {
                    "effect_id", "min_duration", "max_duration", "intensity",
                    "body_part", "is_environmental", "message", "message_npc",
                },
            )
            if unknown_effect:
                result.todos.append(
                    f"{source.location}: field type {field_id} intensity {index} effect unresolved fields: " +
                    ", ".join(unknown_effect)
                )
            lines.extend((f"definition:effect({native_index}, {{", *effect_options, "})"))
        unknown_level = unresolved_fields(level, intensity_supported)
        if unknown_level:
            result.todos.append(
                f"{source.location}: field type {field_id} intensity {index} unresolved fields: " +
                ", ".join(unknown_level)
            )
    if rendered_intensities == 0:
        lines.extend((
            "definition:intensity {",
            f"    name = {lua_quote(f'TODO {field_id}')},",
            '    symbol = "%",',
            '    color = "white",',
            "}",
        ))
        result.todos.append(
            f"{source.location}: field type {field_id} emitted a safe placeholder because no legacy intensity was usable"
        )
    for source_name, method in (
        ("immune_mtypes", "immune_monster"),
        ("block_mtypes", "block_monster"),
    ):
        if source_name not in value:
            continue
        ids = string_ids(value[source_name])
        if ids is None:
            result.todos.append(
                f"{source.location}: field type {field_id} {source_name} needs review"
            )
        else:
            lines.extend(f"definition:{method}({lua_quote(entry)})" for entry in ids)
    return finish_catalog(
        source,
        result,
        "field type",
        field_id,
        lines,
        {
            "type", "id", "intensity_levels", "immune_mtypes", "block_mtypes",
            *duration_options.keys(), *integer_options.keys(), *string_options.keys(),
            *boolean_options.keys(),
        },
        todo_count,
    )


def render_item_group(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    group_id = value.get("id")
    if not safe_platform_id(group_id):
        result.partial.append(f"{source.location}: item group <invalid id>")
        result.todos.append(f"{source.location}: item group needs a stable native id")
        return None
    todo_count = len(result.todos)
    subtype = value.get("subtype", "distribution")
    kind = "distribution" if subtype == "old" else subtype
    if kind not in {"distribution", "collection"}:
        kind = "distribution"
        result.todos.append(f"{source.location}: item group {group_id} subtype needs review")
    ammo = native_integer(value.get("ammo", 0), 0, 100)
    magazine = native_integer(value.get("magazine", 0), 0, 100)
    if ammo is None or magazine is None:
        ammo, magazine = 0, 0
        result.todos.append(f"{source.location}: item group {group_id} ammo chances need review")
    lines = [
        "local definition = content.ItemGroup {",
        f"    id = {lua_quote(group_id)},",
        f"    kind = {lua_quote(kind)},",
        f"    with_ammo = {ammo},",
        f"    with_magazine = {magazine},",
        "}",
    ]

    def add_entry(raw: Any, group: bool = False) -> None:
        entry_id: Any = None
        probability: Any = 100
        variant: Any = ""
        unknown: list[str] = []
        if isinstance(raw, str):
            entry_id = raw
        elif isinstance(raw, list) and len(raw) >= 1:
            entry_id = raw[0]
            probability = raw[1] if len(raw) > 1 else 100
            if len(raw) > 2:
                unknown.append("extra tuple values")
        elif isinstance(raw, dict):
            if "group" in raw:
                group = True
                entry_id = raw.get("group")
            else:
                entry_id = raw.get("item")
            probability = raw.get("prob", raw.get("probability", 100))
            variant = raw.get("variant", "")
            allowed = {"group", "item", "prob", "probability", "variant"}
            unknown.extend(unresolved_fields(raw, allowed))
        probability_int = native_integer(probability, 1, 100 if kind == "collection" else NATIVE_INT_MAX)
        if (
            not safe_platform_id(entry_id) or
            probability_int is None or
            not isinstance(variant, str) or
            (group and variant)
        ):
            result.todos.append(f"{source.location}: item group {group_id} entry needs review")
            return
        if unknown:
            result.todos.append(
                f"{source.location}: item group {group_id} entry unresolved fields: " +
                ", ".join(unknown)
            )
        if group:
            lines.append(f"definition:group({lua_quote(entry_id)}, {probability_int})")
        else:
            lines.append(
                f"definition:item({lua_quote(entry_id)}, {probability_int}, {lua_quote(variant)})"
            )

    for entry in value.get("items", []) if isinstance(value.get("items", []), list) else []:
        add_entry(entry)
    if "items" in value and not isinstance(value["items"], list):
        result.todos.append(f"{source.location}: item group {group_id} items need review")
    for entry in value.get("groups", []) if isinstance(value.get("groups", []), list) else []:
        add_entry(entry, True)
    if "groups" in value and not isinstance(value["groups"], list):
        result.todos.append(f"{source.location}: item group {group_id} groups need review")
    for entry in value.get("entries", []) if isinstance(value.get("entries", []), list) else []:
        add_entry(entry)
    if "entries" in value and not isinstance(value["entries"], list):
        result.todos.append(f"{source.location}: item group {group_id} entries need review")
    return finish_catalog(
        source,
        result,
        "item group",
        group_id,
        lines,
        {"type", "id", "subtype", "ammo", "magazine", "items", "groups", "entries"},
        todo_count,
    )


def damage_entries(value: Any) -> list[tuple[str, int | float, int | float]] | None:
    if isinstance(value, dict) and "damage_type" not in value:
        entries: list[tuple[str, int | float, int | float]] = []
        for damage_id, raw_amount in value.items():
            amount = finite_number(raw_amount, 0.0)
            if not safe_platform_id(damage_id) or amount is None:
                return None
            entries.append((damage_id, amount, 0))
        return entries
    raw_entries = value if isinstance(value, list) else [value]
    entries = []
    for raw in raw_entries:
        if not isinstance(raw, dict):
            return None
        damage_id = raw.get("damage_type")
        amount = finite_number(raw.get("amount"), 0.0)
        armor_penetration = finite_number(raw.get("armor_penetration", 0), 0.0)
        if (
            not safe_platform_id(damage_id) or
            amount is None or
            armor_penetration is None or
            unresolved_fields(raw, {"damage_type", "amount", "armor_penetration"})
        ):
            return None
        entries.append((damage_id, amount, armor_penetration))
    return entries


def canonical_weighted_entries(raw: Any) -> list[tuple[str, int]] | None:
    """Return the effective native weighted-list order and weights.

    Legacy JSON accepts a string, a dense array of strings/pairs, or an
    object map.  Repeated ids replace the earlier weight without changing its
    first position, matching ``weighted_int_list::add_or_replace``.
    """
    parsed: list[tuple[str, int]] = []

    def append(entry_id: Any, weight: Any) -> bool:
        if (
            not bounded_platform_id(entry_id) or
            not isinstance(weight, int) or
            isinstance(weight, bool) or
            not 0 < weight <= NATIVE_INT_MAX
        ):
            return False
        for index, (existing_id, _existing_weight) in enumerate(parsed):
            if existing_id == entry_id:
                parsed[index] = (entry_id, weight)
                return True
        parsed.append((entry_id, weight))
        return True

    if isinstance(raw, str):
        return parsed if append(raw, 1) else None
    if isinstance(raw, dict):
        for entry_id, weight in raw.items():
            if not append(entry_id, weight):
                return None
        return parsed
    if not isinstance(raw, list):
        return None
    for entry in raw:
        if isinstance(entry, str):
            if not append(entry, 1):
                return None
        elif isinstance(entry, list) and len(entry) == 2:
            if not append(entry[0], entry[1]):
                return None
        elif isinstance(entry, dict) and len(entry) in {1, 2}:
            ids = [value for value in entry.values() if isinstance(value, str)]
            weights = [
                value for value in entry.values()
                if isinstance(value, int) and not isinstance(value, bool)
            ]
            if len(ids) != 1 or len(weights) > 1:
                return None
            if not append(ids[0], weights[0] if weights else 1):
                return None
        else:
            return None
    return parsed


def resolve_regional_inheritance(
    source: SourceObject,
    effective_objects: dict[str, dict[str, Any]],
    *,
    defer_missing_parent: bool = False,
) -> tuple[SourceObject | None, list[str]]:
    """Flatten one regional generic-factory object in source load order.

    The native factory resolves ``copy-from`` against the object state that
    exists immediately before the child is loaded.  That distinction matters
    for regional overlays such as ``id: default, copy-from: default``: a global
    id-to-last-definition map would make the object inherit from itself.

    Direct child members replace inherited members.  For the small closed set
    of container-reader fields, legacy ``extend`` entries are inserted and
    ``delete`` entries are removed afterwards.  Unsupported or impossible
    patches fail closed instead of emitting a Lua definition with guessed
    semantics.  The returned object contains no legacy inheritance keys.
    """
    value = source.value
    kind = value.get("type")
    label = REGIONAL_INHERITANCE_LABELS.get(kind)
    if label is None:
        return source, []

    raw_id = value.get("id")
    raw_abstract = value.get("abstract")
    object_id = raw_id if isinstance(raw_id, str) and raw_id else raw_abstract
    display_id = object_id if isinstance(object_id, str) and object_id else "<invalid id>"
    prefix = f"{source.location}: {label} {display_id}"
    has_copy_from = "copy-from" in value
    has_patch = "extend" in value or "delete" in value

    if not has_copy_from and has_patch:
        return None, [
            f"{prefix} extend/delete requires a resolved copy-from parent"
        ]

    if has_copy_from:
        parent_id = value.get("copy-from")
        if not isinstance(parent_id, str) or not parent_id:
            return None, [f"{prefix} copy-from id needs review"]
        parent = effective_objects.get(parent_id)
        if parent is None:
            if defer_missing_parent:
                return None, []
            return None, [
                f"{prefix} copy-from parent '{parent_id}' is not available "
                "in the migration corpus after deferred resolution"
            ]
        resolved = copy.deepcopy(parent)
        resolved.pop("id", None)
        resolved.pop("abstract", None)
        resolved["type"] = kind
        if isinstance(raw_id, str) and raw_id:
            resolved["id"] = raw_id
        elif isinstance(raw_abstract, str) and raw_abstract:
            resolved["abstract"] = raw_abstract
    else:
        resolved = copy.deepcopy(value)

    inheritance_keys = {
        "type", "id", "abstract", "copy-from", "extend", "delete"
    }
    if has_copy_from:
        for key, item in value.items():
            if key not in inheritance_keys:
                if (
                    key in REGIONAL_INHERITANCE_NESTED_FIELDS.get(kind, frozenset()) and
                    isinstance(resolved.get(key), dict) and
                    isinstance(item, dict)
                ):
                    merged = copy.deepcopy(resolved[key])
                    merged.update(copy.deepcopy(item))
                    resolved[key] = merged
                else:
                    resolved[key] = copy.deepcopy(item)

    allowed_fields = REGIONAL_INHERITANCE_CONTAINER_FIELDS[kind]
    todos: list[str] = []
    if kind == "region_settings":
        feature_settings = resolved.get("feature_flag_settings")
        direct_feature_settings = value.get("feature_flag_settings")
        if isinstance(feature_settings, dict):
            for operation in ("extend", "delete"):
                patch = feature_settings.get(operation)
                if patch is None:
                    continue
                if not isinstance(patch, dict):
                    todos.append(
                        f"{prefix} feature_flag_settings.{operation} must be an object"
                    )
                    continue
                for member, raw_entries in patch.items():
                    if member not in {"blacklist", "whitelist"}:
                        todos.append(
                            f"{prefix} feature_flag_settings.{operation}.{member} is not supported"
                        )
                        continue
                    if isinstance(direct_feature_settings, dict) and \
                            member in direct_feature_settings:
                        continue
                    current = feature_settings.get(member, [])
                    entries = raw_entries if isinstance(raw_entries, list) else [raw_entries]
                    if (
                        not isinstance(current, list) or
                        not all(isinstance(entry, str) and entry for entry in current) or
                        not all(isinstance(entry, str) and entry for entry in entries)
                    ):
                        todos.append(
                            f"{prefix} feature_flag_settings.{operation}.{member} has malformed flags"
                        )
                        continue
                    updated = list(dict.fromkeys(current))
                    if operation == "extend":
                        for entry in entries:
                            if entry not in updated:
                                updated.append(entry)
                    else:
                        missing = [entry for entry in entries if entry not in updated]
                        if missing:
                            todos.append(
                                f"{prefix} feature_flag_settings.delete.{member} references absent flags"
                            )
                            continue
                        updated = [entry for entry in updated if entry not in entries]
                    feature_settings[member] = updated
            feature_settings.pop("extend", None)
            feature_settings.pop("delete", None)
    for operation in ("extend", "delete"):
        patch = value.get(operation)
        if patch is None:
            continue
        if not isinstance(patch, dict):
            todos.append(f"{prefix} {operation} must be an object")
            continue
        for member, raw_entries in patch.items():
            if member not in allowed_fields:
                todos.append(
                    f"{prefix} {operation}.{member} is not supported by the native regional reader"
                )
                continue
            # A direct member replaces the inherited container; the native
            # reader does not subsequently process extend/delete for it.
            if member in value:
                continue
            if member in REGIONAL_INHERITANCE_WEIGHTED_FIELDS.get(kind, frozenset()):
                current = canonical_weighted_entries(resolved.get(member, []))
                entries = canonical_weighted_entries(raw_entries)
                if current is None or entries is None:
                    todos.append(
                        f"{prefix} {operation}.{member} has malformed weighted entries"
                    )
                    continue
                updated = list(current)
                if operation == "extend":
                    for entry_id, weight in entries:
                        for index, (existing_id, _existing_weight) in enumerate(updated):
                            if existing_id == entry_id:
                                updated[index] = (entry_id, weight)
                                break
                        else:
                            updated.append((entry_id, weight))
                else:
                    missing = [
                        entry_id for entry_id, _weight in entries
                        if all(existing_id != entry_id for existing_id, _ in updated)
                    ]
                    if missing:
                        todos.append(
                            f"{prefix} delete.{member} references ids absent from the inherited container"
                        )
                        continue
                    deleted_ids = {entry_id for entry_id, _weight in entries}
                    updated = [
                        entry for entry in updated if entry[0] not in deleted_ids
                    ]
                resolved[member] = [list(entry) for entry in updated]
                continue

            current = resolved.get(member, [])
            if not isinstance(current, list):
                todos.append(
                    f"{prefix} {operation}.{member} cannot patch a non-array inherited value"
                )
                continue
            entries = raw_entries if isinstance(raw_entries, list) else [raw_entries]
            updated = copy.deepcopy(current)
            if operation == "extend":
                for entry in entries:
                    if entry not in updated:
                        updated.append(copy.deepcopy(entry))
            else:
                missing = [entry for entry in entries if entry not in updated]
                if missing:
                    todos.append(
                        f"{prefix} delete.{member} references values absent from the inherited container"
                    )
                    continue
                for entry in entries:
                    while entry in updated:
                        updated.remove(entry)
            resolved[member] = updated

    if todos:
        return None, todos

    for key in ("copy-from", "extend", "delete"):
        resolved.pop(key, None)
    if isinstance(raw_id, str) and raw_id:
        resolved.pop("abstract", None)
    if isinstance(object_id, str) and object_id:
        effective_objects[object_id] = copy.deepcopy(resolved)
    return SourceObject(source.path, source.index, resolved), []


def resolve_regional_inheritance_corpus(
    objects: list[SourceObject],
    exclude_types: frozenset[str],
) -> tuple[
    dict[tuple[Path, int], SourceObject],
    dict[tuple[Path, int], list[str]],
]:
    """Flatten regional inheritance with generic_factory-style deferral.

    ``generic_factory`` loads a child immediately when its parent already
    exists, which preserves the previous value for same-id regional overlays.
    A child whose parent is not loaded yet is retried during finalization until
    the dependency graph stops making progress.  Mirror both behaviours here
    so forward references and ordered overlays produce the same effective
    definitions without exposing legacy inheritance at Lua runtime.
    """
    effective_objects: dict[str, dict[str, dict[str, Any]]] = {}
    resolved_sources: dict[tuple[Path, int], SourceObject] = {}
    failures: dict[tuple[Path, int], list[str]] = {}
    deferred: list[SourceObject] = []

    def source_key(source: SourceObject) -> tuple[Path, int]:
        return source.path, source.index

    for source in objects:
        kind = source.value.get("type")
        if kind in exclude_types or kind not in REGIONAL_INHERITANCE_LABELS:
            continue
        resolved, todos = resolve_regional_inheritance(
            source,
            effective_objects.setdefault(kind, {}),
            defer_missing_parent=True,
        )
        if resolved is not None:
            resolved_sources[source_key(source)] = resolved
        elif todos:
            failures[source_key(source)] = todos
        else:
            deferred.append(source)

    while deferred:
        remaining: list[SourceObject] = []
        made_progress = False
        for source in deferred:
            kind = source.value["type"]
            resolved, todos = resolve_regional_inheritance(
                source,
                effective_objects.setdefault(kind, {}),
                defer_missing_parent=True,
            )
            if resolved is not None:
                resolved_sources[source_key(source)] = resolved
                made_progress = True
            elif todos:
                failures[source_key(source)] = todos
            else:
                remaining.append(source)
        if not made_progress:
            for source in remaining:
                kind = source.value["type"]
                _resolved, todos = resolve_regional_inheritance(
                    source,
                    effective_objects.setdefault(kind, {}),
                )
                failures[source_key(source)] = todos
            break
        deferred = remaining

    return resolved_sources, failures


def resolve_copy_from(
    value: dict[str, Any],
    corpus: dict[str, dict[str, Any]],
    *,
    label: str,
    location: str,
    locations_self_default: bool = False,
) -> tuple[dict[str, Any], list[str]]:
    """Resolve a shallow copy-from chain against a same-type corpus.

    Mirrors the legacy generic-factory inheritance semantics: the child starts
    as a copy of the parent's effective object (defaults applied during the
    parent's own load), then the child's own fields override; dict-valued
    members merge one level deep (the legacy gate messages object inherits
    per key).  ``opposite`` is never inherited, matching the sub-body-part
    loader's explicit self default.  Missing parents, non-string ids, and
    cycles fail closed as explicit TODOs.
    """
    chain: list[dict[str, Any]] = []
    current = value
    seen: set[str] = set()
    todos: list[str] = []
    while isinstance(current, dict) and "copy-from" in current:
        parent_id = current.get("copy-from")
        if not isinstance(parent_id, str) or not parent_id:
            todos.append(f"{location}: {label} copy-from id needs review")
            break
        if parent_id in seen:
            todos.append(
                f"{location}: {label} copy-from chain is cyclic at '{parent_id}'"
            )
            break
        seen.add(parent_id)
        parent = corpus.get(parent_id)
        if parent is None:
            todos.append(
                f"{location}: {label} copy-from parent '{parent_id}' is not in the migration corpus"
            )
            break
        chain.append(parent)
        current = parent
    merged: dict[str, Any] = {}
    for parent in reversed(chain):
        effective = dict(parent)
        if locations_self_default:
            # The parent's own load applied the locations_under default
            # before the child could inherit it.
            effective.setdefault("locations_under", [effective.get("id")])
        for key, item in effective.items():
            if key in ("id", "type", "copy-from", "abstract", "opposite", "extend"):
                continue
            merged[key] = item
    for key, item in value.items():
        if key in ("copy-from", "abstract", "opposite", "extend"):
            continue
        if isinstance(item, dict) and isinstance(merged.get(key), dict):
            combined = dict(merged[key])
            combined.update(item)
            merged[key] = combined
        else:
            merged[key] = item
    # Legacy "extend" unions arrays and shallow-merges dicts into the
    # inherited value (sloc_house_boarded extends sloc_house's flags).
    extend = value.get("extend")
    if isinstance(extend, dict):
        for key, item in extend.items():
            if isinstance(item, list) and isinstance(merged.get(key), list):
                merged[key] = list(merged[key]) + list(item)
            elif isinstance(item, dict) and isinstance(merged.get(key), dict):
                combined = dict(merged[key])
                combined.update(item)
                merged[key] = combined
            else:
                merged[key] = item
    return merged, todos


def render_sub_body_part(
    source: SourceObject,
    result: MigrationResult,
    *,
    inheritance_corpus: dict[str, dict[str, Any]] | None = None,
) -> str | None:
    value = source.value
    if "copy-from" in value:
        if inheritance_corpus is None:
            result.partial.append(
                f"{source.location}: sub body part {value.get('id') or '<invalid id>'}"
            )
            result.todos.append(
                f"{source.location}: sub body part inheritance needs the migration corpus"
            )
            return None
        resolved, todos = resolve_copy_from(
            value,
            inheritance_corpus,
            label=f"sub body part {value.get('id') or '<invalid id>'}",
            location=source.location,
            locations_self_default=True,
        )
        for todo in todos:
            result.todos.append(todo)
        if todos:
            result.partial.append(
                f"{source.location}: sub body part {value.get('id') or '<invalid id>'}"
            )
            return None
        # Swap in the resolved value so the remaining checks and the
        # finish_catalog unknown-key audit see the merged entry, not the
        # original copy-from shape.
        value = resolved
        source = SourceObject(source.path, source.index, resolved)
    part_id = value.get("id")
    parent = value.get("parent")
    name = display_text(value.get("name"))
    if not safe_platform_id(part_id) or not safe_platform_id(parent) or not name:
        result.partial.append(f"{source.location}: sub body part {part_id or '<invalid id>'}")
        result.todos.append(
            f"{source.location}: sub body part needs a stable id, name, and parent"
        )
        return None
    todo_count = len(result.todos)
    # Legacy stores an empty plural name when name_multiple is absent; the
    # singular name is never a fallback.
    plural = display_text(value.get("name_multiple"))
    opposite = value.get("opposite", part_id)
    raw_side = value.get("side", "both")
    if (
        isinstance(raw_side, int) and
        not isinstance(raw_side, bool) and
        0 <= raw_side <= 2
    ):
        # Legacy side enum io: 0 = both, 1 = left, 2 = right.
        side = ("both", "left", "right")[raw_side]
    elif isinstance(raw_side, str) and raw_side in {"left", "right", "both"}:
        side = raw_side
    else:
        side = "both"
    coverage = native_integer(value.get("max_coverage", 0), 0, 100)
    secondary = value.get("secondary", False)
    side_valid = (
        (
            isinstance(raw_side, int) and
            not isinstance(raw_side, bool) and
            0 <= raw_side <= 2
        ) or
        (isinstance(raw_side, str) and raw_side in {"left", "right", "both"})
    )
    if (
        not safe_platform_id(opposite) or
        not side_valid or
        coverage is None or
        not isinstance(secondary, bool)
    ):
        plural, opposite, side, coverage, secondary = "", part_id, "both", 0, False
        result.todos.append(
            f"{source.location}: sub body part {part_id} presentation or links need review"
        )
    lines = [
        "local definition = content.SubBodyPart {",
        f"    id = {lua_quote(part_id)},",
        f"    name = {lua_quote(name)},",
        f"    plural_name = {lua_quote(plural)},",
        f"    parent = {lua_quote(parent)},",
        f"    opposite = {lua_quote(opposite)},",
        f"    side = {lua_quote(side)},",
        f"    secondary = {'true' if secondary else 'false'},",
        f"    maximum_coverage = {coverage},",
    ]
    if "similar_bodypart" in value:
        similar = value["similar_bodypart"]
        if safe_platform_id(similar):
            lines.append(f"    similar_body_part = {lua_quote(similar)},")
        else:
            result.todos.append(
                f"{source.location}: sub body part {part_id} similar body part needs review"
            )
    lines.append("}")
    if "locations_under" in value:
        locations = string_ids(value["locations_under"])
        if locations is None or len(set(locations)) != len(locations):
            result.todos.append(
                f"{source.location}: sub body part {part_id} lower locations need review"
            )
        else:
            lines.extend(
                f"definition:location_under({lua_quote(location)})" for location in locations
            )
    if "unarmed_damage" in value:
        entries = damage_entries(value["unarmed_damage"])
        if entries is None:
            result.todos.append(
                f"{source.location}: sub body part {part_id} unarmed damage needs review"
            )
        else:
            for damage_id, amount, armor_penetration in entries:
                if armor_penetration != 0:
                    result.todos.append(
                        f"{source.location}: sub body part {part_id} unarmed armor penetration is not in the native registrar"
                    )
                lines.append(
                    f"definition:unarmed_damage({lua_quote(damage_id)}, {lua_number(amount)})"
                )
    return finish_catalog(
        source,
        result,
        "sub body part",
        part_id,
        lines,
        {
            "type", "id", "name", "name_multiple", "parent", "opposite",
            "side", "secondary", "max_coverage", "locations_under",
            "similar_bodypart", "unarmed_damage",
        },
        todo_count,
    )


WOUND_BODY_PART_TYPES = {
    "head", "torso", "sensor", "mouth", "arm", "hand", "leg", "foot",
    "wing", "tail", "other",
}


def render_wound(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    wound_id = value.get("id")
    name = display_text(value.get("name"))
    description = display_text(value.get("description"))
    damage_types = string_ids(value.get("damage_types"))
    damage_required = value.get("damage_required")
    if (
        not bounded_platform_id(wound_id) or
        not bounded_utf8_string(name, WOUND_NAME_MAX_BYTES) or
        not bounded_utf8_string(description, WOUND_DESCRIPTION_MAX_BYTES) or
        not damage_types or
        not all(bounded_platform_id(entry) for entry in damage_types) or
        len(set(damage_types)) != len(damage_types) or
        not isinstance(damage_required, list) or
        len(damage_required) != 2
    ):
        wound_label = wound_id if bounded_platform_id(wound_id) else "<invalid id>"
        result.partial.append(
            f"{source.location}: wound {wound_label}"
        )
        result.todos.append(
            f"{source.location}: wound needs a stable id, text, distinct damage types, and a two-value damage range within Platform byte bounds"
        )
        return None
    damage_min = native_integer(damage_required[0], 0)
    damage_max = native_integer(damage_required[1], 0)
    if damage_min is None or damage_max is None or damage_max < damage_min:
        result.partial.append(f"{source.location}: wound {wound_id}")
        result.todos.append(
            f"{source.location}: wound {wound_id} damage range needs review"
        )
        return None

    todo_count = len(result.todos)
    raw_name = value.get("name")
    plural_name = name
    if isinstance(raw_name, dict):
        raw_plural = raw_name.get("str_pl", name)
        if bounded_utf8_string(raw_plural, WOUND_NAME_MAX_BYTES):
            plural_name = raw_plural
        elif "str_pl" in raw_name:
            result.todos.append(
                f"{source.location}: wound {wound_id} plural name needs a bounded text conversion"
            )
        if (
            not isinstance(raw_name.get("str"), str) or
            not raw_name.get("str") or
            unresolved_fields(raw_name, {"str", "str_pl"})
        ):
            result.todos.append(
                f"{source.location}: wound {wound_id} name translation metadata needs review"
            )
    elif not isinstance(raw_name, str):
        result.todos.append(
            f"{source.location}: wound {wound_id} name needs review"
        )
    raw_description = value.get("description")
    if isinstance(raw_description, dict):
        if (
            not isinstance(raw_description.get("str"), str) or
            unresolved_fields(raw_description, {"str"})
        ):
            result.todos.append(
                f"{source.location}: wound {wound_id} description translation metadata needs review"
            )

    pain = value.get("pain", [0, 0])
    pain_min: int | None = None
    pain_max: int | None = None
    if isinstance(pain, list) and len(pain) == 2:
        pain_min = native_integer(pain[0], 0)
        pain_max = native_integer(pain[1], 0)
    if pain_min is None or pain_max is None or pain_max < pain_min:
        pain_min, pain_max = 0, 0
        result.todos.append(
            f"{source.location}: wound {wound_id} pain range needs review"
        )

    healing = value.get("healing_time")
    healing_min: int | None = None
    healing_max: int | None = None
    if isinstance(healing, list) and len(healing) == 2:
        healing_min = parse_turns(healing[0])
        healing_max = parse_turns(healing[1])
    if (
        healing_min is None or healing_max is None or
        healing_min <= 0 or healing_max < healing_min or
        healing_max > NATIVE_INT_MAX
    ):
        healing_min, healing_max = 1, 1
        result.todos.append(
            f"{source.location}: wound {wound_id} healing range needs an explicit finite duration review"
        )

    weight = native_integer(value.get("weight", 1), 1)
    limit = native_integer(value.get("limit", 0), 0)
    if weight is None:
        weight = 1
        result.todos.append(
            f"{source.location}: wound {wound_id} weight needs review"
        )
    if limit is None:
        limit = 0
        result.todos.append(
            f"{source.location}: wound {wound_id} per-part limit needs review"
        )

    lines = [
        "local definition = content.Wound {",
        f"    id = {lua_quote(wound_id)},",
        f"    name = {lua_quote(name)},",
        f"    plural_name = {lua_quote(plural_name)},",
        f"    description = {lua_quote(description)},",
        f"    pain_min = {pain_min},",
        f"    pain_max = {pain_max},",
        f"    healing_min_turns = {healing_min},",
        f"    healing_max_turns = {healing_max},",
        f"    damage_min = {damage_min},",
        f"    damage_max = {damage_max},",
        f"    weight = {weight},",
        f"    per_part_limit = {limit},",
    ]
    body_part_flags: dict[str, str] = {}
    for source_name, target_name in (
        ("whitelist_bp_with_flag", "required_body_part_flag"),
        ("blacklist_bp_with_flag", "forbidden_body_part_flag"),
    ):
        if source_name not in value:
            continue
        flag = value[source_name]
        if bounded_platform_id(flag):
            body_part_flags[target_name] = flag
        else:
            result.todos.append(
                f"{source.location}: wound {wound_id} {source_name} needs review"
            )
    if (
        body_part_flags.get("required_body_part_flag") ==
        body_part_flags.get("forbidden_body_part_flag") and
        "required_body_part_flag" in body_part_flags
    ):
        body_part_flags.clear()
        result.todos.append(
            f"{source.location}: wound {wound_id} cannot require and forbid the same body-part flag"
        )
    for target_name in ("required_body_part_flag", "forbidden_body_part_flag"):
        if target_name in body_part_flags:
            lines.append(
                f"    {target_name} = {lua_quote(body_part_flags[target_name])},"
            )
    lines.append("}")
    lines.extend(
        f"definition:damage_type({lua_quote(damage_type)})"
        for damage_type in damage_types
    )

    limb_scores = value.get("limb_scores", [])
    if not isinstance(limb_scores, list):
        limb_scores = []
        result.todos.append(
            f"{source.location}: wound {wound_id} limb scores need review"
        )
    seen_scores: set[str] = set()
    for entry in limb_scores:
        score = entry.get("score") if isinstance(entry, dict) else None
        penalty = finite_number(entry.get("value", 0), 0, 1) if isinstance(entry, dict) else None
        if (
            not bounded_platform_id(score) or score in seen_scores or
            penalty is None or
            unresolved_fields(entry, {"score", "value"})
        ):
            result.todos.append(
                f"{source.location}: wound {wound_id} limb-score entry needs review"
            )
            continue
        seen_scores.add(score)
        lines.append(
            f"definition:limb_score({lua_quote(score)}, {lua_number(penalty)})"
        )

    progressions = value.get("wound_progression", [])
    if not isinstance(progressions, list):
        progressions = []
        result.todos.append(
            f"{source.location}: wound {wound_id} progression list needs review"
        )
    seen_progressions: set[str] = set()
    for entry in progressions:
        target = entry.get("id") if isinstance(entry, dict) else None
        chance = native_integer(entry.get("chance", 0), 0, 100) if isinstance(entry, dict) else None
        if (
            not bounded_platform_id(target) or target == wound_id or
            target in seen_progressions or chance is None or
            unresolved_fields(entry, {"id", "chance"})
        ):
            result.todos.append(
                f"{source.location}: wound {wound_id} progression entry needs review"
            )
            continue
        seen_progressions.add(target)
        lines.append(
            f"definition:progression({lua_quote(target)}, {chance})"
        )

    required_types = string_ids(value.get("whitelist_body_part_types", []))
    forbidden_types = string_ids(value.get("blacklist_body_part_types", []))
    if (
        required_types is None or forbidden_types is None or
        len(set(required_types)) != len(required_types) or
        len(set(forbidden_types)) != len(forbidden_types) or
        not set(required_types).issubset(WOUND_BODY_PART_TYPES) or
        not set(forbidden_types).issubset(WOUND_BODY_PART_TYPES) or
        set(required_types) & set(forbidden_types)
    ):
        required_types, forbidden_types = [], []
        result.todos.append(
            f"{source.location}: wound {wound_id} body-part type filters need review"
        )
    lines.extend(
        f"definition:require_body_part_type({lua_quote(kind)})"
        for kind in required_types
    )
    lines.extend(
        f"definition:forbid_body_part_type({lua_quote(kind)})"
        for kind in forbidden_types
    )
    return finish_catalog(
        source,
        result,
        "wound",
        wound_id,
        lines,
        {
            "type", "id", "name", "description", "pain", "healing_time",
            "damage_types", "damage_required", "weight", "limb_scores",
            "limit", "wound_progression", "whitelist_bp_with_flag",
            "whitelist_body_part_types", "blacklist_bp_with_flag",
            "blacklist_body_part_types",
        },
        todo_count,
    )


def render_wound_fix(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    fix_id = value.get("id")
    name = display_text(value.get("name"))
    description = display_text(value.get("description"))
    removed = string_ids(value.get("wounds_removed"))
    if (
        not bounded_platform_id(fix_id) or
        not bounded_utf8_string(name, WOUND_NAME_MAX_BYTES) or
        not bounded_utf8_string(description, WOUND_DESCRIPTION_MAX_BYTES) or
        not removed or
        not all(bounded_platform_id(entry) for entry in removed) or
        len(set(removed)) != len(removed)
    ):
        fix_label = fix_id if bounded_platform_id(fix_id) else "<invalid id>"
        result.partial.append(
            f"{source.location}: wound fix {fix_label}"
        )
        result.todos.append(
            f"{source.location}: wound fix needs a stable id, text, and distinct removed wounds within Platform byte bounds"
        )
        return None
    todo_count = len(result.todos)
    added = string_ids(value.get("wounds_added", []))
    if (
        added is None or
        not all(bounded_platform_id(entry) for entry in added) or
        len(set(added)) != len(added) or
        set(removed) & set(added)
    ):
        added = []
        result.todos.append(
            f"{source.location}: wound fix {fix_id} added wounds need review"
        )

    duration = parse_turns(value.get("time", 0))
    if duration is None or duration < 0 or duration > NATIVE_INT_MAX // 100:
        duration = 0
        result.todos.append(
            f"{source.location}: wound fix {fix_id} duration needs review"
        )
    health_delta = native_integer(value.get("mod_hp", 0))
    if health_delta is None:
        health_delta = 0
        result.todos.append(
            f"{source.location}: wound fix {fix_id} health delta needs review"
        )
    success_message = display_text(value.get("success_msg"), "")
    if not bounded_utf8_string(
        success_message, WOUND_DESCRIPTION_MAX_BYTES, allow_empty=True
    ):
        success_message = ""
        result.todos.append(
            f"{source.location}: wound fix {fix_id} success message needs a bounded text conversion"
        )
    for field_name in ("name", "description", "success_msg"):
        raw = value.get(field_name)
        if isinstance(raw, dict) and (
            not isinstance(raw.get("str"), str) or
            unresolved_fields(raw, {"str"})
        ):
            result.todos.append(
                f"{source.location}: wound fix {fix_id} {field_name} translation metadata needs review"
            )

    lines = [
        "local definition = content.WoundFix {",
        f"    id = {lua_quote(fix_id)},",
        f"    name = {lua_quote(name)},",
        f"    description = {lua_quote(description)},",
        f"    success_message = {lua_quote(success_message)},",
        f"    duration_turns = {duration},",
        f"    health_delta = {health_delta},",
        "}",
    ]

    skills = value.get("skills", {})
    if not isinstance(skills, dict):
        skills = {}
        result.todos.append(
            f"{source.location}: wound fix {fix_id} skills need review"
        )
    for skill, raw_level in sorted(skills.items(), key=lambda entry: str(entry[0])):
        level = native_integer(raw_level, 0, NATIVE_MAX_SKILL)
        if not bounded_platform_id(skill) or level is None:
            result.todos.append(
                f"{source.location}: wound fix {fix_id} skill entry needs review"
            )
            continue
        lines.append(f"definition:skill({lua_quote(skill)}, {level})")

    proficiencies = value.get("proficiencies", [])
    if not isinstance(proficiencies, list):
        proficiencies = []
        result.todos.append(
            f"{source.location}: wound fix {fix_id} proficiencies need review"
        )
    seen_proficiencies: set[str] = set()
    for entry in proficiencies:
        proficiency = entry.get("proficiency") if isinstance(entry, dict) else None
        multiplier = positive_native_float_literal(
            entry.get("time_save", 1)
        ) if isinstance(entry, dict) else None
        mandatory = entry.get("is_mandatory", False) if isinstance(entry, dict) else None
        if (
            not bounded_platform_id(proficiency) or
            proficiency in seen_proficiencies or multiplier is None or
            not isinstance(mandatory, bool) or
            unresolved_fields(
                entry, {"proficiency", "time_save", "is_mandatory"}
            )
        ):
            result.todos.append(
                f"{source.location}: wound fix {fix_id} proficiency entry needs review"
            )
            continue
        seen_proficiencies.add(proficiency)
        lines.append(
            "definition:proficiency("
            f"{lua_quote(proficiency)}, {lua_number(multiplier)}, "
            f"{'true' if mandatory else 'false'})"
        )

    lines.extend(f"definition:removes({lua_quote(wound)})" for wound in removed)
    lines.extend(f"definition:adds({lua_quote(wound)})" for wound in added)
    requirements = value.get("requirements", [])
    if not isinstance(requirements, list):
        requirements = []
        result.todos.append(
            f"{source.location}: wound fix {fix_id} requirements need review"
        )
    seen_requirements: set[str] = set()
    for entry in requirements:
        if (
            not isinstance(entry, list) or len(entry) != 2 or
            not bounded_platform_id(entry[0]) or
            entry[0] in seen_requirements
        ):
            result.todos.append(
                f"{source.location}: wound fix {fix_id} inline, duplicate, or malformed requirement needs a standalone Requirement"
            )
            continue
        count = native_integer(entry[1], 1)
        if count is None:
            result.todos.append(
                f"{source.location}: wound fix {fix_id} requirement multiplier needs review"
            )
            continue
        seen_requirements.add(entry[0])
        lines.append(
            f"definition:requires({lua_quote(entry[0])}, {count})"
        )
    return finish_catalog(
        source,
        result,
        "wound fix",
        fix_id,
        lines,
        {
            "type", "id", "name", "description", "success_msg", "mod_hp",
            "time", "skills", "wounds_removed", "wounds_added",
            "proficiencies", "requirements",
        },
        todo_count,
    )


def render_body_part(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    part_id = value.get("id")
    name = display_text(value.get("name"))
    if not safe_platform_id(part_id) or not name:
        result.partial.append(f"{source.location}: body part {part_id or '<invalid id>'}")
        result.todos.append(f"{source.location}: body part needs a stable id and name")
        return None
    todo_count = len(result.todos)
    text_fields = {
        "name_multiple": ("plural_name", name),
        "accusative": ("accusative", name),
        "accusative_multiple": ("plural_accusative", name),
        "heading": ("heading", name),
        "heading_multiple": ("plural_heading", name),
        "encumbrance_text": ("encumbrance_text", name),
        "hp_bar_ui_text": ("hp_bar_text", name),
    }
    lines = ["local definition = content.BodyPart {", f"    id = {lua_quote(part_id)},", f"    name = {lua_quote(name)},"]
    for source_name, (target_name, fallback) in text_fields.items():
        text = display_text(value.get(source_name), fallback)
        if not text:
            text = fallback
            result.todos.append(
                f"{source.location}: body part {part_id} {source_name} needs review"
            )
        lines.append(f"    {target_name} = {lua_quote(text)},")
    main_part = value.get("main_part", part_id)
    if not safe_platform_id(main_part):
        main_part = part_id
        result.todos.append(
            f"{source.location}: body part {part_id} main_part needs review"
        )
    connected_to = value.get("connected_to", main_part)
    if not safe_platform_id(connected_to):
        connected_to = main_part
        result.todos.append(
            f"{source.location}: body part {part_id} connected_to needs review"
        )
    opposite = value.get("opposite_part", part_id)
    if not safe_platform_id(opposite):
        opposite = part_id
        result.todos.append(
            f"{source.location}: body part {part_id} opposite_part needs review"
        )
    lines.extend((
        f"    main_part = {lua_quote(main_part)},",
        f"    connected_to = {lua_quote(connected_to)},",
        f"    opposite = {lua_quote(opposite)},",
    ))
    side = value.get("side", "both")
    if side not in {"left", "right", "both"}:
        side = "both"
        result.todos.append(f"{source.location}: body part {part_id} side needs review")
    lines.append(f"    side = {lua_quote(side)},")
    for source_name, target_name, fallback, minimum in (
        ("hit_size", "hit_size", 1, 0.0000001),
        ("hit_difficulty", "hit_difficulty", 1, 0),
    ):
        number = finite_number(value.get(source_name, fallback), minimum)
        if number is None:
            number = fallback
            result.todos.append(
                f"{source.location}: body part {part_id} {source_name} needs review"
            )
        lines.append(f"    {target_name} = {lua_number(number)},")
    for source_name, target_name, fallback, minimum in (
        ("base_hp", "base_health", 60, 1),
        ("drench_capacity", "drench_capacity", 0, 0),
    ):
        number = native_integer(value.get(source_name, fallback), minimum)
        if number is None:
            number = fallback
            result.todos.append(
                f"{source.location}: body part {part_id} {source_name} needs review"
            )
        lines.append(f"    {target_name} = {number},")
    for source_name, target_name, fallback in (
        ("is_limb", "limb", False),
        ("is_vital", "vital", False),
    ):
        state = value.get(source_name, fallback)
        if not isinstance(state, bool):
            state = fallback
            result.todos.append(
                f"{source.location}: body part {part_id} {source_name} needs review"
            )
        lines.append(f"    {target_name} = {'true' if state else 'false'},")
    lines.append("}")

    sub_parts = value.get("sub_parts", [])
    ids = string_ids(sub_parts)
    if ids is None or len(set(ids)) != len(ids):
        result.todos.append(f"{source.location}: body part {part_id} sub-parts need review")
    else:
        lines.extend(f"definition:sub_part({lua_quote(entry)})" for entry in ids)

    raw_limb_types = value.get("limb_types")
    limb_types = raw_limb_types if isinstance(raw_limb_types, list) else [raw_limb_types]
    rendered_limb_type = False
    for raw in limb_types:
        kind: Any = raw
        weight: Any = 1
        if isinstance(raw, list) and len(raw) == 2:
            kind, weight = raw
        numeric_weight = finite_number(weight, 0.0000001)
        if kind not in {"head", "torso", "sensor", "mouth", "arm", "hand", "leg", "foot", "wing", "tail", "other"} or numeric_weight is None:
            result.todos.append(
                f"{source.location}: body part {part_id} limb type needs review"
            )
            continue
        rendered_limb_type = True
        lines.append(
            f"definition:limb_type({lua_quote(kind)}, {lua_number(numeric_weight)})"
        )
    if not rendered_limb_type:
        lines.append('definition:limb_type("other", 1)')
        result.todos.append(f"{source.location}: body part {part_id} needs a native limb type")

    for source_name, method in (("armor", "armor"), ("unarmed_damage", "unarmed_damage")):
        if source_name not in value:
            continue
        entries = damage_entries(value[source_name])
        if entries is None:
            result.todos.append(
                f"{source.location}: body part {part_id} {source_name} needs review"
            )
            continue
        for damage_id, amount, armor_penetration in entries:
            if armor_penetration != 0:
                result.todos.append(
                    f"{source.location}: body part {part_id} {source_name} armor penetration needs review"
                )
            lines.append(
                f"definition:{method}({lua_quote(damage_id)}, {lua_number(amount)})"
            )
    if "flags" in value:
        flags = string_ids(value["flags"])
        if flags is None:
            result.todos.append(f"{source.location}: body part {part_id} flags need review")
        else:
            lines.extend(f"definition:flag({lua_quote(flag)})" for flag in flags)
    if "limb_scores" in value:
        scores = value["limb_scores"]
        if not isinstance(scores, list):
            scores = []
            result.todos.append(f"{source.location}: body part {part_id} limb scores need review")
        for raw in scores:
            if not isinstance(raw, list) or len(raw) not in {2, 3} or not safe_platform_id(raw[0]):
                result.todos.append(f"{source.location}: body part {part_id} limb score needs review")
                continue
            score = finite_number(raw[1], 0.0)
            maximum = finite_number(raw[2] if len(raw) == 3 else raw[1], 0.0)
            if score is None or maximum is None or maximum < score:
                result.todos.append(f"{source.location}: body part {part_id} limb score needs review")
                continue
            lines.append(
                f"definition:limb_score({lua_quote(raw[0])}, {lua_number(score)}, {lua_number(maximum)})"
            )
    if "qualities" in value:
        qualities = value["qualities"]
        if not isinstance(qualities, list):
            qualities = []
            result.todos.append(f"{source.location}: body part {part_id} qualities need review")
        for raw in qualities:
            quality_id = raw.get("quality") if isinstance(raw, dict) else None
            level = native_integer(raw.get("level")) if isinstance(raw, dict) else None
            disable = finite_number(raw.get("disable_percent", 0), 0.0, 1.0) if isinstance(raw, dict) else None
            if not safe_platform_id(quality_id) or level is None or disable is None:
                result.todos.append(f"{source.location}: body part {part_id} quality needs review")
                continue
            unknown = unresolved_fields(raw, {"quality", "level", "disable_percent"})
            if unknown:
                result.todos.append(
                    f"{source.location}: body part {part_id} quality unresolved fields: " +
                    ", ".join(unknown)
                )
            lines.append(
                f"definition:quality({lua_quote(quality_id)}, {level}, {lua_number(disable)})"
            )
    return finish_catalog(
        source,
        result,
        "body part",
        part_id,
        lines,
        {
            "type", "id", "name", *text_fields.keys(), "main_part", "connected_to",
            "opposite_part", "side", "hit_size", "hit_difficulty", "base_hp",
            "drench_capacity", "is_limb", "is_vital", "sub_parts", "limb_types",
            "armor", "unarmed_damage", "flags", "limb_scores", "qualities",
        },
        todo_count,
    )


def render_anatomy(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    anatomy_id = value.get("id")
    parts = string_ids(value.get("parts"))
    if not safe_platform_id(anatomy_id) or not parts or len(set(parts)) != len(parts):
        result.partial.append(f"{source.location}: anatomy {anatomy_id or '<invalid id>'}")
        result.todos.append(
            f"{source.location}: anatomy needs a stable id and distinct body parts"
        )
        return None
    todo_count = len(result.todos)
    lines = ["local definition = content.Anatomy {", f"    id = {lua_quote(anatomy_id)},", "}"]
    lines.extend(f"definition:part({lua_quote(part)})" for part in parts)
    return finish_catalog(
        source, result, "anatomy", anatomy_id, lines,
        {"type", "id", "parts"}, todo_count,
    )


def render_body_graph(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    graph_id = value.get("id")
    if not safe_platform_id(graph_id):
        result.partial.append(f"{source.location}: body graph <invalid id>")
        result.todos.append(f"{source.location}: body graph needs a stable native id")
        return None
    todo_count = len(result.todos)
    lines = ["local definition = content.BodyGraph {", f"    id = {lua_quote(graph_id)},"]
    mirror_is_valid = False
    for source_name, target_name in (
        ("parent_bodypart", "parent_body_part"),
        ("mirror", "mirror"),
        ("label_fill", "label_fill"),
        ("fill_sym", "fill_symbol"),
        ("fill_color", "fill_color"),
    ):
        if source_name not in value:
            continue
        raw = value[source_name]
        if not isinstance(raw, str) or not raw:
            result.todos.append(
                f"{source.location}: body graph {graph_id} {source_name} needs review"
            )
        else:
            lines.append(f"    {target_name} = {lua_quote(raw)},")
            if source_name == "mirror":
                mirror_is_valid = True
    lines.append("}")
    rows = value.get("rows", [])
    fill_rows = value.get("fill_rows")
    if not isinstance(rows, list) or not all(isinstance(row, str) and row for row in rows):
        rows = []
        result.todos.append(f"{source.location}: body graph {graph_id} rows need review")
    if fill_rows is not None and (
        not isinstance(fill_rows, list) or
        len(fill_rows) != len(rows) or
        not all(isinstance(row, str) and row for row in fill_rows)
    ):
        fill_rows = None
        result.todos.append(f"{source.location}: body graph {graph_id} fill rows need review")
    if mirror_is_valid and rows:
        rows = []
        fill_rows = None
        result.todos.append(
            f"{source.location}: body graph {graph_id} has both mirror and rows; rows were omitted because mirrored graphs cannot own rows"
        )
    if not rows and not mirror_is_valid:
        result.todos.append(f"{source.location}: body graph {graph_id} needs rows or a mirror")
    for index, row in enumerate(rows):
        if fill_rows is None:
            lines.append(f"definition:row({lua_quote(row)})")
        else:
            lines.append(
                f"definition:row({lua_quote(row)}, {lua_quote(fill_rows[index])})"
            )
    parts = value.get("parts", {})
    if not isinstance(parts, dict):
        parts = {}
        result.todos.append(f"{source.location}: body graph {graph_id} parts need review")
    for symbol, raw in parts.items():
        if not isinstance(symbol, str) or not symbol or not isinstance(raw, dict):
            result.todos.append(f"{source.location}: body graph {graph_id} part needs review")
            continue
        options: list[str] = []
        has_target = False
        for source_name, target_name in (
            ("body_parts", "body_parts"),
            ("sub_body_parts", "sub_body_parts"),
        ):
            if source_name not in raw:
                continue
            ids = string_ids(raw[source_name])
            if not ids:
                result.todos.append(
                    f"{source.location}: body graph {graph_id} part {symbol} {source_name} needs review"
                )
            else:
                options.append(f"    {target_name} = {lua_string_table(ids)},")
                has_target = True
        for source_name, target_name in (
            ("nested_graph", "nested_graph"),
            ("select_color", "selected_color"),
            ("sym", "display_symbol"),
        ):
            if source_name not in raw:
                continue
            text = raw[source_name]
            if isinstance(text, str) and text:
                options.append(f"    {target_name} = {lua_quote(text)},")
                if source_name == "nested_graph":
                    has_target = True
            else:
                result.todos.append(
                    f"{source.location}: body graph {graph_id} part {symbol} {source_name} needs review"
                )
        unknown = unresolved_fields(
            raw, {"body_parts", "sub_body_parts", "nested_graph", "select_color", "sym"}
        )
        if unknown:
            result.todos.append(
                f"{source.location}: body graph {graph_id} part {symbol} unresolved fields: " +
                ", ".join(unknown)
            )
        if not has_target:
            result.todos.append(
                f"{source.location}: body graph {graph_id} part {symbol} has no usable body, sub-body, or nested-graph target and was omitted"
            )
            continue
        lines.extend((f"definition:part({lua_quote(symbol)}, {{", *options, "})"))
    return finish_catalog(
        source,
        result,
        "body graph",
        graph_id,
        lines,
        {
            "type", "id", "parent_bodypart", "mirror", "label_fill", "fill_sym",
            "fill_color", "rows", "fill_rows", "parts",
        },
        todo_count,
    )


def render_monster(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    monster_id = value.get("id")
    name = display_text(value.get("name"))
    faction = value.get("default_faction")
    if not safe_platform_id(monster_id) or not name or not safe_platform_id(faction):
        result.partial.append(f"{source.location}: monster {monster_id or '<invalid id>'}")
        result.todos.append(
            f"{source.location}: monster needs a stable id, name, and default faction"
        )
        return None
    todo_count = len(result.todos)
    raw_name = value.get("name")
    plural = (
        raw_name.get("str_pl")
        if isinstance(raw_name, dict) and isinstance(raw_name.get("str_pl"), str)
        else name
    )
    lines = [
        "local definition = content.Monster {",
        f"    id = {lua_quote(monster_id)},",
        f"    name = {lua_quote(name)},",
        f"    plural_name = {lua_quote(plural)},",
        f"    default_faction = {lua_quote(faction)},",
    ]
    text_options = {
        "description": "description",
        "symbol": "symbol",
        "color": "color",
        "looks_like": "looks_like",
        "bodytype": "body_type",
        "harvest": "harvest",
        "dissect": "dissect",
        "decay": "decay",
        "speed_description": "speed_description",
    }
    for source_name, target_name in text_options.items():
        if source_name not in value:
            continue
        text = display_text(value[source_name])
        if not text:
            result.todos.append(
                f"{source.location}: monster {monster_id} {source_name} needs review"
            )
        else:
            lines.append(f"    {target_name} = {lua_quote(text)},")
    if "death_drops" in value:
        death_drops = value["death_drops"]
        if safe_platform_id(death_drops):
            lines.append(f"    death_drops = {lua_quote(death_drops)},")
        else:
            result.todos.append(
                f"{source.location}: monster {monster_id} inline death drops need a native ItemGroup"
            )
    for source_name, target_name, parser in (
        ("volume", "volume_ml", lambda raw: parse_integral_unit(raw, {"ml": 1, "l": 1000})),
        ("weight", "weight_grams", lambda raw: parse_integral_unit(raw, {"mg": 0.001, "g": 1, "kg": 1000})),
    ):
        if source_name not in value:
            continue
        amount = parser(value[source_name])
        if amount is None or amount <= 0 or amount > NATIVE_INT64_MAX:
            result.todos.append(
                f"{source.location}: monster {monster_id} {source_name} needs unit review"
            )
        else:
            lines.append(f"    {target_name} = {amount},")
    if "phase" in value:
        phase = value["phase"]
        if phase in {"null", "solid", "liquid", "gas", "plasma"}:
            lines.append(f"    phase = {lua_quote(phase)},")
        else:
            result.todos.append(f"{source.location}: monster {monster_id} phase needs review")
    integer_options = {
        "diff": "difficulty_adjustment",
        "hp": "hp",
        "speed": "speed",
        "aggression": "aggression",
        "morale": "morale",
        "tracking_distance": "tracking_distance",
        "attack_cost": "attack_cost",
        "melee_skill": "melee_skill",
        "melee_dice": "melee_dice",
        "melee_dice_sides": "melee_sides",
        "melee_dice_ap": "melee_armor_penetration",
        "dodge": "dodge",
        "vision_day": "vision_day",
        "vision_night": "vision_night",
        "regenerates": "regenerates",
        "bleed_rate": "bleed_rate",
    }
    for source_name, target_name in integer_options.items():
        if source_name not in value:
            continue
        number = native_integer(value[source_name])
        if number is None:
            result.todos.append(
                f"{source.location}: monster {monster_id} {source_name} needs review"
            )
        else:
            lines.append(f"    {target_name} = {number},")
    for source_name, target_name, minimum, maximum in (
        ("status_chance_multiplier", "status_chance_multiplier", 0.0, 5.0),
        ("luminance", "luminance", 0.0, None),
    ):
        if source_name not in value:
            continue
        number = finite_number(value[source_name], minimum, maximum)
        if number is None:
            result.todos.append(
                f"{source.location}: monster {monster_id} {source_name} needs review"
            )
        else:
            lines.append(f"    {target_name} = {lua_number(number)},")
    boolean_options = {
        "regenerates_in_dark": "regenerates_in_dark",
        "regen_morale": "regenerates_morale",
        "aggro_character": "aggressive_to_characters",
    }
    for source_name, target_name in boolean_options.items():
        if source_name not in value:
            continue
        state = value[source_name]
        if isinstance(state, bool):
            lines.append(f"    {target_name} = {'true' if state else 'false'},")
        else:
            result.todos.append(
                f"{source.location}: monster {monster_id} {source_name} needs review"
            )
    lines.append("}")

    if "material" in value:
        raw_materials = value["material"]
        materials = raw_materials if isinstance(raw_materials, list) else [raw_materials]
        for raw in materials:
            material_id: Any = raw
            portions: Any = 1
            if isinstance(raw, list) and len(raw) == 2:
                material_id, portions = raw
            portions_int = native_integer(portions, 1)
            if not safe_platform_id(material_id) or portions_int is None:
                result.todos.append(
                    f"{source.location}: monster {monster_id} material entry needs review"
                )
                continue
            lines.append(
                f"definition:material({lua_quote(material_id)}, {portions_int})"
            )
    for source_name, method in (
        ("species", "species"),
        ("categories", "category"),
    ):
        if source_name not in value:
            continue
        raw_ids = value[source_name]
        ids = [raw_ids] if isinstance(raw_ids, str) else string_ids(raw_ids)
        if ids is None or not all(safe_platform_id(entry) for entry in ids):
            result.todos.append(
                f"{source.location}: monster {monster_id} {source_name} needs review"
            )
        else:
            lines.extend(f"definition:{method}({lua_quote(entry)})" for entry in ids)
    if "flags" in value:
        flags = string_ids(value["flags"])
        if flags is None:
            result.todos.append(f"{source.location}: monster {monster_id} flags need review")
        else:
            for flag in flags:
                if flag == "GEN_DORMANT":
                    result.todos.append(
                        f"{source.location}: monster {monster_id} GEN_DORMANT needs an explicit derived-monster transaction design"
                    )
                    continue
                lines.append(f"definition:flag({lua_quote(flag)})")
    if "armor" in value:
        append_numeric_map(
            lines, value["armor"], "armor", result, source,
            f"monster {monster_id} armor",
        )
    if "melee_damage" in value:
        entries = damage_entries(value["melee_damage"])
        if entries is None:
            result.todos.append(
                f"{source.location}: monster {monster_id} melee damage needs review"
            )
        else:
            lines.extend(
                f"definition:melee_damage({lua_quote(damage_id)}, {lua_number(amount)}, {lua_number(armor_penetration)})"
                for damage_id, amount, armor_penetration in entries
            )
    if "special_attacks" in value:
        attacks = value["special_attacks"]
        if not isinstance(attacks, list):
            attacks = []
            result.todos.append(
                f"{source.location}: monster {monster_id} special attacks need review"
            )
        for raw in attacks:
            attack_id: Any = raw
            cooldown: Any = None
            if isinstance(raw, list) and len(raw) == 2:
                attack_id, cooldown = raw
            if not safe_platform_id(attack_id):
                result.todos.append(
                    f"{source.location}: monster {monster_id} special attack needs review"
                )
                continue
            if cooldown is None:
                lines.append(f"definition:attack({lua_quote(attack_id)})")
                continue
            cooldown_number = finite_number(cooldown, 0.0, NATIVE_INT_MAX)
            if cooldown_number is None:
                result.todos.append(
                    f"{source.location}: monster {monster_id} special attack {attack_id} cooldown needs review"
                )
                continue
            lines.append(
                f"definition:attack({lua_quote(attack_id)}, {lua_number(cooldown_number)})"
            )
    for source_name, method in (
        ("weakpoint_sets", "weakpoint_set"),
        ("scents_tracked", "track_scent"),
        ("scents_ignored", "ignore_scent"),
        ("goals", "goal"),
        ("anger_triggers", "anger_trigger"),
        ("fear_triggers", "fear_trigger"),
        ("placate_triggers", "placate_trigger"),
    ):
        if source_name not in value:
            continue
        ids = string_ids(value[source_name])
        if ids is None:
            result.todos.append(
                f"{source.location}: monster {monster_id} {source_name} needs review"
            )
        else:
            lines.extend(f"definition:{method}({lua_quote(entry)})" for entry in ids)
    if "emit_fields" in value:
        emissions = value["emit_fields"]
        if not isinstance(emissions, list):
            emissions = []
            result.todos.append(
                f"{source.location}: monster {monster_id} emissions need review"
            )
        for raw in emissions:
            if not isinstance(raw, list) or len(raw) != 2 or not safe_platform_id(raw[0]):
                result.todos.append(
                    f"{source.location}: monster {monster_id} emission needs review"
                )
                continue
            turns = parse_turns(raw[1])
            if turns is None or not 0 < turns <= NATIVE_INT_MAX:
                result.todos.append(
                    f"{source.location}: monster {monster_id} emission {raw[0]} delay needs review"
                )
                continue
            lines.append(f"definition:emission({lua_quote(raw[0])}, {turns})")

    def render_weighted_ids(
        raw: Any, method: str, label: str, minimum: int = NATIVE_INT_MIN
    ) -> None:
        entries = list(raw.items()) if isinstance(raw, dict) else raw
        if not isinstance(entries, list):
            result.todos.append(f"{source.location}: monster {monster_id} {label} need review")
            return
        for entry in entries:
            if not isinstance(entry, (list, tuple)) or len(entry) != 2:
                result.todos.append(f"{source.location}: monster {monster_id} {label} entry needs review")
                continue
            amount = native_integer(entry[1], minimum)
            if not safe_platform_id(entry[0]) or amount is None:
                result.todos.append(f"{source.location}: monster {monster_id} {label} entry needs review")
                continue
            lines.append(f"definition:{method}({lua_quote(entry[0])}, {amount})")

    if "starting_ammo" in value:
        render_weighted_ids(
            value["starting_ammo"], "starting_ammo", "starting ammo", 1
        )
    if "regeneration_modifiers" in value:
        render_weighted_ids(
            value["regeneration_modifiers"], "regeneration_modifier",
            "regeneration modifiers",
        )
    return finish_catalog(
        source,
        result,
        "monster",
        monster_id,
        lines,
        {
            "type", "id", "name", "default_faction", *text_options.keys(),
            "death_drops", "volume", "weight", "phase", *integer_options.keys(),
            "status_chance_multiplier", "luminance", *boolean_options.keys(),
            "material", "species", "categories", "flags", "armor", "melee_damage",
            "special_attacks", "weakpoint_sets", "scents_tracked", "scents_ignored",
            "goals", "anger_triggers", "fear_triggers", "placate_triggers",
            "emit_fields", "starting_ammo", "regeneration_modifiers",
        },
        todo_count,
    )


def render_morale_type(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    morale_id = value.get("id")
    if not safe_platform_id(morale_id):
        result.partial.append(f"{source.location}: morale type <invalid id>")
        result.todos.append(f"{source.location}: morale type needs a stable native id")
        return None
    todo_count = len(result.todos)
    text = display_text(value.get("text"))
    if not text:
        result.todos.append(f"{source.location}: morale type {morale_id} text needs review")
    permanent = value.get("permanent", False)
    if not isinstance(permanent, bool):
        permanent = False
        result.todos.append(
            f"{source.location}: morale type {morale_id} permanence needs review"
        )
    lines = [
        "local definition = content.MoraleType {",
        f"    id = {lua_quote(morale_id)},",
        f"    text = {lua_quote(text)},",
        f"    permanent = {'true' if permanent else 'false'},",
        "}",
    ]
    return finish_catalog(
        source,
        result,
        "morale type",
        morale_id,
        lines,
        {"type", "id", "text", "permanent"},
        todo_count,
    )


def render_disease_type(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    disease_id = value.get("id")
    if not safe_platform_id(disease_id):
        result.partial.append(f"{source.location}: disease type <invalid id>")
        result.todos.append(f"{source.location}: disease type needs a stable native id")
        return None
    todo_count = len(result.todos)
    minimum_duration = parse_turns(value.get("min_duration", 1))
    maximum_duration = parse_turns(value.get("max_duration", 1))
    minimum_intensity = value.get("min_intensity", 1)
    maximum_intensity = value.get("max_intensity", 1)
    symptoms = value.get("symptoms")
    if minimum_duration is None or not 0 < minimum_duration <= NATIVE_INT_MAX:
        minimum_duration = 1
        result.todos.append(
            f"{source.location}: disease type {disease_id} minimum duration needs review"
        )
    if (
        maximum_duration is None or
        not minimum_duration <= maximum_duration <= NATIVE_INT_MAX
    ):
        maximum_duration = minimum_duration
        result.todos.append(
            f"{source.location}: disease type {disease_id} maximum duration needs review"
        )
    if (
        not isinstance(minimum_intensity, int) or
        isinstance(minimum_intensity, bool) or
        not 0 < minimum_intensity <= NATIVE_INT_MAX
    ):
        minimum_intensity = 1
        result.todos.append(
            f"{source.location}: disease type {disease_id} minimum intensity needs review"
        )
    if (
        not isinstance(maximum_intensity, int) or
        isinstance(maximum_intensity, bool) or
        not minimum_intensity <= maximum_intensity <= NATIVE_INT_MAX
    ):
        maximum_intensity = minimum_intensity
        result.todos.append(
            f"{source.location}: disease type {disease_id} maximum intensity needs review"
        )
    if not safe_platform_id(symptoms):
        symptoms = ""
        result.todos.append(
            f"{source.location}: disease type {disease_id} symptom effect needs review"
        )
    lines = [
        "local definition = content.DiseaseType {",
        f"    id = {lua_quote(disease_id)},",
        f"    symptoms = {lua_quote(symptoms)},",
        f"    minimum_duration_turns = {minimum_duration},",
        f"    maximum_duration_turns = {maximum_duration},",
        f"    minimum_intensity = {minimum_intensity},",
        f"    maximum_intensity = {maximum_intensity},",
    ]
    threshold = value.get("health_threshold")
    if (
        isinstance(threshold, int) and
        not isinstance(threshold, bool) and
        -NATIVE_INT_MAX - 1 <= threshold <= NATIVE_INT_MAX
    ):
        lines.append(f"    health_threshold = {threshold},")
    elif threshold is not None:
        result.todos.append(
            f"{source.location}: disease type {disease_id} health threshold needs review"
        )
    lines.append("}")
    body_parts = value.get("affected_bodyparts", [])
    if isinstance(body_parts, list) and all(safe_platform_id(part) for part in body_parts):
        lines.extend(
            f"definition:affected_body_part({lua_quote(part)})" for part in body_parts
        )
    elif "affected_bodyparts" in value:
        result.todos.append(
            f"{source.location}: disease type {disease_id} body parts need review"
        )
    return finish_catalog(
        source,
        result,
        "disease type",
        disease_id,
        lines,
        {
            "type", "id", "min_duration", "max_duration", "min_intensity",
            "max_intensity", "health_threshold", "affected_bodyparts", "symptoms",
        },
        todo_count,
    )


def render_marker_catalog(
    source: SourceObject,
    result: MigrationResult,
    *,
    builder: str,
    label: str,
) -> str | None:
    value = source.value
    object_id = value.get("id")
    if not safe_platform_id(object_id):
        result.partial.append(f"{source.location}: {label} <invalid id>")
        result.todos.append(f"{source.location}: {label} needs a stable native id")
        return None
    todo_count = len(result.todos)
    lines = [
        f"local definition = content.{builder} {{",
        f"    id = {lua_quote(object_id)},",
        "}",
    ]
    return finish_catalog(
        source,
        result,
        label,
        object_id,
        lines,
        {"type", "id"},
        todo_count,
    )


def render_species(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    species_id = value.get("id")
    if not safe_platform_id(species_id):
        result.partial.append(f"{source.location}: species <invalid id>")
        result.todos.append(f"{source.location}: species needs a stable native id")
        return None
    todo_count = len(result.todos)
    lines = [
        "local definition = content.Species {",
        f"    id = {lua_quote(species_id)},",
    ]
    for source_name, target_name in (
        ("description", "description"),
        ("footsteps", "footsteps"),
        ("bleeds", "bleeds"),
    ):
        if source_name not in value:
            continue
        text = display_text(value[source_name])
        if text:
            lines.append(f"    {target_name} = {lua_quote(text)},")
        else:
            result.todos.append(
                f"{source.location}: species {species_id} {source_name} needs review"
            )
    lines.append("}")
    flags = value.get("flags", [])
    if isinstance(flags, list) and all(safe_platform_id(flag) for flag in flags):
        lines.extend(f"definition:flag({lua_quote(flag)})" for flag in flags)
    elif "flags" in value:
        result.todos.append(f"{source.location}: species {species_id} flags need review")
    for source_name, method in (
        ("anger_triggers", "anger"),
        ("fear_triggers", "fear"),
        ("placate_triggers", "placate"),
    ):
        triggers = value.get(source_name, [])
        if isinstance(triggers, list) and all(
            isinstance(trigger, str) and trigger for trigger in triggers
        ):
            lines.extend(
                f"definition:{method}({lua_quote(trigger)})" for trigger in triggers
            )
        elif source_name in value:
            result.todos.append(
                f"{source.location}: species {species_id} {source_name} need review"
            )
    return finish_catalog(
        source,
        result,
        "species",
        species_id,
        lines,
        {
            "type", "id", "description", "footsteps", "bleeds", "flags",
            "anger_triggers", "fear_triggers", "placate_triggers",
        },
        todo_count,
    )


def render_emission(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    emission_id = value.get("id")
    field = value.get("field")
    if not safe_platform_id(emission_id):
        result.partial.append(f"{source.location}: emission <invalid id>")
        result.todos.append(f"{source.location}: emission needs a stable native id")
        return None
    if not safe_platform_id(field) or field == "fd_null":
        result.partial.append(f"{source.location}: emission {emission_id}")
        result.todos.append(
            f"{source.location}: emission {emission_id} needs a static native field fallback"
        )
        return None
    todo_count = len(result.todos)
    lines = [
        "local definition = content.Emission {",
        f"    id = {lua_quote(emission_id)},",
        f"    field = {lua_quote(field)},",
    ]
    for source_name, target_name, maximum in (
        ("intensity", "intensity", NATIVE_INT_MAX),
        ("qty", "quantity", NATIVE_INT_MAX),
        ("chance", "chance", 100),
    ):
        if source_name not in value:
            continue
        number = value[source_name]
        if (
            isinstance(number, int) and
            not isinstance(number, bool) and
            1 <= number <= maximum
        ):
            lines.append(f"    {target_name} = {number},")
        else:
            result.todos.append(
                f"{source.location}: emission {emission_id} {source_name} needs a bounded integer rewrite"
            )
    lines.append("}")
    return finish_catalog(
        source,
        result,
        "emission",
        emission_id,
        lines,
        {"type", "id", "field", "intensity", "qty", "chance"},
        todo_count,
    )


def render_monster_faction(
    source: SourceObject, result: MigrationResult
) -> str | None:
    value = source.value
    faction_id = value.get("name")
    if not safe_platform_id(faction_id):
        result.partial.append(f"{source.location}: monster faction <invalid id>")
        result.todos.append(
            f"{source.location}: monster faction needs a stable native name"
        )
        return None
    todo_count = len(result.todos)
    lines = [
        "local definition = content.MonsterFaction {",
        f"    id = {lua_quote(faction_id)},",
    ]
    if "base_faction" in value:
        base = value["base_faction"]
        if isinstance(base, str):
            lines.append(f"    base = {lua_quote(base)},")
        else:
            result.todos.append(
                f"{source.location}: monster faction {faction_id} base needs review"
            )
    lines.append("}")
    for relation in ("by_mood", "neutral", "friendly", "hate"):
        targets = value.get(relation, [])
        if isinstance(targets, list) and all(
            isinstance(target, str) and target for target in targets
        ):
            lines.extend(
                f"definition:attitude({lua_quote(relation)}, {lua_quote(target)})"
                for target in targets
            )
        elif relation in value:
            result.todos.append(
                f"{source.location}: monster faction {faction_id} {relation} relations need review"
            )
    return finish_catalog(
        source,
        result,
        "monster faction",
        faction_id,
        lines,
        {"type", "name", "base_faction", "by_mood", "neutral", "friendly", "hate"},
        todo_count,
    )


def render_mutation_category(
    source: SourceObject, result: MigrationResult
) -> str | None:
    value = source.value
    category_id = value.get("id")
    if not safe_platform_id(category_id):
        result.partial.append(f"{source.location}: mutation category <invalid id>")
        result.todos.append(
            f"{source.location}: mutation category needs a stable native id"
        )
        return None
    todo_count = len(result.todos)
    name_value = value.get("name")
    name = display_text(name_value, category_id)
    mutagen_value = value.get("mutagen_message")
    mutagen_message = display_text(mutagen_value)
    # An explicit empty mutagen_message (e.g. MYCUS) is a deliberate legacy
    # value and must render as an empty string, not as a review TODO.  A
    # non-string presentation that renders empty is still a real loss.
    presentation_incomplete = (
        not name or
        (
            not mutagen_message and
            mutagen_value is not None and
            not isinstance(mutagen_value, str)
        )
    )
    if presentation_incomplete:
        result.todos.append(
            f"{source.location}: mutation category {category_id} presentation needs review"
        )
    lines = [
        "local definition = content.MutationCategory {",
        f"    id = {lua_quote(category_id)},",
        f"    name = {lua_quote(name or category_id)},",
        f"    mutagen_message = {lua_quote(mutagen_message)},",
    ]
    text_fields = {
        "threshold_mut": "threshold_mutation",
        "memorial_message": "memorial_message",
        "vitamin": "vitamin",
    }
    for source_name, target_name in text_fields.items():
        if source_name not in value:
            continue
        text = display_text(value[source_name])
        if isinstance(value[source_name], str):
            lines.append(f"    {target_name} = {lua_quote(text)},")
        else:
            result.todos.append(
                f"{source.location}: mutation category {category_id} {source_name} needs review"
            )
    integer_fields = {
        "threshold_min": "threshold_minimum",
        "base_removal_chance": "base_removal_chance",
    }
    for source_name, target_name in integer_fields.items():
        if source_name not in value:
            continue
        number = value[source_name]
        valid = (
            isinstance(number, int) and
            not isinstance(number, bool) and
            0 <= number <= NATIVE_INT_MAX and
            (source_name != "base_removal_chance" or number <= 100)
        )
        if valid:
            lines.append(f"    {target_name} = {number},")
        else:
            result.todos.append(
                f"{source.location}: mutation category {category_id} {source_name} needs review"
            )
    multiplier = value.get("base_removal_cost_mul")
    if multiplier is not None:
        if (
            isinstance(multiplier, (int, float)) and
            not isinstance(multiplier, bool) and
            math.isfinite(multiplier) and
            multiplier >= 0
        ):
            lines.append(
                f"    base_removal_cost_multiplier = {lua_number(multiplier)},"
            )
        else:
            result.todos.append(
                f"{source.location}: mutation category {category_id} base removal multiplier needs review"
            )
    for source_name, target_name in (
        ("wip", "work_in_progress"),
        ("skip_test", "skip_consistency_test"),
    ):
        if source_name not in value:
            continue
        state = value[source_name]
        if isinstance(state, bool):
            lines.append(f"    {target_name} = {'true' if state else 'false'},")
        else:
            result.todos.append(
                f"{source.location}: mutation category {category_id} {source_name} needs review"
            )
    lines.append("}")
    return finish_catalog(
        source,
        result,
        "mutation category",
        category_id,
        lines,
        {
            "type", "id", "name", "threshold_mut", "mutagen_message",
            "memorial_message", "vitamin", "threshold_min",
            "base_removal_chance", "base_removal_cost_mul", "wip", "skip_test",
        },
        todo_count,
    )


def render_named_catalog(
    source: SourceObject,
    result: MigrationResult,
    *,
    builder: str,
    label: str,
) -> str | None:
    value = source.value
    object_id = value.get("id")
    if not safe_platform_id(object_id):
        result.partial.append(f"{source.location}: {label} <invalid id>")
        result.todos.append(f"{source.location}: {label} needs a stable native id")
        return None
    todo_count = len(result.todos)
    name = display_text(value.get("name"), object_id)
    if not name:
        name = object_id
        result.todos.append(f"{source.location}: {label} {object_id} name needs review")
    lines = [
        f"local definition = content.{builder} {{",
        f"    id = {lua_quote(object_id)},",
        f"    name = {lua_quote(name)},",
        "}",
    ]
    return finish_catalog(
        source,
        result,
        label,
        object_id,
        lines,
        {"type", "id", "name"},
        todo_count,
    )


def render_vehicle_part_location(
    source: SourceObject, result: MigrationResult
) -> str | None:
    value = source.value
    location_id = value.get("id")
    if not safe_platform_id(location_id):
        result.partial.append(f"{source.location}: vehicle part location <invalid id>")
        result.todos.append(
            f"{source.location}: vehicle part location needs a stable native id"
        )
        return None
    todo_count = len(result.todos)
    name = display_text(value.get("name"), location_id)
    description = display_text(value.get("desc"))
    z_order = value.get("z_order", 0)
    list_order = value.get("list_order", 5)
    if not name:
        name = location_id
        result.todos.append(
            f"{source.location}: vehicle part location {location_id} name needs review"
        )
    for field_name, raw, default in (
        ("z_order", z_order, 0),
        ("list_order", list_order, 5),
    ):
        if (
            not isinstance(raw, int) or
            isinstance(raw, bool) or
            not -NATIVE_INT_MAX - 1 <= raw <= NATIVE_INT_MAX
        ):
            result.todos.append(
                f"{source.location}: vehicle part location {location_id} {field_name} needs review"
            )
            if field_name == "z_order":
                z_order = default
            else:
                list_order = default
    lines = [
        "local definition = content.VehiclePartLocation {",
        f"    id = {lua_quote(location_id)},",
        f"    name = {lua_quote(name)},",
        f"    description = {lua_quote(description)},",
        f"    z_order = {z_order},",
        f"    list_order = {list_order},",
        "}",
    ]
    return finish_catalog(
        source,
        result,
        "vehicle part location",
        location_id,
        lines,
        {"type", "id", "name", "desc", "z_order", "list_order"},
        todo_count,
    )


def render_mood_face(
    source: SourceObject,
    result: MigrationResult,
    *,
    inheritance_corpus: dict[str, dict[str, Any]] | None = None,
) -> str | None:
    value = source.value
    if "copy-from" in value:
        if inheritance_corpus is None:
            result.partial.append(
                f"{source.location}: mood face {value.get('id') or '<invalid id>'}"
            )
            result.todos.append(
                f"{source.location}: mood face inheritance needs the migration corpus"
            )
            return None
        resolved, todos = resolve_copy_from(
            value,
            inheritance_corpus,
            label=f"mood face {value.get('id') or '<invalid id>'}",
            location=source.location,
        )
        for todo in todos:
            result.todos.append(todo)
        if todos:
            result.partial.append(
                f"{source.location}: mood face {value.get('id') or '<invalid id>'}"
            )
            return None
        value = resolved
        source = SourceObject(source.path, source.index, resolved)
    face_id = value.get("id")
    if not safe_platform_id(face_id):
        result.partial.append(f"{source.location}: mood face <invalid id>")
        result.todos.append(f"{source.location}: mood face needs a stable native id")
        return None
    todo_count = len(result.todos)
    lines = [
        "local definition = content.MoodFace {",
        f"    id = {lua_quote(face_id)},",
        "}",
    ]
    values = value.get("values")
    if not isinstance(values, list) or not values:
        result.todos.append(f"{source.location}: mood face {face_id} values need review")
    else:
        seen_scores: set[int] = set()
        for entry in values:
            score = entry.get("value") if isinstance(entry, dict) else None
            face = entry.get("face") if isinstance(entry, dict) else None
            if (
                not isinstance(score, int) or
                isinstance(score, bool) or
                not -NATIVE_INT_MAX - 1 <= score <= NATIVE_INT_MAX or
                score in seen_scores or
                not isinstance(face, str) or
                not face
            ):
                result.todos.append(
                    f"{source.location}: mood face {face_id} value needs review"
                )
                continue
            seen_scores.add(score)
            lines.append(f"definition:value({score}, {lua_quote(face)})")
    return finish_catalog(
        source,
        result,
        "mood face",
        face_id,
        lines,
        {"type", "id", "values"},
        todo_count,
    )


def render_damage_info_order(
    source: SourceObject, result: MigrationResult
) -> str | None:
    value = source.value
    order_id = value.get("id")
    if not safe_platform_id(order_id):
        result.partial.append(f"{source.location}: damage info order <invalid id>")
        result.todos.append(
            f"{source.location}: damage info order needs a stable native id"
        )
        return None
    todo_count = len(result.todos)
    display = value.get("info_display", "detailed")
    if display not in {"none", "basic", "detailed"}:
        display = "detailed"
        result.todos.append(
            f"{source.location}: damage info order {order_id} display mode needs review"
        )
    lines = [
        "local definition = content.DamageInfoOrder {",
        f"    id = {lua_quote(order_id)},",
        f"    display = {lua_quote(display)},",
    ]
    verb = display_text(value.get("verb"))
    if verb:
        lines.append(f"    verb = {lua_quote(verb)},")
    elif "verb" in value:
        result.todos.append(
            f"{source.location}: damage info order {order_id} verb needs review"
        )
    lines.append("}")
    sections = {
        "bionic_info": "bionic",
        "protection_info": "protection",
        "pet_prot_info": "pet_protection",
        "melee_combat_info": "melee",
        "ablative_info": "ablative",
    }
    rendered_sections = 0
    for source_name, target_name in sections.items():
        raw = value.get(source_name)
        order: Any = None
        show_type: Any = True
        if isinstance(raw, int) and not isinstance(raw, bool):
            order = raw
        elif isinstance(raw, dict):
            order = raw.get("order")
            show_type = raw.get("show_type", True)
        elif raw is None:
            continue
        if (
            not isinstance(order, int) or
            isinstance(order, bool) or
            not -NATIVE_INT_MAX - 1 <= order <= NATIVE_INT_MAX or
            not isinstance(show_type, bool)
        ):
            result.todos.append(
                f"{source.location}: damage info order {order_id} {source_name} needs review"
            )
            continue
        lines.append(
            f"definition:section({lua_quote(target_name)}, {order}, "
            f"{'true' if show_type else 'false'})"
        )
        rendered_sections += 1
    if rendered_sections == 0:
        result.todos.append(
            f"{source.location}: damage info order {order_id} needs a display section"
        )
    return finish_catalog(
        source,
        result,
        "damage info order",
        order_id,
        lines,
        {"type", "id", "info_display", "verb", *sections.keys()},
        todo_count,
    )


def render_vehicle_part_category(
    source: SourceObject, result: MigrationResult
) -> str | None:
    value = source.value
    category_id = value.get("id")
    if not safe_platform_id(category_id):
        result.partial.append(f"{source.location}: vehicle part category <invalid id>")
        result.todos.append(
            f"{source.location}: vehicle part category needs a stable native id"
        )
        return None
    todo_count = len(result.todos)
    name = display_text(value.get("name"), category_id)
    short_name = display_text(value.get("short_name"), name)
    priority = value.get("priority", 0)
    if not name or not short_name:
        result.todos.append(
            f"{source.location}: vehicle part category {category_id} labels need review"
        )
    if (
        not isinstance(priority, int) or
        isinstance(priority, bool) or
        not -NATIVE_INT_MAX - 1 <= priority <= NATIVE_INT_MAX
    ):
        priority = 0
        result.todos.append(
            f"{source.location}: vehicle part category {category_id} priority needs review"
        )
    lines = [
        "local definition = content.VehiclePartCategory {",
        f"    id = {lua_quote(category_id)},",
        f"    name = {lua_quote(name)},",
        f"    short_name = {lua_quote(short_name)},",
        f"    priority = {priority},",
        "}",
    ]
    return finish_catalog(
        source,
        result,
        "vehicle part category",
        category_id,
        lines,
        {"type", "id", "name", "short_name", "priority"},
        todo_count,
    )


def parse_named_color(value: Any) -> tuple[int, int, int, int] | None:
    if isinstance(value, list) and len(value) in {3, 4} and all(
        isinstance(channel, int) and
        not isinstance(channel, bool) and
        0 <= channel <= 255
        for channel in value
    ):
        channels = [*value]
        if len(channels) == 3:
            channels.append(255)
        return channels[0], channels[1], channels[2], channels[3]
    if not isinstance(value, str):
        return None
    digits = value[1:] if value.startswith("#") else value
    if len(digits) not in {3, 4, 6, 8} or re.fullmatch(r"[0-9A-Fa-f]+", digits) is None:
        return None
    if len(digits) in {3, 4}:
        digits = "".join(character * 2 for character in digits)
    if len(digits) == 6:
        digits += "FF"
    return tuple(int(digits[index:index + 2], 16) for index in range(0, 8, 2))  # type: ignore[return-value]


def render_named_color(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    name = value.get("name")
    if not isinstance(name, str) or not name:
        result.partial.append(f"{source.location}: named color <invalid name>")
        result.todos.append(f"{source.location}: named color needs a stable name")
        return None
    todo_count = len(result.todos)
    channels = parse_named_color(value.get("value"))
    if channels is None:
        channels = (0, 0, 0, 255)
        result.todos.append(f"{source.location}: named color {name} value needs review")
    red, green, blue, alpha = channels
    lines = [
        "local definition = content.NamedColor {",
        f"    name = {lua_quote(name)},",
        f"    red = {red},",
        f"    green = {green},",
        f"    blue = {blue},",
        f"    alpha = {alpha},",
        "}",
    ]
    return finish_catalog(
        source,
        result,
        "named color",
        name,
        lines,
        {"type", "name", "value"},
        todo_count,
    )


def render_rotatable_symbol(
    source: SourceObject, result: MigrationResult
) -> str | None:
    value = source.value
    symbols = value.get("tuple")
    if (
        not isinstance(symbols, list) or
        len(symbols) not in {2, 4} or
        not all(isinstance(symbol, str) and len(symbol) == 1 for symbol in symbols) or
        len(set(symbols)) != len(symbols)
    ):
        result.partial.append(f"{source.location}: rotatable symbol <invalid tuple>")
        result.todos.append(
            f"{source.location}: rotatable symbol needs two or four distinct glyphs"
        )
        return None
    todo_count = len(result.todos)
    rendered = "{ " + ", ".join(lua_quote(symbol) for symbol in symbols) + " }"
    lines = [
        "local definition = content.RotatableSymbol {",
        f"    symbols = {rendered},",
        "}",
    ]
    return finish_catalog(
        source,
        result,
        "rotatable symbol",
        symbols[0],
        lines,
        {"type", "tuple"},
        todo_count,
    )


def terminal_cell_width(text: str) -> int:
    plain = re.sub(r"</?color[^>]*>", "", text)
    width = 0
    for character in plain:
        if unicodedata.combining(character):
            continue
        width += 2 if unicodedata.east_asian_width(character) in {"W", "F"} else 1
    return width


def render_ascii_art(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    art_id = value.get("id")
    if not safe_platform_id(art_id):
        result.partial.append(f"{source.location}: ASCII art <invalid id>")
        result.todos.append(f"{source.location}: ASCII art needs a stable native id")
        return None
    todo_count = len(result.todos)
    lines = [
        "local definition = content.AsciiArt {",
        f"    id = {lua_quote(art_id)},",
        "}",
    ]
    picture = value.get("picture")
    if not isinstance(picture, list) or not picture:
        result.todos.append(f"{source.location}: ASCII art {art_id} picture needs review")
    else:
        for line in picture:
            if not isinstance(line, str) or terminal_cell_width(line) > 41:
                result.todos.append(
                    f"{source.location}: ASCII art {art_id} line needs width review"
                )
                continue
            lines.append(f"definition:line({lua_quote(line)})")
    return finish_catalog(
        source,
        result,
        "ASCII art",
        art_id,
        lines,
        {"type", "id", "picture"},
        todo_count,
    )


def render_limb_score(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    score_id = value.get("id")
    if not safe_platform_id(score_id):
        result.partial.append(f"{source.location}: limb score <invalid id>")
        result.todos.append(f"{source.location}: limb score needs a stable native id")
        return None
    todo_count = len(result.todos)
    name = display_text(value.get("name"), score_id)
    wounds = value.get("affected_by_wounds", True)
    encumbrance = value.get("affected_by_encumb", True)
    if not isinstance(wounds, bool):
        wounds = True
        result.todos.append(
            f"{source.location}: limb score {score_id} wound behavior needs review"
        )
    if not isinstance(encumbrance, bool):
        encumbrance = True
        result.todos.append(
            f"{source.location}: limb score {score_id} encumbrance behavior needs review"
        )
    lines = [
        "local definition = content.LimbScore {",
        f"    id = {lua_quote(score_id)},",
        f"    name = {lua_quote(name)},",
        f"    affected_by_wounds = {'true' if wounds else 'false'},",
        f"    affected_by_encumbrance = {'true' if encumbrance else 'false'},",
        "}",
    ]
    return finish_catalog(
        source,
        result,
        "limb score",
        score_id,
        lines,
        {"type", "id", "name", "affected_by_wounds", "affected_by_encumb"},
        todo_count,
    )


def render_hit_range(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    todo_count = len(result.todos)
    raw_values = value.get("even_good")
    valid = (
        isinstance(raw_values, list) and
        bool(raw_values) and
        all(
            isinstance(entry, int) and
            not isinstance(entry, bool) and
            0 <= entry <= NATIVE_INT_MAX
            for entry in raw_values
        )
    )
    values = raw_values if valid else []
    if not valid:
        result.todos.append(f"{source.location}: hit range values need review")
    rendered_values = ", ".join(str(entry) for entry in values)
    lines = [
        "local definition = content.HitRange {",
        f"    even_good = {{ {rendered_values} }},",
        "}",
        "content.replace(definition)",
        "",
    ]
    unresolved = unresolved_fields(value, {"type", "even_good"})
    if unresolved:
        result.todos.append(
            f"{source.location}: hit range unresolved fields: {', '.join(unresolved)}"
        )
    status = result.partial if unresolved or len(result.todos) != todo_count else result.converted
    status.append(f"{source.location}: hit range global")
    return "\n".join(lines)


def render_bash_damage_profile(
    source: SourceObject, result: MigrationResult
) -> str | None:
    value = source.value
    profile_id = value.get("id")
    if not safe_platform_id(profile_id):
        result.partial.append(f"{source.location}: bash damage profile <invalid id>")
        result.todos.append(
            f"{source.location}: bash damage profile needs a stable native id"
        )
        return None
    todo_count = len(result.todos)
    lines = [
        "local definition = content.BashDamageProfile {",
        f"    id = {lua_quote(profile_id)},",
        "}",
    ]
    profile = value.get("profile")
    if not isinstance(profile, dict):
        result.todos.append(
            f"{source.location}: bash damage profile {profile_id} factors need review"
        )
    else:
        for damage_id, factor in sorted(profile.items(), key=lambda entry: str(entry[0])):
            if (
                not isinstance(damage_id, str) or
                not damage_id or
                not isinstance(factor, (int, float)) or
                isinstance(factor, bool) or
                not math.isfinite(factor) or
                factor < 0
            ):
                result.todos.append(
                    f"{source.location}: bash damage profile {profile_id} factor needs review"
                )
                continue
            lines.append(
                f"definition:factor({lua_quote(damage_id)}, {lua_number(factor)})"
            )
    return finish_catalog(
        source,
        result,
        "bash damage profile",
        profile_id,
        lines,
        {"type", "id", "profile"},
        todo_count,
    )


def render_clothing_mod(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    mod_id = value.get("id")
    if not safe_platform_id(mod_id):
        result.partial.append(f"{source.location}: clothing modification <invalid id>")
        result.todos.append(
            f"{source.location}: clothing modification needs a stable native id"
        )
        return None
    todo_count = len(result.todos)
    flag = value.get("flag")
    material_item = value.get("item")
    apply_prompt = display_text(value.get("implement_prompt"), "")
    remove_prompt = display_text(value.get("destroy_prompt"), "")
    required_values = (flag, material_item, apply_prompt, remove_prompt)
    if not all(isinstance(entry, str) and entry for entry in required_values):
        result.todos.append(
            f"{source.location}: clothing modification {mod_id} identity or prompts need review"
        )
    lines = [
        "local definition = content.ClothingMod {",
        f"    id = {lua_quote(mod_id)},",
        f"    flag = {lua_quote(flag if isinstance(flag, str) else '')},",
        "    material_item = "
        f"{lua_quote(material_item if isinstance(material_item, str) else '')},",
        f"    apply_prompt = {lua_quote(apply_prompt)},",
        f"    remove_prompt = {lua_quote(remove_prompt)},",
        f"    restricted = {'true' if value.get('restricted') is True else 'false'},",
        "}",
    ]
    modifiers = value.get("mod_value")
    valid_stats = {
        "acid",
        "fire",
        "bash",
        "cut",
        "bullet",
        "encumbrance",
        "warmth",
    }
    if not isinstance(modifiers, list) or not modifiers:
        result.todos.append(
            f"{source.location}: clothing modification {mod_id} modifiers need review"
        )
    else:
        for modifier in modifiers:
            if not isinstance(modifier, dict):
                result.todos.append(
                    f"{source.location}: clothing modification {mod_id} modifier needs review"
                )
                continue
            stat = modifier.get("type")
            amount = modifier.get("value")
            scaling = modifier.get("proportion", [])
            round_up = modifier.get("round_up", False)
            valid = (
                isinstance(stat, str) and
                stat in valid_stats and
                isinstance(amount, (int, float)) and
                not isinstance(amount, bool) and
                math.isfinite(amount) and
                isinstance(scaling, list) and
                len(scaling) <= 2 and
                all(isinstance(entry, str) for entry in scaling) and
                all(entry in {"thickness", "coverage"} for entry in scaling) and
                len(set(scaling)) == len(scaling) and
                isinstance(round_up, bool)
            )
            if not valid:
                result.todos.append(
                    f"{source.location}: clothing modification {mod_id} modifier needs review"
                )
                continue
            rendered_scale = ", ".join(lua_quote(entry) for entry in scaling)
            lines.extend(
                (
                    "definition:modifier {",
                    f"    stat = {lua_quote(stat)},",
                    f"    amount = {lua_number(amount)},",
                    f"    scale = {{ {rendered_scale} }},",
                    f"    round_up = {'true' if round_up else 'false'},",
                    "}",
                )
            )
    return finish_catalog(
        source,
        result,
        "clothing modification",
        mod_id,
        lines,
        {
            "type",
            "id",
            "flag",
            "item",
            "implement_prompt",
            "destroy_prompt",
            "restricted",
            "mod_value",
        },
        todo_count,
    )


def render_overmap_land_use_code(
    source: SourceObject, result: MigrationResult
) -> str | None:
    value = source.value
    code_id = value.get("id")
    # The legacy null land-use entry (the "no land use" code) uses an empty
    # string id and is a real registry object, not an authoring mistake.
    legacy_null_id = code_id == ""
    if not safe_platform_id(code_id) and not legacy_null_id:
        result.partial.append(f"{source.location}: overmap land-use code <invalid id>")
        result.todos.append(
            f"{source.location}: overmap land-use code needs a stable non-null id"
        )
        return None
    todo_count = len(result.todos)
    numeric_code = value.get("land_use_code", 0)
    symbol = value.get("sym")
    color = value.get("color", "black")
    name = display_text(value.get("name"), code_id)
    description = display_text(value.get("detailed_definition"), "")
    if (
        not isinstance(numeric_code, int) or
        isinstance(numeric_code, bool) or
        not NATIVE_INT_MIN <= numeric_code <= NATIVE_INT_MAX or
        not isinstance(symbol, str) or
        len(symbol) != 1 or
        not isinstance(color, str) or
        not color
    ):
        result.todos.append(
            f"{source.location}: overmap land-use code {code_id} display values need review"
        )
    safe_code = (
        numeric_code
        if isinstance(numeric_code, int) and
        not isinstance(numeric_code, bool) and
        NATIVE_INT_MIN <= numeric_code <= NATIVE_INT_MAX
        else 0
    )
    safe_symbol = symbol if isinstance(symbol, str) and len(symbol) == 1 else "?"
    safe_color = color if isinstance(color, str) and color else "black"
    lines = [
        "local definition = content.OvermapLandUseCode {",
        f"    id = {lua_quote(code_id)},",
        f"    code = {safe_code},",
        f"    name = {lua_quote(name)},",
        f"    description = {lua_quote(description)},",
        f"    symbol = {lua_quote(safe_symbol)},",
        f"    color = {lua_quote(safe_color)},",
        "}",
    ]
    return finish_catalog(
        source,
        result,
        "overmap land-use code",
        code_id,
        lines,
        {"type", "id", "land_use_code", "name", "detailed_definition", "sym", "color"},
        todo_count,
    )


def render_overmap_vision(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    vision_id = value.get("id")
    if not safe_platform_id(vision_id) or "$" in str(vision_id):
        result.partial.append(f"{source.location}: overmap vision <invalid id>")
        result.todos.append(
            f"{source.location}: overmap vision needs a stable native id without '$'"
        )
        return None
    todo_count = len(result.todos)
    lines = [
        "local definition = content.OvermapVision {",
        f"    id = {lua_quote(vision_id)},",
        "}",
    ]
    raw_levels = value.get("levels", [])
    if not isinstance(raw_levels, list) or len(raw_levels) > 3:
        result.todos.append(
            f"{source.location}: overmap vision {vision_id} levels need review"
        )
        raw_levels = []
    for index, raw_level in enumerate(raw_levels, start=1):
        if not isinstance(raw_level, dict):
            result.todos.append(
                f"{source.location}: overmap vision {vision_id} level {index} needs review"
            )
            continue
        if raw_level.get("blends_adjacent") is True:
            lines.append("definition:blend_adjacent()")
            unknown = set(raw_level) - {"blends_adjacent"}
            if unknown:
                result.todos.append(
                    f"{source.location}: overmap vision {vision_id} blended level {index} has extra fields"
                )
            continue
        name = raw_level.get("name")
        symbol = raw_level.get("sym")
        color = raw_level.get("color", "black")
        looks_like = raw_level.get("looks_like")
        if (
            not isinstance(name, str) or
            not name or
            not isinstance(symbol, str) or
            len(symbol) != 1 or
            not isinstance(color, str) or
            not color or
            (looks_like is not None and (
                not isinstance(looks_like, str) or not looks_like
            ))
        ):
            result.todos.append(
                f"{source.location}: overmap vision {vision_id} appearance level {index} needs review"
            )
            continue
        lines.extend([
            "definition:appearance {",
            f"    name = {lua_quote(name)},",
            f"    symbol = {lua_quote(symbol)},",
            f"    color = {lua_quote(color)},",
        ])
        if looks_like:
            lines.append(f"    looks_like = {lua_quote(looks_like)},")
        lines.append("}")
        unknown = set(raw_level) - {
            "name", "sym", "color", "looks_like", "blends_adjacent"
        }
        if unknown:
            result.todos.append(
                f"{source.location}: overmap vision {vision_id} level {index} has unsupported fields"
            )
    return finish_catalog(
        source,
        result,
        "overmap vision",
        vision_id,
        lines,
        {"type", "id", "levels"},
        todo_count,
    )


def render_overmap_location(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    location_id = value.get("id")
    if not safe_platform_id(location_id):
        result.partial.append(f"{source.location}: overmap location <invalid id>")
        result.todos.append(f"{source.location}: overmap location needs a stable native id")
        return None
    todo_count = len(result.todos)
    lines = [
        "local definition = content.OvermapLocation {",
        f"    id = {lua_quote(location_id)},",
        "}",
    ]
    selectors = 0
    for field_name, method in (("terrains", "terrain"), ("flags", "terrain_flag")):
        raw_values = value.get(field_name, [])
        if not isinstance(raw_values, list):
            result.todos.append(
                f"{source.location}: overmap location {location_id} {field_name} need review"
            )
            continue
        seen: set[str] = set()
        for raw in raw_values:
            if not isinstance(raw, str) or not raw or raw in seen:
                result.todos.append(
                    f"{source.location}: overmap location {location_id} {field_name} entry needs review"
                )
                continue
            seen.add(raw)
            selectors += 1
            lines.append(f"definition:{method}({lua_quote(raw)})")
    if selectors == 0:
        result.partial.append(f"{source.location}: overmap location {location_id}")
        result.todos.append(
            f"{source.location}: overmap location {location_id} needs at least one terrain selector"
        )
        return None
    return finish_catalog(
        source,
        result,
        "overmap location",
        location_id,
        lines,
        {"type", "id", "terrains", "flags"},
        todo_count,
    )


def render_profession_group(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    group_id = value.get("id")
    if not safe_platform_id(group_id):
        result.partial.append(f"{source.location}: profession group <invalid id>")
        result.todos.append(f"{source.location}: profession group needs a stable native id")
        return None
    professions = value.get("professions")
    if (
        not isinstance(professions, list) or
        not professions or
        any(not isinstance(entry, str) or not entry for entry in professions) or
        len(set(professions)) != len(professions)
    ):
        result.partial.append(f"{source.location}: profession group {group_id}")
        result.todos.append(
            f"{source.location}: profession group {group_id} professions need review"
        )
        return None
    todo_count = len(result.todos)
    lines = [
        "local definition = content.ProfessionGroup {",
        f"    id = {lua_quote(group_id)},",
        "}",
    ]
    lines.extend(
        f"definition:profession({lua_quote(profession)})" for profession in professions
    )
    return finish_catalog(
        source,
        result,
        "profession group",
        group_id,
        lines,
        {"type", "id", "professions"},
        todo_count,
    )


def render_weighted_catalog(
    source: SourceObject,
    result: MigrationResult,
    *,
    builder: str,
    label: str,
    source_field: str,
    method: str,
    object_style: bool = False,
    chance: bool = False,
    allow_duplicates: bool = False,
) -> str | None:
    value = source.value
    group_id = value.get("id")
    if not safe_platform_id(group_id):
        result.partial.append(f"{source.location}: {label} <invalid id>")
        result.todos.append(f"{source.location}: {label} needs a stable native id")
        return None
    todo_count = len(result.todos)
    lines = [f"local definition = content.{builder} {{", f"    id = {lua_quote(group_id)},"]
    supported = {"type", "id", source_field}
    if chance:
        raw_chance = value.get("chance", 0)
        if (
            not isinstance(raw_chance, int) or
            isinstance(raw_chance, bool) or
            not 0 <= raw_chance <= 4_294_967_295
        ):
            result.partial.append(f"{source.location}: {label} {group_id}")
            result.todos.append(f"{source.location}: {label} {group_id} chance needs review")
            return None
        lines.append(f"    chance = {raw_chance},")
        supported.add("chance")
    lines.append("}")
    raw_entries = value.get(source_field)
    if not isinstance(raw_entries, list) or not raw_entries:
        result.partial.append(f"{source.location}: {label} {group_id}")
        result.todos.append(f"{source.location}: {label} {group_id} entries need review")
        return None
    seen: set[str] = set()
    converted = 0
    for raw_entry in raw_entries:
        entry_id: Any = None
        weight: Any = None
        if object_style and isinstance(raw_entry, dict):
            entry_id = raw_entry.get("fault")
            weight = raw_entry.get("weight", 100)
            if set(raw_entry) - {"fault", "weight"}:
                result.todos.append(
                    f"{source.location}: {label} {group_id} entry has unsupported fields"
                )
        elif (
            not object_style and
            isinstance(raw_entry, list) and
            len(raw_entry) == 2
        ):
            entry_id, weight = raw_entry
        if (
            not isinstance(entry_id, str) or
            not entry_id or
            ( not allow_duplicates and entry_id in seen ) or
            not isinstance(weight, int) or
            isinstance(weight, bool) or
            not 1 <= weight <= NATIVE_INT_MAX
        ):
            result.todos.append(
                f"{source.location}: {label} {group_id} weighted entry needs review"
            )
            continue
        seen.add(entry_id)
        converted += 1
        lines.append(f"definition:{method}({lua_quote(entry_id)}, {weight})")
    if converted == 0:
        result.partial.append(f"{source.location}: {label} {group_id}")
        return None
    return finish_catalog(
        source, result, label, group_id, lines, supported, todo_count
    )


def render_explosion_light(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    light_id = value.get("id")
    if not safe_platform_id(light_id):
        result.partial.append(f"{source.location}: explosion light <invalid id>")
        result.todos.append(f"{source.location}: explosion light needs a stable native id")
        return None
    todo_count = len(result.todos)

    def finite(name: str, default: float, *, positive: bool = False) -> float:
        raw = value.get(name, default)
        if (
            isinstance(raw, (int, float)) and
            not isinstance(raw, bool) and
            math.isfinite(raw) and
            (raw > 0 if positive else raw >= 0)
        ):
            return float(raw)
        result.todos.append(
            f"{source.location}: explosion light {light_id} {name} needs review"
        )
        return default

    def rgba_stop(raw_color: Any, raw_alpha: Any) -> tuple[int, int, int, int] | None:
        if (
            isinstance(raw_color, list) and
            len(raw_color) == 3 and
            all(
                isinstance(component, int) and
                not isinstance(component, bool) and
                0 <= component <= 255
                for component in raw_color
            ) and
            isinstance(raw_alpha, int) and
            not isinstance(raw_alpha, bool) and
            0 <= raw_alpha <= 255
        ):
            return raw_color[0], raw_color[1], raw_color[2], raw_alpha
        return None

    stops: list[tuple[int, int, int, int]] = []
    raw_stops = value.get("stops")
    if raw_stops is not None:
        if isinstance(raw_stops, list):
            for raw_stop in raw_stops:
                stop = (
                    rgba_stop(raw_stop.get("color"), raw_stop.get("alpha", 150))
                    if isinstance(raw_stop, dict)
                    else None
                )
                if stop is None or (isinstance(raw_stop, dict) and set(raw_stop) - {"color", "alpha"}):
                    result.todos.append(
                        f"{source.location}: explosion light {light_id} color stop needs review"
                    )
                    continue
                stops.append(stop)
        else:
            result.todos.append(
                f"{source.location}: explosion light {light_id} stops need review"
            )
    else:
        first = rgba_stop(value.get("color_a", [255, 215, 70]), value.get("alpha_a", 150))
        second = rgba_stop(value.get("color_b", [210, 40, 0]), value.get("alpha_b", 70))
        if first is not None and second is not None:
            stops.extend((first, second))
        else:
            result.todos.append(
                f"{source.location}: explosion light {light_id} legacy color stops need review"
            )
    if not stops:
        result.partial.append(f"{source.location}: explosion light {light_id}")
        return None

    easing = value.get("easing", "linear")
    if easing not in {"linear", "ease_in", "ease_out", "smoothstep"}:
        result.todos.append(
            f"{source.location}: explosion light {light_id} easing needs review"
        )
        easing = "linear"
    wave_values = {
        "travel": finite("wave_travel", 0.38),
        "gap": finite("wave_gap", 0.25),
        "rise": finite("rise", 0.05),
        "fade": finite("fade", 0.1),
        "blend": finite("blend", 0.05),
        "spread_jitter": finite("spread_jitter", 0.07),
        "color_jitter": finite("color_jitter", 0.05),
        "flicker": finite("flicker", 0.18),
    }
    duration_values = {
        "base_ms": finite("duration_base_ms", 120.0),
        "per_tile_ms": finite("duration_per_tile_ms", 45.0),
        "minimum_ms": finite("duration_min_ms", 150.0, positive=True),
        "maximum_ms": finite("duration_max_ms", 900.0, positive=True),
    }
    if duration_values["maximum_ms"] < duration_values["minimum_ms"]:
        result.todos.append(
            f"{source.location}: explosion light {light_id} duration bounds need review"
        )
        duration_values["maximum_ms"] = duration_values["minimum_ms"]

    lines = [
        "local definition = content.ExplosionLight {",
        f"    id = {lua_quote(light_id)},",
        "}",
    ]
    lines.extend(
        f"definition:stop({red}, {green}, {blue}, {alpha})"
        for red, green, blue, alpha in stops
    )
    lines.extend(["definition:waves {"])
    lines.extend(
        f"    {name} = {lua_number(number)}," for name, number in wave_values.items()
    )
    lines.extend((f"    easing = {lua_quote(easing)},", "}"))
    lines.append("definition:duration {")
    lines.extend(
        f"    {name} = {lua_number(number)}," for name, number in duration_values.items()
    )
    lines.append("}")
    shake_magnitude = finite("screen_shake_magnitude", 0.0)
    shake_duration = finite("screen_shake_duration_ms", 0.0)
    if shake_magnitude or shake_duration:
        lines.append(
            f"definition:screen_shake({lua_number(shake_magnitude)}, {lua_number(shake_duration)})"
        )
    shock_enabled = value.get("shockwave", False)
    if not isinstance(shock_enabled, bool):
        result.todos.append(
            f"{source.location}: explosion light {light_id} shockwave switch needs review"
        )
        shock_enabled = False
    shock_fields = {"shockwave_strength", "shockwave_speed", "shockwave_thickness"}
    if shock_enabled or any(name in value for name in shock_fields):
        strength = finite("shockwave_strength", 0.0)
        speed = finite("shockwave_speed", 1.0, positive=True)
        thickness = finite("shockwave_thickness", 1.5)
        lines.extend([
            "definition:shockwave {",
            f"    enabled = {'true' if shock_enabled else 'false'},",
            f"    strength = {lua_number(strength)},",
            f"    speed = {lua_number(speed)},",
            f"    thickness = {lua_number(thickness)},",
            "}",
        ])
    supported = {
        "type", "id", "color_a", "color_b", "alpha_a", "alpha_b", "stops",
        "easing", "wave_travel", "wave_gap", "rise", "fade", "blend",
        "spread_jitter", "color_jitter", "flicker", "duration_base_ms",
        "duration_per_tile_ms", "duration_min_ms", "duration_max_ms",
        "screen_shake_magnitude", "screen_shake_duration_ms", "shockwave",
        "shockwave_strength", "shockwave_speed", "shockwave_thickness",
    }
    return finish_catalog(
        source, result, "explosion light", light_id, lines, supported, todo_count
    )


def render_ammo_effect(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    effect_id = value.get("id")
    if not safe_platform_id(effect_id):
        result.partial.append(f"{source.location}: ammo effect <invalid id>")
        result.todos.append(f"{source.location}: ammo effect needs a stable native id")
        return None
    todo_count = len(result.todos)

    def native_integer(raw: Any, *, minimum: int = 0, maximum: int = NATIVE_INT_MAX) -> int | None:
        if (
            isinstance(raw, int) and
            not isinstance(raw, bool) and
            minimum <= raw <= maximum
        ):
            return raw
        return None

    trigger = native_integer(value.get("trigger_chance", 100), maximum=100)
    if trigger is None:
        result.todos.append(
            f"{source.location}: ammo effect {effect_id} trigger chance needs review"
        )
        trigger = 100
    lines = [
        "local definition = content.AmmoEffect {",
        f"    id = {lua_quote(effect_id)},",
        f"    trigger_chance = {trigger},",
        "}",
    ]

    def render_field_list(raw: Any, method: str, *, burst: bool) -> None:
        if raw is None:
            return
        if not isinstance(raw, list):
            result.todos.append(
                f"{source.location}: ammo effect {effect_id} {method} entries need review"
            )
            return
        for entry in raw:
            if not isinstance(entry, dict) or not safe_platform_id(entry.get("field_type")):
                result.todos.append(
                    f"{source.location}: ammo effect {effect_id} {method} entry needs review"
                )
                continue
            minimum = native_integer(entry.get("intensity_min", 1))
            maximum = native_integer(entry.get("intensity_max", minimum)) if minimum is not None else None
            chance = native_integer(entry.get("chance", 100), maximum=100)
            radius = native_integer(entry.get("radius", 1)) if burst else 0
            height = native_integer(entry.get("radius_z", 0)) if burst else 0
            footprint = native_integer(entry.get("size", 0)) if burst else 0
            passable = entry.get("check_passable", False)
            allowed = {
                "field_type", "intensity_min", "intensity_max", "chance"
            } | ({"radius", "radius_z", "size", "check_passable"} if burst else set())
            if (
                minimum is None or
                maximum is None or
                maximum < minimum or
                chance is None or
                radius is None or
                height is None or
                footprint is None or
                not isinstance(passable, bool) or
                set(entry) - allowed
            ):
                result.todos.append(
                    f"{source.location}: ammo effect {effect_id} {method} entry needs review"
                )
                continue
            lines.extend((f"definition:{method} {{", f"    field = {lua_quote(entry['field_type'])},"))
            lines.extend((f"    intensity_min = {minimum},", f"    intensity_max = {maximum},"))
            if burst:
                lines.extend((f"    radius = {radius},", f"    height = {height},"))
            lines.append(f"    chance = {chance},")
            if burst:
                lines.extend((f"    footprint = {footprint},", f"    passable_only = {'true' if passable else 'false'},"))
            lines.append("}")

    render_field_list(value.get("aoe"), "field_burst", burst=True)
    render_field_list(value.get("trail"), "trail", burst=False)

    raw_on_hit = value.get("on_hit_effects")
    if raw_on_hit is not None:
        if not isinstance(raw_on_hit, list):
            result.todos.append(
                f"{source.location}: ammo effect {effect_id} on-hit entries need review"
            )
        else:
            for entry in raw_on_hit:
                duration = entry.get("duration") if isinstance(entry, dict) else None
                intensity = native_integer(entry.get("intensity", 1), minimum=1) if isinstance(entry, dict) else None
                if (
                    not isinstance(entry, dict) or
                    not safe_platform_id(entry.get("effect")) or
                    native_integer(duration, minimum=1) is None or
                    intensity is None or
                    not isinstance(entry.get("need_touch_skin", False), bool) or
                    set(entry) - {"effect", "duration", "intensity", "need_touch_skin"}
                ):
                    result.todos.append(
                        f"{source.location}: ammo effect {effect_id} on-hit entry needs a turn-based duration review"
                    )
                    continue
                lines.extend((
                    "definition:on_hit {",
                    f"    effect = {lua_quote(entry['effect'])},",
                    f"    duration_turns = {duration},",
                    f"    intensity = {intensity},",
                    f"    touch_skin = {'true' if entry.get('need_touch_skin', False) else 'false'},",
                    "}",
                ))

    raw_area = value.get("aoe_effects")
    if raw_area is not None:
        if not isinstance(raw_area, list):
            result.todos.append(
                f"{source.location}: ammo effect {effect_id} area-effect entries need review"
            )
        else:
            for entry in raw_area:
                if not isinstance(entry, dict):
                    result.todos.append(
                        f"{source.location}: ammo effect {effect_id} area-effect entry needs review"
                    )
                    continue
                duration = native_integer(entry.get("duration"), minimum=1)
                minimum = native_integer(entry.get("intensity_min", 1), minimum=1)
                maximum = native_integer(entry.get("intensity_max", minimum), minimum=1) if minimum is not None else None
                chance = native_integer(entry.get("chance", 100), maximum=100)
                radius = native_integer(entry.get("radius", 1))
                hits = entry.get("hits_amount", [1, 1])
                hits_ok = (
                    isinstance(hits, list) and
                    len(hits) == 2 and
                    native_integer(hits[0], minimum=1) is not None and
                    native_integer(hits[1], minimum=hits[0]) is not None
                )
                if (
                    not safe_platform_id(entry.get("effect")) or
                    duration is None or
                    minimum is None or
                    maximum is None or
                    maximum < minimum or
                    chance is None or
                    radius is None or
                    not hits_ok or
                    not isinstance(entry.get("all_bp", False), bool) or
                    set(entry) - {"effect", "duration", "intensity_min", "intensity_max", "chance", "radius", "hits_amount", "all_bp"}
                ):
                    result.todos.append(
                        f"{source.location}: ammo effect {effect_id} area-effect entry needs a turn-based duration review"
                    )
                    continue
                lines.extend((
                    "definition:area_effect {",
                    f"    effect = {lua_quote(entry['effect'])},",
                    f"    duration_turns = {duration},",
                    f"    intensity_min = {minimum},",
                    f"    intensity_max = {maximum},",
                    f"    chance = {chance},",
                    f"    radius = {radius},",
                    f"    hits_min = {hits[0]},",
                    f"    hits_max = {hits[1]},",
                    f"    all_body_parts = {'true' if entry.get('all_bp', False) else 'false'},",
                    "}",
                ))

    raw_explosion = value.get("explosion")
    if raw_explosion is not None:
        if not isinstance(raw_explosion, dict):
            result.todos.append(
                f"{source.location}: ammo effect {effect_id} explosion needs review"
            )
        else:
            power = raw_explosion.get("power", 0)
            factor = raw_explosion.get("distance_factor", 0.8)
            noise = native_integer(raw_explosion.get("max_noise", 90_000_000))
            fire = raw_explosion.get("fire", False)
            light = raw_explosion.get("light_effect", "")

            def numeric(raw: Any) -> bool:
                return (
                    isinstance(raw, (int, float)) and
                    not isinstance(raw, bool) and
                    math.isfinite(raw)
                )
            if (
                not numeric(power) or power < 0 or
                not numeric(factor) or not 0 <= factor <= 1 or
                noise is None or not isinstance(fire, bool) or
                not isinstance(light, str)
            ):
                result.todos.append(
                    f"{source.location}: ammo effect {effect_id} explosion values need review"
                )
            else:
                lines.extend((
                    "definition:explosion {",
                    f"    power = {lua_number(power)},",
                    f"    distance_factor = {lua_number(factor)},",
                    f"    max_noise = {noise},",
                    f"    fire = {'true' if fire else 'false'},",
                    f"    light = {lua_quote(light)},",
                    "}",
                ))
                shrapnel = raw_explosion.get("shrapnel")
                if isinstance(shrapnel, dict):
                    casing = native_integer(shrapnel.get("casing_mass", 0))
                    fragment = shrapnel.get("fragment_mass", 0.005)
                    recovery = native_integer(shrapnel.get("recovery", 0), maximum=100)
                    drop = shrapnel.get("drop", "null")
                    if (
                        casing is not None and numeric(fragment) and fragment > 0 and
                        recovery is not None and isinstance(drop, str) and
                        not set(shrapnel) - {"casing_mass", "fragment_mass", "recovery", "drop"}
                    ):
                        lines.extend((
                            "definition:shrapnel {",
                            f"    casing_mass = {casing},",
                            f"    fragment_mass = {lua_number(fragment)},",
                            f"    recovery = {recovery},",
                            f"    drop = {lua_quote(drop)},",
                            "}",
                        ))
                    else:
                        result.todos.append(
                            f"{source.location}: ammo effect {effect_id} shrapnel needs review"
                        )
                elif shrapnel is not None:
                    result.todos.append(
                        f"{source.location}: ammo effect {effect_id} legacy numeric shrapnel needs review"
                    )
                if set(raw_explosion) - {"power", "distance_factor", "max_noise", "fire", "light_effect", "shrapnel"}:
                    result.todos.append(
                        f"{source.location}: ammo effect {effect_id} explosion has unsupported fields"
                    )

    for legacy_name, method in (
        ("do_flashbang", "flashbang"),
        ("do_emp_blast", "emp"),
        ("foamcrete_build", "foamcrete"),
    ):
        enabled = value.get(legacy_name, False)
        if enabled is True:
            lines.append(f"definition:{method}()")
        elif not isinstance(enabled, bool):
            result.todos.append(
                f"{source.location}: ammo effect {effect_id} {legacy_name} needs review"
            )

    raw_spells = value.get("spell_data")
    if raw_spells is not None:
        if not isinstance(raw_spells, list):
            result.todos.append(
                f"{source.location}: ammo effect {effect_id} spells need review"
            )
        else:
            for entry in raw_spells:
                level = native_integer(entry.get("level", 0)) if isinstance(entry, dict) else None
                self_target = entry.get("self", False) if isinstance(entry, dict) else None
                if (
                    not isinstance(entry, dict) or
                    not safe_platform_id(entry.get("id")) or
                    level is None or
                    not isinstance(self_target, bool) or
                    set(entry) - {"id", "level", "self"}
                ):
                    result.todos.append(
                        f"{source.location}: ammo effect {effect_id} spell entry needs review"
                    )
                    continue
                lines.extend((
                    f"definition:spell({lua_quote(entry['id'])}, {{",
                    f"    level = {level},",
                    f"    self = {'true' if self_target else 'false'},",
                    "})",
                ))
    always = value.get("always_cast_spell", False)
    if always is True:
        lines.append("definition:cast_spells_on_miss()")
    elif not isinstance(always, bool):
        result.todos.append(
            f"{source.location}: ammo effect {effect_id} spell trigger needs review"
        )

    if value.get("eoc"):
        result.todos.append(
            f"{source.location}: ammo effect {effect_id} EOC must be rewritten as a named Lua impact_policy handler"
        )
    supported = {
        "type", "id", "trigger_chance", "aoe", "trail", "on_hit_effects",
        "aoe_effects", "explosion", "do_flashbang", "do_emp_blast",
        "foamcrete_build", "spell_data", "always_cast_spell", "eoc",
    }
    return finish_catalog(
        source, result, "ammo effect", effect_id, lines, supported, todo_count
    )


def render_addiction_type(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    addiction_id = value.get("id")
    if not safe_platform_id(addiction_id):
        result.partial.append(f"{source.location}: addiction type <invalid id>")
        result.todos.append(f"{source.location}: addiction type needs a stable native id")
        return None
    todo_count = len(result.todos)
    fields = {
        "name": display_text(value.get("name")),
        "type_name": display_text(value.get("type_name")),
        "description": display_text(value.get("description")),
    }
    if any(not text for text in fields.values()):
        result.partial.append(f"{source.location}: addiction type {addiction_id}")
        result.todos.append(
            f"{source.location}: addiction type {addiction_id} text needs review"
        )
        return None
    craving = value.get("craving_morale", "")
    if not isinstance(craving, str):
        result.todos.append(
            f"{source.location}: addiction type {addiction_id} craving morale needs review"
        )
        craving = ""
    handler_id = f"TODO_{addiction_id}_tick"
    lines = [
        "local definition = content.AddictionType {",
        f"    id = {lua_quote(addiction_id)},",
        f"    name = {lua_quote(fields['name'])},",
        f"    type_name = {lua_quote(fields['type_name'])},",
        f"    description = {lua_quote(fields['description'])},",
        f"    craving_morale = {lua_quote(craving)},",
        "}",
        f"definition:tick_policy({lua_quote(handler_id)})",
    ]
    legacy_behaviour = "builtin" if value.get("builtin") else "effect_on_condition"
    result.todos.append(
        f"{source.location}: addiction type {addiction_id} {legacy_behaviour} must be rewritten as named Lua handler {handler_id}"
    )
    supported = {
        "type", "id", "name", "type_name", "description", "craving_morale",
        "builtin", "effect_on_condition",
    }
    return finish_catalog(
        source, result, "addiction type", addiction_id, lines, supported, todo_count
    )


def render_character_modifier(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    modifier_id = value.get("id")
    if not safe_platform_id(modifier_id):
        result.partial.append(f"{source.location}: character modifier <invalid id>")
        result.todos.append(f"{source.location}: character modifier needs a stable native id")
        return None
    todo_count = len(result.todos)
    description = display_text(value.get("description"))
    if not description:
        result.partial.append(f"{source.location}: character modifier {modifier_id}")
        result.todos.append(
            f"{source.location}: character modifier {modifier_id} description needs review"
        )
        return None
    operation_map = {"+": "add", "ADD": "add", "x": "multiply", "X": "multiply", "*": "multiply", "MULT": "multiply", "": "none"}
    raw_operation = value.get("mod_type", "")
    operation = operation_map.get(raw_operation) if isinstance(raw_operation, str) else None
    if operation is None:
        result.todos.append(
            f"{source.location}: character modifier {modifier_id} operation needs review"
        )
        operation = "none"
    handler_id = f"TODO_{modifier_id}_evaluate"
    lines = [
        "local definition = content.CharacterModifier {",
        f"    id = {lua_quote(modifier_id)},",
        f"    description = {lua_quote(description)},",
        f"    operation = {lua_quote(operation)},",
        "}",
        f"definition:evaluate_with({lua_quote(handler_id)})",
    ]
    result.todos.append(
        f"{source.location}: character modifier {modifier_id} value/builtin must be rewritten as named Lua evaluator {handler_id}"
    )
    return finish_catalog(
        source,
        result,
        "character modifier",
        modifier_id,
        lines,
        {"type", "id", "description", "mod_type", "value"},
        todo_count,
    )


def render_start_location(
    source: SourceObject,
    result: MigrationResult,
    *,
    inheritance_corpus: dict[str, dict[str, Any]] | None = None,
) -> str | None:
    value = source.value
    if "copy-from" in value:
        if inheritance_corpus is None:
            result.partial.append(
                f"{source.location}: start location {value.get('id') or '<invalid id>'}"
            )
            result.todos.append(
                f"{source.location}: start location inheritance needs the migration corpus"
            )
            return None
        resolved, todos = resolve_copy_from(
            value,
            inheritance_corpus,
            label=f"start location {value.get('id') or '<invalid id>'}",
            location=source.location,
        )
        for todo in todos:
            result.todos.append(todo)
        if todos:
            result.partial.append(
                f"{source.location}: start location {value.get('id') or '<invalid id>'}"
            )
            return None
        value = resolved
        source = SourceObject(source.path, source.index, resolved)
    location_id = value.get("id")
    if not safe_platform_id(location_id):
        result.partial.append(f"{source.location}: start location <invalid id>")
        result.todos.append(f"{source.location}: start location needs a stable native id")
        return None
    todo_count = len(result.todos)
    name = display_text(value.get("name"))
    if not name:
        result.partial.append(f"{source.location}: start location {location_id}")
        result.todos.append(f"{source.location}: start location {location_id} name needs review")
        return None
    lines = [
        "local definition = content.StartLocation {",
        f"    id = {lua_quote(location_id)},",
        f"    name = {lua_quote(name)},",
        "}",
    ]
    terrains = value.get("terrain")
    converted_targets = 0
    match_map = {
        "EXACT": "exact", "TYPE": "type", "SUBTYPE": "subtype",
        "PREFIX": "prefix", "CONTAINS": "contains",
    }
    if isinstance(terrains, list):
        for raw in terrains:
            terrain_id: Any = raw
            match = "type"
            parameters: dict[str, str] = {}
            if isinstance(raw, dict):
                terrain_id = raw.get("om_terrain")
                raw_match = raw.get("om_terrain_match_type", "TYPE")
                match = match_map.get(raw_match) if isinstance(raw_match, str) else None
                raw_parameters = raw.get("parameters", {})
                if (
                    not isinstance(raw_parameters, dict) or
                    not all(isinstance(key, str) and isinstance(item, str) for key, item in raw_parameters.items())
                ):
                    parameters = {}
                    match = None
                else:
                    parameters = raw_parameters
                if set(raw) - {"om_terrain", "om_terrain_match_type", "parameters"}:
                    match = None
            if not safe_platform_id(terrain_id) or match is None:
                result.todos.append(
                    f"{source.location}: start location {location_id} terrain selector needs review"
                )
                continue
            converted_targets += 1
            if not parameters and match == "type":
                lines.append(f"definition:terrain({lua_quote(terrain_id)})")
                continue
            lines.extend((f"definition:terrain({lua_quote(terrain_id)}, {{", f"    match = {lua_quote(match)},"))
            if parameters:
                lines.append("    parameters = {")
                lines.extend(
                    f"        [{lua_quote(key)}] = {lua_quote(item)},"
                    for key, item in sorted(parameters.items())
                )
                lines.append("    },")
            lines.append("})")
    elif "terrain" in value:
        # A present but malformed terrain member is a review item; an absent
        # member is a deliberate legacy value (an empty target set).
        result.todos.append(f"{source.location}: start location {location_id} terrain list needs review")
    if "terrain" in value and converted_targets == 0:
        result.partial.append(f"{source.location}: start location {location_id}")
        return None
    flags = value.get("flags", [])
    if isinstance(flags, list) and all(isinstance(flag, str) and flag for flag in flags):
        lines.extend(f"definition:flag({lua_quote(flag)})" for flag in flags)
    else:
        result.todos.append(f"{source.location}: start location {location_id} flags need review")

    def interval(field: str, method: str) -> None:
        raw = value.get(field)
        if raw is None:
            return
        # Legacy numeric_interval::deserialize normalizes a pair whose max
        # is below the min and negative (sloc_road's [10, -1]) by clamping
        # the max to the native integer maximum; replicate that here.
        if (
            isinstance(raw, list) and len(raw) == 2 and
            all(isinstance(item, int) and not isinstance(item, bool) and NATIVE_INT_MIN <= item <= NATIVE_INT_MAX for item in raw)
        ):
            minimum, maximum = raw
            if maximum < minimum and maximum < 0:
                maximum = NATIVE_INT_MAX
            lines.append(f"definition:{method}({minimum}, {maximum})")
        else:
            result.todos.append(f"{source.location}: start location {location_id} {field} needs review")

    interval("city_sizes", "city_size")
    interval("city_distance", "city_distance")
    interval("allowed_z_levels", "z_levels")
    return finish_catalog(
        source, result, "start location", location_id, lines,
        {"type", "id", "name", "terrain", "flags", "city_sizes", "city_distance", "allowed_z_levels"},
        todo_count,
    )


def render_climbing_aid(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    aid_id = value.get("id")
    if not safe_platform_id(aid_id):
        result.partial.append(f"{source.location}: climbing aid <invalid id>")
        result.todos.append(f"{source.location}: climbing aid needs a concrete stable id")
        return None
    todo_count = len(result.todos)
    slip = value.get("slip_chance_mod", 0)
    if not isinstance(slip, int) or isinstance(slip, bool) or not NATIVE_INT_MIN <= slip <= NATIVE_INT_MAX:
        result.todos.append(f"{source.location}: climbing aid {aid_id} slip modifier needs review")
        slip = 0
    lines = [
        "local definition = content.ClimbingAid {",
        f"    id = {lua_quote(aid_id)},",
        f"    slip_chance_modifier = {slip},",
        "}",
    ]
    condition = value.get("condition")
    category_map = {
        "special": "special", "ter_furn": "terrain_or_furniture",
        "veh": "vehicle", "item": "item", "character": "character", "trait": "trait",
    }
    if not isinstance(condition, dict) or condition.get("type") not in category_map or not isinstance(condition.get("flag"), str):
        result.partial.append(f"{source.location}: climbing aid {aid_id}")
        result.todos.append(f"{source.location}: climbing aid {aid_id} availability needs review")
        return None
    uses = condition.get("uses", 0)
    range_value = condition.get("range", 1)
    if (
        not isinstance(uses, int) or isinstance(uses, bool) or not 0 <= uses <= NATIVE_INT_MAX or
        not isinstance(range_value, int) or isinstance(range_value, bool) or not 0 <= range_value <= NATIVE_INT_MAX or
        set(condition) - {"type", "flag", "uses", "range"}
    ):
        result.partial.append(f"{source.location}: climbing aid {aid_id}")
        result.todos.append(f"{source.location}: climbing aid {aid_id} availability limits need review")
        return None
    lines.extend((
        "definition:available_when {",
        f"    category = {lua_quote(category_map[condition['type']])},",
        f"    flag = {lua_quote(condition['flag'])},",
        f"    uses = {uses},",
        f"    range = {range_value},",
        "}",
    ))
    down = value.get("down")
    if not isinstance(down, dict):
        result.partial.append(f"{source.location}: climbing aid {aid_id}")
        result.todos.append(f"{source.location}: climbing aid {aid_id} descent needs review")
        return None
    scalar_fields = {
        "max_height": ("max_height", 1),
        "easy_climb_back_up": ("easy_climb_back_up", 0),
    }
    descent_values: dict[str, int] = {}
    for old_name, (new_name, default) in scalar_fields.items():
        raw = down.get(old_name, default)
        if not isinstance(raw, int) or isinstance(raw, bool) or not -1 <= raw <= NATIVE_INT_MAX:
            result.todos.append(f"{source.location}: climbing aid {aid_id} {old_name} needs review")
            raw = default
        descent_values[new_name] = raw
    remaining = down.get("allow_remaining_height", True)
    menu = display_text(down.get("menu_text"))
    confirm = display_text(down.get("confirm_text"))
    if not isinstance(remaining, bool) or not menu or not confirm:
        result.partial.append(f"{source.location}: climbing aid {aid_id}")
        result.todos.append(f"{source.location}: climbing aid {aid_id} descent text needs review")
        return None
    lines.extend((
        "definition:descent {",
        f"    max_height = {descent_values['max_height']},",
        f"    easy_climb_back_up = {descent_values['easy_climb_back_up']},",
        f"    allow_remaining_height = {'true' if remaining else 'false'},",
        f"    menu_text = {lua_quote(menu)},",
        f"    unavailable_text = {lua_quote(display_text(down.get('menu_cant')))},",
        f"    hotkey = {lua_quote(down.get('menu_hotkey', '') if isinstance(down.get('menu_hotkey', ''), str) else '')},",
        f"    confirm_text = {lua_quote(confirm)},",
        f"    before_message = {lua_quote(display_text(down.get('msg_before')))},",
        f"    after_message = {lua_quote(display_text(down.get('msg_after')))},",
        "}",
    ))
    cost = down.get("cost")
    if isinstance(cost, dict):
        converted_cost: dict[str, int] = {}
        for old_name, new_name in (("pain", "pain"), ("damage", "damage"), ("kcal", "kilocalories"), ("thirst", "thirst")):
            raw = cost.get(old_name, 0)
            if not isinstance(raw, int) or isinstance(raw, bool) or not 0 <= raw <= NATIVE_INT_MAX:
                result.todos.append(f"{source.location}: climbing aid {aid_id} cost needs review")
                converted_cost = {}
                break
            converted_cost[new_name] = raw
        if converted_cost and not set(cost) - {"pain", "damage", "kcal", "thirst"}:
            lines.append("definition:cost {")
            lines.extend(f"    {key} = {item}," for key, item in converted_cost.items())
            lines.append("}")
    elif cost is not None:
        result.todos.append(f"{source.location}: climbing aid {aid_id} cost needs review")
    deploy = down.get("deploy_furn")
    if isinstance(deploy, str) and deploy:
        lines.append(f"definition:deploy({lua_quote(deploy)})")
    elif deploy is not None and not isinstance(deploy, str):
        result.todos.append(f"{source.location}: climbing aid {aid_id} deployment needs review")
    supported_down = {
        "max_height", "easy_climb_back_up", "allow_remaining_height", "menu_text",
        "menu_cant", "menu_hotkey", "confirm_text", "msg_before", "msg_after", "cost", "deploy_furn",
    }
    if set(down) - supported_down:
        result.todos.append(f"{source.location}: climbing aid {aid_id} descent has unsupported fields")
    return finish_catalog(
        source, result, "climbing aid", aid_id, lines,
        {"type", "id", "slip_chance_mod", "condition", "down"}, todo_count,
    )


def render_weather_type(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    weather_id = value.get("id")
    if not safe_platform_id(weather_id):
        result.partial.append(f"{source.location}: weather type <invalid id>")
        result.todos.append(f"{source.location}: weather type needs a stable native id")
        return None
    todo_count = len(result.todos)

    def text_option(name: str, default: str) -> str:
        raw = value.get(name, default)
        if isinstance(raw, str) and raw:
            return raw
        result.todos.append(
            f"{source.location}: weather type {weather_id} {name} needs review"
        )
        return default

    def codepoint_option(name: str, default: str) -> str:
        raw = value.get(name, default)
        if isinstance(raw, str) and len(raw) == 1:
            return raw
        result.todos.append(
            f"{source.location}: weather type {weather_id} {name} needs one Unicode codepoint"
        )
        return default

    def integer_option(name: str, default: int) -> int:
        raw = value.get(name, default)
        if (
            isinstance(raw, int) and
            not isinstance(raw, bool) and
            NATIVE_INT_MIN <= raw <= NATIVE_INT_MAX
        ):
            return raw
        result.todos.append(
            f"{source.location}: weather type {weather_id} {name} needs review"
        )
        return default

    def number_option(name: str, default: float, *, non_negative: bool = False) -> float:
        raw = value.get(name, default)
        if (
            isinstance(raw, (int, float)) and
            not isinstance(raw, bool) and
            math.isfinite(raw) and
            (not non_negative or raw >= 0)
        ):
            return float(raw)
        result.todos.append(
            f"{source.location}: weather type {weather_id} {name} needs review"
        )
        return default

    def boolean_option(name: str, default: bool) -> bool:
        raw = value.get(name, default)
        if isinstance(raw, bool):
            return raw
        result.todos.append(
            f"{source.location}: weather type {weather_id} {name} needs review"
        )
        return default

    def temperature_delta(raw: Any) -> float | None:
        if isinstance(raw, (int, float)) and not isinstance(raw, bool):
            return float(raw) if math.isfinite(raw) else None
        if not isinstance(raw, str):
            return None
        match = re.fullmatch(
            r"\s*([+-]?\d+(?:\.\d+)?)\s*(C|K|F)(?:_delta)?\s*",
            raw,
            flags=re.IGNORECASE,
        )
        if match is None:
            return None
        amount = float(match.group(1))
        return amount * 5.0 / 9.0 if match.group(2).lower() == "f" else amount

    name = display_text(value.get("name"))
    if not name:
        result.partial.append(f"{source.location}: weather type {weather_id}")
        result.todos.append(
            f"{source.location}: weather type {weather_id} name needs review"
        )
        return None
    precipitation = value.get("precip", "none")
    if precipitation not in {"none", "very_light", "light", "heavy"}:
        result.todos.append(
            f"{source.location}: weather type {weather_id} precipitation needs review"
        )
        precipitation = "none"
    sound_category = value.get("sound_category", "silent")
    if sound_category not in {
        "silent", "drizzle", "rainy", "rainstorm", "thunder", "flurries",
        "snowstorm", "snow", "portal_storm", "clear", "sunny", "cloudy",
    }:
        result.todos.append(
            f"{source.location}: weather type {weather_id} sound category needs review"
        )
        sound_category = "silent"
    raw_delta = value.get("temperature_modifier", 0)
    delta = temperature_delta(raw_delta)
    if delta is None or not math.isfinite(delta):
        result.todos.append(
            f"{source.location}: weather type {weather_id} temperature modifier needs review"
        )
        delta = 0.0

    lines = [
        "local definition = content.WeatherType {",
        f"    id = {lua_quote(weather_id)},",
        f"    name = {lua_quote(name)},",
        f"    color = {lua_quote(text_option('color', 'white'))},",
        f"    map_color = {lua_quote(text_option('map_color', 'white'))},",
        f"    symbol = {lua_quote(codepoint_option('sym', '%'))},",
        f"    sun_symbol = {lua_quote(codepoint_option('sun_sym', '☼'))},",
        f"    ranged_penalty = {integer_option('ranged_penalty', 0)},",
        f"    sight_penalty = {lua_number(number_option('sight_penalty', 1.0, non_negative=True))},",
        f"    light_modifier = {integer_option('light_modifier', 0)},",
        f"    temperature_delta_kelvin = {lua_number(delta)},",
        f"    light_multiplier = {lua_number(number_option('light_multiplier', 1.0, non_negative=True))},",
        f"    sun_multiplier = {lua_number(number_option('sun_multiplier', 1.0, non_negative=True))},",
        f"    sound_attenuation = {integer_option('sound_attn', 0)},",
        f"    dangerous = {'true' if boolean_option('dangerous', False) else 'false'},",
        f"    precipitation = {lua_quote(precipitation)},",
        f"    rains = {'true' if boolean_option('rains', False) else 'false'},",
        f"    tiles_animation = {lua_quote(value.get('tiles_animation', '') if isinstance(value.get('tiles_animation', ''), str) else '')},",
        f"    sound_category = {lua_quote(sound_category)},",
        f"    priority = {integer_option('priority', 0)},",
        "}",
    ]
    if not isinstance(value.get("tiles_animation", ""), str):
        result.todos.append(
            f"{source.location}: weather type {weather_id} tiles animation needs review"
        )

    minimum_duration = parse_turns(value.get("duration_min", 300))
    maximum_duration = parse_turns(value.get("duration_max", 300))
    if minimum_duration is None or not 0 < minimum_duration <= NATIVE_INT_MAX:
        result.todos.append(
            f"{source.location}: weather type {weather_id} minimum duration needs review"
        )
        minimum_duration = 300
    if (
        maximum_duration is None or
        not minimum_duration <= maximum_duration <= NATIVE_INT_MAX
    ):
        result.todos.append(
            f"{source.location}: weather type {weather_id} maximum duration needs review"
        )
        maximum_duration = minimum_duration
    lines.append(f"definition:duration({minimum_duration}, {maximum_duration})")

    animation = value.get("weather_animation")
    if animation is not None:
        if (
            isinstance(animation, dict) and
            isinstance(animation.get("factor"), (int, float)) and
            not isinstance(animation.get("factor"), bool) and
            math.isfinite(animation["factor"]) and
            animation["factor"] >= 0 and
            isinstance(animation.get("color"), str) and
            bool(animation["color"]) and
            isinstance(animation.get("sym"), str) and
            len(animation["sym"]) == 1
        ):
            lines.extend((
                "definition:animation {",
                f"    factor = {lua_number(animation['factor'])},",
                f"    color = {lua_quote(animation['color'])},",
                f"    symbol = {lua_quote(animation['sym'])},",
                "}",
            ))
            if set(animation) - {"factor", "color", "sym"}:
                result.todos.append(
                    f"{source.location}: weather type {weather_id} animation has unsupported fields"
                )
        else:
            result.todos.append(
                f"{source.location}: weather type {weather_id} animation needs review"
            )

    prerequisites = value.get("required_weathers", [])
    if isinstance(prerequisites, list) and all(safe_platform_id(item) for item in prerequisites):
        lines.extend(
            f"definition:requires({lua_quote(item)})" for item in prerequisites
        )
    elif "required_weathers" in value:
        result.todos.append(
            f"{source.location}: weather type {weather_id} prerequisites need review"
        )

    passive_effects = value.get("passive_effects", [])
    if isinstance(passive_effects, list):
        for index, effect in enumerate(passive_effects):
            if not isinstance(effect, dict) or not safe_platform_id(effect.get("effect_id")):
                result.todos.append(
                    f"{source.location}: weather type {weather_id} passive effect #{index} needs review"
                )
                continue
            minimum = parse_turns(effect.get("min_duration", 1))
            maximum = parse_turns(effect.get("max_duration", minimum))
            intensity = effect.get("intensity", 1)
            body_part = effect.get("body_part", "")
            environmental = effect.get("is_environmental", True)
            boolean_fields = {
                field: effect.get(field, False)
                for field in (
                    "immune_in_vehicle", "immune_inside_vehicle", "immune_outside_vehicle"
                )
            }
            chance_fields = {
                field: effect.get(field, 0)
                for field in (
                    "chance_in_vehicle", "chance_inside_vehicle", "chance_outside_vehicle"
                )
            }
            valid = (
                minimum is not None and
                maximum is not None and
                0 < minimum <= maximum <= NATIVE_INT_MAX and
                isinstance(intensity, int) and
                not isinstance(intensity, bool) and
                0 < intensity <= NATIVE_INT_MAX and
                isinstance(body_part, str) and
                isinstance(environmental, bool) and
                all(isinstance(item, bool) for item in boolean_fields.values()) and
                all(
                    isinstance(item, int) and
                    not isinstance(item, bool) and
                    0 <= item <= 100
                    for item in chance_fields.values()
                )
            )
            if not valid:
                result.todos.append(
                    f"{source.location}: weather type {weather_id} passive effect #{index} needs review"
                )
                continue
            lines.extend((
                "definition:passive_effect {",
                f"    effect = {lua_quote(effect['effect_id'])},",
                f"    minimum_duration_turns = {minimum},",
                f"    maximum_duration_turns = {maximum},",
                f"    intensity = {intensity},",
                f"    body_part = {lua_quote(body_part)},",
                f"    environmental = {'true' if environmental else 'false'},",
            ))
            lines.extend(
                f"    {field} = {'true' if item else 'false'},"
                for field, item in boolean_fields.items()
            )
            lines.extend(
                f"    {field} = {item}," for field, item in chance_fields.items()
            )
            lines.extend((
                f"    message = {lua_quote(display_text(effect.get('message')))},",
                f"    npc_message = {lua_quote(display_text(effect.get('message_npc')))},",
                "}",
            ))
            if set(effect) - {
                "effect_id", "min_duration", "max_duration", "intensity", "body_part",
                "is_environmental", "immune_in_vehicle", "immune_inside_vehicle",
                "immune_outside_vehicle", "chance_in_vehicle", "chance_inside_vehicle",
                "chance_outside_vehicle", "message", "message_npc",
            }:
                result.todos.append(
                    f"{source.location}: weather type {weather_id} passive effect #{index} has unsupported fields"
                )
    else:
        result.todos.append(
            f"{source.location}: weather type {weather_id} passive effects need review"
        )

    handler_id = f"TODO_{weather_id}_condition"
    lines.append(f"definition:condition({lua_quote(handler_id)})")
    result.todos.append(
        f"{source.location}: weather type {weather_id} legacy condition tree/jmath must be rewritten as named Lua handler {handler_id}"
    )
    for field_name in ("debug_cause_eoc", "debug_leave_eoc"):
        if value.get(field_name):
            result.todos.append(
                f"{source.location}: weather type {weather_id} {field_name} must be rewritten as explicit Lua debug behaviour"
            )
    supported = {
        "type", "id", "name", "color", "map_color", "sym", "sun_sym",
        "ranged_penalty", "sight_penalty", "light_modifier", "temperature_modifier",
        "light_multiplier", "sun_multiplier", "sound_attn", "dangerous", "precip",
        "rains", "tiles_animation", "sound_category", "priority", "duration_min",
        "duration_max", "weather_animation", "required_weathers", "passive_effects",
        "condition", "debug_cause_eoc", "debug_leave_eoc",
    }
    return finish_catalog(
        source, result, "weather type", weather_id, lines, supported, todo_count
    )


def render_score(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    score_id = value.get("id")
    statistic = value.get("statistic")
    if not safe_platform_id(score_id):
        result.partial.append(f"{source.location}: score <invalid id>")
        result.todos.append(f"{source.location}: score needs a stable native id")
        return None
    if not safe_platform_id(statistic):
        result.partial.append(f"{source.location}: score {score_id}")
        result.todos.append(
            f"{source.location}: score {score_id} statistic needs review"
        )
        return None
    todo_count = len(result.todos)
    lines = [
        "local definition = content.Score {",
        f"    id = {lua_quote(score_id)},",
        f"    statistic = {lua_quote(statistic)},",
    ]
    if "description" in value:
        description = display_text(value.get("description"))
        if description:
            lines.append(f"    description = {lua_quote(description)},")
        else:
            result.todos.append(
                f"{source.location}: score {score_id} description needs review"
            )
    lines.append("}")
    return finish_catalog(
        source,
        result,
        "score",
        score_id,
        lines,
        {"type", "id", "statistic", "description"},
        todo_count,
    )


def render_end_screen(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    screen_id = value.get("id")
    picture = value.get("picture_id")
    priority = value.get("priority", 0)
    if not safe_platform_id(screen_id) or not safe_platform_id(picture):
        result.partial.append(f"{source.location}: end screen <invalid id>")
        result.todos.append(
            f"{source.location}: end screen needs stable screen and ASCII-art ids"
        )
        return None
    if (
        not isinstance(priority, int) or
        isinstance(priority, bool) or
        not NATIVE_INT_MIN <= priority <= NATIVE_INT_MAX
    ):
        result.partial.append(f"{source.location}: end screen {screen_id}")
        result.todos.append(
            f"{source.location}: end screen {screen_id} priority needs review"
        )
        return None
    todo_count = len(result.todos)
    lines = [
        "local definition = content.EndScreen {",
        f"    id = {lua_quote(screen_id)},",
        f"    picture = {lua_quote(picture)},",
        f"    priority = {priority},",
    ]
    if "last_words_label" in value:
        label = display_text(value.get("last_words_label"))
        if label:
            lines.append(f"    last_words_label = {lua_quote(label)},")
        else:
            result.todos.append(
                f"{source.location}: end screen {screen_id} last-words label needs review"
            )
    lines.append("}")
    information = value.get("added_info", [])
    if isinstance(information, list):
        for index, entry in enumerate(information):
            valid = (
                isinstance(entry, list) and
                len(entry) == 2 and
                isinstance(entry[0], list) and
                len(entry[0]) == 2 and
                all(
                    isinstance(number, int) and
                    not isinstance(number, bool) and
                    NATIVE_INT_MIN <= number <= NATIVE_INT_MAX
                    for number in entry[0]
                ) and
                bool(display_text(entry[1]))
            )
            if not valid:
                result.todos.append(
                    f"{source.location}: end screen {screen_id} information #{index} needs review"
                )
                continue
            lines.append(
                f"definition:info({entry[0][0]}, {entry[0][1]}, "
                f"{lua_quote(display_text(entry[1]))})"
            )
    else:
        result.todos.append(
            f"{source.location}: end screen {screen_id} positioned information needs review"
        )
    handler_id = f"TODO_{screen_id}_condition"
    lines.append(f"definition:condition({lua_quote(handler_id)})")
    result.todos.append(
        f"{source.location}: end screen {screen_id} legacy condition tree must be rewritten as named Lua handler {handler_id}"
    )
    return finish_catalog(
        source,
        result,
        "end screen",
        screen_id,
        lines,
        {
            "type", "id", "picture_id", "priority", "condition",
            "added_info", "last_words_label",
        },
        todo_count,
    )


def render_activity_type(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    activity_id = value.get("id")
    verb = display_text(value.get("verb"))
    if not safe_platform_id(activity_id) or not verb:
        result.partial.append(f"{source.location}: activity type <invalid id>")
        result.todos.append(
            f"{source.location}: activity type needs a stable id and display verb"
        )
        return None

    based_on = value.get("based_on", "speed")
    if based_on not in {"time", "speed", "neither"}:
        result.partial.append(f"{source.location}: activity type {activity_id}")
        result.todos.append(
            f"{source.location}: activity type {activity_id} progress model needs review"
        )
        return None

    levels = {
        "SLEEP_EXERCISE": 0.85,
        "NO_EXERCISE": 1.0,
        "LIGHT_EXERCISE": 2.0,
        "MODERATE_EXERCISE": 4.0,
        "BRISK_EXERCISE": 6.0,
        "ACTIVE_EXERCISE": 8.0,
        "EXTRA_EXERCISE": 10.0,
    }
    activity_level = value.get("activity_level", "NO_EXERCISE")
    if isinstance(activity_level, str):
        activity_level = levels.get(activity_level)
    if (
        not isinstance(activity_level, (int, float)) or
        isinstance(activity_level, bool) or
        not math.isfinite(activity_level) or
        activity_level <= 0
    ):
        result.partial.append(f"{source.location}: activity type {activity_id}")
        result.todos.append(
            f"{source.location}: activity type {activity_id} activity level needs review"
        )
        return None

    todo_count = len(result.todos)
    lines = [
        "local definition = content.ActivityType {",
        f"    id = {lua_quote(activity_id)},",
        f"    verb = {lua_quote(verb)},",
        f"    based_on = {lua_quote(based_on)},",
        f"    activity_level = {lua_number(activity_level)},",
    ]
    boolean_fields = (
        ("rooted", "rooted"),
        ("interruptable", "interruptable"),
        ("interruptable_with_kb", "interruptable_with_keyboard"),
        ("can_resume", "can_resume"),
        ("multi_activity", "multi_activity"),
        ("fetch_items_to_zone", "fetch_items_to_zone"),
        ("refuel_fires", "refuel_fires"),
        ("auto_needs", "auto_needs"),
    )
    for source_field, target_field in boolean_fields:
        if source_field not in value:
            continue
        field_value = value[source_field]
        if isinstance(field_value, bool):
            lines.append(
                f"    {target_field} = {'true' if field_value else 'false'},"
            )
        else:
            result.todos.append(
                f"{source.location}: activity type {activity_id} {source_field} needs review"
            )
    lines.append("}")

    distractions = value.get("ignored_distractions", [])
    if isinstance(distractions, list) and all(
        isinstance(entry, str) and bool(entry) for entry in distractions
    ):
        for distraction in distractions:
            lines.append(f"definition:ignore({lua_quote(distraction)})")
    else:
        result.todos.append(
            f"{source.location}: activity type {activity_id} ignored distractions need review"
        )

    if "do_turn_eoc" in value or based_on == "neither":
        handler_id = f"TODO_{activity_id}_turn"
        lines.append(f"definition:on_turn({lua_quote(handler_id)})")
        result.todos.append(
            f"{source.location}: activity type {activity_id} turn behaviour must be rewritten as named Lua handler {handler_id}"
        )
    if "completion_eoc" in value:
        handler_id = f"TODO_{activity_id}_finish"
        lines.append(f"definition:on_finish({lua_quote(handler_id)})")
        result.todos.append(
            f"{source.location}: activity type {activity_id} completion behaviour must be rewritten as named Lua handler {handler_id}"
        )

    return finish_catalog(
        source,
        result,
        "activity type",
        activity_id,
        lines,
        {
            "type", "id", "verb", "rooted", "interruptable",
            "interruptable_with_kb", "based_on", "can_resume",
            "multi_activity", "fetch_items_to_zone", "refuel_fires",
            "auto_needs", "activity_level", "ignored_distractions",
            "do_turn_eoc", "completion_eoc",
        },
        todo_count,
    )


def generated_platform_id(prefix: str, *parts: Any) -> str:
    raw = "_".join(str(part) for part in parts if str(part))
    normalized = unicodedata.normalize("NFKC", raw)
    fragment = re.sub(r"[^A-Za-z0-9_.-]+", "_", normalized).strip("_")
    return f"{prefix}_{fragment or 'entry'}"[:256]


def render_help_topic(
    source: SourceObject, result: MigrationResult, mod_id: str
) -> str | None:
    value = source.value
    title = display_text(value.get("name"))
    order = value.get("order")
    messages = value.get("messages")
    if (
        not title or
        not isinstance(order, int) or
        isinstance(order, bool) or
        not isinstance(messages, list) or
        not messages
    ):
        result.partial.append(f"{source.location}: help topic <invalid>")
        result.todos.append(
            f"{source.location}: help topic needs a title, integer source order, and paragraphs"
        )
        return None
    topic_id = generated_platform_id("help", mod_id, order, title)
    todo_count = len(result.todos)
    lines = [
        "local definition = content.HelpTopic {",
        f"    id = {lua_quote(topic_id)},",
        f"    title = {lua_quote(title)},",
        "}",
    ]
    for index, message in enumerate(messages):
        paragraph = display_text(message)
        if paragraph:
            lines.append(f"definition:paragraph({lua_quote(paragraph)})")
        else:
            result.todos.append(
                f"{source.location}: help topic {topic_id} paragraph #{index} needs translation review"
            )
    return finish_catalog(
        source,
        result,
        "help topic",
        topic_id,
        lines,
        {"type", "order", "name", "messages"},
        todo_count,
    )


def collect_snippet_category(
    source: SourceObject,
    result: MigrationResult,
    categories: dict[str, dict[str, Any]],
) -> None:
    value = source.value
    category_id = value.get("category")
    raw_entries = value.get("text")
    if not isinstance(category_id, str) or not category_id or raw_entries is None:
        result.partial.append(f"{source.location}: snippet category <invalid>")
        result.todos.append(
            f"{source.location}: snippet category needs a stable category and text"
        )
        return
    entries = raw_entries if isinstance(raw_entries, list) else [raw_entries]
    category = categories.setdefault(
        category_id, {"entries": [], "replace": False}
    )
    override = value.get("override", False)
    if not isinstance(override, bool):
        result.partial.append(f"{source.location}: snippet category {category_id}")
        result.todos.append(
            f"{source.location}: snippet category {category_id} override needs review"
        )
        override = False
    if override:
        replaces_external_category = not bool(category["entries"])
        category["entries"] = []
        category["replace"] = replaces_external_category

    todo_count = len(result.todos)
    valid_count = 0
    for index, raw in enumerate(entries):
        if isinstance(raw, str):
            if raw:
                category["entries"].append(("text", raw, 1, None, None, None))
                valid_count += 1
            else:
                result.todos.append(
                    f"{source.location}: snippet category {category_id} entry #{index} is empty"
                )
            continue
        if not isinstance(raw, dict):
            result.todos.append(
                f"{source.location}: snippet category {category_id} entry #{index} needs review"
            )
            continue
        text = display_text(raw.get("text"))
        snippet_id = raw.get("id")
        name = display_text(raw.get("name")) if "name" in raw else ""
        weight = raw.get("weight", 1)
        if (
            not text or
            not isinstance(weight, int) or
            isinstance(weight, bool) or
            weight <= 0 or
            (snippet_id is not None and not safe_platform_id(snippet_id))
        ):
            result.todos.append(
                f"{source.location}: snippet category {category_id} entry #{index} needs text, id, or weight review"
            )
            continue
        handler_id = None
        if "effect_on_examine" in raw:
            if safe_platform_id(snippet_id):
                handler_id = f"TODO_{snippet_id}_examine"
                result.todos.append(
                    f"{source.location}: snippet {snippet_id} effect_on_examine must be rewritten as named Lua handler {handler_id}"
                )
            else:
                result.todos.append(
                    f"{source.location}: anonymous snippet examine effect cannot be preserved and needs a named id"
                )
        unresolved = unresolved_fields(
            raw, {"id", "text", "name", "weight", "effect_on_examine"}
        )
        if unresolved:
            result.todos.append(
                f"{source.location}: snippet entry unresolved fields: " +
                ", ".join(unresolved)
            )
        kind = "entry" if isinstance(snippet_id, str) else "text"
        category["entries"].append(
            (kind, text, weight, snippet_id, name, handler_id)
        )
        valid_count += 1

    unresolved = unresolved_fields(value, {"type", "category", "text", "override"})
    if unresolved:
        result.todos.append(
            f"{source.location}: snippet category {category_id} unresolved fields: " +
            ", ".join(unresolved)
        )
    target = result.converted if valid_count == len(entries) and len(result.todos) == todo_count else result.partial
    target.append(f"{source.location}: snippet category {category_id}")


def render_collected_snippet_category(
    category_id: str, category: dict[str, Any]
) -> str | None:
    entries = category["entries"]
    if not entries:
        return None
    lines = [
        "local definition = content.SnippetCategory {",
        f"    id = {lua_quote(category_id)},",
        "}",
    ]
    for kind, text, weight, snippet_id, name, handler_id in entries:
        if kind == "text":
            lines.append(
                f"definition:text({lua_quote(text)}, {weight})"
            )
            continue
        lines.extend((
            "definition:entry {",
            f"    id = {lua_quote(snippet_id)},",
            f"    text = {lua_quote(text)},",
            f"    weight = {weight},",
        ))
        if name:
            lines.append(f"    name = {lua_quote(name)},")
        if handler_id:
            lines.append(f"    on_examine = {lua_quote(handler_id)},")
        lines.append("}")
    operation = "replace" if category["replace"] else "add"
    lines.extend((f"content.{operation}(definition)", ""))
    return "\n".join(lines)


def render_playlists(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    playlists = value.get("playlists")
    if not isinstance(playlists, list):
        result.partial.append(f"{source.location}: playlist collection")
        result.todos.append(
            f"{source.location}: playlist collection needs a playlists array"
        )
        return None
    todo_count = len(result.todos)
    chunks: list[str] = []
    for index, raw in enumerate(playlists):
        if not isinstance(raw, dict) or not safe_platform_id(raw.get("id")):
            result.todos.append(
                f"{source.location}: playlist #{index} needs a stable id"
            )
            continue
        playlist_id = raw["id"]
        shuffle = raw.get("shuffle", False)
        files = raw.get("files")
        if not isinstance(shuffle, bool) or not isinstance(files, list) or not files:
            result.todos.append(
                f"{source.location}: playlist {playlist_id} shuffle or tracks need review"
            )
            continue
        lines = [
            "local definition = content.Playlist {",
            f"    id = {lua_quote(playlist_id)},",
            f"    shuffle = {'true' if shuffle else 'false'},",
            "}",
        ]
        valid = True
        for track_index, track in enumerate(files):
            if (
                not isinstance(track, dict) or
                not isinstance(track.get("file"), str) or
                not track["file"] or
                not isinstance(track.get("volume"), int) or
                isinstance(track.get("volume"), bool) or
                not 0 <= track["volume"] <= 128
            ):
                result.todos.append(
                    f"{source.location}: playlist {playlist_id} track #{track_index} needs review"
                )
                valid = False
                continue
            lines.append(
                f"definition:track({lua_quote(track['file'])}, {track['volume']})"
            )
        unresolved = unresolved_fields(raw, {"id", "shuffle", "files"})
        if unresolved:
            result.todos.append(
                f"{source.location}: playlist {playlist_id} unresolved fields: " +
                ", ".join(unresolved)
            )
            valid = False
        if valid:
            lines.extend((content_submit_expression(), ""))
            chunks.append("\n".join(lines))
    unresolved = unresolved_fields(value, {"type", "playlists"})
    if unresolved:
        result.todos.append(
            f"{source.location}: playlist collection unresolved fields: " +
            ", ".join(unresolved)
        )
    target = result.converted if chunks and len(result.todos) == todo_count else result.partial
    target.append(f"{source.location}: playlist collection")
    return "\n".join(chunks) if chunks else None


def render_nested_recipe_category(
    source: SourceObject, result: MigrationResult
) -> str | None:
    value = source.value
    category_id = value.get("id")
    name = display_text(value.get("name"))
    category = value.get("category")
    subcategory = value.get("subcategory")
    members = value.get("nested_category_data")
    if not safe_platform_id(category_id):
        result.partial.append(f"{source.location}: nested recipe category <invalid id>")
        result.todos.append(
            f"{source.location}: nested recipe category needs a stable id"
        )
        return None
    if (
        not name or
        not safe_platform_id(category) or
        not safe_platform_id(subcategory) or
        not isinstance(members, list) or
        not members or
        not all(safe_platform_id(member) for member in members)
    ):
        result.partial.append(
            f"{source.location}: nested recipe category {category_id}"
        )
        result.todos.append(
            f"{source.location}: nested recipe category {category_id} presentation or members need review"
        )
        return None
    todo_count = len(result.todos)
    activity_levels = {
        "SLEEP_EXERCISE": 0.85,
        "NO_EXERCISE": 1.0,
        "LIGHT_EXERCISE": 2.0,
        "MODERATE_EXERCISE": 4.0,
        "BRISK_EXERCISE": 6.0,
        "ACTIVE_EXERCISE": 8.0,
        "EXTRA_EXERCISE": 10.0,
    }
    activity = value.get("activity_level", "NO_EXERCISE")
    if isinstance(activity, str):
        activity = activity_levels.get(activity)
    if (
        not isinstance(activity, (int, float)) or
        isinstance(activity, bool) or
        not math.isfinite(activity) or
        activity <= 0
    ):
        result.todos.append(
            f"{source.location}: nested recipe category {category_id} activity level needs review"
        )
        activity = 1.0
    lines = [
        "local definition = content.NestedRecipeCategory {",
        f"    id = {lua_quote(category_id)},",
        f"    name = {lua_quote(name)},",
        f"    description = {lua_quote(display_text(value.get('description')))},",
        f"    category = {lua_quote(category)},",
        f"    subcategory = {lua_quote(subcategory)},",
        f"    activity_level = {lua_number(activity)},",
        "}",
    ]
    lines.extend(
        f"definition:recipe({lua_quote(member)})" for member in members
    )
    return finish_catalog(
        source,
        result,
        "nested recipe category",
        category_id,
        lines,
        {
            "type", "id", "name", "description", "category", "subcategory",
            "activity_level", "nested_category_data",
        },
        todo_count,
    )


def render_overlay_order(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    todo_count = len(result.todos)
    lines = ["local definition = content.OverlayOrder()"]
    raw_entries = value.get("overlay_ordering")
    if not isinstance(raw_entries, list):
        result.partial.append(f"{source.location}: overlay order global")
        result.todos.append(
            f"{source.location}: overlay order needs an overlay_ordering list"
        )
        return None

    converted_ids: set[str] = set()
    for index, entry in enumerate(raw_entries):
        if not isinstance(entry, dict):
            result.todos.append(
                f"{source.location}: overlay order entry #{index} needs review"
            )
            continue
        order = entry.get("order")
        raw_ids = entry.get("id")
        ids = [raw_ids] if isinstance(raw_ids, str) else raw_ids
        if (
            not isinstance(order, int) or
            isinstance(order, bool) or
            not NATIVE_INT_MIN <= order <= NATIVE_INT_MAX or
            not isinstance(ids, list) or
            not ids or
            not all(safe_platform_id(item) for item in ids) or
            set(entry) - {"id", "order"}
        ):
            result.todos.append(
                f"{source.location}: overlay order entry #{index} needs review"
            )
            continue
        for mutation_id in ids:
            if mutation_id in converted_ids:
                result.todos.append(
                    f"{source.location}: overlay order mutation {mutation_id} is duplicated"
                )
                continue
            converted_ids.add(mutation_id)
            lines.append(
                f"definition:mutation({lua_quote(mutation_id)}, {order})"
            )

    if not converted_ids:
        result.partial.append(f"{source.location}: overlay order global")
        result.todos.append(
            f"{source.location}: overlay order has no safely convertible mutations"
        )
        return None
    return finish_catalog(
        source,
        result,
        "overlay order",
        "global",
        lines,
        {"type", "overlay_ordering"},
        todo_count,
    )


def render_zone_type(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    zone_id = value.get("id")
    name = display_text(value.get("name"))
    display_field = value.get("display_field")
    if not safe_platform_id(zone_id):
        result.partial.append(f"{source.location}: zone type <invalid id>")
        result.todos.append(f"{source.location}: zone type needs a stable native id")
        return None
    if not name or not safe_platform_id(display_field):
        result.partial.append(f"{source.location}: zone type {zone_id}")
        result.todos.append(
            f"{source.location}: zone type {zone_id} presentation needs review"
        )
        return None
    todo_count = len(result.todos)
    lines = [
        "local definition = content.ZoneType {",
        f"    id = {lua_quote(zone_id)},",
        f"    name = {lua_quote(name)},",
        f"    description = {lua_quote(display_text(value.get('description')))},",
        f"    display_field = {lua_quote(display_field)},",
    ]
    for field_name in ("can_be_personal", "hidden"):
        raw = value.get(field_name, False)
        if isinstance(raw, bool):
            lines.append(f"    {field_name} = {'true' if raw else 'false'},")
        else:
            result.todos.append(
                f"{source.location}: zone type {zone_id} {field_name} needs review"
            )
    lines.append("}")
    return finish_catalog(
        source,
        result,
        "zone type",
        zone_id,
        lines,
        {
            "type", "id", "name", "description", "display_field",
            "can_be_personal", "hidden",
        },
        todo_count,
    )


def render_attack_vector(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    vector_id = value.get("id")
    if not safe_platform_id(vector_id):
        result.partial.append(f"{source.location}: attack vector <invalid id>")
        result.todos.append(f"{source.location}: attack vector needs a stable native id")
        return None
    todo_count = len(result.todos)

    def boolean_option(name: str, default: bool) -> bool:
        raw = value.get(name, default)
        if isinstance(raw, bool):
            return raw
        result.todos.append(
            f"{source.location}: attack vector {vector_id} {name} needs review"
        )
        return default

    def bounded_integer(name: str, default: int, minimum: int, maximum: int) -> int:
        raw = value.get(name, default)
        if (
            isinstance(raw, int) and
            not isinstance(raw, bool) and
            minimum <= raw <= maximum
        ):
            return raw
        result.todos.append(
            f"{source.location}: attack vector {vector_id} {name} needs review"
        )
        return default

    weapon = boolean_option("weapon", False)
    strict_limbs = boolean_option("strict_limb_definition", False)
    armor_bonus = boolean_option("armor_bonus", True)
    encumbrance_limit = bounded_integer("encumbrance_limit", 100, 0, NATIVE_INT_MAX)
    health_limit = bounded_integer("bp_hp_limit", 10, 0, 100)
    lines = [
        "local definition = content.AttackVector {",
        f"    id = {lua_quote(vector_id)},",
        f"    weapon = {'true' if weapon else 'false'},",
        f"    strict_limbs = {'true' if strict_limbs else 'false'},",
        f"    armor_bonus = {'true' if armor_bonus else 'false'},",
        f"    encumbrance_limit = {encumbrance_limit},",
        f"    health_percent_limit = {health_limit},",
        "}",
    ]

    def render_id_list(field: str, method: str) -> None:
        raw = value.get(field, [])
        if not isinstance(raw, list) or any(
            not isinstance(entry, str) or not entry for entry in raw
        ):
            result.todos.append(
                f"{source.location}: attack vector {vector_id} {field} needs review"
            )
            return
        for entry in raw:
            lines.append(f"definition:{method}({lua_quote(entry)})")

    render_id_list("limbs", "limb")
    render_id_list("contact_area", "contact")
    render_id_list("required_limb_flags", "requires_flag")
    render_id_list("forbidden_limb_flags", "forbids_flag")

    limb_requirements = value.get("limb_req", [])
    if not isinstance(limb_requirements, list):
        result.todos.append(
            f"{source.location}: attack vector {vector_id} limb requirements need review"
        )
    else:
        for requirement in limb_requirements:
            valid = (
                isinstance(requirement, list) and
                len(requirement) == 2 and
                isinstance(requirement[0], str) and
                requirement[0] and
                isinstance(requirement[1], int) and
                not isinstance(requirement[1], bool) and
                0 < requirement[1] <= NATIVE_INT_MAX
            )
            if not valid:
                result.todos.append(
                    f"{source.location}: attack vector {vector_id} limb requirement needs review"
                )
                continue
            lines.append(
                "definition:requires_limb("
                f"{lua_quote(requirement[0])}, {requirement[1]})"
            )
    return finish_catalog(
        source,
        result,
        "attack vector",
        vector_id,
        lines,
        {
            "type",
            "id",
            "weapon",
            "limbs",
            "strict_limb_definition",
            "contact_area",
            "limb_req",
            "armor_bonus",
            "encumbrance_limit",
            "bp_hp_limit",
            "required_limb_flags",
            "forbidden_limb_flags",
        },
        todo_count,
    )


def render_magic_type(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    magic_id = value.get("id")
    if not safe_platform_id(magic_id):
        result.partial.append(f"{source.location}: magic type <invalid id>")
        result.todos.append(f"{source.location}: magic type needs a stable native id")
        return None
    todo_count = len(result.todos)

    energy = "none"
    vitamin: str | None = None
    color = "cyan"
    raw_energy = value.get("energy_source", "NONE")
    if isinstance(raw_energy, str):
        candidate = raw_energy.lower()
        if candidate in {"hp", "mana", "stamina", "bionic", "vitamin", "none"}:
            energy = candidate
        else:
            result.todos.append(
                f"{source.location}: magic type {magic_id} energy source needs review"
            )
    elif isinstance(raw_energy, dict):
        candidate = raw_energy.get("type")
        if isinstance(candidate, str) and candidate.lower() in {
            "hp", "mana", "stamina", "bionic", "vitamin", "none"
        }:
            energy = candidate.lower()
        else:
            result.todos.append(
                f"{source.location}: magic type {magic_id} energy source needs review"
            )
        raw_vitamin = raw_energy.get("vitamin")
        if isinstance(raw_vitamin, str) and raw_vitamin:
            vitamin = raw_vitamin
        elif energy == "vitamin":
            result.todos.append(
                f"{source.location}: magic type {magic_id} vitamin energy needs review"
            )
        raw_color = raw_energy.get("color", "cyan")
        if isinstance(raw_color, str) and raw_color:
            color = raw_color
        else:
            result.todos.append(
                f"{source.location}: magic type {magic_id} energy color needs review"
            )
    else:
        result.todos.append(
            f"{source.location}: magic type {magic_id} energy source needs review"
        )

    def nonnegative_number(name: str, default: float) -> float:
        raw = value.get(name, default)
        if (
            isinstance(raw, (int, float)) and
            not isinstance(raw, bool) and
            math.isfinite(raw) and
            raw >= 0
        ):
            return float(raw)
        result.todos.append(
            f"{source.location}: magic type {magic_id} {name} needs review"
        )
        return default

    failure_cost = nonnegative_number("failure_cost_percent", 0.0)
    failure_experience = nonnegative_number("failure_exp_percent", 0.2)
    lines = [
        "local definition = content.MagicType {",
        f"    id = {lua_quote(magic_id)},",
        f"    energy = {lua_quote(energy)},",
        f"    energy_color = {lua_quote(color)},",
        f"    failure_cost_fraction = {lua_number(failure_cost)},",
        f"    failure_experience_fraction = {lua_number(failure_experience)},",
    ]
    if vitamin:
        lines.append(f"    vitamin = {lua_quote(vitamin)},")
    raw_message = value.get("cannot_cast_message")
    if isinstance(raw_message, str):
        lines.append(f"    cannot_cast_message = {lua_quote(raw_message)},")
    elif raw_message is not None:
        result.todos.append(
            f"{source.location}: magic type {magic_id} casting message needs review"
        )
    raw_maximum = value.get("max_book_level")
    if raw_maximum is not None:
        if (
            isinstance(raw_maximum, int) and
            not isinstance(raw_maximum, bool) and
            0 <= raw_maximum <= NATIVE_INT_MAX
        ):
            lines.append(f"    max_book_level = {raw_maximum},")
        else:
            result.todos.append(
                f"{source.location}: magic type {magic_id} max book level needs review"
            )
    lines.append("}")

    raw_flags = value.get("cannot_cast_flags", [])
    if isinstance(raw_flags, str):
        raw_flags = [raw_flags]
    if isinstance(raw_flags, list) and all(
        isinstance(flag, str) and flag for flag in raw_flags
    ):
        for flag in raw_flags:
            lines.append(f"definition:cannot_cast_when({lua_quote(flag)})")
    else:
        result.todos.append(
            f"{source.location}: magic type {magic_id} casting restrictions need review"
        )

    formula_migrations = {
        "get_level_formula_id": "the first definition:progression handler",
        "exp_for_level_formula_id": "the second definition:progression handler",
        "casting_xp_formula_id": "definition:casting_experience handler",
        "failure_chance_formula_id": "definition:failure_chance handler",
    }
    for field_name, replacement in formula_migrations.items():
        if field_name in value:
            result.todos.append(
                f"{source.location}: magic type {magic_id} {field_name} must be rewritten as {replacement}"
            )
            lines.append(f"-- TODO: rewrite {field_name} as {replacement}.")
    if "failure_eocs" in value:
        result.todos.append(
            f"{source.location}: magic type {magic_id} failure_eocs must be rewritten as a named Lua on_failure handler"
        )
        lines.append("-- TODO: rewrite failure_eocs as definition:on_failure(handler_id).")

    return finish_catalog(
        source,
        result,
        "magic type",
        magic_id,
        lines,
        {
            "type",
            "id",
            "src_mod",
            "energy_source",
            "cannot_cast_flags",
            "cannot_cast_message",
            "max_book_level",
            "failure_cost_percent",
            "failure_exp_percent",
            "get_level_formula_id",
            "exp_for_level_formula_id",
            "casting_xp_formula_id",
            "failure_chance_formula_id",
            "failure_eocs",
        },
        todo_count,
    )


def render_movement_mode(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    mode_id = value.get("id")
    if not safe_platform_id(mode_id):
        result.partial.append(f"{source.location}: movement mode <invalid id>")
        result.todos.append(f"{source.location}: movement mode needs a stable native id")
        return None
    todo_count = len(result.todos)
    activity_levels = {
        "SLEEP_EXERCISE": 0.85,
        "NO_EXERCISE": 1.0,
        "LIGHT_EXERCISE": 2.0,
        "MODERATE_EXERCISE": 4.0,
        "BRISK_EXERCISE": 6.0,
        "ACTIVE_EXERCISE": 8.0,
        "EXTRA_EXERCISE": 10.0,
    }

    def finite_number(name: str, default: float, *, positive: bool = False) -> float:
        raw = value.get(name, default)
        if isinstance(raw, str) and raw in activity_levels:
            raw = activity_levels[raw]
        if (
            isinstance(raw, (int, float)) and
            not isinstance(raw, bool) and
            math.isfinite(raw) and
            (raw > 0 if positive else raw >= 0)
        ):
            return float(raw)
        result.todos.append(
            f"{source.location}: movement mode {mode_id} {name} needs review"
        )
        return default

    def native_integer(name: str, default: int, minimum: int) -> int:
        raw = value.get(name, default)
        if (
            isinstance(raw, int) and
            not isinstance(raw, bool) and
            minimum <= raw <= NATIVE_INT_MAX
        ):
            return raw
        result.todos.append(
            f"{source.location}: movement mode {mode_id} {name} needs review"
        )
        return default

    name = value.get("name", mode_id)
    kind = value.get("move_type", "walking")
    character = value.get("character")
    panel_symbol = value.get("panel_char")
    panel_color = value.get("panel_color", "white")
    symbol_color = value.get("symbol_color", "white")
    if (
        not isinstance(name, str) or
        not name or
        kind not in {"prone", "crouching", "walking", "running"} or
        not isinstance(character, str) or
        len(character) != 1 or
        not isinstance(panel_symbol, str) or
        len(panel_symbol) != 1 or
        not isinstance(panel_color, str) or
        not panel_color or
        not isinstance(symbol_color, str) or
        not symbol_color
    ):
        result.partial.append(f"{source.location}: movement mode {mode_id}")
        result.todos.append(
            f"{source.location}: movement mode {mode_id} identity, symbols, or colors need review"
        )
        return None

    exertion = finite_number("exertion_level", 1.0)
    riding_exertion = finite_number("exertion_level_animal_riding", 0.0)
    stamina = finite_number("stamina_multiplier", 1.0)
    sound = finite_number("sound_multiplier", 1.0)
    speed = finite_number("move_speed_multiplier", 1.0, positive=True)
    mech_power = native_integer("mech_power_use", 2, 0)
    swim_speed = native_integer("swim_speed_mod", 0, -NATIVE_INT_MAX - 1)
    stop_hauling = value.get("stop_hauling", False)
    if not isinstance(stop_hauling, bool):
        result.todos.append(
            f"{source.location}: movement mode {mode_id} stop_hauling needs review"
        )
        stop_hauling = False

    lines = [
        "local definition = content.MovementMode {",
        f"    id = {lua_quote(mode_id)},",
        f"    name = {lua_quote(name)},",
        f"    kind = {lua_quote(kind)},",
        f"    character_symbol = {lua_quote(character)},",
        f"    panel_symbol = {lua_quote(panel_symbol)},",
        f"    panel_color = {lua_quote(panel_color)},",
        f"    symbol_color = {lua_quote(symbol_color)},",
        f"    exertion = {lua_number(exertion)},",
        f"    riding_exertion = {lua_number(riding_exertion)},",
        f"    stamina_multiplier = {lua_number(stamina)},",
        f"    sound_multiplier = {lua_number(sound)},",
        f"    speed_multiplier = {lua_number(speed)},",
        f"    mech_power_kilojoules = {mech_power},",
        f"    swim_speed_modifier = {swim_speed},",
        f"    stop_hauling = {'true' if stop_hauling else 'false'},",
        "}",
    ]
    legacy_default_failure = "You feel bugs crawl over your skin."
    for steed in ("none", "animal", "mech"):
        prepare = value.get(f"prepare_{steed}")
        success = value.get(f"change_good_{steed}")
        failure = value.get(f"change_bad_{steed}", legacy_default_failure)
        if not all(isinstance(text, str) and text for text in (prepare, success, failure)):
            result.todos.append(
                f"{source.location}: movement mode {mode_id} {steed} messages need review"
            )
            continue
        lines.extend([
            f"definition:messages({lua_quote(steed)}, {{",
            f"    prepare = {lua_quote(prepare)},",
            f"    success = {lua_quote(success)},",
            f"    failure = {lua_quote(failure)},",
            "})",
        ])
    return finish_catalog(
        source,
        result,
        "movement mode",
        mode_id,
        lines,
        {
            "type", "id", "character", "panel_char", "name", "panel_color",
            "symbol_color", "exertion_level", "exertion_level_animal_riding",
            "prepare_none", "prepare_animal", "prepare_mech",
            "change_good_none", "change_good_animal", "change_good_mech",
            "change_bad_none", "change_bad_animal", "change_bad_mech",
            "move_type", "stamina_multiplier", "sound_multiplier",
            "move_speed_multiplier", "mech_power_use", "swim_speed_mod",
            "stop_hauling",
        },
        todo_count,
    )


def render_region_settings_ravine(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    ravine_id = value.get("id")
    if not safe_platform_id(ravine_id):
        result.partial.append(f"{source.location}: region settings ravine <invalid id>")
        result.todos.append(f"{source.location}: region settings ravine needs a stable native id")
        return None
    todo_count = len(result.todos)

    def integer_field(name: str, default: int) -> int:
        parsed = native_integer(value.get(name, default))
        if parsed is not None:
            return parsed
        result.todos.append(
            f"{source.location}: region settings ravine {ravine_id} {name} needs review"
        )
        return default

    num_ravines = integer_field("num_ravines", 0)
    ravine_range = integer_field("ravine_range", 45)
    ravine_width = integer_field("ravine_width", 1)
    ravine_depth = integer_field("ravine_depth", -3)

    lines = [
        "local definition = content.RegionSettingsRavine {",
        f"    id = {lua_quote(ravine_id)},",
        f"    num_ravines = {num_ravines},",
        f"    ravine_range = {ravine_range},",
        f"    ravine_width = {ravine_width},",
        f"    ravine_depth = {ravine_depth},",
        "}",
    ]
    return finish_catalog(
        source,
        result,
        "region settings ravine",
        ravine_id,
        lines,
        {"type", "id", "num_ravines", "ravine_range", "ravine_width", "ravine_depth"},
        todo_count,
    )


def render_region_settings_lake(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    lake_id = value.get("id")
    if not safe_platform_id(lake_id):
        result.partial.append(f"{source.location}: region settings lake <invalid id>")
        result.todos.append(f"{source.location}: region settings lake needs a stable native id")
        return None
    todo_count = len(result.todos)

    noise_threshold = value.get("noise_threshold_lake", 0.25)
    if not (isinstance(noise_threshold, (int, float)) and not isinstance(noise_threshold, bool) and math.isfinite(noise_threshold)):
        result.todos.append(f"{source.location}: region settings lake {lake_id} noise_threshold_lake needs review")
        noise_threshold = 0.25

    lake_size_min = native_integer(value.get("lake_size_min", 20))
    if lake_size_min is None:
        result.todos.append(f"{source.location}: region settings lake {lake_id} lake_size_min needs review")
        lake_size_min = 20

    lake_depth = native_integer(value.get("lake_depth", -5))
    if lake_depth is None:
        result.todos.append(f"{source.location}: region settings lake {lake_id} lake_depth needs review")
        lake_depth = -5

    invert_lakes = value.get("invert_lakes", False)
    if not isinstance(invert_lakes, bool):
        result.todos.append(f"{source.location}: region settings lake {lake_id} invert_lakes needs review")
        invert_lakes = False

    def terrain_field(name: str, alias: str, default: str) -> str:
        raw = value.get(name, value.get(alias, default))
        if safe_platform_id(raw):
            return raw
        result.todos.append(
            f"{source.location}: region settings lake {lake_id} {name} needs review"
        )
        return default

    surface_ter = terrain_field("surface_ter", "surface", "lake_surface")
    shore_ter = terrain_field("shore_ter", "shore", "lake_shore")
    interior_ter = terrain_field("interior_ter", "interior", "lake_water_cube")
    bed_ter = terrain_field("bed_ter", "bed", "lake_bed")

    lines = [
        "local definition = content.RegionSettingsLake {",
        f"    id = {lua_quote(lake_id)},",
        f"    noise_threshold_lake = {lua_number(float(noise_threshold))},",
        f"    lake_size_min = {lake_size_min},",
        f"    lake_depth = {lake_depth},",
        f"    invert_lakes = {'true' if invert_lakes else 'false'},",
        f"    surface_ter = {lua_quote(str(surface_ter))},",
        f"    shore_ter = {lua_quote(str(shore_ter))},",
        f"    interior_ter = {lua_quote(str(interior_ter))},",
        f"    bed_ter = {lua_quote(str(bed_ter))},",
    ]

    shore_terrains = value.get("shore_extendable_overmap_terrain")
    if isinstance(shore_terrains, list):
        lines.append("    shore_extendable_overmap_terrain = {")
        for elem in shore_terrains:
            if safe_platform_id(elem):
                lines.append(f"        {lua_quote(elem)},")
            else:
                result.todos.append(f"{source.location}: region settings lake {lake_id} shore_extendable_overmap_terrain element needs review")
        lines.append("    },")
    elif shore_terrains is not None:
        result.todos.append(f"{source.location}: region settings lake {lake_id} shore_extendable_overmap_terrain needs review")

    aliases = value.get("shore_extendable_overmap_terrain_aliases")
    if isinstance(aliases, list):
        lines.append("    shore_extendable_overmap_terrain_aliases = {")
        for alias_obj in aliases:
            if isinstance(alias_obj, dict):
                om_terrain = alias_obj.get("om_terrain", "")
                alias_str = alias_obj.get("alias", "")
                match_type = alias_obj.get("om_terrain_match_type", "exact")
                if (
                    not safe_platform_id(om_terrain) or
                    not safe_platform_id(alias_str) or
                    not isinstance(match_type, str) or
                    match_type.lower() not in {
                        "exact", "type", "subtype", "prefix", "contains"
                    }
                ):
                    result.todos.append(
                        f"{source.location}: region settings lake {lake_id} "
                        "shore_extendable_overmap_terrain_aliases element needs review"
                    )
                    continue
                lines.append("        {")
                lines.append(f"            om_terrain = {lua_quote(om_terrain)},")
                lines.append(f"            alias = {lua_quote(alias_str)},")
                lines.append(f"            om_terrain_match_type = {lua_quote(match_type)},")
                lines.append("        },")
            else:
                result.todos.append(f"{source.location}: region settings lake {lake_id} shore_extendable_overmap_terrain_aliases element needs review")
        lines.append("    },")
    elif aliases is not None:
        result.todos.append(f"{source.location}: region settings lake {lake_id} shore_extendable_overmap_terrain_aliases needs review")

    lines.append("}")

    return finish_catalog(
        source,
        result,
        "region settings lake",
        lake_id,
        lines,
        {
            "type", "id", "noise_threshold_lake", "lake_size_min", "lake_depth",
            "invert_lakes", "surface_ter", "surface", "shore_ter", "shore",
            "interior_ter", "interior", "bed_ter", "bed",
            "shore_extendable_overmap_terrain", "shore_extendable_overmap_terrain_aliases",
        },
        todo_count,
    )


def render_region_settings_ocean(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    ocean_id = value.get("id")
    if not safe_platform_id(ocean_id):
        result.partial.append(f"{source.location}: region settings ocean <invalid id>")
        result.todos.append(f"{source.location}: region settings ocean needs a stable native id")
        return None
    todo_count = len(result.todos)

    noise_threshold = value.get("noise_threshold_ocean", 0.25)
    if not (isinstance(noise_threshold, (int, float)) and not isinstance(noise_threshold, bool) and math.isfinite(noise_threshold)):
        result.todos.append(f"{source.location}: region settings ocean {ocean_id} noise_threshold_ocean needs review")
        noise_threshold = 0.25

    ocean_size_min = native_integer(value.get("ocean_size_min", 100))
    if ocean_size_min is None:
        result.todos.append(f"{source.location}: region settings ocean {ocean_id} ocean_size_min needs review")
        ocean_size_min = 100

    ocean_depth = native_integer(value.get("ocean_depth", -9))
    if ocean_depth is None:
        result.todos.append(f"{source.location}: region settings ocean {ocean_id} ocean_depth needs review")
        ocean_depth = -9

    sandy_beach_width = native_integer(value.get("sandy_beach_width", 2))
    if sandy_beach_width is None:
        result.todos.append(f"{source.location}: region settings ocean {ocean_id} sandy_beach_width needs review")
        sandy_beach_width = 2

    lines = [
        "local definition = content.RegionSettingsOcean {",
        f"    id = {lua_quote(ocean_id)},",
        f"    noise_threshold_ocean = {lua_number(float(noise_threshold))},",
        f"    ocean_size_min = {ocean_size_min},",
        f"    ocean_depth = {ocean_depth},",
        f"    sandy_beach_width = {sandy_beach_width},",
    ]

    for dir_key in ("ocean_start_north", "ocean_start_east", "ocean_start_west", "ocean_start_south"):
        dir_val = value.get(dir_key)
        parsed = native_integer(dir_val)
        if parsed is not None:
            lines.append(f"    {dir_key} = {parsed},")
        elif dir_val is not None:
            result.todos.append(f"{source.location}: region settings ocean {ocean_id} {dir_key} needs review")

    lines.append("}")

    return finish_catalog(
        source,
        result,
        "region settings ocean",
        ocean_id,
        lines,
        {
            "type", "id", "noise_threshold_ocean", "ocean_size_min", "ocean_depth",
            "ocean_start_north", "ocean_start_east", "ocean_start_west", "ocean_start_south",
            "sandy_beach_width",
        },
        todo_count,
    )


def render_region_settings_forest(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    forest_id = value.get("id")
    if not safe_platform_id(forest_id):
        result.partial.append(f"{source.location}: region settings forest <invalid id>")
        result.todos.append(f"{source.location}: region settings forest needs a stable native id")
        return None
    todo_count = len(result.todos)

    def forest_finite_number(name: str, default: float) -> float:
        raw = value.get(name, default)
        if isinstance(raw, (int, float)) and not isinstance(raw, bool) and math.isfinite(raw):
            return float(raw)
        result.todos.append(f"{source.location}: region settings forest {forest_id} {name} needs review")
        return default

    noise_threshold_forest = forest_finite_number("noise_threshold_forest", 0.25)
    noise_threshold_forest_thick = forest_finite_number("noise_threshold_forest_thick", 0.3)
    noise_threshold_swamp_adjacent_water = forest_finite_number(
        "noise_threshold_swamp_adjacent_water", 0.3
    )
    noise_threshold_swamp_isolated = forest_finite_number(
        "noise_threshold_swamp_isolated", 0.6
    )
    forest_threshold_limit = finite_number(
        value.get("forest_threshold_limit", value.get("max_forest", 0.395)),
        -NATIVE_FLOAT_MAX,
        NATIVE_FLOAT_MAX,
    )
    if forest_threshold_limit is None:
        result.todos.append(f"{source.location}: region settings forest {forest_id} forest_threshold_limit needs review")
        forest_threshold_limit = 0.395
    else:
        forest_threshold_limit = float(forest_threshold_limit)

    dist_min = native_integer(value.get("river_floodplain_buffer_distance_min", 3))
    if dist_min is None:
        result.todos.append(f"{source.location}: region settings forest {forest_id} river_floodplain_buffer_distance_min needs review")
        dist_min = 3

    dist_max = native_integer(value.get("river_floodplain_buffer_distance_max", 15))
    if dist_max is None:
        result.todos.append(f"{source.location}: region settings forest {forest_id} river_floodplain_buffer_distance_max needs review")
        dist_max = 15

    lines = [
        "local definition = content.RegionSettingsForest {",
        f"    id = {lua_quote(forest_id)},",
        f"    noise_threshold_forest = {lua_number(noise_threshold_forest)},",
        f"    noise_threshold_forest_thick = {lua_number(noise_threshold_forest_thick)},",
        f"    noise_threshold_swamp_adjacent_water = {lua_number(noise_threshold_swamp_adjacent_water)},",
        f"    noise_threshold_swamp_isolated = {lua_number(noise_threshold_swamp_isolated)},",
        f"    river_floodplain_buffer_distance_min = {dist_min},",
        f"    river_floodplain_buffer_distance_max = {dist_max},",
        f"    forest_threshold_limit = {lua_number(forest_threshold_limit)},",
    ]

    forest_increase = value.get("forest_threshold_increase")
    if isinstance(forest_increase, list) and len(forest_increase) == 4:
        inc_vals = []
        for elem in forest_increase:
            parsed = finite_number(elem, -NATIVE_FLOAT_MAX, NATIVE_FLOAT_MAX)
            if parsed is None:
                inc_vals.append("0.0")
                result.todos.append(f"{source.location}: region settings forest {forest_id} forest_threshold_increase element needs review")
            else:
                inc_vals.append(lua_number(float(parsed)))
        lines.append(f"    forest_threshold_increase = {{{', '.join(inc_vals)}}},")
    elif forest_increase is not None:
        result.todos.append(f"{source.location}: region settings forest {forest_id} forest_threshold_increase needs review")

    lines.append("}")

    return finish_catalog(
        source,
        result,
        "region settings forest",
        forest_id,
        lines,
        {
            "type", "id", "noise_threshold_forest", "noise_threshold_forest_thick",
            "noise_threshold_swamp_adjacent_water", "noise_threshold_swamp_isolated",
            "river_floodplain_buffer_distance_min", "river_floodplain_buffer_distance_max",
            "forest_threshold_limit", "max_forest", "forest_threshold_increase",
        },
        todo_count,
    )


def render_region_settings_river(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    river_id = value.get("id")
    if not bounded_platform_id(river_id):
        result.partial.append(f"{source.location}: region settings river <invalid id>")
        result.todos.append(f"{source.location}: region settings river needs a stable native id")
        return None
    todo_count = len(result.todos)

    river_scale = native_integer(value.get("river_scale", 1))
    if river_scale is None:
        result.todos.append(f"{source.location}: region settings river {river_id} river_scale needs review")
        river_scale = 1

    def river_finite_number(name: str, default: float) -> float:
        raw = value.get(name, default)
        if isinstance(raw, (int, float)) and not isinstance(raw, bool) and math.isfinite(raw):
            return float(raw)
        result.todos.append(f"{source.location}: region settings river {river_id} {name} needs review")
        return default

    river_frequency = river_finite_number("river_frequency", 1.5)
    river_branch_chance = river_finite_number("river_branch_chance", 64.0)
    river_branch_remerge_chance = river_finite_number("river_branch_remerge_chance", 4.0)
    river_branch_scale_decrease = river_finite_number("river_branch_scale_decrease", 1.0)

    lines = [
        "local definition = content.RegionSettingsRiver {",
        f"    id = {lua_quote(river_id)},",
        f"    river_scale = {river_scale},",
        f"    river_frequency = {lua_number(river_frequency)},",
        f"    river_branch_chance = {lua_number(river_branch_chance)},",
        f"    river_branch_remerge_chance = {lua_number(river_branch_remerge_chance)},",
        f"    river_branch_scale_decrease = {lua_number(river_branch_scale_decrease)},",
        "}",
    ]

    return finish_catalog(
        source,
        result,
        "region settings river",
        river_id,
        lines,
        {
            "type", "id", "river_scale", "river_frequency", "river_branch_chance",
            "river_branch_remerge_chance", "river_branch_scale_decrease",
        },
        todo_count,
    )


def render_region_settings_forest_mapgen(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    forest_mapgen_id = value.get("id")
    if not bounded_platform_id(forest_mapgen_id):
        result.partial.append(f"{source.location}: region settings forest mapgen <invalid id>")
        result.todos.append(f"{source.location}: region settings forest mapgen needs a stable native id")
        return None
    todo_count = len(result.todos)

    biomes_raw = value.get("biomes", [])
    biomes = []
    seen_biomes: set[str] = set()
    if isinstance(biomes_raw, list):
        for entry in biomes_raw:
            if bounded_platform_id(entry) and entry not in seen_biomes:
                biomes.append(entry)
                seen_biomes.add(entry)
            else:
                result.todos.append(f"{source.location}: region settings forest mapgen {forest_mapgen_id} biomes entry needs review")
    else:
        result.todos.append(f"{source.location}: region settings forest mapgen {forest_mapgen_id} biomes must be a list")

    lines = [
        "local definition = content.RegionSettingsForestMapgen {",
        f"    id = {lua_quote(forest_mapgen_id)},",
    ]
    if biomes:
        lines.append(f"    biomes = {lua_string_table(biomes)},")
    lines.append("}")

    return finish_catalog(
        source,
        result,
        "region settings forest mapgen",
        forest_mapgen_id,
        lines,
        {"type", "id", "biomes"},
        todo_count,
    )


def render_region_settings_map_extras(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    map_extras_id = value.get("id")
    if not bounded_platform_id(map_extras_id):
        result.partial.append(f"{source.location}: region settings map extras <invalid id>")
        result.todos.append(f"{source.location}: region settings map extras needs a stable native id")
        return None
    todo_count = len(result.todos)

    extras_raw = value.get("extras", [])
    extras = []
    seen_extras: set[str] = set()
    if isinstance(extras_raw, list):
        for entry in extras_raw:
            if bounded_platform_id(entry) and entry not in seen_extras:
                extras.append(entry)
                seen_extras.add(entry)
            else:
                result.todos.append(f"{source.location}: region settings map extras {map_extras_id} extras entry needs review")
    else:
        result.todos.append(f"{source.location}: region settings map extras {map_extras_id} extras must be a list")

    lines = [
        "local definition = content.RegionSettingsMapExtras {",
        f"    id = {lua_quote(map_extras_id)},",
    ]
    if extras:
        lines.append(f"    extras = {lua_string_table(extras)},")
    lines.append("}")

    return finish_catalog(
        source,
        result,
        "region settings map extras",
        map_extras_id,
        lines,
        {"type", "id", "extras"},
        todo_count,
    )


def render_region_settings_terrain_furniture(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    tf_id = value.get("id")
    if not bounded_platform_id(tf_id):
        result.partial.append(f"{source.location}: region settings terrain furniture <invalid id>")
        result.todos.append(f"{source.location}: region settings terrain furniture needs a stable native id")
        return None
    todo_count = len(result.todos)

    tf_raw = value.get("ter_furn", [])
    ter_furn = []
    seen_ter_furn: set[str] = set()
    if isinstance(tf_raw, list):
        for entry in tf_raw:
            if bounded_platform_id(entry) and entry not in seen_ter_furn:
                ter_furn.append(entry)
                seen_ter_furn.add(entry)
            else:
                result.todos.append(f"{source.location}: region settings terrain furniture {tf_id} ter_furn entry needs review")
    else:
        result.todos.append(f"{source.location}: region settings terrain furniture {tf_id} ter_furn must be a list")

    lines = [
        "local definition = content.RegionSettingsTerrainFurniture {",
        f"    id = {lua_quote(tf_id)},",
    ]
    if ter_furn:
        lines.append(f"    ter_furn = {lua_string_table(ter_furn)},")
    lines.append("}")

    return finish_catalog(
        source,
        result,
        "region settings terrain furniture",
        tf_id,
        lines,
        {"type", "id", "ter_furn"},
        todo_count,
    )


def render_region_settings_forest_trail(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    trail_id = value.get("id")
    if not bounded_platform_id(trail_id):
        result.partial.append(f"{source.location}: region settings forest trail <invalid id>")
        result.todos.append(f"{source.location}: region settings forest trail needs a stable native id")
        return None
    todo_count = len(result.todos)

    chance = native_integer(value.get("chance", 1))
    if chance is None:
        result.todos.append(f"{source.location}: region settings forest trail {trail_id} chance needs review")
        chance = 1

    border_point_chance = native_integer(value.get("border_point_chance", 2))
    if border_point_chance is None:
        result.todos.append(f"{source.location}: region settings forest trail {trail_id} border_point_chance needs review")
        border_point_chance = 2

    minimum_forest_size = native_integer(value.get("minimum_forest_size", 50))
    if minimum_forest_size is None:
        result.todos.append(f"{source.location}: region settings forest trail {trail_id} minimum_forest_size needs review")
        minimum_forest_size = 50

    random_point_min = native_integer(value.get("random_point_min", 4))
    if random_point_min is None:
        result.todos.append(f"{source.location}: region settings forest trail {trail_id} random_point_min needs review")
        random_point_min = 4

    random_point_max = native_integer(value.get("random_point_max", 50))
    if random_point_max is None:
        result.todos.append(f"{source.location}: region settings forest trail {trail_id} random_point_max needs review")
        random_point_max = 50

    random_point_size_scalar = native_integer(value.get("random_point_size_scalar", 100))
    if random_point_size_scalar is None:
        result.todos.append(f"{source.location}: region settings forest trail {trail_id} random_point_size_scalar needs review")
        random_point_size_scalar = 100

    trailhead_chance = native_integer(value.get("trailhead_chance", 1))
    if trailhead_chance is None:
        result.todos.append(f"{source.location}: region settings forest trail {trail_id} trailhead_chance needs review")
        trailhead_chance = 1

    trailhead_road_distance = native_integer(value.get("trailhead_road_distance", 6))
    if trailhead_road_distance is None:
        result.todos.append(f"{source.location}: region settings forest trail {trail_id} trailhead_road_distance needs review")
        trailhead_road_distance = 6

    lines = [
        "local definition = content.RegionSettingsForestTrail {",
        f"    id = {lua_quote(trail_id)},",
        f"    chance = {chance},",
        f"    border_point_chance = {border_point_chance},",
        f"    minimum_forest_size = {minimum_forest_size},",
        f"    random_point_min = {random_point_min},",
        f"    random_point_max = {random_point_max},",
        f"    random_point_size_scalar = {random_point_size_scalar},",
        f"    trailhead_chance = {trailhead_chance},",
        f"    trailhead_road_distance = {trailhead_road_distance},",
        "}",
    ]

    trailheads = canonical_weighted_entries(value.get("trailheads", []))
    if trailheads is None:
        result.todos.append(f"{source.location}: region settings forest trail {trail_id} trailheads need review")
    else:
        for special_id, weight in trailheads:
            lines.append(f"definition:trailhead({lua_quote(special_id)}, {weight})")

    return finish_catalog(
        source,
        result,
        "region settings forest trail",
        trail_id,
        lines,
        {
            "type", "id", "chance", "border_point_chance", "minimum_forest_size",
            "random_point_min", "random_point_max", "random_point_size_scalar",
            "trailhead_chance", "trailhead_road_distance", "trailheads",
        },
        todo_count,
    )


def render_region_settings_highway(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    highway_id = value.get("id")
    if not bounded_platform_id(highway_id):
        result.partial.append(f"{source.location}: region settings highway <invalid id>")
        result.todos.append(f"{source.location}: region settings highway needs a stable native id")
        return None
    todo_count = len(result.todos)

    width_of_segments = native_integer(value.get("width_of_segments", 2))
    if width_of_segments is None:
        result.todos.append(f"{source.location}: region settings highway {highway_id} width_of_segments needs review")
        width_of_segments = 2

    raw_straightness = value.get("straightness_chance", 0.6)
    if isinstance(raw_straightness, (int, float)) and not isinstance(raw_straightness, bool) and math.isfinite(raw_straightness):
        straightness_chance = float(raw_straightness)
    else:
        result.todos.append(f"{source.location}: region settings highway {highway_id} straightness_chance needs review")
        straightness_chance = 0.6

    lines = [
        "local definition = content.RegionSettingsHighway {",
        f"    id = {lua_quote(highway_id)},",
        f"    width_of_segments = {width_of_segments},",
        f"    straightness_chance = {lua_number(straightness_chance)},",
    ]

    for field in [
        "reserved_terrain_id", "reserved_terrain_water_id", "segment_flat_special",
        "segment_ramp_special", "segment_road_bridge_special", "segment_bridge_special",
        "segment_bridge_supports_special", "segment_overpass_special", "clockwise_slant_special",
        "counterclockwise_slant_special", "fallback_onramp_special", "fallback_bend_special",
        "fallback_three_way_intersection_special", "fallback_four_way_intersection_special",
        "fallback_supports",
    ]:
        if field not in value:
            continue
        val = value[field]
        if bounded_platform_id(val):
            lines.append(f"    {field} = {lua_quote(val)},")
        else:
            result.todos.append(
                f"{source.location}: region settings highway {highway_id} {field} needs a bounded native id"
            )

    for required_slant in (
        "clockwise_slant_special", "counterclockwise_slant_special"
    ):
        if not bounded_platform_id(value.get(required_slant)):
            result.todos.append(
                f"{source.location}: region settings highway {highway_id} {required_slant} is required for safe finalization"
            )

    lines.append("}")

    def render_highway_bin(field_name: str, method_name: str) -> None:
        entries = canonical_weighted_entries(value.get(field_name, []))
        if entries is None:
            result.todos.append(f"{source.location}: region settings highway {highway_id} {field_name} needs review")
            return
        for special_id, weight in entries:
            lines.append(f"definition:{method_name}({lua_quote(special_id)}, {weight})")

    render_highway_bin("four_way_intersections", "four_way_intersection")
    render_highway_bin("three_way_intersections", "three_way_intersection")
    render_highway_bin("bends", "bend")
    render_highway_bin("road_connections", "road_connection")
    render_highway_bin("interchanges", "interchange")

    return finish_catalog(
        source,
        result,
        "region settings highway",
        highway_id,
        lines,
        {
            "type", "id", "width_of_segments", "straightness_chance",
            "reserved_terrain_id", "reserved_terrain_water_id", "segment_flat_special",
            "segment_ramp_special", "segment_road_bridge_special", "segment_bridge_special",
            "segment_bridge_supports_special", "segment_overpass_special", "clockwise_slant_special",
            "counterclockwise_slant_special", "fallback_onramp_special", "fallback_bend_special",
            "fallback_three_way_intersection_special", "fallback_four_way_intersection_special",
            "fallback_supports", "four_way_intersections", "three_way_intersections",
            "bends", "road_connections", "interchanges",
        },
        todo_count,
    )


def render_region_settings(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    settings_id = value.get("id")
    if not bounded_platform_id(settings_id):
        result.partial.append(f"{source.location}: region settings <invalid id>")
        result.todos.append(
            f"{source.location}: region settings needs a stable native id"
        )
        return None
    city_settings = value.get("cities")
    if not bounded_platform_id(city_settings):
        result.partial.append(f"{source.location}: region settings {settings_id}")
        result.todos.append(
            f"{source.location}: region settings {settings_id} cities needs a bounded native id"
        )
        return None
    todo_count = len(result.todos)
    lines = [
        "local definition = content.RegionSettings {",
        f"    id = {lua_quote(settings_id)},",
        f"    cities = {lua_quote(city_settings)},",
        "}",
    ]

    default_oter = value.get("default_oter")
    if default_oter is not None:
        if (
            isinstance(default_oter, list) and
            len(default_oter) == 21 and
            all(bounded_platform_id(entry) for entry in default_oter)
        ):
            lines.append(
                f"definition:default_oter({lua_string_table(default_oter)})"
            )
        else:
            result.todos.append(
                f"{source.location}: region settings {settings_id} default_oter needs exactly 21 bounded native ids"
            )

    if "default_groundcover" in value:
        groundcover = canonical_weighted_entries(value.get("default_groundcover"))
        if groundcover is None:
            result.todos.append(
                f"{source.location}: region settings {settings_id} default_groundcover needs review"
            )
        elif not groundcover:
            lines.append("definition:default_groundcover({})")
        else:
            for terrain_id, weight in groundcover:
                lines.append(
                    f"definition:groundcover({lua_quote(terrain_id)}, {weight})"
                )

    optional_ids = (
        "forest_composition", "forest_trails", "weather", "forests",
        "rivers", "lakes", "ocean", "highways", "ravines", "map_extras",
        "terrain_furniture",
    )
    for field_name in optional_ids:
        entry = value.get(field_name)
        if entry is None:
            continue
        if bounded_platform_id(entry):
            lines.append(f"definition:{field_name}({lua_quote(entry)})")
        else:
            result.todos.append(
                f"{source.location}: region settings {settings_id} {field_name} needs a bounded native id or null"
            )

    feature_settings = value.get("feature_flag_settings")
    if feature_settings is not None:
        if not isinstance(feature_settings, dict):
            result.todos.append(
                f"{source.location}: region settings {settings_id} feature_flag_settings needs review"
            )
        else:
            for member, method in (
                ("blacklist", "feature_blacklisted"),
                ("whitelist", "feature_whitelisted"),
            ):
                raw_flags = feature_settings.get(member, [])
                if (
                    isinstance(raw_flags, list) and
                    all(isinstance(flag, str) and flag for flag in raw_flags)
                ):
                    for flag in dict.fromkeys(raw_flags):
                        lines.append(f"definition:{method}({lua_quote(flag)})")
                else:
                    result.todos.append(
                        f"{source.location}: region settings {settings_id} feature_flag_settings.{member} needs review"
                    )
            unresolved = unresolved_fields(
                feature_settings, {"blacklist", "whitelist"}
            )
            if unresolved:
                result.todos.append(
                    f"{source.location}: region settings {settings_id} feature_flag_settings unresolved fields: " +
                    ", ".join(unresolved)
                )

    connection_fields = (
        "trail_connection", "sewer_connection", "subway_connection",
        "rail_connection", "intra_city_road_connection",
        "inter_city_road_connection",
    )
    connections = value.get("connections")
    if connections is not None:
        if not isinstance(connections, dict):
            result.todos.append(
                f"{source.location}: region settings {settings_id} connections needs review"
            )
        else:
            for field_name in connection_fields:
                entry = connections.get(field_name)
                if entry is None:
                    continue
                if bounded_platform_id(entry):
                    lines.append(f"definition:{field_name}({lua_quote(entry)})")
                else:
                    result.todos.append(
                        f"{source.location}: region settings {settings_id} connections.{field_name} needs a bounded native id or null"
                    )
            unresolved = unresolved_fields(connections, set(connection_fields))
            if unresolved:
                result.todos.append(
                    f"{source.location}: region settings {settings_id} connections unresolved fields: " +
                    ", ".join(unresolved)
                )

    boolean_fields = (
        "place_swamps", "place_roads", "place_railroads",
        "place_railroads_before_roads", "place_specials",
        "neighbor_connections",
    )
    for field_name in boolean_fields:
        if field_name not in value:
            continue
        entry = value[field_name]
        if isinstance(entry, bool):
            lines.append(f"definition:{field_name}({lua_boolean(entry)})")
        else:
            result.todos.append(
                f"{source.location}: region settings {settings_id} {field_name} needs a boolean"
            )

    if "max_urbanity" in value:
        maximum = finite_number(value["max_urbanity"], -NATIVE_FLOAT_MAX, NATIVE_FLOAT_MAX)
        if maximum is None:
            result.todos.append(
                f"{source.location}: region settings {settings_id} max_urbanity needs a native float"
            )
        else:
            lines.append(f"definition:max_urbanity({lua_number(maximum)})")

    if "urbanity_increase" in value:
        raw_increases = value["urbanity_increase"]
        increases = (
            [finite_number(entry, -NATIVE_FLOAT_MAX, NATIVE_FLOAT_MAX)
             for entry in raw_increases]
            if isinstance(raw_increases, list) and len(raw_increases) == 4
            else []
        )
        if len(increases) == 4 and all(entry is not None for entry in increases):
            lines.append(
                "definition:urbanity_increase({ " +
                ", ".join(lua_number(entry) for entry in increases if entry is not None) +
                " })"
            )
        else:
            result.todos.append(
                f"{source.location}: region settings {settings_id} urbanity_increase needs exactly four native floats"
            )

    return finish_catalog(
        source,
        result,
        "region settings",
        settings_id,
        lines,
        {
            "type", "id", "cities", "default_oter", "default_groundcover",
            "forest_composition", "forest_trails", "weather", "forests",
            "rivers", "lakes", "ocean", "highways", "ravines", "map_extras",
            "terrain_furniture", "feature_flag_settings", "connections",
            "place_swamps", "place_roads", "place_railroads",
            "place_railroads_before_roads", "place_specials",
            "neighbor_connections", "max_urbanity", "urbanity_increase",
        },
        todo_count,
    )


def render_region_terrain_furniture(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    rtf_id = value.get("id")
    if not bounded_platform_id(rtf_id):
        result.partial.append(f"{source.location}: region terrain furniture <invalid id>")
        result.todos.append(f"{source.location}: region terrain furniture needs a stable native id")
        return None
    todo_count = len(result.todos)

    lines = [
        "local definition = content.RegionTerrainFurniture {",
        f"    id = {lua_quote(rtf_id)},",
    ]

    ter_id = value.get("ter_id")
    if bounded_platform_id(ter_id):
        lines.append(f"    ter_id = {lua_quote(ter_id)},")
    elif "ter_id" in value:
        result.todos.append(
            f"{source.location}: region terrain furniture {rtf_id} ter_id needs a bounded native id"
        )

    furn_id = value.get("furn_id")
    if bounded_platform_id(furn_id):
        lines.append(f"    furn_id = {lua_quote(furn_id)},")
    elif "furn_id" in value:
        result.todos.append(
            f"{source.location}: region terrain furniture {rtf_id} furn_id needs a bounded native id"
        )

    lines.append("}")

    def render_rtf_pairs(field_name: str, method_name: str) -> None:
        entries = canonical_weighted_entries(value.get(field_name, []))
        if entries is None:
            result.todos.append(f"{source.location}: region terrain furniture {rtf_id} {field_name} needs review")
            return
        for replacement_id, weight in entries:
            lines.append(f"definition:{method_name}({lua_quote(replacement_id)}, {weight})")

    render_rtf_pairs("replace_with_terrain", "replace_terrain")
    render_rtf_pairs("replace_with_furniture", "replace_furniture")

    return finish_catalog(
        source,
        result,
        "region terrain furniture",
        rtf_id,
        lines,
        {"type", "id", "ter_id", "furn_id", "replace_with_terrain", "replace_with_furniture"},
        todo_count,
    )


def render_forest_biome_component(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    comp_id = value.get("id")
    if not bounded_platform_id(comp_id):
        result.partial.append(f"{source.location}: forest biome component <invalid id>")
        result.todos.append(f"{source.location}: forest biome component needs a stable native id")
        return None
    todo_count = len(result.todos)

    chance = native_integer(value.get("chance", 0))
    if chance is None:
        result.todos.append(f"{source.location}: forest biome component {comp_id} chance needs review")
        chance = 0

    sequence = native_integer(value.get("sequence", 0))
    if sequence is None:
        result.todos.append(f"{source.location}: forest biome component {comp_id} sequence needs review")
        sequence = 0

    lines = [
        "local definition = content.ForestBiomeComponent {",
        f"    id = {lua_quote(comp_id)},",
        f"    chance = {chance},",
        f"    sequence = {sequence},",
        "}",
    ]

    types = canonical_weighted_entries(value.get("types", []))
    if types is None:
        result.todos.append(f"{source.location}: forest biome component {comp_id} types need review")
    else:
        for type_id, weight in types:
            lines.append(f"definition:type({lua_quote(type_id)}, {weight})")

    return finish_catalog(
        source,
        result,
        "forest biome component",
        comp_id,
        lines,
        {"type", "id", "chance", "sequence", "types"},
        todo_count,
    )


def render_city(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    city_id = value.get("id")
    if not safe_platform_id(city_id):
        result.partial.append(f"{source.location}: city <invalid id>")
        result.todos.append(f"{source.location}: city needs a stable native id")
        return None
    todo_count = len(result.todos)

    database_id = native_integer(value.get("database_id"))
    if database_id is None:
        result.todos.append(f"{source.location}: city {city_id} database_id needs review")
        database_id = 0

    name = value.get("name", "")
    if not isinstance(name, str):
        result.todos.append(f"{source.location}: city {city_id} name needs review")
        name = ""

    population = native_integer(value.get("population", 0))
    if population is None or population < 0:
        result.todos.append(f"{source.location}: city {city_id} population needs review")
        population = 0

    size = native_integer(value.get("size", -1))
    if size is None or size < -1:
        result.todos.append(f"{source.location}: city {city_id} size needs review")
        size = -1

    pos_om = value.get("pos_om")
    pos_om_x, pos_om_y = 0, 0
    if isinstance(pos_om, list) and len(pos_om) == 2:
        x = native_integer(pos_om[0])
        y = native_integer(pos_om[1])
        if x is not None and y is not None:
            pos_om_x, pos_om_y = x, y
        else:
            result.todos.append(f"{source.location}: city {city_id} pos_om coordinates need review")
    else:
        result.todos.append(f"{source.location}: city {city_id} pos_om needs review")

    pos = value.get("pos")
    pos_x, pos_y = 0, 0
    if isinstance(pos, list) and len(pos) == 2:
        x = native_integer(pos[0])
        y = native_integer(pos[1])
        if x is not None and y is not None:
            pos_x, pos_y = x, y
        else:
            result.todos.append(f"{source.location}: city {city_id} pos coordinates need review")
    else:
        result.todos.append(f"{source.location}: city {city_id} pos needs review")

    lines = [
        "local definition = content.City {",
        f"    id = {lua_quote(city_id)},",
        f"    database_id = {database_id},",
        f"    name = {lua_quote(name)},",
        f"    population = {population},",
        f"    size = {size},",
        f"    pos_om = {{ {pos_om_x}, {pos_om_y} }},",
        f"    pos = {{ {pos_x}, {pos_y} }},",
        "}",
    ]

    return finish_catalog(
        source,
        result,
        "city",
        city_id,
        lines,
        {"type", "id", "database_id", "name", "population", "size", "pos_om", "pos"},
        todo_count,
    )


def render_faction_mission(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    mission_id = value.get("id")
    if not safe_platform_id(mission_id):
        result.partial.append(f"{source.location}: faction mission <invalid id>")
        result.todos.append(f"{source.location}: faction mission needs a stable native id")
        return None
    todo_count = len(result.todos)

    name = display_text(value.get("name"), "")
    if not name:
        result.todos.append(
            f"{source.location}: faction mission {mission_id} name needs review"
        )
    desc = display_text(value.get("desc", value.get("description")), "")
    if not desc:
        result.todos.append(
            f"{source.location}: faction mission {mission_id} description needs review"
        )
    skill = value.get("skill", "")
    if not isinstance(skill, str):
        result.todos.append(f"{source.location}: faction mission {mission_id} skill needs review")
        skill = ""

    difficulty = value.get("difficulty", "")
    risk_levels = {"NONE", "VERY_LOW", "LOW", "MEDIUM", "HIGH", "VERY_HIGH"}
    if not isinstance(difficulty, str) or (
        difficulty and difficulty not in risk_levels
    ):
        result.todos.append(f"{source.location}: faction mission {mission_id} difficulty needs review")
        difficulty = ""

    risk = value.get("risk", "")
    if not isinstance(risk, str) or (risk and risk not in risk_levels):
        result.todos.append(f"{source.location}: faction mission {mission_id} risk needs review")
        risk = ""

    activity = value.get("activity", "")
    activity_levels = {
        "SLEEP_EXERCISE", "NO_EXERCISE", "LIGHT_EXERCISE",
        "MODERATE_EXERCISE", "BRISK_EXERCISE", "ACTIVE_EXERCISE",
        "EXTRA_EXERCISE",
    }
    if not isinstance(activity, str) or (
        activity and activity not in activity_levels
    ):
        result.todos.append(f"{source.location}: faction mission {mission_id} activity needs review")
        activity = ""

    time_str = display_text(value.get("time", ""), "")
    positions = native_integer(value.get("positions", 0))
    if positions is None or not 0 <= positions <= 65535:
        result.todos.append(f"{source.location}: faction mission {mission_id} positions needs review")
        positions = 0

    items_label = display_text(value.get("items_label", ""), "")
    footer = display_text(value.get("footer", ""), "")

    lines = [
        "local definition = content.FactionMission {",
        f"    id = {lua_quote(mission_id)},",
        f"    name = {lua_quote(name)},",
        f"    desc = {lua_quote(desc)},",
        f"    skill = {lua_quote(skill)},",
        f"    difficulty = {lua_quote(difficulty)},",
        f"    risk = {lua_quote(risk)},",
        f"    activity = {lua_quote(activity)},",
        f"    time = {lua_quote(time_str)},",
        f"    positions = {positions},",
        f"    items_label = {lua_quote(items_label)},",
        f"    footer = {lua_quote(footer)},",
        "}",
    ]

    items_possibilities = value.get("items_possibilities", [])
    if isinstance(items_possibilities, list):
        for item in items_possibilities:
            if isinstance(item, str) and item:
                lines.append(f"definition:add_items_possibility({lua_quote(item)})")
            elif (
                isinstance(item, dict) and
                isinstance(item.get("str"), str) and
                item["str"]
            ):
                lines.append(f"definition:add_items_possibility({lua_quote(item['str'])})")
            else:
                result.todos.append(f"{source.location}: faction mission {mission_id} item possibility needs review")
    else:
        result.todos.append(
            f"{source.location}: faction mission {mission_id} items_possibilities need review"
        )

    effects = value.get("effects", [])
    if isinstance(effects, list):
        for eff in effects:
            if isinstance(eff, str) and eff:
                lines.append(f"definition:add_effect({lua_quote(eff)})")
            elif (
                isinstance(eff, dict) and
                isinstance(eff.get("str"), str) and
                eff["str"]
            ):
                lines.append(f"definition:add_effect({lua_quote(eff['str'])})")
            else:
                result.todos.append(f"{source.location}: faction mission {mission_id} effect needs review")
    else:
        result.todos.append(
            f"{source.location}: faction mission {mission_id} effects need review"
        )

    return finish_catalog(
        source,
        result,
        "faction mission",
        mission_id,
        lines,
        {"type", "id", "name", "desc", "description", "skill", "difficulty", "risk", "activity", "time", "positions", "items_label", "items_possibilities", "effects", "footer"},
        todo_count,
    )


def render_region_settings_city(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    rsc_id = value.get("id")
    if not bounded_platform_id(rsc_id):
        result.partial.append(f"{source.location}: region settings city <invalid id>")
        result.todos.append(f"{source.location}: region settings city needs a stable native id")
        return None
    todo_count = len(result.todos)

    is_megacity = value.get("is_megacity", False)
    if not isinstance(is_megacity, bool):
        result.todos.append(
            f"{source.location}: region settings city {rsc_id} is_megacity needs review"
        )
        is_megacity = False
    city_size = native_integer(value.get("city_size"))
    if city_size is None or not 0 <= city_size <= 16:
        result.todos.append(f"{source.location}: region settings city {rsc_id} city_size needs review")
        city_size = 8

    city_spacing = native_integer(value.get("city_spacing", 4))
    if city_spacing is None or not 0 <= city_spacing <= 8:
        result.todos.append(f"{source.location}: region settings city {rsc_id} city_spacing needs review")
        city_spacing = 4

    shop_radius = native_integer(value.get("shop_radius", 30))
    if shop_radius is None or shop_radius < 0:
        result.todos.append(f"{source.location}: region settings city {rsc_id} shop_radius needs review")
        shop_radius = 30

    shop_sigma = native_integer(value.get("shop_sigma", 20))
    if shop_sigma is None or shop_sigma < 0:
        result.todos.append(f"{source.location}: region settings city {rsc_id} shop_sigma needs review")
        shop_sigma = 20

    park_radius = native_integer(value.get("park_radius", 30))
    if park_radius is None or park_radius < 0:
        result.todos.append(f"{source.location}: region settings city {rsc_id} park_radius needs review")
        park_radius = 30

    park_sigma = native_integer(value.get("park_sigma", 70))
    if park_sigma is None or park_sigma < 0:
        result.todos.append(f"{source.location}: region settings city {rsc_id} park_sigma needs review")
        park_sigma = 70

    name_snippet = value.get("name_snippet", "<city_name>")
    if not isinstance(name_snippet, str):
        result.todos.append(f"{source.location}: region settings city {rsc_id} name_snippet needs review")
        name_snippet = "<city_name>"

    lines = [
        "local definition = content.RegionSettingsCity {",
        f"    id = {lua_quote(rsc_id)},",
        f"    is_megacity = {lua_boolean(is_megacity)},",
        f"    city_size = {city_size},",
        f"    city_spacing = {city_spacing},",
        f"    shop_radius = {shop_radius},",
        f"    shop_sigma = {shop_sigma},",
        f"    park_radius = {park_radius},",
        f"    park_sigma = {park_sigma},",
        f"    name_snippet = {lua_quote(name_snippet)},",
        "}",
    ]

    def render_weighted_bin(field_name: str, method_name: str) -> None:
        entries = canonical_weighted_entries(value.get(field_name, []))
        if entries is None:
            result.todos.append(f"{source.location}: region settings city {rsc_id} {field_name} needs review")
            return
        for special_id, weight in entries:
            lines.append(f"definition:{method_name}({lua_quote(special_id)}, {weight})")

    render_weighted_bin("houses", "add_house")
    render_weighted_bin("shops", "add_shop")
    render_weighted_bin("parks", "add_park")

    return finish_catalog(
        source,
        result,
        "region settings city",
        rsc_id,
        lines,
        {"type", "id", "is_megacity", "city_size", "city_spacing", "shop_radius", "shop_sigma", "park_radius", "park_sigma", "name_snippet", "houses", "shops", "parks"},
        todo_count,
    )


def render_forest_biome_mapgen(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    fbm_id = value.get("id")
    if not bounded_platform_id(fbm_id):
        result.partial.append(f"{source.location}: forest biome mapgen <invalid id>")
        result.todos.append(f"{source.location}: forest biome mapgen needs a stable native id")
        return None
    todo_count = len(result.todos)

    sparseness_adjacency_factor = native_integer(value.get("sparseness_adjacency_factor", 0))
    if sparseness_adjacency_factor is None:
        result.todos.append(f"{source.location}: forest biome mapgen {fbm_id} sparseness_adjacency_factor needs review")
        sparseness_adjacency_factor = 0

    item_group = value.get("item_group", "")
    if not isinstance(item_group, str) or (
        item_group and not bounded_platform_id(item_group)
    ):
        result.todos.append(f"{source.location}: forest biome mapgen {fbm_id} item_group needs review")
        item_group = ""

    item_group_chance = native_integer(value.get("item_group_chance", 0))
    if item_group_chance is None or item_group_chance < 0:
        result.todos.append(f"{source.location}: forest biome mapgen {fbm_id} item_group_chance needs review")
        item_group_chance = 0

    item_spawn_iterations = native_integer(value.get("item_spawn_iterations", 0))
    if item_spawn_iterations is None or item_spawn_iterations < 0:
        result.todos.append(f"{source.location}: forest biome mapgen {fbm_id} item_spawn_iterations needs review")
        item_spawn_iterations = 0

    lines = [
        "local definition = content.ForestBiomeMapgen {",
        f"    id = {lua_quote(fbm_id)},",
        f"    sparseness_adjacency_factor = {sparseness_adjacency_factor},",
        f"    item_group = {lua_quote(item_group)},",
        f"    item_group_chance = {item_group_chance},",
        f"    item_spawn_iterations = {item_spawn_iterations},",
        "}",
    ]

    terrains = value.get("terrains", [])
    if isinstance(terrains, list):
        for ter in terrains:
            if isinstance(ter, str) and bounded_platform_id(ter):
                lines.append(f"definition:add_terrain({lua_quote(ter)})")
            else:
                result.todos.append(f"{source.location}: forest biome mapgen {fbm_id} terrain needs review")
    elif isinstance(terrains, str) and bounded_platform_id(terrains):
        lines.append(f"definition:add_terrain({lua_quote(terrains)})")
    else:
        result.todos.append(
            f"{source.location}: forest biome mapgen {fbm_id} terrains need review"
        )

    components = value.get("components", [])
    if isinstance(components, list):
        for comp in components:
            if isinstance(comp, str) and bounded_platform_id(comp):
                lines.append(f"definition:add_component({lua_quote(comp)})")
            else:
                result.todos.append(f"{source.location}: forest biome mapgen {fbm_id} component needs review")
    elif isinstance(components, str) and bounded_platform_id(components):
        lines.append(f"definition:add_component({lua_quote(components)})")
    else:
        result.todos.append(
            f"{source.location}: forest biome mapgen {fbm_id} components need review"
        )

    groundcover = canonical_weighted_entries(value.get("groundcover", []))
    if groundcover is None:
        result.todos.append(f"{source.location}: forest biome mapgen {fbm_id} groundcover needs review")
    else:
        for ter_id, weight in groundcover:
            lines.append(f"definition:add_groundcover({lua_quote(ter_id)}, {weight})")

    tf = value.get("terrain_furniture", {})
    if isinstance(tf, dict):
        for ter_id, tdata in tf.items():
            if bounded_platform_id(ter_id) and isinstance(tdata, dict):
                chance = native_integer(tdata.get("chance", 0))
                if chance is None or chance < 0:
                    result.todos.append(f"{source.location}: forest biome mapgen {fbm_id} terrain_furniture chance needs review")
                    chance = 0
                furniture_entries = canonical_weighted_entries(tdata.get("furniture", []))
                if furniture_entries is None:
                    result.todos.append(f"{source.location}: forest biome mapgen {fbm_id} terrain_furniture entries need review")
                else:
                    lua_furn = ", ".join(f"{{ {lua_quote(furn_id)}, {weight} }}" for furn_id, weight in furniture_entries)
                    lines.append(f"definition:add_terrain_furniture({lua_quote(ter_id)}, {chance}, {{ {lua_furn} }})")
            else:
                result.todos.append(f"{source.location}: forest biome mapgen {fbm_id} terrain_furniture needs review")
    else:
        result.todos.append(f"{source.location}: forest biome mapgen {fbm_id} terrain_furniture must be an object")

    return finish_catalog(
        source,
        result,
        "forest biome mapgen",
        fbm_id,
        lines,
        {"type", "id", "sparseness_adjacency_factor", "item_group", "item_group_chance", "item_spawn_iterations", "terrains", "components", "groundcover", "terrain_furniture"},
        todo_count,
    )


def render_tool_quality(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    quality_id = value.get("id")
    if not safe_platform_id(quality_id):
        result.partial.append(f"{source.location}: tool quality <invalid id>")
        result.todos.append(f"{source.location}: tool quality needs a stable native id")
        return None
    todo_count = len(result.todos)
    name = display_text(value.get("name"), quality_id)
    lines = [
        "local definition = content.ToolQuality {",
        f"    id = {lua_quote(quality_id)},",
        f"    name = {lua_quote(name)},",
        "}",
    ]
    usages = value.get("usages", [])
    if isinstance(usages, list):
        for usage in usages:
            if (
                isinstance(usage, list) and
                len(usage) == 2 and
                isinstance(usage[0], int) and
                not isinstance(usage[0], bool) and
                0 <= usage[0] <= NATIVE_INT_MAX and
                isinstance(usage[1], list) and
                all(isinstance(text, str) and text for text in usage[1])
            ):
                lines.extend(
                    f"definition:usage({usage[0]}, {lua_quote(text)})"
                    for text in usage[1]
                )
            else:
                result.todos.append(
                    f"{source.location}: tool quality {quality_id} usage needs review"
                )
    else:
        result.todos.append(
            f"{source.location}: tool quality {quality_id} usages need review"
        )
    return finish_catalog(
        source,
        result,
        "tool quality",
        quality_id,
        lines,
        {"type", "id", "name", "usages"},
        todo_count,
    )


def render_skill_display(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    display_id = value.get("id")
    if not safe_platform_id(display_id):
        result.partial.append(f"{source.location}: skill display <invalid id>")
        result.todos.append(f"{source.location}: skill display needs a stable native id")
        return None
    todo_count = len(result.todos)
    label = display_text(value.get("display_string"), display_id)
    lines = [
        "local definition = content.SkillDisplay {",
        f"    id = {lua_quote(display_id)},",
        f"    label = {lua_quote(label)},",
        "}",
    ]
    return finish_catalog(
        source,
        result,
        "skill display",
        display_id,
        lines,
        {"type", "id", "display_string"},
        todo_count,
    )


def render_skill(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    skill_id = value.get("id")
    if not safe_platform_id(skill_id):
        result.partial.append(f"{source.location}: skill <invalid id>")
        result.todos.append(f"{source.location}: skill needs a stable native id")
        return None
    todo_count = len(result.todos)
    name = display_text(value.get("name"), skill_id)
    description = display_text(value.get("description"), "")
    display_category = value.get("display_category", "none")
    sort_rank = value.get("sort_rank", 1000000)
    if not safe_platform_id(display_category):
        display_category = "none"
        result.todos.append(
            f"{source.location}: skill {skill_id} display category needs review"
        )
    if not isinstance(sort_rank, int) or isinstance(sort_rank, bool) or not -NATIVE_INT_MAX <= sort_rank <= NATIVE_INT_MAX:
        sort_rank = 1000000
        result.todos.append(f"{source.location}: skill {skill_id} sort rank needs review")
    lines = [
        "local definition = content.Skill {",
        f"    id = {lua_quote(skill_id)},",
        f"    name = {lua_quote(name)},",
        f"    description = {lua_quote(description)},",
        f"    display_category = {lua_quote(display_category)},",
        f"    sort_rank = {sort_rank},",
    ]
    for field_name in ("teachable", "obsolete", "consumes_focus"):
        raw = value.get(field_name, {"teachable": True, "obsolete": False, "consumes_focus": True}[field_name])
        if isinstance(raw, bool):
            lines.append(f"    {field_name} = {'true' if raw else 'false'},")
        else:
            result.todos.append(
                f"{source.location}: skill {skill_id} {field_name} needs review"
            )
    lines.append("}")
    tags = value.get("tags", [])
    if isinstance(tags, list) and all(isinstance(tag, str) and tag for tag in tags):
        lines.extend(f"definition:tag({lua_quote(tag)})" for tag in tags)
    elif "tags" in value:
        result.todos.append(f"{source.location}: skill {skill_id} tags need review")
    companion = value.get("companion_skill_practice", [])
    if isinstance(companion, list):
        # Legacy load uses unordered_map::emplace, so a duplicate practice
        # key keeps its first weight; later duplicates are dropped, not
        # review items.
        seen_practices: set[str] = set()
        for entry in companion:
            practice_skill = entry.get("skill")
            # An empty skill string is a deliberate legacy value meaning the
            # skill practices itself; it must render as an empty-string id.
            if not (
                isinstance(entry, dict) and
                isinstance(practice_skill, str) and
                (practice_skill == "" or safe_platform_id(practice_skill)) and
                isinstance(entry.get("weight"), int) and
                not isinstance(entry["weight"], bool) and
                -NATIVE_INT_MAX <= entry["weight"] <= NATIVE_INT_MAX
            ):
                result.todos.append(
                    f"{source.location}: skill {skill_id} companion practice needs review"
                )
                continue
            if practice_skill in seen_practices:
                continue
            seen_practices.add(practice_skill)
            lines.append(
                f"definition:companion_practice({lua_quote(practice_skill)}, {entry['weight']})"
            )
    level_descriptions: dict[int, dict[str, str]] = {}
    for field_name, variant in (
        ("level_descriptions_theory", "theory"),
        ("level_descriptions_practice", "practice"),
    ):
        entries = value.get(field_name, [])
        if not isinstance(entries, list):
            result.todos.append(
                f"{source.location}: skill {skill_id} {field_name} needs review"
            )
            continue
        for entry in entries:
            if (
                isinstance(entry, dict) and
                isinstance(entry.get("level"), int) and
                not isinstance(entry["level"], bool) and
                0 <= entry["level"] <= NATIVE_MAX_SKILL and
                display_text(entry.get("description"))
            ):
                description_text = display_text(entry["description"])
                level_descriptions.setdefault(entry["level"], {})[variant] = description_text
            else:
                result.todos.append(
                    f"{source.location}: skill {skill_id} level description needs review"
                )
    for level, descriptions in sorted(level_descriptions.items()):
        theory = descriptions.get("theory")
        practice = descriptions.get("practice")
        if theory is not None and practice is not None:
            lines.append(
                f"definition:level_description({level}, {lua_quote(theory)}, {lua_quote(practice)})"
            )
        elif theory is not None:
            lines.append(
                f"definition:level_description({level}, {lua_quote(theory)})"
            )
        else:
            # Practice-only levels must not invent a theory text: the legacy
            # maps are independent and the native builder mirrors that.
            lines.append(
                f"definition:level_description_practice({level}, {lua_quote(practice)})"
            )
    timing = value.get("time_to_attack")
    if isinstance(timing, dict):
        minimum = timing.get("min_time", 50)
        base = timing.get("base_time", 220)
        reduction = timing.get("time_reduction_per_level", 25)
        if all(isinstance(entry, int) and not isinstance(entry, bool) and 0 <= entry <= NATIVE_INT_MAX for entry in (minimum, base, reduction)):
            lines.append(f"definition:attack_time({minimum}, {base}, {reduction})")
        else:
            result.todos.append(f"{source.location}: skill {skill_id} attack timing needs review")
    rank_fields = (
        value.get("companion_combat_rank_factor", 0),
        value.get("companion_survival_rank_factor", 0),
        value.get("companion_industry_rank_factor", 0),
    )
    if all(isinstance(entry, int) and not isinstance(entry, bool) and -NATIVE_INT_MAX <= entry <= NATIVE_INT_MAX for entry in rank_fields):
        lines.append(
            "definition:companion_rank_factors(" + ", ".join(str(entry) for entry in rank_fields) + ")"
        )
    else:
        result.todos.append(f"{source.location}: skill {skill_id} companion rank factors need review")
    for field_name, method in (
        ("requires_all_traits", "requires_all_trait"),
        ("requires_any_traits", "requires_any_trait"),
    ):
        traits = value.get(field_name, [])
        if isinstance(traits, list) and all(isinstance(trait, str) and trait for trait in traits):
            lines.extend(f"definition:{method}({lua_quote(trait)})" for trait in traits)
        elif field_name in value:
            result.todos.append(f"{source.location}: skill {skill_id} {field_name} needs review")
    return finish_catalog(
        source,
        result,
        "skill",
        skill_id,
        lines,
        {
            "type", "id", "name", "description", "display_category", "sort_rank",
            "teachable", "obsolete", "consumes_focus", "tags", "companion_skill_practice",
            "level_descriptions_theory", "level_descriptions_practice", "time_to_attack",
            "companion_combat_rank_factor", "companion_survival_rank_factor",
            "companion_industry_rank_factor", "requires_all_traits", "requires_any_traits",
        },
        todo_count,
    )


def render_vitamin(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    vitamin_id = value.get("id")
    if not safe_platform_id(vitamin_id):
        result.partial.append(f"{source.location}: vitamin <invalid id>")
        result.todos.append(f"{source.location}: vitamin needs a stable native id")
        return None
    todo_count = len(result.todos)
    kind = value.get("vit_type", "vitamin")
    minimum = value.get("min", 0)
    maximum = value.get("max", 0)
    rate = parse_turns(value.get("rate", 1))
    if kind not in {"vitamin", "toxin", "drug", "counter"}:
        kind = "vitamin"
        result.todos.append(f"{source.location}: vitamin {vitamin_id} kind needs review")
    if not isinstance(minimum, int) or isinstance(minimum, bool) or not -NATIVE_INT_MAX <= minimum <= NATIVE_INT_MAX:
        minimum = 0
        result.todos.append(f"{source.location}: vitamin {vitamin_id} minimum needs review")
    if not isinstance(maximum, int) or isinstance(maximum, bool) or not -NATIVE_INT_MAX <= maximum <= NATIVE_INT_MAX:
        maximum = 0
        result.todos.append(f"{source.location}: vitamin {vitamin_id} maximum needs review")
    if rate is None or not 0 < rate <= NATIVE_INT_MAX:
        rate = 1
        result.todos.append(f"{source.location}: vitamin {vitamin_id} rate needs review")
    lines = [
        "local definition = content.Vitamin {",
        f"    id = {lua_quote(vitamin_id)},",
        f"    name = {lua_quote(display_text(value.get('name'), vitamin_id))},",
        f"    kind = {lua_quote(kind)},",
        f"    minimum = {minimum},",
        f"    maximum = {maximum},",
        f"    rate_turns = {rate},",
    ]
    for field_name in ("deficiency", "excess"):
        effect = value.get(field_name)
        if isinstance(effect, str) and effect:
            lines.append(f"    {field_name} = {lua_quote(effect)},")
        elif field_name in value and effect not in (None, ""):
            result.todos.append(
                f"{source.location}: vitamin {vitamin_id} {field_name} needs review"
            )
    lines.append("}")
    if "weight_per_unit" in value:
        micrograms = parse_vitamin_micrograms(value["weight_per_unit"])
        if micrograms is None or not 0 < micrograms <= NATIVE_INT_MAX:
            result.todos.append(
                f"{source.location}: vitamin {vitamin_id} unit weight needs review"
            )
        else:
            lines.append(f"definition:weight_micrograms({micrograms})")
    for field_name, method in (
        ("disease", "deficiency_range"),
        ("disease_excess", "excess_range"),
    ):
        entries = value.get(field_name, [])
        if isinstance(entries, list):
            for entry in entries:
                if (
                    isinstance(entry, list) and
                    len(entry) == 2 and
                    all(isinstance(number, int) and not isinstance(number, bool) and -NATIVE_INT_MAX <= number <= NATIVE_INT_MAX for number in entry)
                ):
                    lines.append(f"definition:{method}({entry[0]}, {entry[1]})")
                else:
                    result.todos.append(
                        f"{source.location}: vitamin {vitamin_id} {field_name} entry needs review"
                    )
        elif field_name in value:
            result.todos.append(
                f"{source.location}: vitamin {vitamin_id} {field_name} needs review"
            )
    decays = value.get("decays_into", [])
    if isinstance(decays, list):
        for entry in decays:
            if (
                isinstance(entry, list) and
                len(entry) == 2 and
                safe_platform_id(entry[0]) and
                isinstance(entry[1], int) and
                not isinstance(entry[1], bool) and
                0 < entry[1] <= NATIVE_INT_MAX
            ):
                lines.append(f"definition:decays_into({lua_quote(entry[0])}, {entry[1]})")
            else:
                result.todos.append(
                    f"{source.location}: vitamin {vitamin_id} decay entry needs review"
                )
    flags = value.get("flags", [])
    if isinstance(flags, list) and all(isinstance(flag, str) and flag for flag in flags):
        lines.extend(f"definition:flag({lua_quote(flag)})" for flag in flags)
    elif "flags" in value:
        result.todos.append(f"{source.location}: vitamin {vitamin_id} flags need review")
    return finish_catalog(
        source,
        result,
        "vitamin",
        vitamin_id,
        lines,
        {
            "type", "id", "vit_type", "name", "deficiency", "excess", "min", "max",
            "rate", "weight_per_unit", "disease", "disease_excess", "decays_into", "flags",
        },
        todo_count,
    )


def render_json_flag(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    flag_id = value.get("id")
    if not safe_platform_id(flag_id):
        result.partial.append(f"{source.location}: JSON flag <invalid id>")
        result.todos.append(f"{source.location}: JSON flag needs a stable native id")
        return None
    todo_count = len(result.todos)
    lines = ["local definition = content.JsonFlag {", f"    id = {lua_quote(flag_id)},"]
    string_fields = ("info", "restriction", "name", "item_prefix", "item_suffix", "requires_flag")
    for field_name in string_fields:
        raw = value.get(field_name)
        if isinstance(raw, str):
            lines.append(f"    {field_name} = {lua_quote(raw)},")
        elif isinstance(raw, dict) and display_text(raw):
            lines.append(f"    {field_name} = {lua_quote(display_text(raw))},")
            if set(raw) != {"str"}:
                result.todos.append(
                    f"{source.location}: JSON flag {flag_id} {field_name} translation metadata needs review"
                )
        elif field_name in value:
            result.todos.append(
                f"{source.location}: JSON flag {flag_id} {field_name} needs review"
            )
    for field_name, default in (("inherit", True), ("craft_inherit", False)):
        raw = value.get(field_name, default)
        if isinstance(raw, bool):
            lines.append(f"    {field_name} = {'true' if raw else 'false'},")
        else:
            result.todos.append(
                f"{source.location}: JSON flag {flag_id} {field_name} needs review"
            )
    taste = value.get("taste_mod", 0)
    if isinstance(taste, int) and not isinstance(taste, bool) and -NATIVE_INT_MAX <= taste <= NATIVE_INT_MAX:
        lines.append(f"    taste_modifier = {taste},")
    else:
        result.todos.append(f"{source.location}: JSON flag {flag_id} taste modifier needs review")
    lines.append("}")
    conflicts = value.get("conflicts", [])
    if isinstance(conflicts, list) and all(isinstance(flag, str) and flag for flag in conflicts):
        lines.extend(f"definition:conflicts_with({lua_quote(flag)})" for flag in conflicts)
    elif "conflicts" in value:
        result.todos.append(f"{source.location}: JSON flag {flag_id} conflicts need review")
    return finish_catalog(
        source,
        result,
        "JSON flag",
        flag_id,
        lines,
        {"type", "id", *string_fields, "inherit", "craft_inherit", "taste_mod", "conflicts"},
        todo_count,
    )


def render_damage_type(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    damage_id = value.get("id")
    if not safe_platform_id(damage_id):
        result.partial.append(f"{source.location}: damage type <invalid id>")
        result.todos.append(f"{source.location}: damage type needs a stable native id")
        return None
    todo_count = len(result.todos)
    lines = [
        "local definition = content.DamageType {",
        f"    id = {lua_quote(damage_id)},",
        f"    name = {lua_quote(display_text(value.get('name'), damage_id))},",
    ]
    for field_name in ("skill", "magic_color"):
        raw = value.get(field_name)
        if isinstance(raw, str) and raw:
            lines.append(f"    {field_name} = {lua_quote(raw)},")
        elif field_name in value:
            result.todos.append(
                f"{source.location}: damage type {damage_id} {field_name} needs review"
            )
    factor = value.get("bash_conversion_factor")
    if isinstance(factor, (int, float)) and not isinstance(factor, bool) and factor >= 0:
        lines.append(f"    bash_conversion_factor = {factor!r},")
    elif "bash_conversion_factor" in value:
        result.todos.append(
            f"{source.location}: damage type {damage_id} bash conversion needs review"
        )
    boolean_fields = {
        "melee_only": "melee_only",
        "physical": "physical",
        "mon_difficulty": "monster_difficulty",
        "no_resist": "no_resist",
        "edged": "edged",
        "environmental": "environmental",
        "material_required": "material_required",
    }
    for source_name, target_name in boolean_fields.items():
        raw = value.get(source_name, False)
        if isinstance(raw, bool):
            lines.append(f"    {target_name} = {'true' if raw else 'false'},")
        else:
            result.todos.append(
                f"{source.location}: damage type {damage_id} {source_name} needs review"
            )
    lines.append("}")
    derived = value.get("derived_from")
    if isinstance(derived, list) and len(derived) == 2 and safe_platform_id(derived[0]) and isinstance(derived[1], (int, float)) and not isinstance(derived[1], bool):
        lines.append(f"definition:derived({lua_quote(derived[0])}, {derived[1]!r})")
    elif "derived_from" in value:
        result.todos.append(f"{source.location}: damage type {damage_id} derivation needs review")
    immune = value.get("immune_flags", {})
    if isinstance(immune, dict):
        for group, method in (("character", "immune_character_flag"), ("monster", "immune_monster_flag")):
            flags = immune.get(group, [])
            if isinstance(flags, list) and all(isinstance(flag, str) and flag for flag in flags):
                lines.extend(f"definition:{method}({lua_quote(flag)})" for flag in flags)
            elif group in immune:
                result.todos.append(
                    f"{source.location}: damage type {damage_id} {group} immunity needs review"
                )
    elif "immune_flags" in value:
        result.todos.append(f"{source.location}: damage type {damage_id} immunities need review")
    for source_name, method in (("onhit_eocs", "on_hit"), ("ondamage_eocs", "on_damage")):
        if source_name in value:
            result.todos.append(
                f"{source.location}: damage type {damage_id} {source_name} must become a named {method} handler"
            )
    return finish_catalog(
        source,
        result,
        "damage type",
        damage_id,
        lines,
        {
            "type", "id", "name", "skill", "magic_color", "bash_conversion_factor",
            *boolean_fields.keys(), "derived_from", "immune_flags", "onhit_eocs", "ondamage_eocs",
        },
        todo_count,
    )


def render_material(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    material_id = value.get("id")
    if not safe_platform_id(material_id):
        result.partial.append(f"{source.location}: material <invalid id>")
        result.todos.append(f"{source.location}: material needs a stable native id")
        return None
    todo_count = len(result.todos)
    lines = [
        "local definition = content.Material {",
        f"    id = {lua_quote(material_id)},",
        f"    name = {lua_quote(display_text(value.get('name'), material_id))},",
    ]
    option_map = {
        "salvaged_into": "salvaged_into",
        "repaired_with": "repaired_with",
        "bash_dmg_verb": "bash_damage_verb",
        "cut_dmg_verb": "cut_damage_verb",
    }
    for source_name, target_name in option_map.items():
        raw = value.get(source_name)
        text = display_text(raw) if isinstance(raw, (str, dict)) else ""
        if text:
            lines.append(f"    {target_name} = {lua_quote(text)},")
        elif source_name in value and raw not in (None, ""):
            result.todos.append(
                f"{source.location}: material {material_id} {source_name} needs review"
            )
    numeric_map = {
        "chip_resist": "chip_resistance",
        "density": "density",
        "sheet_thickness": "sheet_thickness",
        "repair_difficulty": "repair_difficulty",
        "wind_resist": "wind_resistance",
        "specific_heat_liquid": "specific_heat_liquid",
        "specific_heat_solid": "specific_heat_solid",
        "latent_heat": "latent_heat",
        "freezing_point": "freezing_point",
    }
    for source_name, target_name in numeric_map.items():
        raw = value.get(source_name)
        if isinstance(raw, (int, float)) and not isinstance(raw, bool):
            lines.append(f"    {target_name} = {raw!r},")
        elif source_name in value:
            result.todos.append(
                f"{source.location}: material {material_id} {source_name} needs review"
            )
    breathability = value.get("breathability")
    breathability_values = {
        "IMPERMEABLE": 0, "POOR": 1, "AVERAGE": 2, "GOOD": 3,
        "MOISTURE_WICKING": 4, "SECOND_SKIN": 5,
    }
    if isinstance(breathability, str) and breathability in breathability_values:
        lines.append(f"    breathability = {breathability_values[breathability]},")
    elif "breathability" in value:
        result.todos.append(
            f"{source.location}: material {material_id} breathability needs review"
        )
    for field_name in ("rotting", "soft", "uncomfortable", "conductive"):
        raw = value.get(field_name, False)
        if isinstance(raw, bool):
            lines.append(f"    {field_name} = {'true' if raw else 'false'},")
        else:
            result.todos.append(
                f"{source.location}: material {material_id} {field_name} needs review"
            )
    lines.append("}")
    adjectives = value.get("dmg_adj", [])
    if isinstance(adjectives, list):
        for index, adjective in enumerate(adjectives, 1):
            text = display_text(adjective)
            if text:
                lines.append(f"definition:damage_adjective({index}, {lua_quote(text)})")
            else:
                result.todos.append(
                    f"{source.location}: material {material_id} damage adjective #{index} needs review"
                )
    resistances = value.get("resist", {})
    if isinstance(resistances, dict):
        for damage_id, amount in sorted(resistances.items()):
            if safe_platform_id(damage_id) and isinstance(amount, (int, float)) and not isinstance(amount, bool):
                lines.append(f"definition:resistance({lua_quote(damage_id)}, {amount!r})")
            else:
                result.todos.append(
                    f"{source.location}: material {material_id} resistance {damage_id} needs review"
                )
    vitamins = value.get("vitamins", [])
    if isinstance(vitamins, list):
        for entry in vitamins:
            if isinstance(entry, list) and len(entry) == 2 and safe_platform_id(entry[0]) and isinstance(entry[1], (int, float)) and not isinstance(entry[1], bool):
                lines.append(f"definition:vitamin({lua_quote(entry[0])}, {entry[1]!r})")
            else:
                result.todos.append(
                    f"{source.location}: material {material_id} vitamin entry needs review"
                )
    burn_data = value.get("burn_data", [])
    if isinstance(burn_data, list):
        for intensity, burn in enumerate(burn_data, 1):
            if isinstance(burn, dict):
                immune = burn.get("immune", False)
                volume = parse_integral_unit(burn.get("volume_per_turn", 0), {"ml": 1, "l": 1000})
                fuel = burn.get("fuel", 0)
                smoke = burn.get("smoke", 0)
                burned = burn.get("burn", 0)
                if isinstance(immune, bool) and volume is not None and all(isinstance(number, (int, float)) and not isinstance(number, bool) for number in (fuel, smoke, burned)):
                    lines.append(
                        f"definition:burn({intensity}, {'true' if immune else 'false'}, {volume}, {fuel!r}, {smoke!r}, {burned!r})"
                    )
                    continue
            result.todos.append(
                f"{source.location}: material {material_id} burn intensity {intensity} needs review"
            )
    for field_name in ("fuel_data", "burn_products"):
        if field_name in value:
            result.todos.append(
                f"{source.location}: material {material_id} {field_name} needs unit-aware review"
            )
    return finish_catalog(
        source,
        result,
        "material",
        material_id,
        lines,
        {
            "type", "id", "name", *option_map.keys(), *numeric_map.keys(), "breathability",
            "rotting", "soft", "uncomfortable", "conductive", "dmg_adj", "resist",
            "vitamins", "burn_data", "fuel_data", "burn_products",
        },
        todo_count,
    )


def render_ammunition_type(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    ammo_id = value.get("id")
    if not safe_platform_id(ammo_id):
        result.partial.append(f"{source.location}: ammunition type <invalid id>")
        result.todos.append(f"{source.location}: ammunition type needs a stable native id")
        return None
    todo_count = len(result.todos)
    lines = [
        "local definition = content.AmmunitionType {",
        f"    id = {lua_quote(ammo_id)},",
        f"    name = {lua_quote(display_text(value.get('name'), ammo_id))},",
    ]
    default_item = value.get("default")
    if isinstance(default_item, str):
        lines.append(f"    default_item = {lua_quote(default_item)},")
    elif "default" in value:
        result.todos.append(
            f"{source.location}: ammunition type {ammo_id} default item needs review"
        )
    lines.append("}")
    return finish_catalog(
        source,
        result,
        "ammunition type",
        ammo_id,
        lines,
        {"type", "id", "name", "default"},
        todo_count,
    )


def render_item_category(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    category_id = value.get("id")
    if not safe_platform_id(category_id):
        result.partial.append(f"{source.location}: item category <invalid id>")
        result.todos.append(f"{source.location}: item category needs a stable native id")
        return None
    todo_count = len(result.todos)
    sort_rank = value.get("sort_rank", 0)
    spawn_rate = value.get("spawn_rate", 1.0)
    if not isinstance(sort_rank, int) or isinstance(sort_rank, bool) or not -NATIVE_INT_MAX <= sort_rank <= NATIVE_INT_MAX:
        sort_rank = 0
        result.todos.append(f"{source.location}: item category {category_id} sort rank needs review")
    if not isinstance(spawn_rate, (int, float)) or isinstance(spawn_rate, bool) or spawn_rate < 0:
        spawn_rate = 1.0
        result.todos.append(f"{source.location}: item category {category_id} spawn rate needs review")
    raw_header = value.get("name_header")
    if isinstance(raw_header, dict):
        header = raw_header.get("str", raw_header.get("str_sp", ""))
    else:
        header = raw_header
    if not isinstance(header, str) or not header:
        header = category_id
    # name_noun is a plural translation in legacy data (the "str_sp" form).
    raw_noun = value.get("name_noun")
    if isinstance(raw_noun, dict):
        noun = raw_noun.get("str_sp", raw_noun.get("str", ""))
    else:
        noun = raw_noun
    if not isinstance(noun, str) or not noun:
        noun = category_id
    lines = [
        "local definition = content.ItemCategory {",
        f"    id = {lua_quote(category_id)},",
        f"    header = {lua_quote(header)},",
        f"    noun = {lua_quote(noun)},",
        f"    sort_rank = {sort_rank},",
        f"    spawn_rate = {spawn_rate!r},",
    ]
    zone = value.get("zone")
    if isinstance(zone, str) and zone:
        lines.append(f"    zone = {lua_quote(zone)},")
    elif "zone" in value:
        result.todos.append(f"{source.location}: item category {category_id} zone needs review")
    lines.append("}")
    priorities = value.get("priority_zones", [])
    if isinstance(priorities, list):
        for priority in priorities:
            if not isinstance(priority, dict) or not safe_platform_id(priority.get("id")):
                result.todos.append(
                    f"{source.location}: item category {category_id} priority zone needs review"
                )
                continue
            flags = priority.get("flags", [])
            filthy = priority.get("filthy", False)
            if not isinstance(flags, list) or not all(isinstance(flag, str) and flag for flag in flags) or not isinstance(filthy, bool):
                result.todos.append(
                    f"{source.location}: item category {category_id} priority-zone matcher needs review"
                )
                continue
            rendered_flags = "{ " + ", ".join(lua_quote(flag) for flag in flags) + " }"
            lines.append(
                f"definition:priority_zone({lua_quote(priority['id'])}, {rendered_flags}, {'true' if filthy else 'false'})"
            )
    elif "priority_zones" in value:
        result.todos.append(
            f"{source.location}: item category {category_id} priority zones need review"
        )
    return finish_catalog(
        source,
        result,
        "item category",
        category_id,
        lines,
        {"type", "id", "name_header", "name_noun", "sort_rank", "spawn_rate", "zone", "priority_zones"},
        todo_count,
    )


def render_recipe_category(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    category_id = value.get("id")
    if not safe_platform_id(category_id):
        result.partial.append(f"{source.location}: recipe category <invalid id>")
        result.todos.append(f"{source.location}: recipe category needs a stable native id")
        return None
    todo_count = len(result.todos)
    lines = ["local definition = content.RecipeCategory {", f"    id = {lua_quote(category_id)},"]
    for source_name, target_name in (
        ("is_hidden", "hidden"),
        ("is_practice", "practice"),
        ("is_building", "building"),
        ("is_wildcard", "wildcard"),
    ):
        raw = value.get(source_name, False)
        if isinstance(raw, bool):
            lines.append(f"    {target_name} = {'true' if raw else 'false'},")
        else:
            result.todos.append(
                f"{source.location}: recipe category {category_id} {source_name} needs review"
            )
    lines.append("}")
    subcategories = value.get("recipe_subcategories", [])
    if isinstance(subcategories, list) and all(isinstance(entry, str) and entry for entry in subcategories):
        lines.extend(f"definition:subcategory({lua_quote(entry)})" for entry in subcategories)
    else:
        result.todos.append(
            f"{source.location}: recipe category {category_id} subcategories need review"
        )
    return finish_catalog(
        source,
        result,
        "recipe category",
        category_id,
        lines,
        {"type", "id", "is_hidden", "is_practice", "is_building", "is_wildcard", "recipe_subcategories"},
        todo_count,
    )


def render_proficiency_category(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    category_id = value.get("id")
    if not safe_platform_id(category_id):
        result.partial.append(f"{source.location}: proficiency category <invalid id>")
        result.todos.append(f"{source.location}: proficiency category needs a stable native id")
        return None
    todo_count = len(result.todos)
    lines = [
        "local definition = content.ProficiencyCategory {",
        f"    id = {lua_quote(category_id)},",
        f"    name = {lua_quote(display_text(value.get('name'), category_id))},",
        f"    description = {lua_quote(display_text(value.get('description')))},",
        "}",
    ]
    return finish_catalog(
        source,
        result,
        "proficiency category",
        category_id,
        lines,
        {"type", "id", "name", "description"},
        todo_count,
    )


def render_proficiency(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    proficiency_id = value.get("id")
    if not safe_platform_id(proficiency_id):
        result.partial.append(f"{source.location}: proficiency <invalid id>")
        result.todos.append(f"{source.location}: proficiency needs a stable native id")
        return None
    todo_count = len(result.todos)
    category = value.get("category")
    if not safe_platform_id(category):
        category = ""
        result.todos.append(f"{source.location}: proficiency {proficiency_id} category needs review")
    learn_turns = parse_turns(value.get("time_to_learn", "9999 h"))
    if learn_turns is None or not 0 < learn_turns <= NATIVE_INT_MAX:
        learn_turns = 35996400
        result.todos.append(f"{source.location}: proficiency {proficiency_id} training time needs review")
    lines = [
        "local definition = content.Proficiency {",
        f"    id = {lua_quote(proficiency_id)},",
        f"    name = {lua_quote(display_text(value.get('name'), proficiency_id))},",
        f"    description = {lua_quote(display_text(value.get('description')))},",
        f"    category = {lua_quote(category)},",
        f"    time_to_learn_turns = {learn_turns},",
    ]
    for source_name, target_name, default in (
        ("default_time_multiplier", "time_multiplier", 2.0),
        ("default_skill_penalty", "skill_penalty", 1.0),
        ("default_weakpoint_bonus", "weakpoint_bonus", 0.0),
        ("default_weakpoint_penalty", "weakpoint_penalty", 0.0),
    ):
        raw = value.get(source_name, default)
        if isinstance(raw, (int, float)) and not isinstance(raw, bool):
            lines.append(f"    {target_name} = {raw!r},")
        else:
            result.todos.append(
                f"{source.location}: proficiency {proficiency_id} {source_name} needs review"
            )
    for field_name, default in (("can_learn", False), ("ignore_focus", False), ("teachable", True)):
        raw = value.get(field_name, default)
        if isinstance(raw, bool):
            lines.append(f"    {field_name} = {'true' if raw else 'false'},")
        else:
            result.todos.append(
                f"{source.location}: proficiency {proficiency_id} {field_name} needs review"
            )
    lines.append("}")
    required = value.get("required_proficiencies", [])
    if isinstance(required, list) and all(safe_platform_id(entry) for entry in required):
        lines.extend(f"definition:requires({lua_quote(entry)})" for entry in required)
    elif "required_proficiencies" in value:
        result.todos.append(
            f"{source.location}: proficiency {proficiency_id} prerequisites need review"
        )
    bonuses = value.get("bonuses", {})
    if isinstance(bonuses, dict):
        for bonus_category, entries in bonuses.items():
            if not isinstance(bonus_category, str) or not isinstance(entries, list):
                result.todos.append(
                    f"{source.location}: proficiency {proficiency_id} bonuses need review"
                )
                continue
            for entry in entries:
                if isinstance(entry, dict) and entry.get("type") in {"strength", "dexterity", "intelligence", "perception", "stamina"} and isinstance(entry.get("value"), (int, float)) and not isinstance(entry["value"], bool):
                    lines.append(
                        f"definition:bonus({lua_quote(bonus_category)}, {lua_quote(entry['type'])}, {entry['value']!r})"
                    )
                else:
                    result.todos.append(
                        f"{source.location}: proficiency {proficiency_id} bonus entry needs review"
                    )
    elif "bonuses" in value:
        result.todos.append(f"{source.location}: proficiency {proficiency_id} bonuses need review")
    return finish_catalog(
        source,
        result,
        "proficiency",
        proficiency_id,
        lines,
        {
            "type", "id", "name", "description", "category", "time_to_learn",
            "default_time_multiplier", "default_skill_penalty", "default_weakpoint_bonus",
            "default_weakpoint_penalty", "can_learn", "ignore_focus", "teachable",
            "required_proficiencies", "bonuses",
        },
        todo_count,
    )


def render_weapon_category(source: SourceObject, result: MigrationResult) -> str | None:
    value = source.value
    category_id = value.get("id")
    if not safe_platform_id(category_id):
        result.partial.append(f"{source.location}: weapon category <invalid id>")
        result.todos.append(f"{source.location}: weapon category needs a stable native id")
        return None
    todo_count = len(result.todos)
    lines = [
        "local definition = content.WeaponCategory {",
        f"    id = {lua_quote(category_id)},",
        f"    name = {lua_quote(display_text(value.get('name'), category_id))},",
        "}",
    ]
    proficiencies = value.get("proficiencies", [])
    if isinstance(proficiencies, list) and all(safe_platform_id(entry) for entry in proficiencies):
        lines.extend(f"definition:proficiency({lua_quote(entry)})" for entry in proficiencies)
    elif "proficiencies" in value:
        result.todos.append(
            f"{source.location}: weapon category {category_id} proficiencies need review"
        )
    return finish_catalog(
        source,
        result,
        "weapon category",
        category_id,
        lines,
        {"type", "id", "name", "proficiencies"},
        todo_count,
    )


def lua_scalar_literal(value: Any) -> str | None:
    if isinstance(value, bool):
        return "true" if value else "false"
    if isinstance(value, str):
        return lua_quote(value)
    if isinstance(value, int):
        return str(value)
    if isinstance(value, float) and math.isfinite(value):
        return lua_number(value)
    return None


def render_eoc_value_expression(value: Any, missing_default: str) -> str | None:
    literal = lua_scalar_literal(value)
    if literal is not None:
        return literal
    if not isinstance(value, dict) or len(value) != 1:
        return None
    key, name = next(iter(value.items()))
    if (
        key not in {"context_val", "u_val"} or
        not isinstance(name, str) or
        not name or len(name) > 1024 or "\0" in name
    ):
        return None
    quoted = lua_quote(name)
    if key == "context_val":
        return f"context.data[{quoted}]"
    return f"ccb.state.character.get({quoted}, {missing_default})"


def render_eoc_string_expression(value: Any) -> str | None:
    if isinstance(value, str):
        return lua_quote(value)
    if isinstance(value, bool) or not isinstance(value, dict):
        return None
    rendered = render_eoc_value_expression(value, lua_quote(""))
    return None if rendered is None else f"tostring(({rendered}) or {lua_quote('')})"


def render_eoc_numeric_expression(value: Any, missing_default: str) -> str | None:
    if isinstance(value, bool) or isinstance(value, str):
        return None
    if isinstance(value, (int, float)):
        return lua_scalar_literal(value)
    rendered = render_eoc_value_expression(value, missing_default)
    return None if rendered is None else f"tonumber(({rendered}) or {missing_default})"


def render_mutation_id_expression(value: Any) -> str | None:
    """Render a checked mutation GameId from a literal or proven variable."""
    if safe_platform_id(value):
        return (
            'services.types.id("mutation", '
            f"{lua_quote(value)})"
        )
    if not isinstance(value, dict):
        return None
    rendered = render_eoc_string_expression(value)
    if rendered is None:
        return None
    return f'services.types.id("mutation", {rendered})'


def render_mutation_category_expression(value: Any) -> str | None:
    """Render a category GameId, using nil for the native ANY sentinel."""
    if value is None:
        return "nil"
    if safe_platform_id(value):
        if value == "ANY":
            return "nil"
        return (
            'services.types.id("mutation_category", '
            f"{lua_quote(value)})"
        )
    if not isinstance(value, dict):
        return None
    rendered = render_eoc_string_expression(value)
    if rendered is None:
        return None
    return f'services.types.id("mutation_category", {rendered})'


def render_mutation_chance_expression(value: Any) -> str | None:
    """Render the integral one-in chance accepted by Character::mutate."""
    if isinstance(value, int) and not isinstance(value, bool):
        if 0 <= value <= MAX_MUTATION_RANDOM_CHANCE:
            return str(value)
        return None
    if isinstance(value, float) and math.isfinite(value):
        if value.is_integer() and 0 <= value <= MAX_MUTATION_RANDOM_CHANCE:
            return str(int(value))
        return None
    if not isinstance(value, dict):
        return None
    rendered = render_eoc_numeric_expression(value, "0")
    return rendered


def render_static_mutation_effect(
    effect: dict[str, Any],
    key: str,
    target_expression: str | None,
) -> list[str] | None:
    """Render one bounded u_/npc_ mutation effect through typed services."""
    if target_expression is None or key not in effect:
        return None
    if key in {"u_mutate", "npc_mutate"}:
        if set(effect) - {key, "use_vitamins"}:
            return None
        chance = render_mutation_chance_expression(effect[key])
        if chance is None:
            return None
        use_vitamins = effect.get("use_vitamins", True)
        if not isinstance(use_vitamins, bool):
            return None
        return [
            "    services.mutations.mutate(",
            f"        {target_expression}, {chance}, {lua_boolean(use_vitamins)})",
        ]
    if key in {"u_mutate_category", "npc_mutate_category"}:
        if set(effect) - {key, "use_vitamins", "true_random"}:
            return None
        category = render_mutation_category_expression(effect[key])
        if category is None:
            return None
        use_vitamins = effect.get("use_vitamins", True)
        true_random = effect.get("true_random", False)
        if not isinstance(use_vitamins, bool) or not isinstance(true_random, bool):
            return None
        return [
            "    services.mutations.mutate_category(",
            f"        {target_expression}, {category}, "
            f"{lua_boolean(use_vitamins)}, {lua_boolean(true_random)})",
        ]
    if key in {"u_mutate_towards", "npc_mutate_towards"}:
        if set(effect) - {key, "category", "use_vitamins"}:
            return None
        mutation = render_mutation_id_expression(effect[key])
        category = render_mutation_category_expression(effect.get("category"))
        if mutation is None or category is None:
            return None
        use_vitamins = effect.get("use_vitamins", True)
        if not isinstance(use_vitamins, bool):
            return None
        return [
            "    services.mutations.mutate_towards(",
            f"        {target_expression}, {mutation}, {category}, "
            f"{lua_boolean(use_vitamins)})",
        ]
    return None


def render_static_character_effect(
    effect: dict[str, Any],
    key: str,
    target_expression: str | None,
) -> list[str] | None:
    """Render one static u_/npc_add_effect without preserving EOC syntax."""
    if target_expression is None or not safe_platform_id(effect.get(key)):
        return None
    allowed_keys = {
        key, "duration", "intensity", "target_part", "force",
    }
    if set(effect) - allowed_keys:
        return None
    raw_duration = effect.get("duration")
    permanent = raw_duration == "PERMANENT"
    duration = 1 if permanent else parse_turns(raw_duration)
    if duration is None or not 1 <= duration <= MAX_EFFECT_DURATION_TURNS:
        return None
    intensity = effect.get("intensity", 0)
    if (
        not isinstance(intensity, int) or isinstance(intensity, bool) or
        not 0 <= intensity <= NATIVE_MAX_EFFECT_INTENSITY
    ):
        return None
    target_part = effect.get("target_part")
    if target_part is not None and not safe_platform_id(target_part):
        return None
    force = effect.get("force", False)
    if not isinstance(force, bool):
        return None
    options: list[str] = []
    if target_part is not None:
        options.append(
            "body_part = services.types.id(\"body_part\", "
            f"{lua_quote(target_part)})"
        )
    if permanent:
        options.append("permanent = true")
    if intensity:
        options.append(f"intensity = {intensity}")
    if force:
        options.append("force = true")
    result = [
        "    services.effects.add(",
        f"        {target_expression},",
        "        services.types.id(\"effect\", "
        f"{lua_quote(effect[key])}),",
    ]
    duration_literal = (
        f"services.time.duration({duration}, \"turn\")"
    )
    if options:
        result.append(f"        {duration_literal}, {{ {', '.join(options)} }})")
    else:
        result.append(f"        {duration_literal})")
    return result


def render_static_character_morale(
    effect: dict[str, Any],
    key: str,
    target_expression: str | None,
) -> list[str] | None:
    """Render one static u_/npc_add_morale without preserving EOC syntax."""
    if target_expression is None or not safe_platform_id(effect.get(key)):
        return None
    allowed_keys = {
        key, "bonus", "max_bonus", "duration", "decay_start", "capped",
    }
    if set(effect) - allowed_keys:
        return None
    bonus = effect.get("bonus")
    max_bonus = effect.get("max_bonus")
    if (
        not isinstance(bonus, int) or isinstance(bonus, bool) or
        not NATIVE_INT_MIN <= bonus <= NATIVE_INT_MAX or
        not isinstance(max_bonus, int) or isinstance(max_bonus, bool) or
        not NATIVE_INT_MIN <= max_bonus <= NATIVE_INT_MAX
    ):
        return None
    options: list[str] = []
    for name in ("duration", "decay_start"):
        if name in effect:
            duration = parse_turns(effect[name])
            if duration is None or not 0 <= duration <= MAX_EFFECT_DURATION_TURNS:
                return None
            options.append(
                f"{name} = services.time.duration({duration}, \"turn\")"
            )
    capped = effect.get("capped", False)
    if not isinstance(capped, bool):
        return None
    if capped:
        options.append("capped = true")
    result = [
        "    services.morale.add(",
        f"        {target_expression},",
        "        services.types.id(\"morale\", "
        f"{lua_quote(effect[key])}),",
        f"        {bonus}, {max_bonus}",
    ]
    if options:
        result[-1] += ", { " + ", ".join(options) + " })"
    else:
        result[-1] += ")"
    return result


def _static_character_variable_descriptor(
    value: Any,
) -> tuple[str, str] | None:
    """Return an actor-variable descriptor for a bounded u_/npc_ var."""
    if not isinstance(value, dict) or len(value) != 1:
        return None
    key, name = next(iter(value.items()))
    if key not in {"u_val", "npc_val"}:
        return None
    if not bounded_utf8_string(name, 256):
        return None
    if any(ord(character) < 0x20 or ord(character) == 0x7F for character in name):
        return None
    return ("u" if key == "u_val" else "npc", name)


def render_static_dimension_name(
    effect: dict[str, Any],
    avatar_actor_proven: bool,
    npc_actor_proven: bool,
) -> list[str] | None:
    """Store the active dimension id in a proven Character variable."""
    if set(effect) != {"dimension_name"}:
        return None
    target = _static_character_variable_descriptor(effect["dimension_name"])
    if target is None:
        return None
    if target[0] == "u":
        if not avatar_actor_proven:
            return None
    elif not npc_actor_proven:
        return None
    return [
        "    services.variables.set(",
        f"        actor, {lua_quote(target[1])}, "
        "services.gameplay.environment.dimension())",
    ]


def render_static_mirror_coordinates(
    effect: dict[str, Any],
    avatar_actor_proven: bool,
    npc_actor_proven: bool,
) -> list[str] | None:
    """Mirror two stored typed coordinates around a third Character variable."""
    if set(effect) != {"mirror_coordinates", "center_var", "relative_var"}:
        return None
    output = _static_character_variable_descriptor(effect["mirror_coordinates"])
    center = _static_character_variable_descriptor(effect["center_var"])
    relative = _static_character_variable_descriptor(effect["relative_var"])
    if output is None or center is None or relative is None:
        return None
    if not (output[0] == center[0] == relative[0]):
        return None
    if output[0] == "u":
        if not avatar_actor_proven:
            return None
    elif not npc_actor_proven:
        return None
    return [
        "    local center_result = services.variables.get(",
        f"        actor, {lua_quote(center[1])})",
        "    local relative_result = services.variables.get(",
        f"        actor, {lua_quote(relative[1])})",
        "    if center_result.exists and relative_result.exists then",
        "        local center = service_value(center_result)",
        "        local relative = service_value(relative_result)",
        "        services.variables.set(",
        f"            actor, {lua_quote(output[1])}, "
        "center:scale_by(2):subtract(relative))",
        "    end",
    ]


def render_static_closest_city_effect(
    effect: dict[str, Any],
    avatar_actor_proven: bool,
    npc_actor_proven: bool,
) -> list[str] | None:
    """Render closest_city for a proven actor-owned location variable.

    The legacy effect reads and writes the same var_info and also publishes
    city_name/city_size in dialogue context.  Keep dynamic/global/context
    var_info shapes fail-closed until the Lua runtime has an equivalent
    writable context-variable contract.
    """
    if "closest_city" not in effect:
        return None
    if set(effect) - {"closest_city", "known"}:
        return None
    target = _static_character_variable_descriptor(effect["closest_city"])
    if target is None:
        return None
    if target[0] == "u" and not avatar_actor_proven:
        return None
    if target[0] == "npc" and not npc_actor_proven:
        return None
    known = effect.get("known", True)
    if not isinstance(known, bool):
        return None
    return [
        "    local location = service_value(services.variables.get(",
        f"        actor, {lua_quote(target[1])}))",
        "    if location.exists then",
        "        local city = services.overmap.closest_city(",
        f"            location.value, {'true' if known else 'false'})",
        "        if city.ok then",
        "            services.variables.set(",
        f"                actor, {lua_quote(target[1])}, city.value.position)",
        "            context.data[\"city_name\"] = city.value.name",
        "            context.data[\"city_size\"] = city.value.size",
        "        end",
        "    end",
    ]


def render_static_teleport_effect(
    effect: dict[str, Any],
    avatar_actor_proven: bool,
    npc_actor_proven: bool,
) -> list[str] | None:
    """Render a proven Character teleport through the typed relocation API.

    The legacy effect accepts arbitrary var_info, item/vehicle/zone talkers,
    and success/failure message variables.  Only Character actors with a
    same-scope ``u_val``/``npc_val`` or typed ``context_val`` destination are
    safe to emit.  Everything else remains an explicit migration TODO.
    """
    keys = [key for key in ("u_teleport", "npc_teleport") if key in effect]
    if len(keys) != 1:
        return None
    key = keys[0]
    if set(effect) - {key, "force", "force_safe"}:
        return None
    if key == "u_teleport":
        if not avatar_actor_proven:
            return None
        actor_expression = "actor"
    else:
        if not npc_actor_proven:
            return None
        actor_expression = "actor"

    option_parts: list[str] = []
    for option in ("force", "force_safe"):
        if option in effect:
            value = effect[option]
            if not isinstance(value, bool):
                return None
            option_parts.append(f"{option} = {'true' if value else 'false'}")
    options_expression = (
        "{ " + ", ".join(option_parts) + " }"
        if option_parts else None
    )

    target = effect[key]
    destination_lines: list[str]
    if isinstance(target, dict) and len(target) == 1:
        target_key, target_name = next(iter(target.items()))
        if target_key == "context_val":
            if not bounded_utf8_string(target_name, 256):
                return None
            if any(
                ord(character) < 0x20 or ord(character) == 0x7F
                for character in target_name
            ):
                return None
            destination_lines = [
                "    local destination = context.data["
                f"{lua_quote(target_name)}]",
                "    if destination ~= nil then",
            ]
        elif target_key in {"u_val", "npc_val"}:
            descriptor = _static_character_variable_descriptor(target)
            if descriptor is None:
                return None
            scope, variable = descriptor
            if scope == "u":
                variable_handle = "services.characters.avatar()"
            else:
                if not npc_actor_proven:
                    return None
                variable_handle = "actor"
            destination_lines = [
                "    local destination = service_value(services.variables.get(",
                f"        {variable_handle}, {lua_quote(variable)}))",
                "    if destination.exists then",
                "        destination = destination.value",
            ]
        else:
            return None
    else:
        return None

    lines = destination_lines
    call = (
        "        services.relocation.creature_at(\n"
        f"            {actor_expression}, destination"
    )
    if options_expression is not None:
        call += ", " + options_expression
    call += ")"
    lines.append(call)
    lines.append("    end")
    return lines


def render_static_dimension_travel_effect(
    effect: dict[str, Any],
    avatar_actor_proven: bool,
) -> list[str] | None:
    """Render literal avatar dimension travel through the native workflow.

    Dimension travel is a world swap, so dynamic targets, message templates,
    target-location variables, and unproven actors stay fail-closed.  The
    bounded service mirrors the native radius/filter/vehicle options and
    leaves ordinary Lua responsible for any follow-up state.
    """
    if not avatar_actor_proven or "u_travel_to_dimension" not in effect:
        return None
    target = effect.get("u_travel_to_dimension")
    if not safe_platform_id(target):
        return None
    allowed = {
        "u_travel_to_dimension", "npc_travel_radius", "npc_travel_filter",
        "item_travel_radius", "take_vehicle",
    }
    if set(effect) - allowed:
        return None
    npc_radius = effect.get("npc_travel_radius", 0)
    item_radius = effect.get("item_travel_radius", -1)
    npc_filter = effect.get("npc_travel_filter", "all")
    take_vehicle = effect.get("take_vehicle", False)
    if (
        not isinstance(npc_radius, int) or isinstance(npc_radius, bool) or
        not 0 <= npc_radius <= 60 or
        not isinstance(item_radius, int) or isinstance(item_radius, bool) or
        not -1 <= item_radius <= 60 or
        not isinstance(npc_filter, str) or
        npc_filter not in {"all", "follower", "enemy", "none"} or
        not isinstance(take_vehicle, bool)
    ):
        return None
    option_parts: list[str] = []
    if npc_radius != 0:
        option_parts.append(f"npc_travel_radius = {npc_radius}")
    if npc_filter != "all":
        option_parts.append(f"npc_travel_filter = {lua_quote(npc_filter)}")
    if item_radius != -1:
        option_parts.append(f"item_travel_radius = {item_radius}")
    if take_vehicle:
        option_parts.append("take_vehicle = true")
    if option_parts:
        return [
            "    service_value(services.relocation.travel_to_dimension(",
            f"        {lua_quote(target)}, {{ " + ", ".join(option_parts) + " }))",
        ]
    return [
        "    service_value(services.relocation.travel_to_dimension(",
        f"        {lua_quote(target)}))",
    ]


def render_static_transform_line_effect(
    effect: dict[str, Any],
    avatar_actor_proven: bool,
    npc_actor_proven: bool,
) -> list[str] | None:
    """Render a bounded transform_line over two same-actor coordinates."""
    if set(effect) != {"transform_line", "first", "second"}:
        return None
    transform = effect.get("transform_line")
    if not safe_platform_id(transform):
        return None
    first = _static_character_variable_descriptor(effect.get("first"))
    second = _static_character_variable_descriptor(effect.get("second"))
    if first is None or second is None or first[0] != second[0]:
        return None
    if first[0] == "u" and not avatar_actor_proven:
        return None
    if first[0] == "npc" and not npc_actor_proven:
        return None
    return [
        "    local first = service_value(services.variables.get(",
        f"        actor, {lua_quote(first[1])}))",
        "    local second = service_value(services.variables.get(",
        f"        actor, {lua_quote(second[1])}))",
        "    if first.exists and second.exists then",
        "        services.world.transform_line(",
        "            first.value, second.value, services.types.id(\"ter_furn_transform\", "
        f"{lua_quote(transform)}))",
        "    end",
    ]


def _combat_actor_expression(
    key: str,
    avatar_actor_proven: bool,
    npc_event_character_actor_proven: bool,
) -> str | None:
    """Return a proven Character expression for one combat selector."""
    if key.startswith("npc_"):
        return "actor" if npc_event_character_actor_proven else None
    if avatar_actor_proven:
        return "actor"
    if npc_event_character_actor_proven:
        return "services.characters.avatar()"
    return None


def _combat_literal_number(
    value: Any,
    minimum: float,
    maximum: float,
    *,
    integer: bool = False,
) -> int | float | None:
    literal = finite_number_literal(value)
    if literal is None:
        return None
    numeric = float(literal)
    if numeric < minimum or numeric > maximum:
        return None
    if integer and numeric != math.trunc(numeric):
        return None
    return int(literal) if integer else literal


def _combat_literal_bool(value: Any, default: bool) -> bool | None:
    if value is None:
        return default
    return value if isinstance(value, bool) else None


def render_static_combat_attack(
    effect: dict[str, Any],
    key: str,
    avatar_actor_proven: bool,
    npc_event_character_actor_proven: bool,
) -> list[str] | None:
    if key not in effect:
        return None
    attacker: str | None
    target: str | None
    if key == "npc_attack":
        attacker = _combat_actor_expression(
            key, avatar_actor_proven, npc_event_character_actor_proven
        )
        target = (
            "services.characters.avatar()"
            if npc_event_character_actor_proven else None
        )
    elif key == "u_attack":
        if npc_event_character_actor_proven:
            attacker = "services.characters.avatar()"
            target = "actor"
        else:
            # A game-start EOC proves the avatar, but does not prove a
            # dialogue target.  Do not invent one from ambient context.
            attacker = None
            target = None
    else:
        return None
    if attacker is None or target is None:
        return None
    if set(effect) - {
        key, "allow_special", "allow_unarmed", "forced_movecost"
    }:
        return None
    technique = effect[key]
    if not isinstance(technique, str) or len(technique.encode("utf-8")) > PLATFORM_ID_MAX_BYTES:
        return None
    if technique and not safe_platform_id(technique):
        return None
    allow_special = _combat_literal_bool(effect.get("allow_special"), True)
    allow_unarmed = _combat_literal_bool(effect.get("allow_unarmed"), True)
    forced_movecost = _combat_literal_number(
        effect.get("forced_movecost", -1), -1, 1000000, integer=True
    )
    if allow_special is None or allow_unarmed is None or forced_movecost is None:
        return None
    options: list[str] = []
    if not allow_special:
        options.append("allow_special = false")
    if not allow_unarmed:
        options.append("allow_unarmed = false")
    if forced_movecost != -1:
        options.append(f"forced_movecost = {forced_movecost}")
    option_expression = "nil" if not options else "{ " + ", ".join(options) + " }"
    return [
        "    services.characters.attack(",
        f"        {attacker}, {target}, {lua_quote(technique)}, {option_expression})",
    ]


def render_static_combat_ranged_attack(
    effect: Any,
    key: str,
    avatar_actor_proven: bool,
    npc_event_character_actor_proven: bool,
) -> list[str] | None:
    if effect != key or key not in {"u_ranged_attack", "npc_ranged_attack"}:
        return None
    if key == "npc_ranged_attack":
        if not npc_event_character_actor_proven:
            return None
        return [
            "    services.characters.ranged_attack(",
            "        actor, services.characters.avatar())",
        ]
    if npc_event_character_actor_proven:
        return [
            "    services.characters.ranged_attack(",
            "        services.characters.avatar(), actor)",
        ]
    # game_start proves only the avatar, not a target.
    return None


def render_static_combat_knockback(
    effect: dict[str, Any],
    key: str,
    avatar_actor_proven: bool,
    npc_event_character_actor_proven: bool,
) -> list[str] | None:
    if key not in effect or set(effect) - {
        key, "stun", "dam_mult", "target_var", "direction_var"
    }:
        return None
    # Variable-backed target/direction values are deliberately not rendered.
    if "target_var" in effect or "direction_var" in effect:
        return None
    actor = _combat_actor_expression(
        key, avatar_actor_proven, npc_event_character_actor_proven
    )
    if actor is None:
        return None
    force = _combat_literal_number(
        effect[key], -1000, 1000, integer=True
    )
    stun = _combat_literal_number(
        effect.get("stun", 0), -1000, 1000, integer=True
    )
    dam_mult = _combat_literal_number(
        effect.get("dam_mult", 0), -1000, 1000, integer=True
    )
    if force is None or stun is None or dam_mult is None:
        return None
    options: list[str] = []
    if force != 0:
        options.append(f"force = {force}")
    if stun != 0:
        options.append(f"stun = {stun}")
    if dam_mult != 0:
        options.append(f"dam_mult = {dam_mult}")
    if not options:
        return [f"    services.characters.knockback({actor})"]
    return [
        f"    services.characters.knockback({actor}, {{ " +
        ", ".join(options) + " })",
    ]


def render_static_combat_explosion(
    effect: dict[str, Any],
    key: str,
    avatar_actor_proven: bool,
    npc_event_character_actor_proven: bool,
) -> list[str] | None:
    if key not in effect or not isinstance(effect[key], dict):
        return None
    actor = _combat_actor_expression(
        key, avatar_actor_proven, npc_event_character_actor_proven
    )
    if actor is None or "target_var" in effect:
        return None
    allowed_outer = {
        key, "target_var", "emp_blast", "scrambler_blast", "flashbang",
        "flashbang_avatar_is_immune", "flashbang_radius",
    }
    if set(effect) - allowed_outer:
        return None
    explosion = effect[key]
    allowed_inner = {
        "power", "distance_factor", "max_noise", "fire", "shrapnel"
    }
    if set(explosion) - allowed_inner:
        return None
    power = _combat_literal_number(
        explosion.get("power", 0), -1000000, 1000000
    )
    distance_factor = _combat_literal_number(
        explosion.get("distance_factor", 0.75), 0, 1000
    )
    max_noise = _combat_literal_number(
        explosion.get("max_noise", 90000000), 0, 1000000000, integer=True
    )
    fire = _combat_literal_bool(explosion.get("fire"), False)
    if power is None or distance_factor is None or max_noise is None or fire is None:
        return None
    options: list[str] = []
    if power != 0:
        options.append(f"power = {lua_number(power)}")
    if distance_factor != 0.75:
        options.append(f"distance_factor = {lua_number(distance_factor)}")
    if max_noise != 90000000:
        options.append(f"max_noise = {max_noise}")
    if fire:
        options.append("fire = true")
    if "shrapnel" in explosion:
        shrapnel = explosion["shrapnel"]
        if isinstance(shrapnel, (int, float)) and not isinstance(shrapnel, bool):
            casing_mass = _combat_literal_number(
                shrapnel, 0, 1000000000, integer=True
            )
            if casing_mass is None:
                return None
            options.append(f"shrapnel = {{ casing_mass = {casing_mass} }}")
        elif isinstance(shrapnel, dict):
            if set(shrapnel) - {"casing_mass", "fragment_mass", "recovery", "drop"}:
                return None
            casing_mass = _combat_literal_number(
                shrapnel.get("casing_mass"), 0, 1000000000, integer=True
            )
            fragment_mass = _combat_literal_number(
                shrapnel.get("fragment_mass", 0.005), 0, 1000
            )
            recovery = _combat_literal_number(
                shrapnel.get("recovery", 0), 0, 100, integer=True
            )
            drop = shrapnel.get("drop", "null")
            if (
                casing_mass is None or fragment_mass is None or recovery is None or
                not bounded_utf8_string(drop, PLATFORM_ID_MAX_BYTES, allow_empty=False)
            ):
                return None
            shrapnel_options = [f"casing_mass = {casing_mass}"]
            if fragment_mass != 0.005:
                shrapnel_options.append(f"fragment_mass = {lua_number(fragment_mass)}")
            if recovery != 0:
                shrapnel_options.append(f"recovery = {recovery}")
            if drop != "null":
                shrapnel_options.append(f"drop = {lua_quote(drop)}")
            options.append(
                "shrapnel = { " + ", ".join(shrapnel_options) + " }"
            )
        else:
            return None
    for name in ("emp_blast", "scrambler_blast", "flashbang"):
        value = _combat_literal_bool(effect.get(name), False)
        if value is None:
            return None
        if value:
            options.append(f"{name} = true")
    immune = _combat_literal_bool(
        effect.get("flashbang_avatar_is_immune"), False
    )
    radius = _combat_literal_number(
        effect.get("flashbang_radius", 8), 0, 1000, integer=True
    )
    if immune is None or radius is None:
        return None
    if immune:
        options.append("flashbang_avatar_is_immune = true")
    if radius != 8:
        options.append(f"flashbang_radius = {radius}")
    option_expression = "nil" if not options else "{ " + ", ".join(options) + " }"
    return [
        f"    services.characters.explosion({actor}, {option_expression})",
    ]


def render_static_combat_emit(
    effect: dict[str, Any],
    key: str,
    avatar_actor_proven: bool,
    npc_event_character_actor_proven: bool,
) -> list[str] | None:
    if key not in effect or "target_var" in effect:
        return None
    if set(effect) - {key, "chance_mult", "target_var"}:
        return None
    actor = _combat_actor_expression(
        key, avatar_actor_proven, npc_event_character_actor_proven
    )
    emission = effect[key]
    if (
        actor is None or not bounded_utf8_string(
            emission, PLATFORM_ID_MAX_BYTES, allow_empty=False
        )
    ):
        return None
    chance = _combat_literal_number(
        effect.get("chance_mult", 1), 0, 1000
    )
    if chance is None:
        return None
    return [
        f"    services.characters.emit({actor}, {lua_quote(emission)}, "
        f"{lua_number(chance)})",
    ]


def render_static_combat_cast_spell(
    effect: dict[str, Any],
    key: str,
    avatar_actor_proven: bool,
    npc_event_character_actor_proven: bool,
) -> list[str] | None:
    if key not in effect or not isinstance(effect[key], dict):
        return None
    actor = _combat_actor_expression(
        key, avatar_actor_proven, npc_event_character_actor_proven
    )
    if actor is None:
        return None
    if set(effect) - {key, "targeted", "loc", "true_eocs", "false_eocs"}:
        return None
    if any(name in effect for name in ("loc", "true_eocs", "false_eocs")):
        return None
    targeted = _combat_literal_bool(effect.get("targeted"), False)
    if targeted is None or targeted:
        return None
    spell = effect[key]
    allowed_spell = {
        "id", "hit_self", "min_level", "max_level", "message", "npc_message"
    }
    if set(spell) - allowed_spell:
        return None
    spell_id = spell.get("id")
    if not bounded_platform_id(spell_id):
        return None
    hit_self = _combat_literal_bool(spell.get("hit_self"), False)
    min_level = _combat_literal_number(
        spell.get("min_level", 0), 0, 1000, integer=True
    )
    max_level = _combat_literal_number(
        spell.get("max_level", -1), -1, 1000, integer=True
    )
    if hit_self is None or min_level is None or max_level is None:
        return None
    if max_level >= 0 and max_level < min_level:
        return None
    options: list[str] = []
    if hit_self:
        options.append("hit_self = true")
    if min_level != 0:
        options.append(f"min_level = {min_level}")
    if max_level != -1:
        options.append(f"max_level = {max_level}")
    for name in ("message", "npc_message"):
        if name in spell:
            message = spell[name]
            if not bounded_utf8_string(message, 4096, allow_empty=True):
                return None
            options.append(f"{name} = {lua_quote(message)}")
    option_expression = "nil" if not options else "{ " + ", ".join(options) + " }"
    return [
        f"    services.characters.cast_spell({actor}, "
        f"services.types.id(\"spell\", {lua_quote(spell_id)}), "
        f"{option_expression})",
    ]


def render_static_combat_die(
    effect: Any,
    key: str,
    avatar_actor_proven: bool,
    npc_event_character_actor_proven: bool,
) -> list[str] | None:
    actor = _combat_actor_expression(
        key, avatar_actor_proven, npc_event_character_actor_proven
    )
    if actor is None:
        return None
    if effect == key:
        return [f"    services.characters.die({actor})"]
    if not isinstance(effect, dict) or key not in effect:
        return None
    if set(effect) - {key, "remove_corpse", "supress_message"}:
        return None
    remove_corpse = _combat_literal_bool(effect.get("remove_corpse"), False)
    suppress = _combat_literal_bool(effect.get("supress_message"), False)
    if (
        ("remove_corpse" in effect and remove_corpse is None) or
        ("supress_message" in effect and suppress is None)
    ):
        return None
    options: list[str] = []
    if "remove_corpse" in effect:
        options.append(f"remove_corpse = {lua_boolean(remove_corpse)}")
    if "supress_message" in effect:
        options.append(f"suppress_message = {lua_boolean(suppress)}")
    if not options:
        return [f"    services.characters.die({actor})"]
    return [
        f"    services.characters.die({actor}, {{ " + ", ".join(options) + " })",
    ]


def render_static_combat_prevent_death(
    effect: Any,
    key: str,
    avatar_actor_proven: bool,
    npc_event_character_actor_proven: bool,
) -> list[str] | None:
    if effect != key:
        return None
    actor = _combat_actor_expression(
        key, avatar_actor_proven, npc_event_character_actor_proven
    )
    return None if actor is None else [
        f"    services.characters.prevent_death({actor})"
    ]


def render_static_character_variable(
    effect: dict[str, Any],
    key: str,
    target_expression: str | None,
) -> list[str] | None:
    """Render a literal u_/npc_add_var with native string semantics."""
    if target_expression is None or not bounded_utf8_string(effect.get(key), 256):
        return None
    if any(
        ord(character) < 0x20 or ord(character) == 0x7F
        for character in effect[key]
    ):
        return None
    allowed = {key, "value", "possible_values", "time"}
    if set(effect) - allowed:
        return None
    time_value = effect.get("time", False)
    if not isinstance(time_value, bool):
        return None
    options = [name for name in ("value", "possible_values") if name in effect]
    if time_value:
        if options:
            return None
        value_expression = "tostring(services.turn())"
        return [
            "    services.variables.set(",
            f"        {target_expression}, {lua_quote(effect[key])}, "
            f"{value_expression})",
        ]
    if len(options) != 1:
        return None
    if "value" in effect:
        value = effect["value"]
        if not bounded_utf8_string(value, 8192, allow_empty=True):
            return None
        value_expression = lua_quote(value)
        return [
            "    services.variables.set(",
            f"        {target_expression}, {lua_quote(effect[key])}, "
            f"{value_expression})",
        ]
    values = effect["possible_values"]
    if (
        not isinstance(values, list) or not values or len(values) > 64 or
        not all(
            bounded_utf8_string(value, 8192, allow_empty=True) for value in values
        )
    ):
        return None
    rendered_values = ", ".join(lua_quote(value) for value in values)
    return [
        f"    local values = {{ {rendered_values} }}",
        "    services.variables.set(",
        f"        {target_expression}, {lua_quote(effect[key])}, "
        "values[services.random.int(1, #values)])",
    ]


def render_static_character_wound(
    effect: dict[str, Any],
    key: str,
    target_expression: str | None,
    remove: bool,
) -> list[str] | None:
    """Render literal body-part wound changes through the typed wound service."""
    if target_expression is None or not safe_platform_id(effect.get(key)):
        return None
    if set(effect) - {key, "wound_id"}:
        return None
    body_part = effect[key]
    wound_ids = effect.get("wound_id")
    if remove:
        if (
            not isinstance(wound_ids, list) or not wound_ids or len(wound_ids) > 64 or
            not all(safe_platform_id(value) for value in wound_ids)
        ):
            return None
    elif not safe_platform_id(wound_ids):
        return None
    values = wound_ids if remove else [wound_ids]
    lines: list[str] = []
    for wound_id in values:
        service_name = "remove" if remove else "add"
        lines.extend(
            [
                f"    services.wounds.{service_name}(",
                f"        {target_expression}, services.types.id(\"body_part\", "
                f"{lua_quote(body_part)}),",
                f"        services.types.id(\"wound\", {lua_quote(wound_id)}))",
            ]
        )
    return lines


def render_static_character_pick_bodypart(
    effect: dict[str, Any],
    key: str,
    avatar_actor_proven: bool,
    npc_actor_proven: bool,
) -> list[str] | None:
    """Render the non-interactive, literal body-part picker slice.

    The native effect writes a selected body-part id to an actor variable.  A
    Platform callback cannot silently open the legacy avatar picker, so avatar
    shapes require explicit ``pick_random=true``; NPC shapes already select
    randomly in the native handler.  Only the wounded filter is lowered here;
    flag/type filters remain explicit TODOs until their definition metadata is
    exposed as a typed service.
    """
    if key not in {"u_pick_bodypart", "npc_pick_bodypart"}:
        return None
    target = _static_character_variable_descriptor(effect.get(key))
    if target is None:
        return None
    expected_scope = "u" if key == "u_pick_bodypart" else "npc"
    if target[0] != expected_scope:
        return None
    if target[0] == "u" and not avatar_actor_proven:
        return None
    if target[0] == "npc" and not npc_actor_proven:
        return None
    allowed = {key, "pick_random", "wounded"}
    if set(effect) - allowed:
        return None
    pick_random = effect.get("pick_random", False)
    if not isinstance(pick_random, bool):
        return None
    if target[0] == "u" and not pick_random:
        return None
    wounded = effect.get("wounded")
    if wounded is not None and not isinstance(wounded, bool):
        return None
    options = ""
    if wounded is not None:
        options = "{ wounded = " + ("true" if wounded else "false") + " }"
    call = (
        "service_value(services.characters.pick_body_part(actor, " +
        (options if options else "{}") + "))"
    )
    return [
        f"    local picked = {call}",
        "    if picked ~= nil then",
        f"        services.variables.set(actor, {lua_quote(target[1])}, picked.body_part.value)",
        "    end",
    ]


def render_static_character_activity(
    effect: dict[str, Any],
    key: str,
    target_expression: str | None,
) -> list[str] | None:
    """Render a plain time-based u_/npc_assign_activity shape."""
    if target_expression is None or not safe_platform_id(effect.get(key)):
        return None
    if set(effect) != {key, "duration"}:
        return None
    if effect[key] == "ACT_TARGET_PRACTICE":
        return None
    duration = parse_turns(effect.get("duration"))
    if duration is None or not 1 <= duration <= MAX_ACTIVITY_DURATION_TURNS:
        return None
    return [
        "    services.activities.assign_timed(",
        f"        {target_expression}, services.types.id(\"activity\", "
        f"{lua_quote(effect[key])}),",
        f"        services.time.duration({duration}, \"turn\"))",
    ]


def render_named_character_activity(
    target_expression: str, activity_id: str, duration_minutes: int
) -> str:
    """Render a legacy named activity with the typed duration contract."""
    return (
        f"    services.activities.assign_timed({target_expression}, "
        f"services.types.id(\"activity\", {lua_quote(activity_id)}), "
        f"services.time.duration({duration_minutes * 60}, \"turn\"))"
    )


def render_static_character_math(
    effect: dict[str, Any],
    avatar_actor_proven: bool,
    npc_actor_proven: bool,
) -> list[str] | None:
    """Render only finite numeric assignments to a proven actor variable."""
    raw = effect.get("math")
    if not isinstance(raw, list) or len(raw) != 1 or not isinstance(raw[0], str):
        return None
    match = re.fullmatch(
        r"(u|npc)_([A-Za-z_][A-Za-z0-9_]*)\s*"
        r"(\+\+|--|\+=|-=|\*=|/=|=)\s*"
        r"([+-]?(?:\d+(?:\.\d*)?|\.\d+))?",
        raw[0].strip(),
    )
    if match is None:
        return None
    prefix, name, operator, literal_text = match.groups()
    if (prefix == "u" and not avatar_actor_proven) or (
        prefix == "npc" and not npc_actor_proven
    ):
        return None
    try:
        number = float(literal_text) if literal_text is not None else 1.0
    except ValueError:
        return None
    if not math.isfinite(number) or abs(number) > 1000000000:
        return None
    if operator in {"++", "--"}:
        number = number if operator == "++" else -number
        operator = "+="
    if operator == "=" and literal_text is None:
        return None
    if operator == "/=" and number == 0:
        return None
    actor_expression = "actor"
    if operator == "=":
        return [
            "    services.variables.set(",
            f"        {actor_expression}, {lua_quote(name)}, {lua_number(number)})",
        ]
    operation = {
        "+=": "+",
        "-=": "-",
        "*=": "*",
        "/=": "/",
    }.get(operator)
    if operation is None:
        return None
    return [
        f"    local current = service_value(services.variables.get({actor_expression}, "
        f"{lua_quote(name)}))",
        "    current = tonumber(current.value) or 0",
        "    services.variables.set(",
        f"        {actor_expression}, {lua_quote(name)}, "
        f"current {operation} {lua_number(number)})",
    ]


def render_static_character_copy_var(
    effect: dict[str, Any],
    avatar_actor_proven: bool,
    npc_actor_proven: bool,
) -> list[str] | None:
    if set(effect) != {"copy_var", "target_var"}:
        return None
    source = _static_character_variable_descriptor(effect["copy_var"])
    target = _static_character_variable_descriptor(effect["target_var"])
    if source is None or target is None or source[0] != target[0]:
        return None
    if source[0] == "u" and not avatar_actor_proven:
        return None
    if source[0] == "npc" and not npc_actor_proven:
        return None
    return [
        f"    local copied = service_value(services.variables.get(actor, "
        f"{lua_quote(source[1])}))",
        "    if copied.exists then",
        "        services.variables.set(actor, "
        f"{lua_quote(target[1])}, copied.value)",
        "    else",
        f"        services.variables.remove(actor, {lua_quote(target[1])})",
        "    end",
    ]


def render_static_character_string_var(
    effect: dict[str, Any],
    avatar_actor_proven: bool,
    npc_actor_proven: bool,
) -> list[str] | None:
    if "set_string_var" not in effect or "target_var" not in effect:
        return None
    if set(effect) - {"set_string_var", "target_var"}:
        return None
    target = _static_character_variable_descriptor(effect["target_var"])
    if target is None:
        return None
    if target[0] == "u" and not avatar_actor_proven:
        return None
    if target[0] == "npc" and not npc_actor_proven:
        return None
    values = effect["set_string_var"]
    if isinstance(values, str):
        values = [values]
    if (
        not isinstance(values, list) or not values or len(values) > 64 or
        not all(bounded_utf8_string(value, 8192, allow_empty=True) for value in values)
    ):
        return None
    rendered_values = ", ".join(lua_quote(value) for value in values)
    if len(values) == 1:
        value_expression = lua_quote(values[0])
        return [
            "    services.variables.set(",
            f"        actor, {lua_quote(target[1])}, {value_expression})",
        ]
    return [
        f"    local values = {{ {rendered_values} }}",
        "    services.variables.set(",
        f"        actor, {lua_quote(target[1])}, "
        "values[services.random.int(1, #values)])",
    ]


def render_static_sample_range(
    effect: dict[str, Any],
    avatar_actor_proven: bool,
    npc_actor_proven: bool,
) -> list[str] | None:
    """Render bounded literal sample_range assignments.

    The legacy handler rounds its numeric inputs, clamps the sample count to
    both the population (when sampling without replacement) and the number of
    target variables, then writes one integer to each selected variable.  This
    slice keeps those rules explicit and uses the isolated Platform RNG rather
    than inventing a generic EOC evaluator.
    """
    if set(effect) != {"sample_range"}:
        return None
    sample = effect.get("sample_range")
    if not isinstance(sample, dict):
        return None
    if set(sample) - {"count", "min", "max", "replace", "target_vars"}:
        return None
    count_literal = finite_number_literal(sample.get("count"))
    minimum_literal = finite_number_literal(sample.get("min"))
    maximum_literal = finite_number_literal(sample.get("max"))
    if count_literal is None or minimum_literal is None or maximum_literal is None:
        return None

    def rounded_integer(value: int | float) -> int | None:
        numeric = float(value)
        rounded = (
            math.floor(numeric + 0.5)
            if numeric >= 0
            else math.ceil(numeric - 0.5)
        )
        if not math.isfinite(float(rounded)) or abs(rounded) > 1000000000:
            return None
        return int(rounded)

    count = rounded_integer(count_literal)
    minimum = rounded_integer(minimum_literal)
    maximum = rounded_integer(maximum_literal)
    if count is None or minimum is None or maximum is None:
        return None
    if count < 0 or minimum > maximum:
        return None
    replace = sample.get("replace", False)
    if not isinstance(replace, bool):
        return None
    target_vars = sample.get("target_vars")
    if not isinstance(target_vars, list) or not target_vars or len(target_vars) > 64:
        return None
    descriptors = [_static_character_variable_descriptor(value) for value in target_vars]
    if any(descriptor is None for descriptor in descriptors):
        return None

    def target_expression(scope: str) -> str | None:
        if scope == "u":
            if avatar_actor_proven:
                return "actor"
            if npc_actor_proven:
                return "services.characters.avatar()"
            return None
        if npc_actor_proven:
            return "actor"
        return None

    targets = [
        (target_expression(descriptor[0]), descriptor[1])
        for descriptor in descriptors
    ]
    if any(handle is None for handle, _ in targets):
        return None
    population = maximum - minimum + 1
    effective_count = min(count, len(targets))
    if not replace:
        effective_count = min(effective_count, population)
    rendered = [
        "    local samples = services.random.sample_integers("
        f"{minimum}, {maximum}, {effective_count}, "
        f"{'true' if replace else 'false'})"
    ]
    for index, (handle, name) in enumerate(targets[:effective_count], start=1):
        rendered.extend(
            [
                "    services.variables.set(",
                f"        {handle}, {lua_quote(name)}, samples[{index}])",
            ]
        )
    return rendered


def render_static_timed_event_reschedule(
    effect: dict[str, Any],
) -> list[str] | None:
    """Render a literal keyed timed-event reschedule through Platform time."""
    if set(effect) - {"alter_timed_events", "time_in_future"}:
        return None
    key = effect.get("alter_timed_events")
    if not bounded_utf8_string(key, PLATFORM_ID_MAX_BYTES, allow_empty=True):
        return None
    duration = parse_turns(effect.get("time_in_future", 0))
    if duration is None or not -31536000 <= duration <= 31536000:
        return None
    return [
        "    services.time.reschedule(",
        f"        {lua_quote(key)}, services.time.duration({duration}, \"turn\"))",
    ]


FACTION_RELATIONSHIP_NAMES = frozenset({
    "kill on sight",
    "watch your back",
    "share my stuff",
    "share public goods",
    "guard your stuff",
    "lets you in",
    "defends your space",
    "knows your voice",
})


def render_static_faction_trust(
    effect: dict[str, Any], target_expression: str | None
) -> list[str] | None:
    """Render the literal NPC-faction trust effect without EOC syntax."""
    if target_expression is None or set(effect) != {"u_add_faction_trust"}:
        return None
    amount = effect["u_add_faction_trust"]
    if isinstance(amount, bool):
        return None
    if isinstance(amount, float):
        if not math.isfinite(amount) or not amount.is_integer():
            return None
        amount = int(amount)
    if not isinstance(amount, int) or not -1000000 <= amount <= 1000000:
        return None
    return [
        "    services.characters.add_faction_trust(",
        f"        {target_expression}, {amount})",
    ]


def render_static_faction_relationship(
    effect: dict[str, Any], key: str,
    source_expression: str | None, target_expression: str | None,
) -> list[str] | None:
    """Render a literal NPC-to-avatar faction relationship update."""
    if (
        source_expression is None or target_expression is None or
        key not in effect or
        set(effect) - {key, "set_value_to"}
    ):
        return None
    relationship = effect[key]
    if relationship not in FACTION_RELATIONSHIP_NAMES:
        return None
    enabled = effect.get("set_value_to", True)
    if not isinstance(enabled, bool):
        return None
    return [
        "    services.characters.set_faction_relationship(",
        f"        {source_expression}, {target_expression},",
        f"        {lua_quote(relationship)}, {'true' if enabled else 'false'})",
    ]


def render_static_context_presence_condition(condition: dict[str, Any]) -> str | None:
    """Render literal event-context presence checks without EOC variables."""
    if set(condition) != {"expects_vars"}:
        return None
    values = condition.get("expects_vars")
    if (
        not isinstance(values, list) or not values or len(values) > 64 or
        not all(bounded_utf8_string(value, 256) for value in values)
    ):
        return None
    return " and ".join(
        f"context.data[{lua_quote(value)}] ~= nil" for value in values
    )


def render_static_condition_math(condition: dict[str, Any]) -> str | None:
    """Render only finite numeric comparisons from the legacy math condition."""
    if set(condition) != {"math"}:
        return None
    raw = condition.get("math")
    if not isinstance(raw, list) or len(raw) != 1 or not isinstance(raw[0], str):
        return None
    match = re.fullmatch(
        r"\s*([+-]?(?:\d+(?:\.\d*)?|\.\d+))\s*"
        r"(==|!=|<=|>=|<|>)\s*"
        r"([+-]?(?:\d+(?:\.\d*)?|\.\d+))\s*",
        raw[0],
    )
    if match is None:
        return None
    try:
        left = float(match.group(1))
        right = float(match.group(3))
    except ValueError:
        return None
    if not math.isfinite(left) or not math.isfinite(right):
        return None
    return f"{lua_number(left)} {match.group(2)} {lua_number(right)}"


def render_static_line_of_sight_condition(
    condition: dict[str, Any],
) -> str | None:
    """Render a literal line-of-sight check against context coordinates.

    The native condition accepts dynamic variables and arbitrary numeric
    expressions.  Migration only emits the typed environment query when both
    endpoints are explicit context values and the range is a finite integer
    inside the Platform service bound; all other shapes remain TODOs.
    """
    if not {"line_of_sight", "loc_1", "loc_2"} <= set(condition):
        return None
    if set(condition) - {"line_of_sight", "loc_1", "loc_2", "with_fields"}:
        return None
    raw_range = finite_number_literal(condition.get("line_of_sight"))
    if (
        raw_range is None or
        math.trunc(float(raw_range)) != float(raw_range) or
        raw_range < 0 or raw_range > 100000
    ):
        return None

    def context_location(value: Any) -> str | None:
        if (
            not isinstance(value, dict) or
            set(value) != {"context_val"} or
            not bounded_utf8_string(value.get("context_val"), 256)
        ):
            return None
        return f"context.data[{lua_quote(value['context_val'])}]"

    first = context_location(condition.get("loc_1"))
    second = context_location(condition.get("loc_2"))
    if first is None or second is None:
        return None
    with_fields = condition.get("with_fields", True)
    if not isinstance(with_fields, bool):
        return None
    return (
        "services.gameplay.environment.line_of_sight("
        f"{first}, {second}, {int(raw_range)}, "
        f"{'true' if with_fields else 'false'})"
    )


def render_eoc_condition_expression(
    condition: Any, avatar_actor_proven: bool = False,
    weapon_actor_proven: bool = False,
    npc_actor_proven: bool = False,
) -> str | None:
    """Translate bounded legacy predicates into ordinary Lua composition."""
    character_actor_proven = avatar_actor_proven or weapon_actor_proven or \
        npc_actor_proven
    if condition is None:
        return "true"
    if isinstance(condition, bool):
        return "true" if condition else "false"
    if isinstance(condition, str):
        if condition == "is_day":
            return "not services.gameplay.environment.is_night()"
        # These legacy predicates need a dedicated native query with explicit
        # location/mission/item semantics.  Do not emit a made-up generic
        # service call: returning ``None`` makes render_eoc record a visible
        # TODO and keeps the generated Lua executable against the declared API.
        if condition == "u_has_camp":
            return "service_value(services.camps.player_has_camp())"
        if condition in ("u_has_activity", "npc_has_activity"):
            return "service_value(services.activities.snapshot(actor)).active"
        if weapon_actor_proven and condition == "u_has_weapon":
            return "character_has_weapon(actor)"
        if npc_actor_proven and condition == "npc_has_weapon":
            return "character_has_weapon(actor)"
        if weapon_actor_proven and condition == "u_can_drop_weapon":
            return "character_can_drop_weapon(actor)"
        if npc_actor_proven and condition == "npc_can_drop_weapon":
            return "character_can_drop_weapon(actor)"
        if character_actor_proven and condition == "u_is_travelling":
            return "character_travel_has_path(actor)"
        if npc_actor_proven and condition == "npc_is_travelling":
            return "character_travel_has_path(actor)"
        if character_actor_proven and condition == "u_at_safe_space":
            return "character_at_safe_space(actor)"
        if npc_actor_proven and condition == "at_safe_space":
            return "character_at_safe_space(actor)"
        if npc_actor_proven and condition == "npc_at_safe_space":
            return "character_at_safe_space(actor)"
        if character_actor_proven and condition == "u_has_pickup_list":
            return "character_has_pickup_whitelist(actor)"
        if npc_actor_proven and condition == "has_pickup_list":
            return "character_has_pickup_whitelist(actor)"
        if npc_actor_proven and condition == "npc_has_pickup_list":
            return "character_has_pickup_whitelist(actor)"
        if weapon_actor_proven and condition == "player_see_u":
            return ("service_value(services.creatures.can_see("
                    "services.creatures.avatar(), actor))")
        if npc_actor_proven and condition == "player_see_npc":
            return ("service_value(services.creatures.can_see("
                    "services.creatures.avatar(), actor))")
        if avatar_actor_proven and condition == "u_is_warm":
            return ("service_value(services.characters.snapshot(actor))"
                    ".creature.warm")
        if npc_actor_proven and condition == "npc_is_warm":
            return ("service_value(services.characters.snapshot(actor))"
                    ".creature.warm")
        if avatar_actor_proven and condition == "u_is_deaf":
            return ("service_value(services.characters.snapshot(actor))"
                    ".senses.deaf")
        if npc_actor_proven and condition == "npc_is_deaf":
            return ("service_value(services.characters.snapshot(actor))"
                    ".senses.deaf")
        if avatar_actor_proven and condition == "u_is_underwater":
            return "service_value(services.characters.is_underwater(actor))"
        if npc_actor_proven and condition == "npc_is_underwater":
            return "service_value(services.characters.is_underwater(actor))"
        if avatar_actor_proven and condition == "u_is_alive":
            return "service_value(services.characters.is_alive(actor))"
        if npc_actor_proven and condition == "npc_is_alive":
            return "service_value(services.characters.is_alive(actor))"
        if avatar_actor_proven and condition == "u_is_avatar":
            return "true"
        if avatar_actor_proven and condition == "u_male":
            return ("service_value(services.characters.snapshot(actor))"
                    ".male")
        if npc_actor_proven and condition == "npc_male":
            return ("service_value(services.characters.snapshot(actor))"
                    ".male")
        if npc_actor_proven and condition == "npc_female":
            return ("not service_value(services.characters.snapshot(actor))"
                    ".male")
        if avatar_actor_proven and condition == "u_is_character":
            return "true"
        if npc_actor_proven and condition == "npc_is_character":
            return "true"
        if npc_actor_proven and condition == "npc_is_npc":
            return "true"
        if avatar_actor_proven and condition == "u_female":
            return ("not service_value(services.characters.snapshot(actor))"
                    ".male")
        if avatar_actor_proven and condition == "u_is_outside":
            return (
                "services.gameplay.environment.is_outside("
                "service_value(services.characters.snapshot(actor))"
                ".creature.position)"
            )
        if npc_actor_proven and condition == "npc_is_outside":
            return (
                "services.gameplay.environment.is_outside("
                "service_value(services.characters.snapshot(actor))"
                ".creature.position)"
            )
        if condition == "npc_has_activity":
            return "(services.characters.snapshot(actor).activity ~= nil)"
        if isinstance(condition, dict) and "expects_vars" in condition:
            return None
        if isinstance(condition, dict) and "math" in condition:
            return None
        if avatar_actor_proven and condition in (
            "u_is_npc", "u_is_monster", "u_is_item", "u_is_furniture",
            "u_is_vehicle", "u_hostile", "u_is_in_vehicle",
            "u_controlling_vehicle", "u_driving", "u_is_riding",
            "u_is_avatar_passenger", "u_is_driven", "u_is_remote_controlled",
            "u_is_on_rails", "u_is_falling", "u_is_floating", "u_is_flying",
            "u_is_sinking", "u_is_skidding", "u_can_float", "u_can_fly",
            "u_following", "u_vehicle_owned_by_avatar", "has_beta",
            "is_by_radio", "has_reason", "has_assigned_mission",
            "has_many_assigned_missions", "has_available_mission",
            "has_many_available_missions", "u_mission_complete",
            "u_mission_failed", "u_mission_incomplete",
            "mission_complete", "mission_failed", "mission_incomplete",
            "u_has_available_mission", "u_has_many_available_missions",
        ):
            return "false"
        if avatar_actor_proven and condition in (
            "u_exists", "has_alpha", "u_friend", "u_available",
            "has_no_assigned_mission", "has_no_available_mission",
            "u_has_no_available_mission",
        ):
            return "true"
        if npc_actor_proven and condition in (
            "npc_is_avatar", "npc_is_monster", "npc_is_item",
            "npc_is_furniture", "npc_is_vehicle", "npc_friend",
            "npc_is_falling", "npc_is_floating", "npc_is_flying",
            "npc_is_sinking", "npc_is_skidding", "npc_can_float", "npc_can_fly",
            "npc_is_in_vehicle", "npc_controlling_vehicle", "npc_driving",
            "npc_is_riding", "npc_is_avatar_passenger", "npc_is_driven",
            "npc_is_remote_controlled", "npc_is_on_rails",
            "npc_vehicle_owned_by_avatar", "npc_following",
            "npc_has_assigned_camp", "has_beta",
            "npc_has_available_mission", "npc_has_many_available_missions",
            "npc_mission_complete", "npc_mission_failed", "npc_mission_incomplete",
        ):
            return "false"
        if npc_actor_proven and condition in (
            "npc_exists", "npc_hostile", "npc_available",
            "npc_has_no_available_mission",
        ):
            return "true"
        if avatar_actor_proven and condition == "u_can_see":
            return "not (service_value(services.characters.snapshot(actor)).senses.blind)"
        if npc_actor_proven and condition == "npc_can_see":
            return "not (service_value(services.characters.snapshot(actor)).senses.blind)"
        if avatar_actor_proven and condition in (
            "u_has_stolen_item", "u_can_stow_weapon", "u_are_owed",
            "u_train_skills", "u_train_spells", "u_train_styles",
        ):
            return "false"
        if npc_actor_proven and condition in (
            "npc_train_skills", "npc_train_spells", "npc_train_styles",
            "npc_has_stolen_item", "npc_can_stow_weapon",
        ):
            return "false"
        return None
    if not isinstance(condition, dict):
        return None

    rendered_presence = render_static_context_presence_condition(condition)
    if rendered_presence is not None:
        return rendered_presence
    rendered_math = render_static_condition_math(condition)
    if rendered_math is not None:
        return rendered_math
    rendered_line_of_sight = render_static_line_of_sight_condition(condition)
    if rendered_line_of_sight is not None:
        return rendered_line_of_sight

    if (
        avatar_actor_proven and
        set(condition) == {"u_has_activity"} and
        isinstance(condition.get("u_has_activity"), str)
    ):
        return "service_value(services.activities.snapshot(actor)).active"

    if set(condition) in ({"and"}, {"or"}):
        operator = "and" if "and" in condition else "or"
        entries = condition[operator]
        if not isinstance(entries, list) or not entries:
            return None
        rendered = [
            render_eoc_condition_expression(
                entry, avatar_actor_proven, weapon_actor_proven,
                npc_actor_proven
            )
            for entry in entries
        ]
        if any(entry is None for entry in rendered):
            return None
        return f" {operator} ".join(f"({entry})" for entry in rendered)
    if set(condition) == {"not"}:
        rendered = render_eoc_condition_expression(
            condition["not"], avatar_actor_proven, weapon_actor_proven,
            npc_actor_proven
        )
        return None if rendered is None else f"not ({rendered})"

    for key, function_name, minimum in (
        ("compare_string", "any_equal", 2),
        ("compare_string_match_all", "all_equal", 1),
    ):
        if set(condition) == {key}:
            values = condition[key]
            if not isinstance(values, list) or len(values) < minimum:
                return None
            rendered = [
                render_eoc_string_expression(value)
                for value in values
            ]
            if any(value is None for value in rendered):
                return None
            rendered_values = ", ".join(rendered)
            return (
                f"services.gameplay.strings.{function_name}"
                f"({{{rendered_values}}})"
            )

    if set(condition) == {"one_in_chance"}:
        value = finite_number_literal(condition["one_in_chance"])
        if value is None or value < -1000000000 or value > 1000000000:
            return None
        return f"services.random.one_in({lua_number(value)})"

    if set(condition) == {"x_in_y_chance"}:
        chance = condition["x_in_y_chance"]
        if not isinstance(chance, dict) or set(chance) != {"x", "y"}:
            return None
        numerator = finite_number_literal(chance["x"])
        denominator = finite_number_literal(chance["y"])
        if (
            numerator is None or denominator is None or
            denominator <= 0 or numerator < 0 or numerator > denominator
        ):
            return None
        return (
            "services.random.probability("
            f"{lua_number(numerator)}, {lua_number(denominator)})"
        )

    if set(condition) <= {"roll_contested", "difficulty", "die_size"} and {
        "roll_contested", "difficulty"
    } <= set(condition):
        check = finite_number_literal(condition["roll_contested"])
        difficulty = finite_number_literal(condition["difficulty"])
        raw_die_size = condition.get("die_size", 10)
        die_size = (
            raw_die_size
            if isinstance(raw_die_size, int) and
            not isinstance(raw_die_size, bool)
            else None
        )
        if (
            check is None or difficulty is None or die_size is None or
            die_size <= 0 or die_size > 1000000000
        ):
            return None
        return (
            "services.random.contested("
            f"{lua_number(check)}, {lua_number(difficulty)}, {die_size})"
        )

    if set(condition) == {"mod_is_loaded"} and isinstance(
        condition["mod_is_loaded"], str
    ):
        return (
            "services.gameplay.mods.is_loaded("
            f"{lua_quote(condition['mod_is_loaded'])})"
        )
    if set(condition) == {"current_dimension"} and isinstance(
        condition["current_dimension"], str
    ):
        return (
            "services.gameplay.environment.dimension() == "
            f"{lua_quote(condition['current_dimension'])}"
        )
    if set(condition) == {"is_season"} and isinstance(
        condition["is_season"], str
    ):
        return (
            "services.time_snapshot().season_id == "
            f"{lua_quote(condition['is_season'])}"
        )
    if (
        set(condition) == {"is_weather"} and
        isinstance(condition.get("is_weather"), str) and
        safe_platform_id(condition.get("is_weather"))
    ):
        return (
            "services.weather.current().weather.value == "
            f"{lua_quote(condition['is_weather'])}"
        )
    if (
        set(condition) == {"map_furniture_with_flag", "loc"} and
        bounded_utf8_string(condition.get("map_furniture_with_flag"), 256) and
        isinstance(condition.get("loc"), dict) and
        set(condition["loc"]) == {"context_val"} and
        isinstance(condition["loc"].get("context_val"), str)
    ):
        loc_expression = render_eoc_value_expression(
            condition["loc"], lua_quote(""))
        if loc_expression is not None:
            return (
                "services.gameplay.environment.furniture_has_flag("
                f"{loc_expression}, "
                f"{lua_quote(condition['map_furniture_with_flag'])})"
            )
    if (
        set(condition) == {"map_terrain_with_flag", "loc"} and
        bounded_utf8_string(condition.get("map_terrain_with_flag"), 256) and
        isinstance(condition.get("loc"), dict) and
        set(condition["loc"]) == {"context_val"} and
        isinstance(condition["loc"].get("context_val"), str)
    ):
        loc_expression = render_eoc_value_expression(
            condition["loc"], lua_quote(""))
        if loc_expression is not None:
            return (
                "services.gameplay.environment.terrain_has_flag("
                f"{loc_expression}, "
                f"{lua_quote(condition['map_terrain_with_flag'])})"
            )
    for condition_key, native_call in (
        ("map_in_city", "services.overmap.is_in_city"),
        ("map_is_outside", "services.gameplay.environment.is_indoor_tile"),
        ("is_outside", "services.gameplay.environment.is_outside"),
    ):
        if (
            set(condition) == {condition_key} and
            isinstance(condition.get(condition_key), dict) and
            set(condition[condition_key]) == {"context_val"} and
            isinstance(condition[condition_key].get("context_val"), str)
        ):
            loc_expression = render_eoc_value_expression(
                condition[condition_key], lua_quote(""))
            if loc_expression is not None:
                return f"{native_call}({loc_expression})"
    if "expects_vars" in condition:
        return None
    if "math" in condition:
        return None
    # Remaining legacy condition selectors are intentionally fail-closed.  A
    # generic ``services.domain.*`` function is not part of the Platform
    # contract and would produce Lua that fails only when the handler fires.
    # Keep the selector in the migration report until a typed native query is
    # implemented for its exact semantics.
    for condition_key, native_call in (
        ("map_terrain_id", "terrain_id"),
        ("map_furniture_id", "furniture_id"),
        ("map_field_id", "field_exists"),
    ):
        if (
            set(condition) == {condition_key, "loc"} and
            bounded_utf8_string(condition.get(condition_key), 256) and
            safe_platform_id(condition.get(condition_key)) and
            isinstance(condition.get("loc"), dict) and
            set(condition["loc"]) == {"context_val"} and
            isinstance(condition["loc"].get("context_val"), str)
        ):
            loc_expression = render_eoc_value_expression(
                condition["loc"], lua_quote(""))
            if loc_expression is not None:
                if native_call == "field_exists":
                    return (
                        "services.gameplay.environment.field_exists("
                        f"{loc_expression}, "
                        f"{lua_quote(condition[condition_key])})"
                    )
                return (
                    f"services.gameplay.environment.{native_call}("
                    f"{loc_expression}) == "
                    f"{lua_quote(condition[condition_key])}"
                )
    for condition_key, native_call, is_field in (
        ("u_is_on_terrain", "terrain_id", False),
        ("npc_is_on_terrain", "terrain_id", False),
        ("u_is_on_furniture", "furniture_id", False),
        ("npc_is_on_furniture", "furniture_id", False),
        ("u_is_in_field", "field_exists", True),
        ("npc_is_in_field", "field_exists", True),
        ("u_is_on_terrain_with_flag", "terrain_has_flag", True),
        ("npc_is_on_terrain_with_flag", "terrain_has_flag", True),
        ("u_is_on_furniture_with_flag", "furniture_has_flag", True),
        ("npc_is_on_furniture_with_flag", "furniture_has_flag", True),
    ):
        actor_proven = (
            avatar_actor_proven if condition_key.startswith("u_") else
            npc_actor_proven
        )
        if (
            actor_proven and
            set(condition) == {condition_key} and
            bounded_utf8_string(condition.get(condition_key), 256) and
            safe_platform_id(condition.get(condition_key))
        ):
            position = (
                "service_value(services.characters.snapshot(actor))"
                ".creature.position"
            )
            return (
                f"services.gameplay.environment.{native_call}("
                f"{position}, "
                f"{lua_quote(condition[condition_key])})"
                if is_field else
                f"services.gameplay.environment.{native_call}("
                f"{position}) == {lua_quote(condition[condition_key])}"
            )
    if (
        set(condition) == {"u_has_mission"} and
        isinstance(condition.get("u_has_mission"), str) and
        safe_platform_id(condition.get("u_has_mission"))
    ):
        return (
            "service_value(services.missions.avatar_has_active("
            "services.types.id(\"mission\", "
            f"{lua_quote(condition['u_has_mission'])})))"
        )

    if (
        set(condition) == {"u_has_faction_trust"} and
        finite_number_literal(condition.get("u_has_faction_trust")) is not None
    ):
        trust = finite_number_literal(condition["u_has_faction_trust"])
        return (
            "service_value(services.factions.player()).reputation.trusts >= "
            f"{lua_number(trust)}"
        )

    # The legacy body-part temperature predicate defaults its body part from
    # dialogue reason when `bodypart` is omitted.  A Platform handler has no
    # implicit reason/body-part channel, so only an explicit typed body part
    # and finite threshold are eligible for migration.
    for temperature_key, actor_proven in (
        ("u_has_part_temp", avatar_actor_proven),
        ("npc_has_part_temp", npc_actor_proven),
    ):
        if (
            actor_proven and
            set(condition) == {temperature_key, "bodypart"} and
            safe_platform_id(condition.get("bodypart"))
        ):
            threshold = finite_number_literal(condition.get(temperature_key))
            if (
                threshold is not None and
                -MAX_CHARACTER_PART_TEMPERATURE <= float(threshold) <=
                MAX_CHARACTER_PART_TEMPERATURE
            ):
                return (
                    "service_value(services.characters.has_part_temp("
                    "actor, services.types.id(\"body_part\", "
                    f"{lua_quote(condition['bodypart'])}), "
                    f"{lua_number(threshold)}))"
                )

    # Effect predicates are safe only for a proven character actor and a
    # finite literal effect id.  Keep the query in the normal Platform service
    # surface; dynamic/context-valued ids and unproven actors remain TODOs.
    for effect_key, actor_proven in (
        ("u_has_effect", avatar_actor_proven),
        ("npc_has_effect", npc_actor_proven),
    ):
        if (
            actor_proven and
            set(condition) == {effect_key} and
            safe_platform_id(condition.get(effect_key))
        ):
            return (
                "service_value(services.effects.has(actor, "
                "services.types.id(\"effect\", "
                f"{lua_quote(condition[effect_key])})))"
            )
    for effect_key, actor_proven in (
        ("u_has_any_effect", avatar_actor_proven),
        ("npc_has_any_effect", npc_actor_proven),
    ):
        if (
            actor_proven and
            set(condition) == {effect_key} and
            isinstance(condition.get(effect_key), list) and
            0 < len(condition[effect_key]) <= 64 and
            all(safe_platform_id(value) for value in condition[effect_key])
        ):
            queries = [
                "service_value(services.effects.has(actor, "
                "services.types.id(\"effect\", "
                f"{lua_quote(value)})))"
                for value in condition[effect_key]
            ]
            return " or ".join(f"({query})" for query in queries)

    if (
        set(condition) == {"u_safe_mode_trigger"} and
        isinstance(condition.get("u_safe_mode_trigger"), str) and
        condition["u_safe_mode_trigger"] in (
            "N", "NE", "E", "SE", "S", "SW", "W", "NW"
        )
    ):
        # The handler reads the global avatar's safe-mode visibility and no
        # talker, so the conversion is context-free.
        return (
            "services.gameplay.environment.safe_mode_dangerous("
            f"{lua_quote(condition['u_safe_mode_trigger'])})"
        )
    if (
        (avatar_actor_proven and set(condition) in ({"u_mission_goal"}, {"mission_goal"})) or
        (npc_actor_proven and set(condition) == {"npc_mission_goal"})
    ) and isinstance(list(condition.values())[0], str):
        # The actor talker has no selected mission, so the legacy handler
        # compares a null mission regardless of the goal value.
        return "false"
    if (
        avatar_actor_proven and
        set(condition) == {"follower_present"} and
        isinstance(condition.get("follower_present"), str)
    ):
        return "false"
    for rule_key in (
        "u_aim_rule", "u_engagement_rule",
        "u_cbm_recharge_rule", "u_cbm_reserve_rule", "u_rule",
        "u_override",
    ):
        if (
            avatar_actor_proven and
            set(condition) == {rule_key} and
            isinstance(condition.get(rule_key), str)
        ):
            # Only the NPC talker overrides has_ai_rule; the avatar's base
            # const_talker implementation returns false for every rule.
            return "false"
    for rule_key in ("npc_rule", "npc_override"):
        if (
            npc_actor_proven and
            set(condition) == {rule_key} and
            isinstance(condition.get(rule_key), str)
        ):
            return "false"
    for bodytype_key, actor_proven in (
        ("u_bodytype", avatar_actor_proven),
        ("npc_bodytype", npc_actor_proven),
    ):
        if (
            actor_proven and
            set(condition) == {bodytype_key} and
            isinstance(condition.get(bodytype_key), str)
        ):
            # talker_character_const::bodytype hardcodes every Character as
            # "human" (the TODO for limby characters is unreachable today).
            return (
                "true" if condition[bodytype_key] == "human" else "false"
            )
    for purifiable_key, actor_proven in (
        ("u_is_trait_purifiable", avatar_actor_proven),
        ("npc_is_trait_purifiable", npc_actor_proven),
    ):
        if (
            actor_proven and
            set(condition) == {purifiable_key} and
            safe_platform_id(condition.get(purifiable_key))
        ):
            return (
                "services.mutations.definition("
                "services.types.id(\"mutation\", "
                f"{lua_quote(condition[purifiable_key])}))"
                ".availability.purifiable"
            )
    for part_flag_key, actor_proven in (
        ("u_has_part_flag", avatar_actor_proven),
        ("npc_has_part_flag", npc_actor_proven),
    ):
        if (
            actor_proven and
            set(condition) <= {part_flag_key, "enabled"} and
            isinstance(condition.get(part_flag_key), str) and
            (
                "enabled" not in condition or
                isinstance(condition.get("enabled"), bool)
            )
        ):
            # The base const_talker::has_part_flag returns false and no
            # Character/NPC talker overrides it, so the predicate is dead
            # for every proven actor regardless of the flag or enabled value.
            return "false"
    if (
        avatar_actor_proven and
        set(condition) == {"u_has_class"} and
        isinstance(condition.get("u_has_class"), str)
    ):
        # talker_character_const never overrides is_myclass, so the base
        # talker returns false for the avatar regardless of the class id.
        return "false"
    if (
        npc_actor_proven and
        set(condition) == {"npc_has_class"} and
        safe_platform_id(condition.get("npc_has_class"))
    ):
        return (
            "service_value(services.npcs.get(actor)).class.value == "
            f"{lua_quote(condition['npc_has_class'])}"
        )
    sleepiness_levels = {
        "TIRED": 191,
        "DEAD_TIRED": 383,
        "EXHAUSTED": 575,
        "MASSIVE_SLEEPINESS": 1000,
    }
    for need_key, actor_proven in (
        ("u_need", avatar_actor_proven),
        ("npc_need", npc_actor_proven),
    ):
        if (
            actor_proven and
            isinstance(condition, dict) and
            set(condition) <= {need_key, "amount", "level"} and
            condition.get(need_key) in ("hunger", "thirst", "sleepiness")
        ):
            if (
                set(condition) == {need_key, "amount"} and
                isinstance(condition.get("amount"), int) and
                not isinstance(condition.get("amount"), bool) and
                NATIVE_INT_MIN <= condition["amount"] <= NATIVE_INT_MAX
            ):
                return (
                    "service_value(services.characters.snapshot(actor))"
                    f".needs.{condition[need_key]} > {condition['amount']}"
                )
            if (
                set(condition) == {need_key, "level"} and
                condition.get(need_key) == "sleepiness" and
                condition.get("level") in sleepiness_levels
            ):
                return (
                    "service_value(services.characters.snapshot(actor))"
                    f".needs.sleepiness > "
                    f"{sleepiness_levels[condition['level']]}"
                )
            if set(condition) == {need_key}:
                return (
                    "service_value(services.characters.snapshot(actor))"
                    f".needs.{condition[need_key]} > 0"
                )
    if (
        avatar_actor_proven and
        set(condition) == {"u_has_trait"} and
        safe_platform_id(condition.get("u_has_trait"))
    ):
        return (
            "service_value(services.mutations.has("
            "actor, "
            "services.types.id(\"mutation\", "
            f"{lua_quote(condition['u_has_trait'])})))"
        )
    if avatar_actor_proven and set(condition) == {"u_has_any_trait"}:
        traits = condition.get("u_has_any_trait")
        if (
            not isinstance(traits, list) or
            not traits or
            not all(safe_platform_id(trait) for trait in traits)
        ):
            return None
        queries = [
            "service_value(services.mutations.has("
            "actor, "
            "services.types.id(\"mutation\", "
            f"{lua_quote(trait)})))"
            for trait in traits
        ]
        return " or ".join(f"({query})" for query in queries)
    if (
        avatar_actor_proven and
        set(condition) == {"u_has_martial_art"} and
        safe_platform_id(condition.get("u_has_martial_art"))
    ):
        return (
            "service_value(services.martial_arts.get("
            "actor, "
            "services.types.id(\"martial_art\", "
            f"{lua_quote(condition['u_has_martial_art'])}))).known"
        )
    if (
        avatar_actor_proven and
        set(condition) == {"u_using_martial_art"} and
        safe_platform_id(condition.get("u_using_martial_art"))
    ):
        return (
            "service_value(services.martial_arts.get("
            "actor, "
            "services.types.id(\"martial_art\", "
            f"{lua_quote(condition['u_using_martial_art'])}))).selected"
        )
    if (
        avatar_actor_proven and
        set(condition) == {"u_has_proficiency"} and
        safe_platform_id(condition.get("u_has_proficiency"))
    ):
        return (
            "service_value(services.proficiencies.get("
            "actor, "
            "services.types.id(\"proficiency\", "
            f"{lua_quote(condition['u_has_proficiency'])}))).known"
        )
    for npc_key, u_key in (
        ("npc_has_trait", "u_has_trait"),
        ("npc_has_martial_art", "u_has_martial_art"),
        ("npc_using_martial_art", "u_using_martial_art"),
        ("npc_has_proficiency", "u_has_proficiency"),
    ):
        if (
            npc_actor_proven and
            set(condition) == {npc_key} and
            safe_platform_id(condition.get(npc_key))
        ):
            native_surface, native_kind, field = {
                "u_has_trait": (
                    "services.mutations.has", "mutation", ""),
                "u_has_martial_art": (
                    "services.martial_arts.get", "martial_art", ".known"),
                "u_using_martial_art": (
                    "services.martial_arts.get", "martial_art", ".selected"),
                "u_has_proficiency": (
                    "services.proficiencies.get", "proficiency", ".known"),
            }[u_key]
            return (
                f"service_value({native_surface}("
                "actor, "
                f"services.types.id(\"{native_kind}\", "
                f"{lua_quote(condition[npc_key])}))){field}"
            )
    if npc_actor_proven and set(condition) == {"npc_has_any_trait"}:
        traits = condition.get("npc_has_any_trait")
        if (
            not isinstance(traits, list) or
            not traits or
            not all(safe_platform_id(trait) for trait in traits)
        ):
            return None
        queries = [
            "service_value(services.mutations.has("
            "actor, "
            "services.types.id(\"mutation\", "
            f"{lua_quote(trait)})))"
            for trait in traits
        ]
        return " or ".join(f"({query})" for query in queries)
    if (
        avatar_actor_proven and
        set(condition) == {"u_has_profession"} and
        safe_platform_id(condition.get("u_has_profession"))
    ):
        return (
            "character_has_profession(actor, "
            f"{lua_quote(condition['u_has_profession'])})"
        )
    if (
        npc_actor_proven and
        set(condition) == {"npc_has_profession"} and
        safe_platform_id(condition.get("npc_has_profession"))
    ):
        return (
            "character_has_profession(actor, "
            f"{lua_quote(condition['npc_has_profession'])})"
        )
    if (
        avatar_actor_proven and
        set(condition) == {"u_know_recipe"} and
        safe_platform_id(condition.get("u_know_recipe"))
    ):
        return (
            "service_value(services.recipes.knows("
            "actor, "
            "services.types.id(\"recipe\", "
            f"{lua_quote(condition['u_know_recipe'])})))"
        )
    if (
        avatar_actor_proven and
        set(condition) == {"u_has_bionics"} and
        safe_platform_id(condition.get("u_has_bionics"))
    ):
        if condition["u_has_bionics"] == "ANY":
            return "character_has_any_bionic_or_capacity(actor)"
        return (
            "service_value(services.bionics.has("
            "actor, "
            "services.types.id(\"bionic\", "
            f"{lua_quote(condition['u_has_bionics'])})))"
        )
    if (
        npc_actor_proven and
        set(condition) == {"npc_has_bionics"} and
        safe_platform_id(condition.get("npc_has_bionics"))
    ):
        if condition["npc_has_bionics"] == "ANY":
            return "character_has_any_bionic_or_capacity(actor)"
        return (
            "service_value(services.bionics.has("
            "actor, "
            "services.types.id(\"bionic\", "
            f"{lua_quote(condition['npc_has_bionics'])})))"
        )
    if (
        weapon_actor_proven and
        not npc_actor_proven and
        set(condition) == {"u_has_flag"} and
        safe_platform_id(condition.get("u_has_flag"))
    ):
        return (
            "service_value(services.characters.has_flag("
            "actor, "
            "services.types.id(\"json_flag\", "
            f"{lua_quote(condition['u_has_flag'])})))"
        )
    if (
        npc_actor_proven and
        set(condition) == {"npc_has_flag"} and
        safe_platform_id(condition.get("npc_has_flag"))
    ):
        return (
            "service_value(services.characters.has_flag("
            "actor, "
            "services.types.id(\"json_flag\", "
            f"{lua_quote(condition['npc_has_flag'])})))"
        )
    if (
        weapon_actor_proven and
        not npc_actor_proven and
        set(condition) == {"u_is_wearing"} and
        safe_platform_id(condition.get("u_is_wearing"))
    ):
        return (
            "character_is_wearing(actor, "
            f"{lua_quote(condition['u_is_wearing'])})"
        )
    if (
        npc_actor_proven and
        set(condition) == {"npc_is_wearing"} and
        safe_platform_id(condition.get("npc_is_wearing"))
    ):
        return (
            "character_is_wearing(actor, "
            f"{lua_quote(condition['npc_is_wearing'])})"
        )
    if (
        avatar_actor_proven and
        set(condition) == {"u_has_item"} and
        safe_platform_id(condition.get("u_has_item"))
    ):
        return (
            "character_has_item(actor, "
            f"{lua_quote(condition['u_has_item'])})"
        )
    if (
        npc_actor_proven and
        set(condition) == {"npc_has_item"} and
        safe_platform_id(condition.get("npc_has_item"))
    ):
        return (
            "character_has_item(actor, "
            f"{lua_quote(condition['npc_has_item'])})"
        )
    if (
        avatar_actor_proven and
        set(condition) == {"u_has_move_mode"} and
        safe_platform_id(condition.get("u_has_move_mode"))
    ):
        return (
            "service_value(services.characters.snapshot(actor))"
            ".movement.id == "
            f"{lua_quote(condition['u_has_move_mode'])}"
        )
    if (
        npc_actor_proven and
        set(condition) == {"npc_has_move_mode"} and
        safe_platform_id(condition.get("npc_has_move_mode"))
    ):
        return (
            "service_value(services.characters.snapshot(actor))"
            ".movement.id == "
            f"{lua_quote(condition['npc_has_move_mode'])}"
        )
    if (
        weapon_actor_proven and
        set(condition) == {"u_has_wielded_with_flag"} and
        safe_platform_id(condition.get("u_has_wielded_with_flag")) and
        len(condition["u_has_wielded_with_flag"].encode("utf-8")) <= 256
    ):
        return (
            "character_wields_with_flag(actor, "
            "services.types.id(\"json_flag\", "
            f"{lua_quote(condition['u_has_wielded_with_flag'])}))"
        )
    if (
        avatar_actor_proven and
        set(condition) == {"u_has_cash"} and
        isinstance(condition.get("u_has_cash"), int) and
        not isinstance(condition.get("u_has_cash"), bool) and
        NATIVE_INT_MIN <= condition["u_has_cash"] <= NATIVE_INT_MAX
    ):
        return (
            "service_value(services.characters.snapshot(actor))"
            f".cash >= {condition['u_has_cash']}"
        )
    for condition_key, stat_field in (
        ("u_has_strength", "strength"),
        ("u_has_dexterity", "dexterity"),
        ("u_has_intelligence", "intelligence"),
        ("u_has_perception", "perception"),
    ):
        if (
            avatar_actor_proven and
            set(condition) == {condition_key} and
            isinstance(condition.get(condition_key), int) and
            not isinstance(condition.get(condition_key), bool) and
            NATIVE_INT_MIN <= condition[condition_key] <= NATIVE_INT_MAX
        ):
            return (
                "service_value(services.characters.snapshot(actor))"
                f".stats.{stat_field} >= {condition[condition_key]}"
            )
        npc_key = "npc" + condition_key[1:]
        if (
            npc_actor_proven and
            set(condition) == {npc_key} and
            isinstance(condition.get(npc_key), int) and
            not isinstance(condition.get(npc_key), bool) and
            NATIVE_INT_MIN <= condition[npc_key] <= NATIVE_INT_MAX
        ):
            return (
                "service_value(services.characters.snapshot(actor))"
                f".stats.{stat_field} >= {condition[npc_key]}"
            )
    for rule_key, field_name, valid_values in (
        ("npc_aim_rule", "aim", {"AIM_WHEN_CONVENIENT", "AIM_SPRAY", "AIM_PRECISE", "AIM_STRICTLY_PRECISE"}),
        ("npc_engagement_rule", "engagement", {"ENGAGE_NONE", "ENGAGE_CLOSE", "ENGAGE_WEAK", "ENGAGE_HIT", "ENGAGE_ALL", "ENGAGE_FREE_FIRE", "ENGAGE_NO_MOVE"}),
        ("npc_cbm_reserve_rule", "cbm_reserve", {"CBM_RESERVE_ALL", "CBM_RESERVE_MOST", "CBM_RESERVE_SOME", "CBM_RESERVE_LITTLE", "CBM_RESERVE_NONE"}),
        ("npc_cbm_recharge_rule", "cbm_recharge", {"CBM_RECHARGE_ALL", "CBM_RECHARGE_MOST", "CBM_RECHARGE_SOME", "CBM_RECHARGE_LITTLE", "CBM_RECHARGE_NONE"}),
    ):
        if (
            npc_actor_proven and
            set(condition) == {rule_key} and
            isinstance(condition.get(rule_key), str) and
            condition[rule_key] in valid_values
        ):
            return (
                f"service_value(services.npcs.ai_rules(actor)).{field_name} == "
                f"{lua_quote(condition[rule_key])}"
            )
    if (
        avatar_actor_proven and
        isinstance(condition, dict) and
        set(condition) == {"u_has_species"} and
        isinstance(condition.get("u_has_species"), str)
    ):
        return "true" if condition["u_has_species"].lower() == "human" else "false"
    if (
        npc_actor_proven and
        isinstance(condition, dict) and
        set(condition) == {"npc_has_species"} and
        isinstance(condition.get("npc_has_species"), str)
    ):
        return "true" if condition["npc_has_species"].lower() == "human" else "false"
    return None


def render_eoc(source: SourceObject, result: MigrationResult) -> str:
    value = source.value
    eoc_id = stable_id(value, f"anonymous_{source.index}")
    stable_handler = isinstance(value.get("id"), str) and bool(value["id"])
    handler_id = f"migrated.{eoc_id}"
    required_event = value.get("required_event")
    avatar_fatal_hook = value.get("eoc_type") == "PREVENT_DEATH"
    avatar_actor_proven = (
        avatar_fatal_hook or
        (
            required_event == "game_start" and
            game_start_avatar_actor_is_proven()
        )
    )
    item_event_character_actor_proven = (
        isinstance(required_event, str) and
        required_event in PROVEN_ITEM_ACTOR_EVENTS
    )
    npc_event_character_actor_proven = (
        isinstance(required_event, str) and
        required_event in PROVEN_NPC_ACTOR_EVENTS
    )
    npc_actor_proven = npc_event_character_actor_proven
    character_actor_proven = (
        avatar_actor_proven or item_event_character_actor_proven or
        npc_event_character_actor_proven
    )
    weapon_actor_proven = character_actor_proven
    lines = [
        f"-- Extracted from {source.location}; review every TODO before enabling.",
        f"runtime.handler({lua_quote(handler_id)}, function(context)",
    ]
    if avatar_actor_proven:
        lines.append("    local actor = services.characters.avatar()")
    elif item_event_character_actor_proven:
        lines.append("    local actor = context.actors.character")
    elif npc_event_character_actor_proven:
        lines.append("    local actor = context.actors.npc")
    if avatar_fatal_hook:
        lines.append("    local prevent_death = false")
    raw_condition = value.get("condition", True)
    condition_expression = render_eoc_condition_expression(
        raw_condition, avatar_actor_proven, weapon_actor_proven,
        npc_event_character_actor_proven
    )
    condition_converted = condition_expression is not None
    if condition_expression is None:
        lines.append("    -- TODO: translate the legacy condition into a Lua predicate.")
        result.todos.append(
            f"{source.location}: EOC {eoc_id} condition needs a native Lua predicate"
        )
    elif condition_expression != "true":
        lines.append(f"    if not ({condition_expression}) then")
        lines.append("        return")
        lines.append("    end")
    effects = value.get("effect", [])
    if isinstance(effects, (dict, str)):
        effects = [effects]
    converted_effect = False
    all_effects_converted = True
    if isinstance(effects, list):
        for effect_index, effect in enumerate(effects):
            if avatar_fatal_hook and effect == "u_prevent_death":
                lines.append("    prevent_death = true")
                converted_effect = True
            elif avatar_actor_proven and effect == "u_cancel_activity":
                lines.append("    services.activities.cancel(actor)")
                converted_effect = True
            elif npc_event_character_actor_proven and \
                    effect == "npc_cancel_activity":
                lines.append("    services.activities.cancel(actor)")
                converted_effect = True
            elif (
                isinstance(effect, dict) and
                ("u_add_var" in effect or "npc_add_var" in effect)
            ):
                key = "u_add_var" if "u_add_var" in effect else "npc_add_var"
                target_expression = (
                    "actor" if key == "u_add_var" and character_actor_proven
                    else "actor" if key == "npc_add_var" and npc_event_character_actor_proven
                    else None
                )
                rendered = render_static_character_variable(
                    effect, key, target_expression
                )
                if rendered is not None:
                    lines.extend(rendered)
                    converted_effect = True
                else:
                    lines.append(
                        "    -- TODO: translate the variable name/value into "
                        "bounded Lua values."
                    )
                    result.todos.append(
                        f"{source.location}: EOC {eoc_id} effect #{effect_index} "
                        "needs domain-service conversion"
                    )
                    all_effects_converted = False
            elif (
                avatar_actor_proven and
                isinstance(effect, dict) and
                set(effect) == {"u_lose_var"} and
                bounded_utf8_string(effect.get("u_lose_var"), 256)
            ):
                lines.append(
                    "    services.variables.remove(actor, "
                    f"{lua_quote(effect['u_lose_var'])})"
                )
                converted_effect = True
            elif (
                npc_actor_proven and
                isinstance(effect, dict) and
                set(effect) == {"npc_lose_var"} and
                bounded_utf8_string(effect.get("npc_lose_var"), 256)
            ):
                lines.append(
                    "    services.variables.remove(actor, "
                    f"{lua_quote(effect['npc_lose_var'])})"
                )
                converted_effect = True
            elif (
                isinstance(effect, dict) and
                ("u_add_wound" in effect or "npc_add_wound" in effect)
            ):
                key = "u_add_wound" if "u_add_wound" in effect else "npc_add_wound"
                target_expression = (
                    "actor" if key == "u_add_wound" and character_actor_proven
                    else "actor" if key == "npc_add_wound" and npc_event_character_actor_proven
                    else None
                )
                rendered = render_static_character_wound(
                    effect, key, target_expression, False
                )
                if rendered is not None:
                    lines.extend(rendered)
                    converted_effect = True
                else:
                    lines.append(
                        "    -- TODO: translate the wound target or id into "
                        "bounded Lua values."
                    )
                    result.todos.append(
                        f"{source.location}: EOC {eoc_id} effect #{effect_index} "
                        "needs domain-service conversion"
                    )
                    all_effects_converted = False
            elif (
                isinstance(effect, dict) and
                ("u_remove_wound" in effect or "npc_remove_wound" in effect)
            ):
                key = "u_remove_wound" if "u_remove_wound" in effect else "npc_remove_wound"
                target_expression = (
                    "actor" if key == "u_remove_wound" and character_actor_proven
                    else "actor" if key == "npc_remove_wound" and npc_event_character_actor_proven
                    else None
                )
                rendered = render_static_character_wound(
                    effect, key, target_expression, True
                )
                if rendered is not None:
                    lines.extend(rendered)
                    converted_effect = True
                else:
                    lines.append(
                        "    -- TODO: translate the wound target or ids into "
                        "bounded Lua values."
                    )
                    result.todos.append(
                        f"{source.location}: EOC {eoc_id} effect #{effect_index} "
                        "needs domain-service conversion"
                    )
                    all_effects_converted = False
            elif (
                isinstance(effect, dict) and
                set(effect) == {"message"} and
                isinstance(effect.get("message"), str)
            ):
                lines.append(f"    services.message({lua_quote(effect['message'])})")
                converted_effect = True
            elif (
                avatar_actor_proven and
                isinstance(effect, dict) and
                set(effect) == {"u_message"} and
                isinstance(effect.get("u_message"), str)
            ):
                # The avatar target is the player, so the u_ spelling is the
                # same player message as the bare `message` effect.
                lines.append(f"    services.message({lua_quote(effect['u_message'])})")
                converted_effect = True
            elif (
                npc_actor_proven and
                isinstance(effect, dict) and
                set(effect) == {"npc_message"} and
                isinstance(effect.get("npc_message"), str)
            ):
                # The legacy handler returns early for an NPC target, so the
                # effect is a deliberate no-op under npc_becomes_hostile.
                converted_effect = True
            elif (
                isinstance(effect, dict) and
                set(effect) == {"give_achievement"} and
                safe_platform_id(effect.get("give_achievement"))
            ):
                lines.append("    services.achievements.complete(")
                lines.append(
                    "        services.types.id(\"achievement\", "
                    f"{lua_quote(effect['give_achievement'])}))"
                )
                converted_effect = True
            elif (
                avatar_actor_proven and
                isinstance(effect, dict) and
                set(effect) == {"u_add_bionic"} and
                safe_platform_id(effect.get("u_add_bionic"))
            ):
                lines.append("    services.bionics.grant(")
                lines.append("        actor,")
                lines.append(
                    "        services.types.id(\"bionic\", "
                    f"{lua_quote(effect['u_add_bionic'])}))"
                )
                converted_effect = True
            elif (
                avatar_actor_proven and
                isinstance(effect, dict) and
                set(effect) == {"u_lose_bionic"} and
                safe_platform_id(effect.get("u_lose_bionic"))
            ):
                lines.append("    services.bionics.remove_type(")
                lines.append("        actor,")
                lines.append(
                    "        services.types.id(\"bionic\", "
                    f"{lua_quote(effect['u_lose_bionic'])}))"
                )
                converted_effect = True
            elif (
                avatar_actor_proven and
                isinstance(effect, dict) and
                set(effect) == {"u_learn_recipe"} and
                safe_platform_id(effect.get("u_learn_recipe"))
            ):
                lines.append("    services.recipes.learn(")
                lines.append("        actor,")
                lines.append(
                    "        services.types.id(\"recipe\", "
                    f"{lua_quote(effect['u_learn_recipe'])}))"
                )
                converted_effect = True
            elif (
                avatar_actor_proven and
                isinstance(effect, dict) and
                set(effect) in (
                    {"u_forget_recipe", "category"},
                    {"u_forget_recipe", "subcategory"},
                    {"u_forget_recipe", "category", "subcategory"},
                ) and
                safe_platform_id(effect.get("u_forget_recipe")) and
                (
                    effect.get("category") is True or
                    "subcategory" in effect
                ) and
                (
                    "subcategory" not in effect or
                    safe_platform_id(effect.get("subcategory"))
                )
            ):
                lines.append("    services.recipes.forget_category(")
                lines.append("        actor,")
                category_suffix = "," if "subcategory" in effect else ")"
                lines.append(
                    "        services.types.id(\"crafting_category\", "
                    f"{lua_quote(effect['u_forget_recipe'])}){category_suffix}"
                )
                if "subcategory" in effect:
                    lines.append(
                        f"        {lua_quote(effect['subcategory'])})"
                    )
                converted_effect = True
            elif (
                avatar_actor_proven and
                isinstance(effect, dict) and
                set(effect) == {"u_forget_recipe"} and
                safe_platform_id(effect.get("u_forget_recipe"))
            ):
                lines.append("    services.recipes.forget(")
                lines.append("        actor,")
                lines.append(
                    "        services.types.id(\"recipe\", "
                    f"{lua_quote(effect['u_forget_recipe'])}))"
                )
                converted_effect = True
            elif (
                avatar_actor_proven and
                isinstance(effect, dict) and
                set(effect) == {"u_learn_martial_art"} and
                safe_platform_id(effect.get("u_learn_martial_art"))
            ):
                lines.append("    services.martial_arts.learn(")
                lines.append("        actor,")
                lines.append(
                    "        services.types.id(\"martial_art\", "
                    f"{lua_quote(effect['u_learn_martial_art'])}))"
                )
                converted_effect = True
            elif (
                avatar_actor_proven and
                isinstance(effect, dict) and
                set(effect) == {"u_forget_martial_art"} and
                safe_platform_id(effect.get("u_forget_martial_art"))
            ):
                lines.append("    services.martial_arts.forget(")
                lines.append("        actor,")
                lines.append(
                    "        services.types.id(\"martial_art\", "
                    f"{lua_quote(effect['u_forget_martial_art'])}))"
                )
                converted_effect = True
            elif (
                npc_actor_proven and
                isinstance(effect, dict) and
                set(effect) == {"npc_add_bionic"} and
                safe_platform_id(effect.get("npc_add_bionic"))
            ):
                lines.append("    services.bionics.grant(")
                lines.append("        actor,")
                lines.append(
                    "        services.types.id(\"bionic\", "
                    f"{lua_quote(effect['npc_add_bionic'])}))"
                )
                converted_effect = True
            elif (
                npc_actor_proven and
                isinstance(effect, dict) and
                set(effect) == {"npc_lose_bionic"} and
                safe_platform_id(effect.get("npc_lose_bionic"))
            ):
                lines.append("    services.bionics.remove_type(")
                lines.append("        actor,")
                lines.append(
                    "        services.types.id(\"bionic\", "
                    f"{lua_quote(effect['npc_lose_bionic'])}))"
                )
                converted_effect = True
            elif (
                npc_actor_proven and
                isinstance(effect, dict) and
                set(effect) == {"npc_learn_recipe"} and
                safe_platform_id(effect.get("npc_learn_recipe"))
            ):
                lines.append("    services.recipes.learn(")
                lines.append("        actor,")
                lines.append(
                    "        services.types.id(\"recipe\", "
                    f"{lua_quote(effect['npc_learn_recipe'])}))"
                )
                converted_effect = True
            elif (
                npc_actor_proven and
                isinstance(effect, dict) and
                set(effect) == {"npc_forget_recipe"} and
                safe_platform_id(effect.get("npc_forget_recipe"))
            ):
                lines.append("    services.recipes.forget(")
                lines.append("        actor,")
                lines.append(
                    "        services.types.id(\"recipe\", "
                    f"{lua_quote(effect['npc_forget_recipe'])}))"
                )
                converted_effect = True
            elif (
                npc_actor_proven and
                isinstance(effect, dict) and
                set(effect) == {"npc_learn_martial_art"} and
                safe_platform_id(effect.get("npc_learn_martial_art"))
            ):
                lines.append("    services.martial_arts.learn(")
                lines.append("        actor,")
                lines.append(
                    "        services.types.id(\"martial_art\", "
                    f"{lua_quote(effect['npc_learn_martial_art'])}))"
                )
                converted_effect = True
            elif (
                npc_actor_proven and
                isinstance(effect, dict) and
                set(effect) == {"npc_forget_martial_art"} and
                safe_platform_id(effect.get("npc_forget_martial_art"))
            ):
                lines.append("    services.martial_arts.forget(")
                lines.append("        actor,")
                lines.append(
                    "        services.types.id(\"martial_art\", "
                    f"{lua_quote(effect['npc_forget_martial_art'])}))"
                )
                converted_effect = True
            elif (
                isinstance(effect, dict) and
                len(
                    [
                        key for key in (
                            "u_mutate", "npc_mutate",
                            "u_mutate_category", "npc_mutate_category",
                            "u_mutate_towards", "npc_mutate_towards",
                        )
                        if key in effect
                    ]
                ) == 1
            ):
                mutation_key = next(
                    key for key in (
                        "u_mutate", "npc_mutate",
                        "u_mutate_category", "npc_mutate_category",
                        "u_mutate_towards", "npc_mutate_towards",
                    )
                    if key in effect
                )
                target_expression = (
                    "actor" if mutation_key.startswith("u_") and
                    avatar_actor_proven
                    else "actor" if mutation_key.startswith("npc_") and
                    npc_event_character_actor_proven
                    else None
                )
                rendered = render_static_mutation_effect(
                    effect, mutation_key, target_expression
                )
                if rendered is not None:
                    lines.extend(rendered)
                    converted_effect = True
                else:
                    lines.append(
                        "    -- TODO: translate the mutation target, category, "
                        "chance, or options into bounded Lua values."
                    )
                    result.todos.append(
                        f"{source.location}: EOC {eoc_id} effect #{effect_index} "
                        "needs domain-service conversion"
                    )
                    all_effects_converted = False
            elif (
                isinstance(effect, dict) and
                ("u_add_effect" in effect or "npc_add_effect" in effect)
            ):
                key = "u_add_effect" if "u_add_effect" in effect else "npc_add_effect"
                target_expression = (
                    "actor" if key == "npc_add_effect" and npc_event_character_actor_proven
                    else "actor" if key == "u_add_effect" and avatar_actor_proven
                    else None
                )
                rendered = render_static_character_effect(
                    effect, key, target_expression
                )
                if rendered is not None:
                    lines.extend(rendered)
                    converted_effect = True
                else:
                    lines.append(
                        "    -- TODO: translate the effect amount, target, or "
                        "options into bounded Lua values."
                    )
                    result.todos.append(
                        f"{source.location}: EOC {eoc_id} effect #{effect_index} "
                        "needs domain-service conversion"
                    )
                    all_effects_converted = False
            elif (
                avatar_actor_proven and
                isinstance(effect, dict) and
                set(effect) == {"u_activate_trait"} and
                safe_platform_id(effect.get("u_activate_trait"))
            ):
                lines.append("    services.mutations.set_active(")
                lines.append("        actor,")
                lines.append(
                    "        services.types.id(\"mutation\", "
                    f"{lua_quote(effect['u_activate_trait'])}),"
                )
                lines.append("        true)")
                converted_effect = True
            elif (
                avatar_actor_proven and
                isinstance(effect, dict) and
                set(effect) == {"u_deactivate_trait"} and
                safe_platform_id(effect.get("u_deactivate_trait"))
            ):
                lines.append("    services.mutations.set_active(")
                lines.append("        actor,")
                lines.append(
                    "        services.types.id(\"mutation\", "
                    f"{lua_quote(effect['u_deactivate_trait'])}),"
                )
                lines.append("        false)")
                converted_effect = True
            elif (
                npc_actor_proven and
                isinstance(effect, dict) and
                set(effect) == {"npc_activate_trait"} and
                safe_platform_id(effect.get("npc_activate_trait"))
            ):
                lines.append("    services.mutations.set_active(")
                lines.append("        actor,")
                lines.append(
                    "        services.types.id(\"mutation\", "
                    f"{lua_quote(effect['npc_activate_trait'])}),"
                )
                lines.append("        true)")
                converted_effect = True
            elif (
                npc_actor_proven and
                isinstance(effect, dict) and
                set(effect) == {"npc_deactivate_trait"} and
                safe_platform_id(effect.get("npc_deactivate_trait"))
            ):
                lines.append("    services.mutations.set_active(")
                lines.append("        actor,")
                lines.append(
                    "        services.types.id(\"mutation\", "
                    f"{lua_quote(effect['npc_deactivate_trait'])}),"
                )
                lines.append("        false)")
                converted_effect = True
            elif (
                avatar_actor_proven and
                isinstance(effect, dict) and
                set(effect) <= {"u_add_trait", "variant"} and
                "u_add_trait" in effect and
                safe_platform_id(effect.get("u_add_trait")) and
                (
                    "variant" not in effect or
                    (
                        isinstance(effect.get("variant"), str) and
                        bool(effect["variant"])
                    )
                )
            ):
                lines.append("    services.mutations.grant(")
                lines.append("        actor,")
                if "variant" in effect:
                    lines.append(
                        "        services.types.id(\"mutation\", "
                        f"{lua_quote(effect['u_add_trait'])}),"
                    )
                    lines.append(
                        f"        {lua_quote(effect['variant'])})"
                    )
                else:
                    lines.append(
                        "        services.types.id(\"mutation\", "
                        f"{lua_quote(effect['u_add_trait'])}))"
                    )
                converted_effect = True
            elif (
                npc_event_character_actor_proven and
                isinstance(effect, dict) and
                set(effect) <= {"npc_add_trait", "variant"} and
                "npc_add_trait" in effect and
                safe_platform_id(effect.get("npc_add_trait")) and
                (
                    "variant" not in effect or
                    (
                        isinstance(effect.get("variant"), str) and
                        bool(effect["variant"])
                    )
                )
            ):
                lines.append("    services.mutations.grant(")
                lines.append("        actor,")
                if "variant" in effect:
                    lines.append(
                        "        services.types.id(\"mutation\", "
                        f"{lua_quote(effect['npc_add_trait'])}),"
                    )
                    lines.append(
                        f"        {lua_quote(effect['variant'])})"
                    )
                else:
                    lines.append(
                        "        services.types.id(\"mutation\", "
                        f"{lua_quote(effect['npc_add_trait'])}))"
                    )
                converted_effect = True
            elif (
                avatar_actor_proven and
                isinstance(effect, dict) and
                set(effect) == {"u_lose_trait"} and
                safe_platform_id(effect.get("u_lose_trait"))
            ):
                lines.append("    services.mutations.remove(")
                lines.append("        actor,")
                lines.append(
                    "        services.types.id(\"mutation\", "
                    f"{lua_quote(effect['u_lose_trait'])}))"
                )
                converted_effect = True
            elif (
                npc_event_character_actor_proven and
                isinstance(effect, dict) and
                set(effect) == {"npc_lose_trait"} and
                safe_platform_id(effect.get("npc_lose_trait"))
            ):
                lines.append("    services.mutations.remove(")
                lines.append("        actor,")
                lines.append(
                    "        services.types.id(\"mutation\", "
                    f"{lua_quote(effect['npc_lose_trait'])}))"
                )
                converted_effect = True
            elif (
                avatar_actor_proven and
                isinstance(effect, dict) and
                set(effect) == {"u_lose_effect"} and
                safe_platform_id(effect.get("u_lose_effect"))
            ):
                lines.append("    services.effects.remove(")
                lines.append("        actor,")
                lines.append(
                    "        services.types.id(\"effect\", "
                    f"{lua_quote(effect['u_lose_effect'])}))"
                )
                converted_effect = True
            elif (
                avatar_actor_proven and
                isinstance(effect, dict) and
                set(effect) == {"u_add_wet"} and
                isinstance(effect.get("u_add_wet"), int) and
                not isinstance(effect.get("u_add_wet"), bool) and
                -1000000 <= effect["u_add_wet"] <= 1000000
            ):
                lines.append(
                    f"    services.characters.add_wet(actor, "
                    f"{effect['u_add_wet']})"
                )
                converted_effect = True
            elif (
                npc_event_character_actor_proven and
                isinstance(effect, dict) and
                set(effect) == {"npc_add_wet"} and
                isinstance(effect.get("npc_add_wet"), int) and
                not isinstance(effect.get("npc_add_wet"), bool) and
                -1000000 <= effect["npc_add_wet"] <= 1000000
            ):
                lines.append(
                    f"    services.characters.add_wet(actor, "
                    f"{effect['npc_add_wet']})"
                )
                converted_effect = True
            elif (
                isinstance(effect, dict) and
                ("u_add_morale" in effect or "npc_add_morale" in effect)
            ):
                key = "u_add_morale" if "u_add_morale" in effect else "npc_add_morale"
                target_expression = (
                    "actor" if key == "npc_add_morale" and npc_event_character_actor_proven
                    else "actor" if key == "u_add_morale" and avatar_actor_proven
                    else None
                )
                rendered = render_static_character_morale(
                    effect, key, target_expression
                )
                if rendered is not None:
                    lines.extend(rendered)
                    converted_effect = True
                else:
                    lines.append(
                        "    -- TODO: translate the morale amount, target, or "
                        "options into bounded Lua values."
                    )
                    result.todos.append(
                        f"{source.location}: EOC {eoc_id} effect #{effect_index} "
                        "needs domain-service conversion"
                    )
                    all_effects_converted = False
            elif (
                avatar_actor_proven and
                isinstance(effect, dict) and
                set(effect) == {"u_lose_morale"} and
                safe_platform_id(effect.get("u_lose_morale"))
            ):
                lines.append("    services.morale.remove(")
                lines.append("        actor,")
                lines.append(
                    "        services.types.id(\"morale\", "
                    f"{lua_quote(effect['u_lose_morale'])}))"
                )
                converted_effect = True
            elif (
                npc_actor_proven and
                isinstance(effect, dict) and
                set(effect) == {"npc_add_morale", "bonus", "max_bonus"} and
                safe_platform_id(effect.get("npc_add_morale")) and
                isinstance(effect.get("bonus"), int) and
                not isinstance(effect.get("bonus"), bool) and
                NATIVE_INT_MIN <= effect["bonus"] <= NATIVE_INT_MAX and
                isinstance(effect.get("max_bonus"), int) and
                not isinstance(effect.get("max_bonus"), bool) and
                NATIVE_INT_MIN <= effect["max_bonus"] <= NATIVE_INT_MAX
            ):
                lines.append("    services.morale.add(")
                lines.append("        actor,")
                lines.append(
                    "        services.types.id(\"morale\", "
                    f"{lua_quote(effect['npc_add_morale'])}),"
                )
                lines.append(
                    f"        {effect['bonus']}, {effect['max_bonus']})"
                )
                converted_effect = True
            elif (
                npc_actor_proven and
                isinstance(effect, dict) and
                set(effect) == {"npc_lose_morale"} and
                safe_platform_id(effect.get("npc_lose_morale"))
            ):
                lines.append("    services.morale.remove(")
                lines.append("        actor,")
                lines.append(
                    "        services.types.id(\"morale\", "
                    f"{lua_quote(effect['npc_lose_morale'])}))"
                )
                converted_effect = True
            elif (
                item_event_character_actor_proven and
                isinstance(effect, dict) and
                set(effect) == {"npc_set_flag"} and
                safe_platform_id(effect.get("npc_set_flag")) and
                len(effect["npc_set_flag"].encode("utf-8")) <= 256
            ):
                lines.append("    if context.actors.item ~= nil then")
                lines.append("        services.items.set_flag(")
                lines.append("            context.actors.item,")
                lines.append(
                    "            services.types.id(\"json_flag\", "
                    f"{lua_quote(effect['npc_set_flag'])}), true)"
                )
                lines.append("    end")
                converted_effect = True
            elif (
                item_event_character_actor_proven and
                isinstance(effect, dict) and
                set(effect) == {"npc_unset_flag"} and
                safe_platform_id(effect.get("npc_unset_flag")) and
                len(effect["npc_unset_flag"].encode("utf-8")) <= 256
            ):
                lines.append("    if context.actors.item ~= nil then")
                lines.append("        services.items.set_flag(")
                lines.append("            context.actors.item,")
                lines.append(
                    "            services.types.id(\"json_flag\", "
                    f"{lua_quote(effect['npc_unset_flag'])}), false)"
                )
                lines.append("    end")
                converted_effect = True
            elif (
                item_event_character_actor_proven and
                isinstance(effect, dict) and
                set(effect) == {"set_browsed"} and
                isinstance(effect.get("set_browsed"), bool)
            ):
                lines.append("    if context.actors.item ~= nil then")
                lines.append("        service_value(services.items.update(")
                lines.append("            context.actors.item, {")
                lines.append(
                    "                browsed = " +
                    ("true" if effect["set_browsed"] else "false") + ","
                )
                lines.append("            }))")
                lines.append("    end")
                converted_effect = True
            elif (
                item_event_character_actor_proven and
                isinstance(effect, dict) and
                set(effect) <= {"transform_item", "active"} and
                "transform_item" in effect and
                (
                    "active" not in effect or
                    isinstance(effect.get("active"), bool)
                )
            ):
                target_expression = render_eoc_string_expression(
                    effect.get("transform_item")
                )
                if target_expression is None:
                    lines.append(
                        "    -- TODO: translate the dynamic item transform target."
                    )
                    result.todos.append(
                        f"{source.location}: EOC {eoc_id} transform_item "
                        "target needs a bounded Lua expression"
                    )
                    all_effects_converted = False
                else:
                    active = "true" if effect.get("active", False) else "false"
                    lines.append("    if context.actors.item ~= nil then")
                    lines.append("        service_value(services.items.transform(")
                    lines.append("            context.actors.item,")
                    lines.append(
                        "            services.types.id(\"item\", " +
                        target_expression + "), {"
                    )
                    lines.append("                carrier = actor,")
                    lines.append(f"                active = {active},")
                    lines.append("            }))")
                    lines.append("    end")
                    converted_effect = True
            elif (
                item_event_character_actor_proven and
                isinstance(effect, dict) and
                ("u_set_fault" in effect or "npc_set_fault" in effect)
            ):
                key = "u_set_fault" if "u_set_fault" in effect else "npc_set_fault"
                rendered = render_static_item_fault_effect(
                    effect, key
                )
                if rendered is not None:
                    lines.extend(rendered)
                    converted_effect = True
                else:
                    lines.append(
                        "    -- TODO: translate the item fault id and options "
                        "into bounded Lua values."
                    )
                    result.todos.append(
                        f"{source.location}: EOC {eoc_id} effect #{effect_index} "
                        "needs domain-service conversion"
                    )
                    all_effects_converted = False
            elif (
                item_event_character_actor_proven and
                isinstance(effect, dict) and
                ("u_set_random_fault_of_type" in effect or
                 "npc_set_random_fault_of_type" in effect)
            ):
                key = (
                    "u_set_random_fault_of_type"
                    if "u_set_random_fault_of_type" in effect
                    else "npc_set_random_fault_of_type"
                )
                rendered = render_static_item_fault_effect(
                    effect, key
                )
                if rendered is not None:
                    lines.extend(rendered)
                    converted_effect = True
                else:
                    lines.append(
                        "    -- TODO: translate the random item fault type "
                        "and options into bounded Lua values."
                    )
                    result.todos.append(
                        f"{source.location}: EOC {eoc_id} effect #{effect_index} "
                        "needs domain-service conversion"
                    )
                    all_effects_converted = False
            elif (
                isinstance(effect, dict) and
                set(effect) <= {"sound_effect", "id", "volume"} and
                {"sound_effect", "id"} <= set(effect) and
                isinstance(effect.get("id"), str) and
                isinstance(effect.get("sound_effect"), str) and
                bool(effect["id"]) and
                bool(effect["sound_effect"]) and
                (
                    "volume" not in effect or
                    (
                        isinstance(effect.get("volume"), int) and
                        not isinstance(effect.get("volume"), bool) and
                        0 <= effect["volume"] <= 128
                    )
                )
            ):
                volume = effect.get("volume", 80)
                lines.append(
                    "    services.sound.play("
                    f"{lua_quote(effect['id'])}, "
                    f"{lua_quote(effect['sound_effect'])}, {volume})"
                )
                converted_effect = True
            elif npc_actor_proven and effect == "npc_wants_to_talk":
                lines.append('    services.npcs.set_attitude(actor, "talk")')
                converted_effect = True
            elif npc_actor_proven and effect == "u_wants_to_talk":
                # Avatar target has no NPC talker (d.actor(false)->get_npc() is null),
                # so this effect is a deliberate no-op under npc_becomes_hostile.
                converted_effect = True
            elif npc_actor_proven and effect == "hostile":
                lines.append('    services.npcs.set_attitude(actor, "kill")')
                converted_effect = True
            elif npc_actor_proven and effect == "flee":
                lines.append('    services.npcs.set_attitude(actor, "flee")')
                converted_effect = True
            elif (
                npc_actor_proven and isinstance(effect, dict) and
                set(effect) == {"npc_change_class"} and
                safe_platform_id(effect.get("npc_change_class"))
            ):
                lines.append(
                    "    services.npcs.set_class(actor, "
                    "services.types.id(\"npc_class\", "
                    f"{lua_quote(effect['npc_change_class'])}))"
                )
                converted_effect = True
            elif (
                npc_actor_proven and isinstance(effect, dict) and
                set(effect) == {"npc_change_faction"} and
                safe_platform_id(effect.get("npc_change_faction"))
            ):
                lines.append(
                    "    services.npcs.set_faction(actor, "
                    "services.types.id(\"faction\", "
                    f"{lua_quote(effect['npc_change_faction'])}))"
                )
                converted_effect = True
            elif (
                npc_actor_proven and isinstance(effect, dict) and
                set(effect) == {"npc_first_topic"} and
                bounded_utf8_string(
                    effect.get("npc_first_topic"), 256, allow_empty=False
                )
            ):
                lines.append(
                    "    services.npcs.set_first_topic(actor, "
                    f"{lua_quote(effect['npc_first_topic'])})"
                )
                converted_effect = True
            elif npc_actor_proven and effect == "npc_make_radio_representative":
                lines.append(
                    "    services.npcs.set_radio_representative(actor, true)"
                )
                converted_effect = True
            elif npc_actor_proven and effect == "npc_thankful":
                lines.append("    services.npcs.make_thankful(actor)")
                converted_effect = True
            elif (
                npc_actor_proven and isinstance(effect, dict) and
                len(effect) == 1 and
                next(iter(effect)) in {
                    "set_npc_rule", "clear_npc_rule", "toggle_npc_rule"
                } and
                safe_platform_id(effect.get(next(iter(effect))))
            ):
                key = next(iter(effect))
                enabled = {
                    "set_npc_rule": "true",
                    "clear_npc_rule": "false",
                    "toggle_npc_rule": "nil",
                }[key]
                lines.append(
                    "    services.npcs.set_ally_rule(actor, "
                    f"{lua_quote(effect[key])}, {enabled})"
                )
                converted_effect = True
            elif (
                npc_actor_proven and isinstance(effect, dict) and
                len(effect) == 1 and
                next(iter(effect)) in {
                    "set_npc_aim_rule", "set_npc_engagement_rule",
                    "set_npc_cbm_recharge_rule", "set_npc_cbm_reserve_rule",
                } and
                safe_platform_id(effect.get(next(iter(effect))))
            ):
                key = next(iter(effect))
                family = {
                    "set_npc_aim_rule": "aim",
                    "set_npc_engagement_rule": "engagement",
                    "set_npc_cbm_recharge_rule": "cbm_recharge",
                    "set_npc_cbm_reserve_rule": "cbm_reserve",
                }[key]
                lines.append(
                    "    services.npcs.set_ai_policy(actor, "
                    f"{lua_quote(family)}, {lua_quote(effect[key])})"
                )
                converted_effect = True
            elif (
                isinstance(effect, dict) and len(effect) == 1 and
                next(iter(effect)) in {
                    "u_recalculate_enchantment_cache",
                    "npc_recalculate_enchantment_cache",
                } and (
                    "npc_recalculate_enchantment_cache" in effect and
                    npc_event_character_actor_proven or
                    "u_recalculate_enchantment_cache" in effect and
                    (avatar_actor_proven or npc_event_character_actor_proven)
                )
            ):
                key = next(iter(effect))
                target = None
                if key.startswith("npc_") and npc_event_character_actor_proven:
                    target = "actor"
                elif key.startswith("u_") and avatar_actor_proven:
                    target = "actor"
                elif key.startswith("u_") and npc_event_character_actor_proven:
                    target = "services.characters.avatar()"
                lines.append(
                    "    services.characters.recalculate_enchantments("
                    f"{target})"
                )
                converted_effect = True
            elif effect == "nothing":
                # Deliberate no-op.
                converted_effect = True
            elif (
                avatar_actor_proven and
                isinstance(effect, dict) and
                set(effect) <= {"u_spawn_item", "count"} and
                "u_spawn_item" in effect and
                safe_platform_id(effect.get("u_spawn_item")) and
                (
                    "count" not in effect or
                    (
                        isinstance(effect.get("count"), int) and
                        not isinstance(effect.get("count"), bool) and
                        1 <= effect["count"] <= 100
                    )
                )
            ):
                count = effect.get("count", 1)
                lines.append(
                    "    services.inventory.give(actor, "
                    f"services.types.id(\"item\", {lua_quote(effect['u_spawn_item'])}), {count})"
                )
                converted_effect = True
            elif (
                isinstance(effect, dict) and
                set(effect) <= {"map_spawn_item", "count", "loc"} and
                "map_spawn_item" in effect and
                safe_platform_id(effect.get("map_spawn_item")) and
                (
                    "count" not in effect or
                    (
                        isinstance(effect.get("count"), int) and
                        not isinstance(effect.get("count"), bool) and
                        1 <= effect["count"] <= 100
                    )
                ) and
                (
                    (
                        isinstance(effect.get("loc"), dict) and
                        set(effect["loc"]) == {"context_val"} and
                        isinstance(effect["loc"].get("context_val"), str) and
                        safe_platform_id(effect["loc"]["context_val"])
                    ) or
                    (
                        "loc" not in effect and
                        avatar_actor_proven
                    )
                )
            ):
                count = effect.get("count", 1)
                if "loc" in effect:
                    loc_expr = f"context.data[{lua_quote(effect['loc']['context_val'])}]"
                else:
                    loc_expr = "service_value(services.characters.snapshot(actor)).creature.position"
                lines.append(
                    f"    services.world.spawn_item({loc_expr}, "
                    f"services.types.id(\"item\", {lua_quote(effect['map_spawn_item'])}), {count})"
                )
                converted_effect = True
            elif avatar_actor_proven and effect == "player_weapon_away":
                lines.append("    services.inventory.stash_wielded(actor)")
                converted_effect = True
            elif (
                isinstance(effect, dict) and
                set(effect) <= {"set_trap", "loc"} and
                "set_trap" in effect and
                safe_platform_id(effect.get("set_trap")) and
                (
                    (
                        isinstance(effect.get("loc"), dict) and
                        set(effect["loc"]) == {"context_val"} and
                        isinstance(effect["loc"].get("context_val"), str) and
                        safe_platform_id(effect["loc"]["context_val"])
                    ) or
                    (
                        "loc" not in effect and
                        avatar_actor_proven
                    )
                )
            ):
                if "loc" in effect:
                    loc_expr = f"context.data[{lua_quote(effect['loc']['context_val'])}]"
                else:
                    loc_expr = "service_value(services.characters.snapshot(actor)).creature.position"
                lines.append(
                    f"    services.world.set_trap({loc_expr}, "
                    f"services.types.id(\"trap\", {lua_quote(effect['set_trap'])}))"
                )
                converted_effect = True
            elif (
                isinstance(effect, dict) and
                set(effect) <= {"signal_hordes", "loc"} and
                "signal_hordes" in effect and
                isinstance(effect.get("signal_hordes"), int) and
                not isinstance(effect.get("signal_hordes"), bool) and
                effect["signal_hordes"] >= 0 and
                (
                    (
                        isinstance(effect.get("loc"), dict) and
                        set(effect["loc"]) == {"context_val"} and
                        isinstance(effect["loc"].get("context_val"), str) and
                        safe_platform_id(effect["loc"]["context_val"])
                    ) or
                    (
                        "loc" not in effect and
                        avatar_actor_proven
                    )
                )
            ):
                if "loc" in effect:
                    loc_expr = f"context.data[{lua_quote(effect['loc']['context_val'])}]"
                else:
                    loc_expr = "service_value(services.characters.snapshot(actor)).creature.position"
                lines.append(
                    f"    services.hordes.signal({loc_expr}, {effect['signal_hordes']})"
                )
                converted_effect = True
            elif (
                isinstance(effect, dict) and
                set(effect) <= {"reveal_route", "radius"} and
                "reveal_route" in effect and
                isinstance(effect.get("reveal_route"), dict) and
                set(effect["reveal_route"]) == {"context_val"} and
                isinstance(effect["reveal_route"].get("context_val"), str) and
                safe_platform_id(effect["reveal_route"]["context_val"]) and
                (
                    "radius" not in effect or
                    (
                        isinstance(effect.get("radius"), int) and
                        not isinstance(effect.get("radius"), bool) and
                        0 <= effect["radius"] <= 100
                    )
                )
            ):
                radius = effect.get("radius", 0)
                loc_expr = f"context.data[{lua_quote(effect['reveal_route']['context_val'])}]"
                lines.append(f"    services.overmap.reveal({loc_expr}, {radius})")
                converted_effect = True
            elif npc_actor_proven and effect == "follow":
                lines.append('    services.npcs.set_attitude(actor, "follow")')
                converted_effect = True
            elif npc_actor_proven and effect == "stop_following":
                lines.append('    services.npcs.set_attitude(actor, "null")')
                converted_effect = True
            elif npc_actor_proven and effect == "stranger_neutral":
                lines.append('    services.npcs.set_attitude(actor, "null")')
                converted_effect = True
            elif effect == "end_conversation":
                # Deliberate no-op.
                converted_effect = True
            elif (
                avatar_actor_proven and
                isinstance(effect, dict) and
                set(effect) == {"turn_cost"} and
                isinstance(effect.get("turn_cost"), int) and
                not isinstance(effect.get("turn_cost"), bool) and
                effect["turn_cost"] >= 0
            ):
                lines.append(f"    services.characters.adjust(actor, {{ moves = -{effect['turn_cost']} }})")
                converted_effect = True
            elif npc_actor_proven and isinstance(effect, str) and effect in {"wake_up", "reveal_stats"}:
                # Deliberate no-op in headless/scripted context.
                converted_effect = True
            elif npc_actor_proven and effect == "insult_combat":
                lines.append('    services.npcs.set_attitude(actor, "kill")')
                converted_effect = True
            elif npc_actor_proven and effect == "lead_to_safety":
                lines.append('    services.npcs.set_attitude(actor, "lead")')
                converted_effect = True
            elif npc_actor_proven and effect == "leave":
                lines.append('    services.npcs.set_attitude(actor, "null")')
                converted_effect = True
            elif npc_actor_proven and effect == "follow_only":
                lines.append('    services.npcs.set_attitude(actor, "follow")')
                converted_effect = True
            elif npc_actor_proven and effect == "deny_follow":
                lines.append(
                    '    services.effects.add(actor, services.types.id("effect", "asked_to_follow"), services.time.duration(21600, "turn"))'
                )
                converted_effect = True
            elif npc_actor_proven and effect == "deny_lead":
                lines.append(
                    '    services.effects.add(actor, services.types.id("effect", "asked_to_lead"), services.time.duration(21600, "turn"))'
                )
                converted_effect = True
            elif npc_actor_proven and effect == "deny_equipment":
                lines.append(
                    '    services.effects.add(actor, services.types.id("effect", "asked_for_item"), services.time.duration(3600, "turn"))'
                )
                converted_effect = True
            elif npc_actor_proven and effect == "deny_train":
                lines.append(
                    '    services.effects.add(actor, services.types.id("effect", "asked_to_train"), services.time.duration(21600, "turn"))'
                )
                converted_effect = True
            elif npc_actor_proven and effect == "deny_personal_info":
                lines.append(
                    '    services.effects.add(actor, services.types.id("effect", "asked_personal_info"), services.time.duration(10800, "turn"))'
                )
                converted_effect = True
            elif npc_actor_proven and effect == "player_leaving":
                lines.append('    services.npcs.set_attitude(actor, "wait_for_leave")')
                converted_effect = True
            elif npc_actor_proven and effect == "start_mugging":
                lines.append('    services.npcs.set_attitude(actor, "mug")')
                converted_effect = True
            elif npc_actor_proven and effect == "remove_stolen_status":
                lines.append('    services.npcs.set_attitude(actor, "null")')
                converted_effect = True
            elif npc_actor_proven and effect == "assign_guard":
                lines.append('    services.npcs.set_attitude(actor, "null")')
                converted_effect = True
            elif npc_actor_proven and effect == "stop_guard":
                lines.append('    services.npcs.set_attitude(actor, "follow")')
                converted_effect = True
            elif npc_actor_proven and effect == "buy_chicken":
                lines.append(
                    '    services.spawns.monster(services.types.id("monster", "mon_chicken"), '
                    'service_value(services.characters.snapshot(actor)).creature.position, 1)'
                )
                converted_effect = True
            elif npc_actor_proven and effect == "buy_horse":
                lines.append(
                    '    services.spawns.monster(services.types.id("monster", "mon_horse"), '
                    'service_value(services.characters.snapshot(actor)).creature.position, 1)'
                )
                converted_effect = True
            elif npc_actor_proven and effect == "buy_cow":
                lines.append(
                    '    services.spawns.monster(services.types.id("monster", "mon_cow"), '
                    'service_value(services.characters.snapshot(actor)).creature.position, 1)'
                )
                converted_effect = True
            elif isinstance(effect, str) and effect in {"start_trade", "barber_hair", "barber_beard", "buy_haircut", "buy_shave"}:
                # Deliberate presentation/interaction no-op in headless/scripted context.
                converted_effect = True
            elif npc_actor_proven and effect == "revert_activity":
                lines.append('    services.activities.cancel(actor)')
                converted_effect = True
            elif npc_actor_proven and effect == "morale_chat_activity":
                lines.append(
                    render_named_character_activity(
                        "services.characters.avatar()", "ACT_SOCIALIZE", 10
                    )
                )
                converted_effect = True
            elif npc_actor_proven and effect == "do_butcher":
                lines.append(render_named_character_activity("actor", "ACT_BUTCHER", 30))
                converted_effect = True
            elif npc_actor_proven and effect == "do_chop_plank":
                lines.append(render_named_character_activity("actor", "ACT_CHOP_PLANKS", 30))
                converted_effect = True
            elif npc_actor_proven and effect == "do_chop_trees":
                lines.append(render_named_character_activity("actor", "ACT_CHOP_TREE", 60))
                converted_effect = True
            elif npc_actor_proven and effect == "do_construction":
                lines.append(render_named_character_activity("actor", "ACT_BUILD", 60))
                converted_effect = True
            elif npc_actor_proven and effect == "do_farming":
                lines.append(render_named_character_activity("actor", "ACT_PLANT_SEED", 30))
                converted_effect = True
            elif npc_actor_proven and effect == "do_fishing":
                lines.append(render_named_character_activity("actor", "ACT_FISH", 60))
                converted_effect = True
            elif npc_actor_proven and effect == "do_mining":
                lines.append(render_named_character_activity("actor", "ACT_MINING", 60))
                converted_effect = True
            elif npc_actor_proven and effect == "do_mopping":
                lines.append(render_named_character_activity("actor", "ACT_MOPPING", 15))
                converted_effect = True
            elif npc_actor_proven and isinstance(effect, str) and effect in {"do_read", "do_eread"}:
                lines.append(render_named_character_activity("actor", "ACT_READ", 30))
                converted_effect = True
            elif npc_actor_proven and effect == "do_read_repeatedly":
                lines.append(render_named_character_activity("actor", "ACT_READ", 120))
                converted_effect = True
            elif npc_actor_proven and effect == "do_study":
                lines.append(render_named_character_activity("actor", "ACT_STUDY_SPELL", 60))
                converted_effect = True
            elif npc_actor_proven and effect == "sort_loot":
                lines.append(render_named_character_activity("actor", "ACT_SORT_LOOT", 30))
                converted_effect = True
            elif npc_actor_proven and effect == "do_craft":
                lines.append(render_named_character_activity("actor", "ACT_CRAFT", 60))
                converted_effect = True
            elif npc_actor_proven and effect == "do_disassembly":
                lines.append(render_named_character_activity("actor", "ACT_DISASSEMBLE", 60))
                converted_effect = True
            elif npc_actor_proven and effect == "do_vehicle_deconstruct":
                lines.append(render_named_character_activity("actor", "ACT_VEHICLE_DECONSTRUCT", 60))
                converted_effect = True
            elif npc_actor_proven and effect == "do_vehicle_repair":
                lines.append(render_named_character_activity("actor", "ACT_VEHICLE_REPAIR", 60))
                converted_effect = True
            elif npc_actor_proven and effect == "drop_items_in_place":
                lines.append(render_named_character_activity("actor", "ACT_DROP", 1))
                converted_effect = True
            elif npc_actor_proven and effect == "find_mount":
                lines.append(render_named_character_activity("actor", "ACT_FIND_MOUNT", 10))
                converted_effect = True
            elif npc_actor_proven and isinstance(effect, str) and effect in {"start_training", "start_training_seminar"}:
                lines.append(render_named_character_activity("actor", "ACT_TRAIN", 60))
                converted_effect = True
            elif npc_actor_proven and effect == "distribute_food_auto":
                lines.append(render_named_character_activity("actor", "ACT_DISTRIBUTE_FOOD", 30))
                converted_effect = True
            elif effect == "lightning":
                # The native effect only arms the weather manager when the
                # player is above ground; the typed service preserves that
                # gate and exposes a detached weather snapshot.
                lines.append("    services.weather.activate_lightning()")
                converted_effect = True
            elif effect == "next_weather":
                # `weather.refresh` is the native set_nextweather(calendar::turn)
                # operation used by the legacy next_weather effect.
                lines.append("    services.weather.refresh()")
                converted_effect = True
            elif isinstance(effect, dict) and (
                "u_pick_bodypart" in effect or "npc_pick_bodypart" in effect
            ):
                key = (
                    "u_pick_bodypart"
                    if "u_pick_bodypart" in effect
                    else "npc_pick_bodypart"
                )
                rendered = render_static_character_pick_bodypart(
                    effect, key, avatar_actor_proven,
                    npc_event_character_actor_proven,
                )
                if rendered is not None:
                    lines.extend(rendered)
                    converted_effect = True
                else:
                    lines.append(
                        "    -- TODO: translate body-part picking through an "
                        "explicit non-interactive character service."
                    )
                    result.todos.append(
                        f"{source.location}: EOC {eoc_id} effect #{effect_index} "
                        "needs domain-service conversion"
                    )
                    all_effects_converted = False
            elif isinstance(effect, str) and effect in {
                "dismount", "lesser_give_aid", "give_all_aid", "lesser_give_all_aid",
                "open_dialogue", "pick_style", "take_control",
                "clear_dimension",
                "clear_overrides", "place_override",
            }:
                # Deliberate presentation/interaction no-op in headless/scripted context.
                converted_effect = True
            elif npc_actor_proven and effect == "return_to_camp_duties":
                lines.append('    services.npcs.set_attitude(actor, "null")')
                converted_effect = True
            elif isinstance(effect, dict) and "trigger_event" in effect:
                event_name = effect.get("trigger_event")
                if isinstance(event_name, str):
                    lines.append(f"    runtime.trigger({lua_quote('game:' + event_name)})")
                    converted_effect = True
            elif isinstance(effect, dict) and ("u_deal_damage" in effect or "npc_deal_damage" in effect):
                key = "u_deal_damage" if "u_deal_damage" in effect else "npc_deal_damage"
                damage_type = effect.get(key)
                amount = finite_number_literal(effect.get("amount"))
                allowed_keys = {
                    key, "amount", "bodypart", "arpen", "arpen_mult", "dmg_mult",
                    "min_hit", "max_hit", "hit_roll", "can_attack_high",
                }
                target_expression = (
                    "actor" if key == "npc_deal_damage" and npc_event_character_actor_proven
                    else "actor" if key == "u_deal_damage" and avatar_actor_proven
                    else "services.characters.avatar()" if key == "u_deal_damage"
                    else None
                )
                static_options = (
                    target_expression is not None and
                    safe_platform_id(damage_type) and
                    amount is not None and
                    -MAX_CHARACTER_DAMAGE <= float(amount) <= MAX_CHARACTER_DAMAGE and
                    set(effect).issubset(allowed_keys)
                )
                damage_converted = False
                if static_options:
                    option_lines: list[str] = []
                    bodypart = effect.get("bodypart")
                    if bodypart is not None:
                        static_options = safe_platform_id(bodypart)
                        if static_options:
                            option_lines.append(
                                "body_part = services.types.id(\"body_part\", "
                                f"{lua_quote(bodypart)})"
                            )
                    for legacy_name, lua_name in (
                        ("arpen", "armor_penetration"),
                        ("arpen_mult", "armor_penetration_multiplier"),
                        ("dmg_mult", "damage_multiplier"),
                    ):
                        if legacy_name in effect:
                            number = finite_number_literal(effect[legacy_name])
                            number_minimum = (
                                -MAX_CHARACTER_DAMAGE if legacy_name == "arpen"
                                else -MAX_CHARACTER_DAMAGE_MULTIPLIER
                            )
                            number_maximum = (
                                MAX_CHARACTER_DAMAGE if legacy_name == "arpen"
                                else MAX_CHARACTER_DAMAGE_MULTIPLIER
                            )
                            if (
                                number is None or
                                not number_minimum <= float(number) <= number_maximum
                            ):
                                static_options = False
                                break
                            option_lines.append(f"{lua_name} = {lua_number(number)}")
                    for legacy_name in ("min_hit", "max_hit", "hit_roll"):
                        if legacy_name in effect:
                            number = effect[legacy_name]
                            if (
                                not isinstance(number, int) or isinstance(number, bool) or
                                not -MAX_CHARACTER_HIT_OPTION <= number <= MAX_CHARACTER_HIT_OPTION or
                                legacy_name in {"min_hit", "max_hit"} and number < -1
                            ):
                                static_options = False
                                break
                            option_lines.append(f"{legacy_name} = {number}")
                    if static_options and "min_hit" in effect and "max_hit" in effect:
                        if effect["max_hit"] != -1 and effect["max_hit"] < effect["min_hit"]:
                            static_options = False
                    if static_options and "can_attack_high" in effect:
                        if not isinstance(effect["can_attack_high"], bool):
                            static_options = False
                        else:
                            option_lines.append(
                                f"can_attack_high = {'true' if effect['can_attack_high'] else 'false'}"
                            )
                    if static_options:
                        lines.append("    services.characters.damage(")
                        lines.append(
                            f"        {target_expression}, services.types.id(\"damage_type\", "
                            f"{lua_quote(damage_type)}), {lua_number(amount)},"
                        )
                        if option_lines:
                            lines.append("        { " + ", ".join(option_lines) + " })")
                        else:
                            lines[-1] += ")"
                        damage_converted = True
                        converted_effect = True
                if not damage_converted:
                    result.todos.append(
                        f"{source.location}: EOC {eoc_id} effect #{effect_index} "
                        "damage amount/options need a finite static Lua-native conversion"
                    )
                    all_effects_converted = False
            elif isinstance(effect, dict) and ("u_teleport" in effect or "npc_teleport" in effect):
                rendered = render_static_teleport_effect(
                    effect, avatar_actor_proven,
                    npc_event_character_actor_proven,
                )
                if rendered is not None:
                    lines.extend(rendered)
                    converted_effect = True
                else:
                    lines.append(
                        "    -- TODO: translate teleport through a typed "
                        "creature-relocation service."
                    )
                    result.todos.append(
                        f"{source.location}: EOC {eoc_id} effect #{effect_index} "
                        "needs domain-service conversion"
                    )
                    all_effects_converted = False
            elif isinstance(effect, dict) and ("u_set_goal" in effect or "npc_set_goal" in effect):
                lines.append(
                    "    -- TODO: translate the NPC goal through a typed "
                    "navigation service."
                )
                result.todos.append(
                    f"{source.location}: EOC {eoc_id} effect #{effect_index} "
                    "needs domain-service conversion"
                )
                all_effects_converted = False
            elif isinstance(effect, dict) and ("u_set_guard_pos" in effect or "npc_set_guard_pos" in effect):
                lines.append(
                    "    -- TODO: translate the NPC guard position through a "
                    "typed navigation service."
                )
                result.todos.append(
                    f"{source.location}: EOC {eoc_id} effect #{effect_index} "
                    "needs domain-service conversion"
                )
                all_effects_converted = False
            elif isinstance(effect, dict) and "goto_location" in effect:
                lines.append(
                    "    -- TODO: translate goto_location through a typed "
                    "overmap navigation service."
                )
                result.todos.append(
                    f"{source.location}: EOC {eoc_id} effect #{effect_index} "
                    "needs domain-service conversion"
                )
                all_effects_converted = False
            elif isinstance(effect, dict) and "custom_light_level" in effect:
                rendered = render_static_light_override(effect)
                if rendered is not None:
                    lines.extend(rendered)
                    converted_effect = True
                else:
                    lines.append(
                        "    -- TODO: translate custom_light_level through an "
                        "explicit world-light service."
                    )
                    result.todos.append(
                        f"{source.location}: EOC {eoc_id} effect #{effect_index} "
                        "needs domain-service conversion"
                    )
                    all_effects_converted = False
            elif (
                item_event_character_actor_proven and
                isinstance(effect, dict) and
                ("u_activate" in effect or "npc_activate" in effect)
            ):
                key = "u_activate" if "u_activate" in effect else "npc_activate"
                rendered = render_static_item_activation_effect(effect, key)
                if rendered is not None:
                    lines.extend(rendered)
                    converted_effect = True
                else:
                    lines.append(
                        "    -- TODO: translate item activation through a "
                        "typed item-handle service."
                    )
                    result.todos.append(
                        f"{source.location}: EOC {eoc_id} effect #{effect_index} "
                        "needs domain-service conversion"
                    )
                    all_effects_converted = False
            elif isinstance(effect, dict) and ("u_activate" in effect or "npc_activate" in effect):
                lines.append(
                    "    -- TODO: translate item activation through a typed "
                    "item-handle service."
                )
                result.todos.append(
                    f"{source.location}: EOC {eoc_id} effect #{effect_index} "
                    "needs domain-service conversion"
                )
                all_effects_converted = False
            elif isinstance(effect, dict) and ("u_set_fault" in effect or "npc_set_fault" in effect):
                lines.append(
                    "    -- TODO: translate item fault mutation through a typed "
                    "item-handle service."
                )
                result.todos.append(
                    f"{source.location}: EOC {eoc_id} effect #{effect_index} "
                    "needs domain-service conversion"
                )
                all_effects_converted = False
            elif isinstance(effect, dict) and ("u_set_random_fault_of_type" in effect or "npc_set_random_fault_of_type" in effect):
                lines.append(
                    "    -- TODO: translate random item-fault mutation through a "
                    "typed item-handle service."
                )
                result.todos.append(
                    f"{source.location}: EOC {eoc_id} effect #{effect_index} "
                    "needs domain-service conversion"
                )
                all_effects_converted = False
            elif isinstance(effect, dict) and "transform_item" in effect:
                result.todos.append(
                    f"{source.location}: EOC {eoc_id} transform_item needs "
                    "a native item-talker transform service"
                )
                all_effects_converted = False
            elif isinstance(effect, dict) and "transform_line" in effect:
                rendered = render_static_transform_line_effect(
                    effect, avatar_actor_proven, npc_actor_proven
                )
                if rendered is not None:
                    lines.extend(rendered)
                    converted_effect = True
                else:
                    lines.append(
                        "    -- TODO: translate transform_line through an explicit "
                        "world transformation service."
                    )
                    result.todos.append(
                        f"{source.location}: EOC {eoc_id} effect #{effect_index} "
                        "needs domain-service conversion"
                    )
                    all_effects_converted = False
            elif isinstance(effect, dict) and "u_travel_to_dimension" in effect:
                rendered = render_static_dimension_travel_effect(
                    effect, avatar_actor_proven
                )
                if rendered is not None:
                    lines.extend(rendered)
                    converted_effect = True
                else:
                    lines.append(
                        "    -- TODO: translate u_travel_to_dimension with an explicit "
                        "dimension target and relocation policy."
                    )
                    result.todos.append(
                        f"{source.location}: EOC {eoc_id} effect #{effect_index} "
                        "needs domain-service conversion"
                    )
                    all_effects_converted = False
            elif (
                isinstance(effect, dict) and
                ("u_assign_activity" in effect or "npc_assign_activity" in effect)
            ):
                key = (
                    "u_assign_activity"
                    if "u_assign_activity" in effect
                    else "npc_assign_activity"
                )
                target_expression = (
                    "actor" if key == "u_assign_activity" and character_actor_proven
                    else "actor" if key == "npc_assign_activity" and npc_event_character_actor_proven
                    else None
                )
                rendered = render_static_character_activity(
                    effect, key, target_expression
                )
                if rendered is not None:
                    lines.extend(rendered)
                    converted_effect = True
                else:
                    lines.append(
                        "    -- TODO: translate the activity id and duration into "
                        "a plain typed activity service."
                    )
                    result.todos.append(
                        f"{source.location}: EOC {eoc_id} effect #{effect_index} "
                        "needs domain-service conversion"
                    )
                    all_effects_converted = False
            elif isinstance(effect, dict) and "math" in effect:
                rendered = render_static_character_math(
                    effect, character_actor_proven, npc_event_character_actor_proven
                )
                if rendered is not None:
                    lines.extend(rendered)
                    converted_effect = True
                else:
                    lines.append(
                        "    -- TODO: translate this math expression into "
                        "ordinary Lua and typed variable services."
                    )
                    result.todos.append(
                        f"{source.location}: EOC {eoc_id} effect #{effect_index} "
                        "needs domain-service conversion"
                    )
                    all_effects_converted = False
            elif isinstance(effect, dict) and "copy_var" in effect:
                rendered = render_static_character_copy_var(
                    effect, character_actor_proven, npc_event_character_actor_proven
                )
                if rendered is not None:
                    lines.extend(rendered)
                    converted_effect = True
                else:
                    lines.append(
                        "    -- TODO: translate copy_var into typed variable "
                        "services."
                    )
                    result.todos.append(
                        f"{source.location}: EOC {eoc_id} effect #{effect_index} "
                        "needs domain-service conversion"
                    )
                    all_effects_converted = False
            elif isinstance(effect, dict) and "add_debt" in effect:
                lines.append(
                    "    -- TODO: translate add_debt into an explicit Lua "
                    "resource mutation."
                )
                result.todos.append(
                    f"{source.location}: EOC {eoc_id} effect #{effect_index} "
                    "needs domain-service conversion"
                )
                all_effects_converted = False
            elif isinstance(effect, dict) and "sample_range" in effect:
                rendered = render_static_sample_range(
                    effect, avatar_actor_proven, npc_event_character_actor_proven
                )
                if rendered is not None:
                    lines.extend(rendered)
                    converted_effect = True
                else:
                    lines.append(
                        "    -- TODO: translate sample_range into bounded "
                        "random and variable services."
                    )
                    result.todos.append(
                        f"{source.location}: EOC {eoc_id} effect #{effect_index} "
                        "needs domain-service conversion"
                    )
                    all_effects_converted = False
            elif isinstance(effect, dict) and "set_string_var" in effect:
                rendered = render_static_character_string_var(
                    effect, character_actor_proven, npc_event_character_actor_proven
                )
                if rendered is not None:
                    lines.extend(rendered)
                    converted_effect = True
                else:
                    lines.append(
                        "    -- TODO: translate set_string_var into typed "
                        "variable services."
                    )
                    result.todos.append(
                        f"{source.location}: EOC {eoc_id} effect #{effect_index} "
                        "needs domain-service conversion"
                    )
                    all_effects_converted = False
            elif isinstance(effect, dict) and "mirror_coordinates" in effect:
                rendered = render_static_mirror_coordinates(
                    effect, character_actor_proven, npc_event_character_actor_proven
                )
                if rendered is not None:
                    lines.extend(rendered)
                    converted_effect = True
                else:
                    lines.append(
                        "    -- TODO: translate mirror_coordinates through "
                        "typed coordinate and variable services."
                    )
                    result.todos.append(
                        f"{source.location}: EOC {eoc_id} effect #{effect_index} "
                        "needs domain-service conversion"
                    )
                    all_effects_converted = False
            elif isinstance(effect, dict) and "dimension_name" in effect:
                rendered = render_static_dimension_name(
                    effect, character_actor_proven, npc_event_character_actor_proven
                )
                if rendered is not None:
                    lines.extend(rendered)
                    converted_effect = True
                else:
                    lines.append(
                        "    -- TODO: translate dimension_name through a "
                        "typed Character variable service."
                    )
                    result.todos.append(
                        f"{source.location}: EOC {eoc_id} effect #{effect_index} "
                        "needs domain-service conversion"
                    )
                    all_effects_converted = False
            elif isinstance(effect, dict) and "alter_timed_events" in effect:
                rendered = render_static_timed_event_reschedule(effect)
                if rendered is not None:
                    lines.extend(rendered)
                    converted_effect = True
                else:
                    lines.append(
                        "    -- TODO: translate alter_timed_events through a "
                        "bounded timed-event service."
                    )
                    result.todos.append(
                        f"{source.location}: EOC {eoc_id} effect #{effect_index} "
                        "needs domain-service conversion"
                    )
                    all_effects_converted = False
            elif (
                isinstance(effect, dict) and
                "u_add_faction_trust" in effect
            ):
                rendered = render_static_faction_trust(
                    effect,
                    "actor" if npc_event_character_actor_proven else None,
                )
                if rendered is not None:
                    lines.extend(rendered)
                    converted_effect = True
                else:
                    lines.append(
                        "    -- TODO: translate faction trust through the "
                        "typed character-faction service."
                    )
                    result.todos.append(
                        f"{source.location}: EOC {eoc_id} effect #{effect_index} "
                        "needs domain-service conversion"
                    )
                    all_effects_converted = False
            elif (
                isinstance(effect, dict) and
                ("npc_set_fac_relation" in effect or
                 "u_set_fac_relation" in effect)
            ):
                relation_key = (
                    "npc_set_fac_relation"
                    if "npc_set_fac_relation" in effect
                    else "u_set_fac_relation"
                )
                if relation_key == "npc_set_fac_relation":
                    source_expression = (
                        "actor" if npc_event_character_actor_proven else None
                    )
                    target_expression = (
                        "services.characters.avatar()"
                        if npc_event_character_actor_proven else None
                    )
                else:
                    source_expression = (
                        "services.characters.avatar()"
                        if npc_event_character_actor_proven else None
                    )
                    target_expression = (
                        "actor" if npc_event_character_actor_proven else None
                    )
                rendered = render_static_faction_relationship(
                    effect, relation_key, source_expression, target_expression,
                )
                if rendered is not None:
                    lines.extend(rendered)
                    converted_effect = True
                else:
                    lines.append(
                        "    -- TODO: translate faction relationship through "
                        "the typed character-faction service."
                    )
                    result.todos.append(
                        f"{source.location}: EOC {eoc_id} effect #{effect_index} "
                        "needs domain-service conversion"
                    )
                    all_effects_converted = False
            elif isinstance(effect, dict) and "closest_city" in effect:
                rendered = render_static_closest_city_effect(
                    effect, avatar_actor_proven, npc_actor_proven
                )
                if rendered is not None:
                    lines.extend(rendered)
                    converted_effect = True
                else:
                    lines.append(
                        "    -- TODO: translate closest_city through a typed "
                        "city query and writable location variable."
                    )
                    result.todos.append(
                        f"{source.location}: EOC {eoc_id} effect #{effect_index} "
                        "needs domain-service conversion"
                    )
                    all_effects_converted = False
            elif (
                isinstance(effect, dict) and
                any(key in effect for key in (
                    "u_attack", "npc_attack", "u_knockback", "npc_knockback",
                    "u_explosion", "npc_explosion", "u_emit", "npc_emit",
                    "u_cast_spell", "npc_cast_spell", "u_die", "npc_die",
                ))
            ):
                combat_key = next(
                    key for key in (
                        "u_attack", "npc_attack", "u_knockback", "npc_knockback",
                        "u_explosion", "npc_explosion", "u_emit", "npc_emit",
                        "u_cast_spell", "npc_cast_spell", "u_die", "npc_die",
                    ) if key in effect
                )
                rendered = None
                if combat_key in {"u_attack", "npc_attack"}:
                    rendered = render_static_combat_attack(
                        effect, combat_key, avatar_actor_proven,
                        npc_event_character_actor_proven,
                    )
                elif combat_key in {"u_knockback", "npc_knockback"}:
                    rendered = render_static_combat_knockback(
                        effect, combat_key, avatar_actor_proven,
                        npc_event_character_actor_proven,
                    )
                elif combat_key in {"u_explosion", "npc_explosion"}:
                    rendered = render_static_combat_explosion(
                        effect, combat_key, avatar_actor_proven,
                        npc_event_character_actor_proven,
                    )
                elif combat_key in {"u_emit", "npc_emit"}:
                    rendered = render_static_combat_emit(
                        effect, combat_key, avatar_actor_proven,
                        npc_event_character_actor_proven,
                    )
                elif combat_key in {"u_cast_spell", "npc_cast_spell"}:
                    rendered = render_static_combat_cast_spell(
                        effect, combat_key, avatar_actor_proven,
                        npc_event_character_actor_proven,
                    )
                elif combat_key in {"u_die", "npc_die"}:
                    rendered = render_static_combat_die(
                        effect, combat_key, avatar_actor_proven,
                        npc_event_character_actor_proven,
                    )
                if rendered is not None:
                    lines.extend(rendered)
                    converted_effect = True
                else:
                    lines.append(
                        "    -- TODO: translate this combat effect through a "
                        "proven actor and bounded literal options."
                    )
                    result.todos.append(
                        f"{source.location}: EOC {eoc_id} effect #{effect_index} "
                        "needs domain-service conversion"
                    )
                    all_effects_converted = False
            elif (
                isinstance(effect, str) and
                effect in {
                    "u_ranged_attack", "npc_ranged_attack",
                    "u_prevent_death", "npc_prevent_death",
                    "u_die", "npc_die",
                }
            ):
                rendered = None
                if effect in {"u_ranged_attack", "npc_ranged_attack"}:
                    rendered = render_static_combat_ranged_attack(
                        effect, effect, avatar_actor_proven,
                        npc_event_character_actor_proven,
                    )
                elif effect in {"u_prevent_death", "npc_prevent_death"}:
                    # The fatal avatar hook has a separate cancellable contract
                    # above; preserve its prevent_death flag instead of making a
                    # direct mutation here.
                    if not avatar_fatal_hook:
                        rendered = render_static_combat_prevent_death(
                            effect, effect, avatar_actor_proven,
                            npc_event_character_actor_proven,
                        )
                else:
                    rendered = render_static_combat_die(
                        effect, effect, avatar_actor_proven,
                        npc_event_character_actor_proven,
                    )
                if rendered is not None:
                    lines.extend(rendered)
                    converted_effect = True
                else:
                    lines.append(
                        "    -- TODO: translate this combat effect through a "
                        "proven actor and bounded literal options."
                    )
                    result.todos.append(
                        f"{source.location}: EOC {eoc_id} effect #{effect_index} "
                        "needs domain-service conversion"
                    )
                    all_effects_converted = False
            elif (
                isinstance(effect, str) and effect in {"lightning", "next_weather"} or
                isinstance(effect, dict) and any(
                    key in effect for key in (
                        "mirror_coordinates", "sample_range", "dimension_name",
                        "u_add_faction_trust", "u_set_fac_relation",
                        "npc_set_fac_relation", "closest_city",
                    )
                )
            ):
                lines.append(
                    "    -- TODO: translate this effect through a native "
                    "domain service; no placeholder call is emitted."
                )
                result.todos.append(
                    f"{source.location}: EOC {eoc_id} effect #{effect_index} "
                    "needs domain-service conversion"
                )
                all_effects_converted = False
            elif effect == "take_control_menu":
                # Presentation menu no-op
                converted_effect = True
            elif (
                isinstance(effect, dict) and any(key in effect for key in (
                    "add_mission", "basecamp_mission", "clear_mission",
                    "companion_mission", "finish_mission", "mission_failure",
                    "assign_mission", "assign_camp", "bionic_install",
                    "bionic_install_allies", "bionic_remove", "bionic_remove_allies",
                    "repair_bionic_limbs", "npc_run_vehicle_eocs", "u_run_vehicle_eocs",
                    "quote_vehicle_full_repair", "select_vehicle_part_service",
                    "start_vehicle_full_repair", "copy_location",
                    "location_variable_adjust", "mapgen_update", "npc_location_variable",
                    "npc_map_run_eocs", "npc_set_field", "drop_stolen_item",
                    "drop_weapon", "npc_consume_item", "npc_consume_item_sum",
                    "npc_gets_item", "npc_gets_item_to_use", "npc_map_run_item_eocs",
                    "npc_pickup_items", "npc_remove_item_with", "player_weapon_drop",
                    "quote_npc_trade_item", "set_item_category_spawn_rates", "u_buy_item",
                    "u_consume_item", "u_consume_item_sum", "u_map_run_item_eocs",
                    "u_pickup_items", "u_remove_item_with", "u_sell_item", "give_equipment",
                    "mission_reward", "mission_success", "offer_mission",
                    "remove_active_mission", "reveal_map", "revert_location",
                    "set_furniture", "set_terrain", "u_location_variable", "u_set_field",
                    "clear_npc_rule", "copy_npc_rules", "give_aid", "npc_attack",
                    "npc_bulk_donate", "npc_bulk_trade_accept", "npc_cast_spell",
                    "npc_change_class", "npc_change_faction", "npc_choose_adjacent_highlight",
                    "npc_die", "npc_emit", "npc_explosion", "npc_first_topic",
                    "npc_knockback", "npc_level_spell_class", "npc_lose_category",
                    "npc_lose_effect", "npc_make_radio_representative", "npc_make_sound",
                    "npc_mutate", "npc_mutate_category", "npc_mutate_towards",
                    "npc_prevent_death", "npc_query_omt", "npc_query_tile", "npc_ranged_attack",
                    "npc_recalculate_enchantment_cache", "npc_roll_remainder", "npc_rules_menu",
                    "npc_run_fixed_zone_eocs", "npc_run_inv_eocs", "npc_run_monster_eocs",
                    "npc_run_npc_eocs", "npc_set_talker", "npc_set_trait_purifiability",
                    "npc_spawn_monster", "npc_spawn_npc", "npc_thankful", "npc_transform_radius",
                    "set_npc_aim_rule", "set_npc_cbm_recharge_rule", "set_npc_cbm_reserve_rule",
                    "set_npc_engagement_rule", "set_npc_pickup", "set_npc_rule",
                    "start_training_npc", "toggle_npc_rule", "u_attack", "u_bulk_donate",
                    "u_bulk_trade_accept", "u_buy_monster", "u_cast_spell",
                    "u_choose_adjacent_highlight", "u_die", "u_emit", "u_explosion",
                    "u_faction_rep", "u_knockback", "u_level_spell_class", "u_lose_category",
                    "u_make_radio_representative", "u_make_sound", "u_mutate",
                    "u_mutate_category", "u_mutate_towards", "u_prevent_death", "u_query_omt",
                    "u_query_tile", "u_ranged_attack", "u_recalculate_enchantment_cache",
                    "u_roll_remainder", "u_run_fixed_zone_eocs", "u_run_inv_eocs",
                    "u_run_monster_eocs", "u_run_npc_eocs", "u_set_talker",
                    "u_set_trait_purifiability", "u_spawn_monster", "u_spawn_npc",
                    "u_spend_cash", "u_transform_radius"
                )) or
                isinstance(effect, str) and effect in {
                    "abandon_camp", "return_to_camp_duties", "start_camp",
                    "quote_vehicle_full_repair", "select_vehicle_part_service",
                    "start_vehicle_full_repair", "mapgen_update", "npc_map_run_eocs",
                    "drop_stolen_item", "drop_weapon", "player_weapon_drop", "give_equipment",
                    "mission_reward", "mission_success", "offer_mission",
                    "remove_active_mission", "reveal_map", "revert_location",
                    "set_furniture", "set_terrain", "u_map_run_eocs",
                    "clear_npc_rule", "copy_npc_rules", "give_aid", "npc_attack",
                    "npc_bulk_donate", "npc_bulk_trade_accept", "npc_die", "npc_first_topic",
                    "npc_make_radio_representative", "npc_prevent_death", "npc_rules_menu",
                    "npc_set_talker", "npc_thankful", "start_training_npc", "toggle_npc_rule",
                    "u_attack", "u_bulk_donate", "u_bulk_trade_accept", "u_die",
                    "u_make_radio_representative", "u_prevent_death", "u_set_talker"
                }
            ):
                lines.append(
                    "    -- TODO: translate this legacy effect through a typed "
                    "native service; no placeholder call is emitted."
                )
                result.todos.append(
                    f"{source.location}: EOC {eoc_id} effect #{effect_index} "
                    "needs domain-service conversion"
                )
                all_effects_converted = False
            else:
                lines.append("    -- TODO: translate one legacy effect into domain-service calls.")
                result.todos.append(
                    f"{source.location}: EOC {eoc_id} effect #{effect_index} needs domain-service conversion"
                )
                all_effects_converted = False
    else:
        lines.append("    -- TODO: translate the legacy effect into normal Lua control flow.")
        result.todos.append(
            f"{source.location}: EOC {eoc_id} effect needs domain-service conversion"
        )
        all_effects_converted = False
    if avatar_fatal_hook:
        lines.append("    if prevent_death then")
        lines.append("        return false")
        lines.append("    end")
    lines.extend(("end)", ""))
    has_event_trigger = isinstance(required_event, str) and bool(required_event)
    has_trigger = has_event_trigger or avatar_fatal_hook
    if avatar_fatal_hook:
        lines.append(
            f"runtime.hook(\"on_avatar_fatal\", {lua_quote(handler_id)})"
        )
    elif has_event_trigger:
        lines.append(f"runtime.on({lua_quote('game:' + required_event)}, {lua_quote(handler_id)})")
    else:
        lines.append(f"-- TODO: attach {lua_quote(handler_id)} to a Platform event, hook, item callback, or task.")
        result.todos.append(
            f"{source.location}: EOC {eoc_id} needs an explicit Platform trigger"
        )
    unresolved = sorted(
        set(value) - {"type", "id", "eoc_type", "required_event", "effect", "condition"}
    )
    if not stable_handler:
        result.todos.append(
            f"{source.location}: EOC {eoc_id} needs a stable handler id"
        )
    if unresolved:
        result.todos.append(
            f"{source.location}: EOC {eoc_id} unresolved fields: {', '.join(unresolved)}"
        )
    if (
        stable_handler and
        converted_effect and
        all_effects_converted and
        has_trigger and
        condition_converted and
        not unresolved
    ):
        result.converted.append(f"{source.location}: EOC {eoc_id}")
    else:
        result.partial.append(f"{source.location}: EOC {eoc_id}")
    return "\n".join(lines) + "\n"


def render_report(result: MigrationResult, mod_id: str) -> str:
    lines = [
        f"# Lua-first migration report: `{mod_id}`",
        "",
        "This report is generated from source structure, not proof of gameplay equivalence.",
        "No JSON loader, EOC runner, or raw legacy object was emitted.",
        "",
        f"- Fully translated skeletons: {len(result.converted)}",
        f"- Partial skeletons: {len(result.partial)}",
        f"- Explicit TODOs: {len(result.todos)}",
        "",
        "## Fully translated skeletons",
        "",
    ]
    lines.extend(f"- {entry}" for entry in result.converted)
    if not result.converted:
        lines.append("- None")
    lines.extend(("", "## Partial skeletons", ""))
    lines.extend(f"- {entry}" for entry in result.partial)
    if not result.partial:
        lines.append("- None")
    lines.extend(("", "## Required manual decisions", ""))
    lines.extend(f"- [ ] {entry}" for entry in result.todos)
    if not result.todos:
        lines.append("- None")
    lines.append("")
    return "\n".join(lines)


def migrate(objects: list[SourceObject], mod_id: str,
            exclude_types: frozenset[str] = frozenset()) -> MigrationResult:
    result = MigrationResult()
    catalog_chunks: dict[str, list[str]] = {
        "ascii_art": [],
        "json_flag": [],
        "tool_quality": [],
        "skill_display_type": [],
        "skill": [],
        "vitamin": [],
        "damage_type": [],
        "bash_damage_profile": [],
        "damage_info_order": [],
        "material": [],
        "proficiency_category": [],
        "proficiency": [],
        "weapon_category": [],
        "ITEM_CATEGORY": [],
        "recipe_category": [],
        "ammunition_type": [],
        "scent_type": [],
        "butchery_requirement": [],
        "item_action": [],
        "scenario": [],
        "vehicle_color_palette": [],
        "monstergroup": [],
        "overmap_connection": [],
        "speed_description": [],
        "sound_effect": [],
        "sound_effect_preload": [],
        "harvest_drop_type": [],
        "harvest": [],
        "behavior": [],
        "effect_type": [],
        "item_group": [],
        "sub_body_part": [],
        "wound": [],
        "body_part": [],
        "wound_fix": [],
        "anatomy": [],
        "body_graph": [],
        "field_type": [],
        "monster_attack": [],
        "weakpoint_set": [],
        "MONSTER": [],
        "hit_range": [],
        "morale_type": [],
        "disease_type": [],
        "mood_face": [],
        "limb_score": [],
        "clothing_mod": [],
        "monster_flag": [],
        "SPECIES": [],
        "emit": [],
        "MONSTER_FACTION": [],
        "mutation_type": [],
        "connect_group": [],
        "mutation_category": [],
        "construction_category": [],
        "construction_group": [],
        "vehicle_part_category": [],
        "vehicle_part_location": [],
        "overmap_land_use_code": [],
        "oter_vision": [],
        "overmap_location": [],
        "profession_group": [],
        "map_extra_collection": [],
        "vehicle_group": [],
        "fault_group": [],
        "explosion_light": [],
        "ammo_effect": [],
        "addiction_type": [],
        "character_mod": [],
        "start_location": [],
        "climbing_aid": [],
        "weather_type": [],
        "score": [],
        "overlay_order": [],
        "LOOT_ZONE": [],
        "speech": [],
        "end_screen": [],
        "activity_type": [],
        "help": [],
        "snippet": [],
        "playlist": [],
        "nested_category": [],
        "attack_vector": [],
        "technique": [],
        "martial_art": [],
        "trap": [],
        "construction": [],
        "furniture": [],
        "terrain": [],
        "gate": [],
        "fault": [],
        "fault_fix": [],
        "dream": [],
        "achievement": [],
        "conduct": [],
        "ITEM_BLACKLIST": [],
        "TRAIT_BLACKLIST": [],
        "MONSTER_BLACKLIST": [],
        "MONSTER_WHITELIST": [],
        "SCENARIO_BLACKLIST": [],
        "profession_blacklist": [],
        "charge_removal_blacklist": [],
        "temperature_removal_blacklist": [],
        "map_extra": [],
        "weather_generator": [],
        "bionic_migration": [],
        "effect_migration": [],
        "field_type_migration": [],
        "oter_id_migration": [],
        "overmap_special_migration": [],
        "proficiency_migration": [],
        "ter_furn_migration": [],
        "trap_migration": [],
        "var_migration": [],
        "vehicle_part_migration": [],
        "MIGRATION": [],
        "TRAIT_MIGRATION": [],
        "spell_migration": [],
        "camp_migration": [],
        "mod_migration": [],
        "trait_group": [],
        "monster_adjustment": [],
        "shopkeeper_blacklist": [],
        "shopkeeper_whitelist": [],
        "shopkeeper_consumption_rates": [],
        "magic_type": [],
        "movement_mode": [],
        "region_settings_ravine": [],
        "region_settings_lake": [],
        "region_settings_ocean": [],
        "region_settings_forest": [],
        "region_settings_river": [],
        "region_settings_forest_mapgen": [],
        "region_settings_map_extras": [],
        "region_settings_terrain_furniture": [],
        "region_settings_forest_trail": [],
        "region_settings_highway": [],
        "region_settings": [],
        "option_slider": [],
        "dimension_region_layout": [],
        "dimension": [],
        "omt_placeholder": [],
        "region_terrain_furniture": [],
        "forest_biome_component": [],
        "city": [],
        "faction_mission": [],
        "region_settings_city": [],
        "forest_biome_mapgen": [],
        "named_color": [],
        "rotatable_symbol": [],
        "requirement": [],
        "recipe_group": [],
    }
    item_chunks: list[str] = []
    recipe_chunks: list[str] = []
    behaviour_chunks: list[str] = []
    speech_pools: dict[str, list[tuple[str, int]]] = {}
    snippet_categories: dict[str, dict[str, Any]] = {}
    metadata: SourceObject | None = None
    # Copy-from corpora for the domains with legacy inheritance: parents may
    # live in files whose other types are excluded from this run, so each
    # corpus is built from every loaded object of that type before filtering.
    inheritance_corpora: dict[str, dict[str, dict[str, Any]]] = {}
    for source in objects:
        kind = source.value.get("type")
        if kind in exclude_types:
            continue
        if kind in ("sub_body_part", "gate", "mood_face", "start_location"):
            entry_id = source.value.get("id")
            if isinstance(entry_id, str) and entry_id:
                inheritance_corpora.setdefault(kind, {})[entry_id] = source.value
    regional_sources, regional_failures = resolve_regional_inheritance_corpus(
        objects, exclude_types
    )
    for source in objects:
        kind = source.value.get("type")
        if kind in exclude_types:
            continue
        if kind in REGIONAL_INHERITANCE_LABELS:
            original_source = source
            source_key = (original_source.path, original_source.index)
            inheritance_todos = regional_failures.get(source_key)
            if inheritance_todos is not None:
                object_id = (
                    original_source.value.get("id") or
                    original_source.value.get("abstract") or
                    "<invalid id>"
                )
                result.partial.append(
                    f"{original_source.location}: "
                    f"{REGIONAL_INHERITANCE_LABELS[kind]} {object_id}"
                )
                result.todos.extend(inheritance_todos)
                continue
            source = regional_sources[source_key]
        if kind == "MOD_INFO" and metadata is None:
            metadata = source
        elif kind == "MOD_INFO":
            metadata_id = stable_id(source.value, "<invalid id>")
            result.partial.append(
                f"{source.location}: MOD_INFO {metadata_id}"
            )
            result.todos.append(
                f"{source.location}: additional MOD_INFO cannot be represented by one Platform ModDefinition"
            )
        elif kind in ITEM_TYPES:
            rendered = render_item(source, result)
            if rendered:
                item_chunks.append(rendered)
        elif kind in RECIPE_TYPES:
            rendered = render_recipe(source, result)
            if rendered:
                recipe_chunks.append(rendered)
        elif kind in EOC_TYPES:
            behaviour_chunks.append(render_eoc(source, result))
        elif kind == "tool_quality":
            rendered = render_tool_quality(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "ascii_art":
            rendered = render_ascii_art(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "skill_display_type":
            rendered = render_skill_display(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "skill":
            rendered = render_skill(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "vitamin":
            rendered = render_vitamin(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "json_flag":
            rendered = render_json_flag(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "damage_type":
            rendered = render_damage_type(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "bash_damage_profile":
            rendered = render_bash_damage_profile(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "damage_info_order":
            rendered = render_damage_info_order(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "material":
            rendered = render_material(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "proficiency_category":
            rendered = render_proficiency_category(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "proficiency":
            rendered = render_proficiency(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "weapon_category":
            rendered = render_weapon_category(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "ITEM_CATEGORY":
            rendered = render_item_category(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "recipe_category":
            rendered = render_recipe_category(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "ammunition_type":
            rendered = render_ammunition_type(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "scent_type":
            rendered = render_scent_type(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "butchery_requirement":
            rendered = render_butchery_requirement(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "item_action":
            rendered = render_item_action(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "scenario":
            rendered = render_scenario(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "vehicle_color_palette":
            rendered = render_vehicle_color_palette(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "monstergroup":
            rendered = render_monster_group(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "overmap_connection":
            rendered = render_overmap_connection(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "speed_description":
            rendered = render_speed_description(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "sound_effect":
            rendered = render_sound_effect(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "sound_effect_preload":
            rendered = render_sound_effect_preload(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "harvest_drop_type":
            rendered = render_harvest_drop_type(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "harvest":
            rendered = render_harvest(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "behavior":
            rendered = render_behavior(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "effect_type":
            rendered = render_effect_type(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "item_group":
            rendered = render_item_group(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "sub_body_part":
            rendered = render_sub_body_part(
                source, result,
                inheritance_corpus=inheritance_corpora.get("sub_body_part"),
            )
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "wound":
            rendered = render_wound(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "body_part":
            rendered = render_body_part(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "wound_fix":
            rendered = render_wound_fix(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "anatomy":
            rendered = render_anatomy(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "body_graph":
            rendered = render_body_graph(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "field_type":
            rendered = render_field_type(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "monster_attack":
            rendered = render_monster_attack(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "weakpoint_set":
            rendered = render_weakpoint_set(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "MONSTER":
            rendered = render_monster(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "hit_range":
            rendered = render_hit_range(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "morale_type":
            rendered = render_morale_type(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "disease_type":
            rendered = render_disease_type(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "mood_face":
            rendered = render_mood_face(
                source, result,
                inheritance_corpus=inheritance_corpora.get("mood_face"),
            )
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "limb_score":
            rendered = render_limb_score(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "clothing_mod":
            rendered = render_clothing_mod(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "monster_flag":
            rendered = render_marker_catalog(
                source, result, builder="MonsterFlag", label="monster flag"
            )
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "SPECIES":
            rendered = render_species(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "emit":
            rendered = render_emission(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "MONSTER_FACTION":
            rendered = render_monster_faction(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "mutation_type":
            rendered = render_marker_catalog(
                source, result, builder="MutationType", label="mutation type"
            )
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "connect_group":
            rendered = render_marker_catalog(
                source, result, builder="ConnectGroup", label="connect group"
            )
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "mutation_category":
            rendered = render_mutation_category(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "construction_category":
            rendered = render_named_catalog(
                source,
                result,
                builder="ConstructionCategory",
                label="construction category",
            )
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "construction_group":
            rendered = render_named_catalog(
                source,
                result,
                builder="ConstructionGroup",
                label="construction group",
            )
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "vehicle_part_category":
            rendered = render_vehicle_part_category(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "vehicle_part_location":
            rendered = render_vehicle_part_location(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "overmap_land_use_code":
            rendered = render_overmap_land_use_code(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "oter_vision":
            rendered = render_overmap_vision(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "overmap_location":
            rendered = render_overmap_location(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "profession_group":
            rendered = render_profession_group(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "map_extra_collection":
            rendered = render_weighted_catalog(
                source,
                result,
                builder="MapExtraCollection",
                label="map-extra collection",
                source_field="extras",
                method="extra",
                chance=True,
            )
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "vehicle_group":
            rendered = render_weighted_catalog(
                source,
                result,
                builder="VehicleGroup",
                label="vehicle group",
                source_field="vehicles",
                method="vehicle",
                allow_duplicates=True,
            )
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "fault_group":
            rendered = render_weighted_catalog(
                source,
                result,
                builder="FaultGroup",
                label="fault group",
                source_field="group",
                method="fault",
                object_style=True,
                allow_duplicates=True,
            )
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "explosion_light":
            rendered = render_explosion_light(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "ammo_effect":
            rendered = render_ammo_effect(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "addiction_type":
            rendered = render_addiction_type(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "character_mod":
            rendered = render_character_modifier(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "start_location":
            rendered = render_start_location(
                source, result,
                inheritance_corpus=inheritance_corpora.get("start_location"),
            )
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "climbing_aid":
            rendered = render_climbing_aid(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "weather_type":
            rendered = render_weather_type(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "score":
            rendered = render_score(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "overlay_order":
            rendered = render_overlay_order(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "LOOT_ZONE":
            rendered = render_zone_type(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "speech":
            value = source.value
            raw_speakers = value.get("speaker")
            speakers = (
                [raw_speakers]
                if isinstance(raw_speakers, str)
                else raw_speakers
            )
            sound = display_text(value.get("sound"))
            volume = value.get("volume")
            valid = (
                isinstance(speakers, list) and
                bool(speakers) and
                all(safe_platform_id(speaker) for speaker in speakers) and
                bool(sound) and
                isinstance(volume, int) and
                not isinstance(volume, bool) and
                NATIVE_INT_MIN <= volume <= NATIVE_INT_MAX
            )
            unresolved = unresolved_fields(
                value, {"type", "speaker", "sound", "volume"}
            )
            if valid:
                for speaker in speakers:
                    speech_pools.setdefault(speaker, []).append((sound, volume))
            if unresolved:
                result.todos.append(
                    f"{source.location}: speech unresolved fields: " +
                    ", ".join(unresolved)
                )
            if valid and not unresolved:
                result.converted.append(f"{source.location}: speech line")
            else:
                result.partial.append(f"{source.location}: speech line")
                if not valid:
                    result.todos.append(
                        f"{source.location}: speech speakers, text, or volume need review"
                    )
        elif kind == "end_screen":
            rendered = render_end_screen(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "activity_type":
            rendered = render_activity_type(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "help":
            rendered = render_help_topic(source, result, mod_id)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "snippet":
            collect_snippet_category(source, result, snippet_categories)
        elif kind == "playlist":
            rendered = render_playlists(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "nested_category":
            rendered = render_nested_recipe_category(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "attack_vector":
            rendered = render_attack_vector(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "technique":
            rendered = render_technique(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "martial_art":
            rendered = render_martial_art(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "trap":
            rendered = render_trap(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "construction":
            rendered = render_construction(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "furniture":
            rendered = render_furniture(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "terrain":
            rendered = render_terrain(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "gate":
            rendered = render_gate(
                source, result,
                inheritance_corpus=inheritance_corpora.get("gate"),
            )
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "fault":
            rendered = render_fault(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "fault_fix":
            rendered = render_fault_fix(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "dream":
            rendered = render_dream(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind in ("achievement", "conduct"):
            rendered = render_achievement(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind in ("ITEM_BLACKLIST", "TRAIT_BLACKLIST", "MONSTER_BLACKLIST",
                      "MONSTER_WHITELIST", "SCENARIO_BLACKLIST",
                      "profession_blacklist", "charge_removal_blacklist",
                      "temperature_removal_blacklist"):
            rendered = render_blacklist(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "map_extra":
            rendered = render_map_extra(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "weather_generator":
            rendered = render_weather_generator(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "monster_adjustment":
            rendered = render_monster_adjustment(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "trait_group":
            rendered = render_weighted_catalog(
                source,
                result,
                builder="TraitGroup",
                label="trait group",
                source_field="traits",
                method="trait",
            )
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind in ("shopkeeper_blacklist", "shopkeeper_whitelist",
                      "shopkeeper_consumption_rates"):
            rendered = render_shopkeeper(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind in ("bionic_migration", "effect_migration",
                      "field_type_migration", "oter_id_migration",
                      "overmap_special_migration", "proficiency_migration",
                      "ter_furn_migration", "trap_migration",
                      "var_migration", "vehicle_part_migration",
                      "MIGRATION", "TRAIT_MIGRATION", "spell_migration",
                      "camp_migration", "mod_migration"):
            rendered = render_migration(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind in UNREGISTERED_CONTENT_TYPES:
            report_missing_content_registrar(source, result)
        elif kind == "magic_type":
            rendered = render_magic_type(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "movement_mode":
            rendered = render_movement_mode(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "region_settings_ravine":
            rendered = render_region_settings_ravine(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "region_settings_lake":
            rendered = render_region_settings_lake(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "region_settings_ocean":
            rendered = render_region_settings_ocean(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "region_settings_forest":
            rendered = render_region_settings_forest(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "region_settings_river":
            rendered = render_region_settings_river(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "region_settings_forest_mapgen":
            rendered = render_region_settings_forest_mapgen(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "region_settings_map_extras":
            rendered = render_region_settings_map_extras(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "region_settings_terrain_furniture":
            rendered = render_region_settings_terrain_furniture(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "region_settings_forest_trail":
            rendered = render_region_settings_forest_trail(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "region_settings_highway":
            rendered = render_region_settings_highway(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "region_settings":
            rendered = render_region_settings(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "option_slider":
            rendered = render_option_slider(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "dimension_region_layout":
            rendered = render_dimension_region_layout(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "dimension":
            rendered = render_dimension(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "omt_placeholder":
            rendered = render_omt_placeholder(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "region_terrain_furniture":
            rendered = render_region_terrain_furniture(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "forest_biome_component":
            rendered = render_forest_biome_component(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "city":
            rendered = render_city(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "faction_mission":
            rendered = render_faction_mission(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "region_settings_city":
            rendered = render_region_settings_city(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "forest_biome_mapgen":
            rendered = render_forest_biome_mapgen(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "named_color":
            rendered = render_named_color(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "rotatable_symbol":
            rendered = render_rotatable_symbol(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "requirement":
            rendered = render_requirement(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        elif kind == "recipe_group":
            rendered = render_recipe_group(source, result)
            if rendered:
                catalog_chunks[kind].append(rendered)
        else:
            report_missing_content_registrar(source, result)

    for speaker in sorted(speech_pools):
        lines = [
            "local definition = content.SpeechPool {",
            f"    id = {lua_quote(speaker)},",
            "}",
        ]
        lines.extend(
            f"definition:line({lua_quote(sound)}, {volume})"
            for sound, volume in speech_pools[speaker]
        )
        lines.extend((content_submit_expression(), ""))
        catalog_chunks["speech"].append("\n".join(lines))

    for category_id, category in snippet_categories.items():
        rendered = render_collected_snippet_category(category_id, category)
        if rendered:
            catalog_chunks["snippet"].append(rendered)

    main = [
        'local ccb = require("ccb")',
        "",
        "local content = ccb.content",
        "local runtime = ccb.runtime",
        "local services = ccb.services",
    ]
    needs_character_has_item = any(
        "character_has_item(" in chunk for chunk in behaviour_chunks
    )
    needs_character_is_wearing = any(
        "character_is_wearing(" in chunk for chunk in behaviour_chunks
    )
    needs_character_has_weapon = any(
        "character_has_weapon(" in chunk for chunk in behaviour_chunks
    )
    needs_character_has_any_bionic_or_capacity = any(
        "character_has_any_bionic_or_capacity(" in chunk
        for chunk in behaviour_chunks
    )
    needs_character_can_drop_weapon = any(
        "character_can_drop_weapon(" in chunk for chunk in behaviour_chunks
    )
    needs_character_wields_with_flag = any(
        "character_wields_with_flag(" in chunk for chunk in behaviour_chunks
    )
    needs_character_travel_has_path = any(
        "character_travel_has_path(" in chunk for chunk in behaviour_chunks
    )
    needs_character_at_safe_space = any(
        "character_at_safe_space(" in chunk for chunk in behaviour_chunks
    )
    needs_character_has_pickup_whitelist = any(
        "character_has_pickup_whitelist(" in chunk for chunk in behaviour_chunks
    )
    needs_character_has_profession = any(
        "character_has_profession(" in chunk for chunk in behaviour_chunks
    )
    needs_character_weapon_helpers = (
        needs_character_has_weapon or
        needs_character_can_drop_weapon or
        needs_character_wields_with_flag
    )
    if (
        needs_character_has_item or
        needs_character_is_wearing or
        needs_character_has_any_bionic_or_capacity or
        needs_character_weapon_helpers or
        needs_character_has_profession or
        any("service_value(" in chunk for chunk in behaviour_chunks)
    ):
        main.extend(
            (
                "",
                "local function service_value(result)",
                "    if not result.ok then",
                "        error(result.error.message)",
                "    end",
                "    return result.value",
                "end",
            )
        )
    if needs_character_has_any_bionic_or_capacity:
        main.extend(
            (
                "",
                "local function character_has_any_bionic_or_capacity(character)",
                "    local summary = service_value(services.bionics.summary(character))",
                "    return summary.installed_count > 0 or summary.has_capacity",
                "end",
            )
        )
    if needs_character_has_weapon:
        main.extend(
            (
                "",
                "local function character_has_weapon(character)",
                "    local wielded = service_value(services.inventory.wielded(character))",
                "    if wielded == nil then",
                "        return false",
                "    end",
                "    local style = service_value(services.martial_arts.current(character))",
                "    return not style.force_unarmed",
                "end",
            )
        )
    if needs_character_can_drop_weapon:
        main.extend(
            (
                "",
                "local function character_can_drop_weapon(character)",
                "    local wielded = service_value(services.inventory.wielded(character))",
                "    if wielded == nil then",
                "        return false",
                "    end",
                "    local style = service_value(services.martial_arts.current(character))",
                "    if style.force_unarmed then",
                "        return false",
                "    end",
                "    local no_unwield = service_value(services.items.has_flag(",
                "        wielded, services.types.id(\"json_flag\", \"NO_UNWIELD\")))",
                "    return not no_unwield",
                "end",
            )
        )
    if needs_character_wields_with_flag:
        main.extend(
            (
                "",
                "local function character_wields_with_flag(character, flag)",
                "    local wielded = service_value(services.inventory.wielded(character))",
                "    return wielded ~= nil and service_value(",
                "        services.items.has_flag(wielded, flag))",
                "end",
            )
        )
    if needs_character_has_item:
        main.extend(
            (
                "",
                "local function character_has_item(character, item_id)",
                "    local resources = service_value(services.inventory.resources(",
                "        character, services.types.id(\"item\", item_id), 1))",
                "    return resources.has_charges or resources.has_amount",
                "end",
            )
        )
    if needs_character_is_wearing:
        main.extend(
            (
                "",
                "local function character_is_wearing(character, item_id)",
                "    return service_value(services.inventory.is_wearing(",
                "        character, services.types.id(\"item\", item_id)))",
                "end",
            )
        )
    if needs_character_travel_has_path:
        main.extend(
            (
                "",
                "local function character_travel_has_path(character)",
                "    local snapshot = service_value(services.characters.snapshot(character))",
                "    return snapshot.travel.has_path",
                "end",
            )
        )
    if needs_character_at_safe_space:
        main.extend(
            (
                "",
                "local function character_at_safe_space(character)",
                "    local snapshot = service_value(services.characters.snapshot(character))",
                "    local position = services.coords.project_to(",
                "        snapshot.creature.position, \"omt\")",
                "    return services.overmap.is_safe(position) and",
                "        service_value(services.characters.is_safe(character))",
                "end",
            )
        )
    if needs_character_has_pickup_whitelist:
        main.extend(
            (
                "",
                "local function character_has_pickup_whitelist(character)",
                "    local rules = services.npcs.ai_rules(character)",
                "    if not rules.ok then",
                "        return false",
                "    end",
                "    return rules.value.pickup_whitelist",
                "end",
            )
        )
    if needs_character_has_profession:
        main.extend(
            (
                "",
                "local function character_has_profession(character, profession_id)",
                "    return service_value(services.characters.has_profession(",
                "        character, profession_id))",
                "end",
            )
        )
    catalog_labels = {
        "ascii_art": "Native ASCII-art definitions",
        "json_flag": "Native JSON-flag definitions",
        "tool_quality": "Native tool-quality definitions",
        "butchery_requirement": "Native butchery-requirement definitions",
        "item_action": "Native item-action definitions",
        "scenario": "Native scenario definitions",
        "vehicle_color_palette": "Native vehicle color palettes",
        "monstergroup": "Native monster groups",
        "overmap_connection": "Native overmap connections",
        "skill_display_type": "Native skill display categories",
        "skill": "Native skill definitions",
        "sound_effect": "Native ambient sound-effect definitions",
        "sound_effect_preload": "Native ambient sound-effect preloads",
        "vitamin": "Native vitamin definitions",
        "damage_type": "Native damage-type definitions",
        "bash_damage_profile": "Native bash-damage profiles",
        "damage_info_order": "Native damage-info presentation order",
        "material": "Native material definitions",
        "proficiency_category": "Native proficiency categories",
        "proficiency": "Native proficiency definitions",
        "weapon_category": "Native weapon categories",
        "ITEM_CATEGORY": "Native item categories",
        "recipe_category": "Native recipe categories",
        "ammunition_type": "Native ammunition types",
        "scent_type": "Native scent types",
        "speed_description": "Native speed descriptions",
        "harvest_drop_type": "Native harvest-drop types",
        "harvest": "Native harvest lists",
        "behavior": "Native behavior trees and named Lua policies",
        "effect_type": "Native effect types",
        "item_group": "Native composable item groups",
        "sub_body_part": "Native sub-body-part definitions",
        "wound": "Native wound definitions",
        "body_part": "Native body-part definitions",
        "wound_fix": "Native wound-fix definitions",
        "anatomy": "Native anatomy definitions",
        "body_graph": "Native body-graph definitions",
        "field_type": "Native field types",
        "monster_attack": "Native monster attacks and named Lua policies",
        "weakpoint_set": "Native weakpoint sets",
        "MONSTER": "Native monster definitions",
        "hit_range": "Native global hit-range configuration",
        "morale_type": "Native morale types",
        "disease_type": "Native disease types",
        "mood_face": "Native mood-face tables",
        "limb_score": "Native limb-score definitions",
        "clothing_mod": "Native clothing modifications",
        "monster_flag": "Native monster flags",
        "SPECIES": "Native monster species",
        "emit": "Native field emissions and named Lua profiles",
        "MONSTER_FACTION": "Native monster factions",
        "mutation_type": "Native mutation types",
        "connect_group": "Native terrain and furniture connection groups",
        "mutation_category": "Native mutation categories",
        "construction_category": "Native construction categories",
        "construction_group": "Native construction groups",
        "vehicle_part_category": "Native vehicle-part categories",
        "vehicle_part_location": "Native vehicle-part locations",
        "overmap_land_use_code": "Native overmap land-use codes",
        "oter_vision": "Native composable overmap-vision profiles",
        "overmap_location": "Native composable overmap locations",
        "profession_group": "Native profession groups",
        "map_extra_collection": "Native weighted map-extra collections",
        "vehicle_group": "Native weighted vehicle groups",
        "fault_group": "Native weighted fault groups",
        "explosion_light": "Native composable explosion-light recipes",
        "ammo_effect": "Native composable ammunition effects and named Lua impact policies",
        "addiction_type": "Native addiction types and named Lua tick policies",
        "character_mod": "Native character modifiers and named Lua evaluators",
        "start_location": "Native composable start locations",
        "climbing_aid": "Native composable climbing aids",
        "weather_type": "Native weather types and named Lua condition policies",
        "score": "Native score definitions",
        "overlay_order": "Native global mutation-overlay ordering",
        "LOOT_ZONE": "Native zone-type definitions",
        "speech": "Native speaker-labelled speech pools",
        "end_screen": "Native end screens and named Lua selection policies",
        "activity_type": "Native activity types and named Lua turn/completion policies",
        "help": "Native stable-id help topics",
        "snippet": "Native composable snippet categories and named Lua examine policies",
        "playlist": "Native soundpack playlists",
        "nested_category": "Native composable nested recipe categories",
        "attack_vector": "Native attack vectors",
        "technique": "Native martial-arts techniques",
        "martial_art": "Native martial-art styles",
        "trap": "Native trap definitions",
        "construction": "Native construction definitions",
        "furniture": "Native furniture definitions",
        "terrain": "Native terrain definitions",
        "gate": "Native gate definitions",
        "fault": "Native fault definitions",
        "fault_fix": "Native fault-fix definitions",
        "dream": "Native dream definitions",
        "achievement": "Native achievement definitions",
        "conduct": "Native conduct definitions",
        "ITEM_BLACKLIST": "Native item blacklists",
        "TRAIT_BLACKLIST": "Native trait blacklists",
        "MONSTER_BLACKLIST": "Native monster blacklists",
        "MONSTER_WHITELIST": "Native monster whitelists",
        "SCENARIO_BLACKLIST": "Native scenario blacklists",
        "profession_blacklist": "Native profession blacklists",
        "charge_removal_blacklist": "Native charge-removal blacklists",
        "temperature_removal_blacklist": "Native temperature-removal blacklists",
        "map_extra": "Native map extras",
        "weather_generator": "Native weather generators",
        "bionic_migration": "Native bionic migrations",
        "effect_migration": "Native effect migrations",
        "field_type_migration": "Native field-type migrations",
        "oter_id_migration": "Native overmap-terrain migrations",
        "overmap_special_migration": "Native overmap-special migrations",
        "proficiency_migration": "Native proficiency migrations",
        "ter_furn_migration": "Native terrain and furniture migrations",
        "trap_migration": "Native trap migrations",
        "var_migration": "Native variable migrations",
        "vehicle_part_migration": "Native vehicle-part migrations",
        "MIGRATION": "Native item migrations",
        "TRAIT_MIGRATION": "Native trait and mutation migrations",
        "spell_migration": "Native spell migrations",
        "camp_migration": "Native camp migrations",
        "mod_migration": "Native mod migrations",
        "trait_group": "Native trait groups",
        "monster_adjustment": "Native monster adjustments",
        "shopkeeper_blacklist": "Native shopkeeper blacklists",
        "shopkeeper_whitelist": "Native shopkeeper whitelists",
        "shopkeeper_consumption_rates": "Native shopkeeper consumption rates",
        "magic_type": "Native magic types and named Lua policies",
        "movement_mode": "Native composable movement modes",
        "region_settings_ravine": "Native region settings ravines",
        "region_settings_lake": "Native region settings lakes",
        "region_settings_ocean": "Native region settings oceans",
        "region_settings_forest": "Native region settings forests",
        "region_settings_river": "Native region settings rivers",
        "region_settings_forest_mapgen": "Native region settings forest mapgens",
        "region_settings_map_extras": "Native region settings map extras",
        "region_settings_terrain_furniture": "Native region settings terrain furnitures",
        "region_settings_forest_trail": "Native region settings forest trails",
        "region_settings_highway": "Native region settings highways",
        "region_settings": "Native region settings",
        "option_slider": "Native option sliders",
        "dimension_region_layout": "Native dimension region layouts",
        "dimension": "Native dimensions",
        "omt_placeholder": "Native overmap terrain placeholders",
        "region_terrain_furniture": "Native region terrain furnitures",
        "forest_biome_component": "Native forest biome components",
        "city": "Native city definitions",
        "faction_mission": "Native faction missions",
        "region_settings_city": "Native region settings cities",
        "forest_biome_mapgen": "Native forest biome mapgens",
        "named_color": "Native named colors",
        "rotatable_symbol": "Native rotatable-symbol groups",
        "requirement": "Native reusable requirements",
        "recipe_group": "Native recipe groups",
    }
    for kind, chunks in catalog_chunks.items():
        if chunks:
            wrapped = []
            for chunk in chunks:
                wrapped.extend(("do", chunk.rstrip(), "end"))
            main.extend(("", f"-- {catalog_labels[kind]}", *wrapped))
    if item_chunks:
        main.extend(("", '-- Native item definitions', *item_chunks))
    if recipe_chunks:
        main.extend(("", '-- Native recipe definitions', *recipe_chunks))
    if behaviour_chunks:
        main.extend(("", '-- Native Lua behaviour', *behaviour_chunks))
    main.append("")
    result.files[Path("main.lua")] = "\n".join(main)

    if metadata is not None:
        result.files[Path("mod.lua")] = render_mod_definition(
            metadata, result, mod_id
        )
    result.files[Path("MIGRATION_REPORT.md")] = render_report(result, mod_id)
    return result


def normalized_mod_id(requested: str | None, objects: list[SourceObject]) -> str:
    if requested:
        candidate = requested
    else:
        candidate = "migrated_lua_mod"
        for source in objects:
            if source.value.get("type") == "MOD_INFO":
                candidate = stable_id(source.value, candidate)
                break
    if not candidate or "#" in candidate or any(character.isspace() for character in candidate):
        raise ValueError("mod id must be non-empty and cannot contain '#'/whitespace")
    return candidate


def _exists_or_symlink(path: Path) -> bool:
    return path.exists() or path.is_symlink()


def _install_staged_file(source: Path, destination: Path) -> None:
    source.replace(destination)


def write_result(result: MigrationResult, output: Path, force: bool, check: bool) -> bool:
    if output.is_symlink() or (output.exists() and not output.is_dir()):
        raise ValueError(f"output is not a directory: {output}")
    for relative in result.files:
        if relative.is_absolute() or ".." in relative.parts:
            raise ValueError(f"unsafe migration output path: {relative}")

    stale: list[Path] = []
    existing = [
        output / relative
        for relative in sorted(result.files)
        if _exists_or_symlink(output / relative)
    ]
    if not check and not force and existing:
        raise ValueError(f"refusing to overwrite {existing[0]}; pass --force")

    for relative, contents in sorted(result.files.items()):
        destination = output / relative
        if check:
            try:
                current = destination.read_text(encoding="utf-8")
            except OSError:
                stale.append(relative)
            else:
                if current != contents:
                    stale.append(relative)
            continue
    if check and stale:
        print("stale Lua-first migration output:", file=sys.stderr)
        for relative in stale:
            print(f"  {relative.as_posix()}", file=sys.stderr)
        return False
    if check:
        return True

    output.parent.mkdir(parents=True, exist_ok=True)
    for relative in sorted(result.files):
        destination = output / relative
        if destination.exists() and destination.is_dir():
            raise ValueError(f"migration output path is a directory: {destination}")
        parent = destination.parent
        while parent != output:
            if parent.is_symlink() or (parent.exists() and not parent.is_dir()):
                raise ValueError(f"migration output parent is not a directory: {parent}")
            parent = parent.parent

    temporary = Path(
        tempfile.mkdtemp(prefix=f".{output.name}.lua-first-", dir=output.parent)
    )
    staged_root = temporary / "generated"
    backup_root = temporary / "backup"
    try:
        for relative, contents in sorted(result.files.items()):
            staged = staged_root / relative
            staged.parent.mkdir(parents=True, exist_ok=True)
            staged.write_text(contents, encoding="utf-8")

        if not output.exists():
            staged_root.replace(output)
            return True

        created_directories: list[Path] = []
        backups: list[tuple[Path, Path]] = []
        installed: list[Path] = []
        try:
            for relative in sorted(result.files):
                destination = output / relative
                missing: list[Path] = []
                parent = destination.parent
                while parent != output and not parent.exists():
                    missing.append(parent)
                    parent = parent.parent
                for directory in reversed(missing):
                    directory.mkdir()
                    created_directories.append(directory)

            for relative in sorted(result.files):
                destination = output / relative
                if not _exists_or_symlink(destination):
                    continue
                backup = backup_root / relative
                backup.parent.mkdir(parents=True, exist_ok=True)
                destination.replace(backup)
                backups.append((destination, backup))

            for relative in sorted(result.files):
                destination = output / relative
                _install_staged_file(staged_root / relative, destination)
                installed.append(destination)
        except Exception:
            for destination in reversed(installed):
                if _exists_or_symlink(destination):
                    destination.unlink()
            for destination, backup in reversed(backups):
                if _exists_or_symlink(backup):
                    backup.replace(destination)
            for directory in reversed(created_directories):
                try:
                    directory.rmdir()
                except OSError:
                    pass
            raise
    finally:
        shutil.rmtree(temporary, ignore_errors=True)
    return True


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("inputs", nargs="+", type=Path)
    parser.add_argument("--output", required=True, type=Path)
    parser.add_argument("--mod-id")
    parser.add_argument("--force", action="store_true")
    parser.add_argument(
        "--replace", action="store_true",
        help="emit content.replace instead of content.add for migrated ids",
    )
    parser.add_argument(
        "--exclude-types",
        help="comma-separated JSON object types to skip entirely: entries of "
             "these types render no output and produce no partials or TODOs",
    )
    parser.add_argument(
        "--check", action="store_true",
        help="compare deterministic output without writing files",
    )
    args = parser.parse_args(argv)
    try:
        objects = load_objects(args.inputs)
        mod_id = normalized_mod_id(args.mod_id, objects)
        global EMIT_REPLACE_CONTENT
        EMIT_REPLACE_CONTENT = args.replace
        excluded = frozenset(
            token.strip()
            for token in (args.exclude_types or "").split(",")
            if token.strip()
        )
        result = migrate(objects, mod_id, exclude_types=excluded)
        if not write_result(result, args.output, args.force, args.check):
            return 1
    except (OSError, ValueError) as error:
        parser.error(str(error))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
