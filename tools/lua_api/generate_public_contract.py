#!/usr/bin/env python3
"""Generate the complete, machine-readable CCB Lua API v5 contract."""

from __future__ import annotations

import argparse
import hashlib
import json
import re
from collections import Counter, defaultdict
from pathlib import Path
from typing import Iterable

try:
    from .check_luals_declarations import (
        INTENTIONALLY_UNDECLARED_TABLES,
        TABLE_CLASSES,
        coordinate_factories,
    )
    from .generate_ccb_inventory import (
        build_inventory as build_native_inventory,
    )
except ImportError:
    from check_luals_declarations import (  # type: ignore
        INTENTIONALLY_UNDECLARED_TABLES,
        TABLE_CLASSES,
        coordinate_factories,
    )
    from generate_ccb_inventory import (  # type: ignore
        build_inventory as build_native_inventory,
    )


REPOSITORY_ROOT = Path(__file__).resolve().parents[2]

DECLARATIONS = REPOSITORY_ROOT / "data/lua/types/ccb_api_v5.d.lua"

MANIFEST_SCHEMA = REPOSITORY_ROOT / "data/lua/manifest.schema.json"

NATIVE_INVENTORY = (
    REPOSITORY_ROOT / "data/lua/reference/ccb_native_inventory.json"
)

DEFAULT_OUTPUT = (
    REPOSITORY_ROOT / "data/lua/reference/ccb_public_api_v5.json"
)

DEFAULT_COVERAGE = (
    REPOSITORY_ROOT / "data/lua/reference/ccb_public_api_v5_coverage.json"
)

CONTRACT_SCHEMA = (
    REPOSITORY_ROOT / "data/lua/reference/ccb_public_api_v5.schema.json"
)

COVERAGE_SCHEMA = (
    REPOSITORY_ROOT /
    "data/lua/reference/ccb_public_api_v5_coverage.schema.json"
)

CAPABILITY_TOKEN_MAP = {
    "require_actions": "game.actions",
    "require_action": "game.actions",
    "require_dangerous": "game.actions.dangerous",
    "require_callback": "game.callbacks",
    "require_hook": "game.hooks",
    "require_native_events": "events",
    "require_read": "game.read",
    "require_values": "game.read",
    "require_write": "game.write",
}

NAMESPACE_CAPABILITIES = {
    "events": ["events"],
    "game.action_menu": ["ui.pages"],
    "game.actions": ["game.actions"],
    "game.callbacks": ["game.callbacks"],
    "game.definitions": ["registry.read"],
    "game.hooks": ["game.hooks"],
    "game.mapgen": ["events", "game.hooks", "game.read"],
    "game.native_events": ["events", "game.read"],
    "game.relocation": ["game.actions.dangerous", "game.write"],
    "game.sidebar": ["ui.pages"],
    "game.state_get": ["state.character"],
    "game.state_set": ["state.character"],
    "game.targeting": ["game.actions"],
    "modules.import": ["modules.import"],
    "registry": ["registry.read"],
    "scheduler": ["scheduler"],
    "services.call": ["services.consume"],
    "services.provide": ["services.provide"],
    "sidebar": ["ui.pages"],
    "state.character": ["state.character"],
    "state.page": ["state.page"],
    "state.world": ["state.world"],
    "ui": ["ui.pages"],
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

OPERATOR_SIGNATURES = {
    "__add": (["self", "other"], ["same type"]),
    "__div": (["self", "divisor"], ["same type"]),
    "__eq": (["self", "other"], ["boolean"]),
    "__le": (["self", "other"], ["boolean"]),
    "__lt": (["self", "other"], ["boolean"]),
    "__mul": (["self", "factor"], ["same type"]),
    "__sub": (["self", "other"], ["same type"]),
    "__tostring": (["self"], ["string"]),
    "__unm": (["self"], ["same type"]),
}

def relative(path: Path) -> str:
    try:
        return path.relative_to(REPOSITORY_ROOT).as_posix()
    except ValueError:
        # Parser regression tests intentionally use temporary files.
        return path.as_posix()

def line_number(contents: str, offset: int) -> int:
    return contents.count("\n", 0, offset) + 1
