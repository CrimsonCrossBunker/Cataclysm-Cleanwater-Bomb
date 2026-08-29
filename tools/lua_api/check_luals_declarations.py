#!/usr/bin/env python3
"""Check the LuaLS declarations for the sole Lua-first Platform contract."""

from __future__ import annotations

import argparse
import re
from pathlib import Path


REPOSITORY_ROOT = Path(__file__).resolve().parents[2]
DEFAULT_DECLARATIONS = REPOSITORY_ROOT / "data/lua/types/ccb_platform_v1.d.lua"

CLASS_PATTERN = re.compile(
    r"^---@class\s+([A-Za-z_][A-Za-z0-9_]*)(?:\s*:\s*[^\r\n]+)?$",
    re.MULTILINE,
)
METHOD_PATTERN = re.compile(
    r"^function\s+([A-Za-z_][A-Za-z0-9_]*)[:.]([A-Za-z_][A-Za-z0-9_]*)\s*\(([^)]*)\)",
    re.MULTILINE,
)
FIELD_PATTERN = re.compile(
    r"^---@field\s+([A-Za-z_][A-Za-z0-9_]*)\??\s+([^\s]+)",
    re.MULTILINE,
)


def check(path: Path) -> dict[str, int]:
    contents = path.read_text(encoding="utf-8")
    if "Lua-first Platform v1" not in contents:
        raise RuntimeError(f"{path} is not a Platform v1 declaration file")
    forbidden = ("api_version", "capabilities", "manifest.json", "game.")
    for token in forbidden:
        if token in contents:
            raise RuntimeError(
                f"{path} retains a forbidden Platform declaration token: {token}"
            )

    classes = CLASS_PATTERN.findall(contents)
    if len(classes) != len(set(classes)):
        raise RuntimeError(f"{path} repeats a LuaLS class declaration")

    methods = METHOD_PATTERN.findall(contents)
    identities = [(owner, name) for owner, name, _ in methods]
    if len(identities) != len(set(identities)):
        raise RuntimeError(f"{path} repeats a LuaLS method declaration")
    for owner, name, parameters in methods:
        values = [value.strip() for value in parameters.split(",") if value.strip()]
        if len(values) != len(set(values)):
            raise RuntimeError(f"{path} repeats a parameter in {owner}.{name}")
        if any(value in {"function", "local", "end", "repeat", "until"} for value in values):
            raise RuntimeError(f"{path} uses a Lua reserved parameter in {owner}.{name}")

    fields = FIELD_PATTERN.findall(contents)
    if len(fields) != len({name for name, _ in fields}):
        # Fields repeat legitimately across different classes; validate them
        # per class below rather than globally.
        for match in CLASS_PATTERN.finditer(contents):
            next_class = CLASS_PATTERN.search(contents, match.end())
            block = contents[match.end(): next_class.start() if next_class else None]
            names = [name for name, _ in FIELD_PATTERN.findall(block)]
            if len(names) != len(set(names)):
                raise RuntimeError(f"{path} repeats a field in {match.group(1)}")

    if re.search(r"^---@param\s+options\??\s+table(?:\s|$)", contents, re.MULTILINE):
        raise RuntimeError(f"{path} uses an untyped options table")

    required = {"CcbPlatformContent", "CcbPlatformRuntime"}
    missing = sorted(required - set(classes))
    if missing:
        raise RuntimeError(f"{path} omits required Platform classes: {missing}")

    runtime_source = (REPOSITORY_ROOT / "src/lua_platform_runtime.cpp").read_text(encoding="utf-8")
    loader_source = (REPOSITORY_ROOT / "src/lua_platform_loader.cpp").read_text(encoding="utf-8")
    for marker in ('ccb["runtime"]', 'ccb["dialogue"]', 'ccb["services"]'):
        if marker not in runtime_source:
            raise RuntimeError(f"native Platform registration is missing {marker}")
    has_mod_definition_registration = (
        'ccb["ModDefinition"]' in loader_source or
        re.search(r'\bset_function\(\s*"ModDefinition"\s*,', loader_source)
        is not None
    )
    if not has_mod_definition_registration:
        raise RuntimeError("native Platform ModDefinition registration is missing")

    return {
        "classes": len(classes),
        "methods": len(methods),
        "fields": len(fields),
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--declarations", type=Path, default=DEFAULT_DECLARATIONS)
    args = parser.parse_args()
    summary = check(args.declarations)
    print(
        "LuaLS Platform declarations: "
        f"{summary['classes']} classes, {summary['methods']} methods, "
        f"{summary['fields']} fields"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
