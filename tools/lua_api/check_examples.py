#!/usr/bin/env python3
"""Validate Lua syntax, manifests, and the complete API v5 example Mod."""

from __future__ import annotations

import argparse
import json
import shutil
import subprocess
from pathlib import Path

try:
    from .generate_public_contract import (
        DEFAULT_OUTPUT,
        MANIFEST_SCHEMA,
        REPOSITORY_ROOT,
    )
except ImportError:
    from generate_public_contract import (  # type: ignore
        DEFAULT_OUTPUT,
        MANIFEST_SCHEMA,
        REPOSITORY_ROOT,
    )


BUILTIN_MANIFEST = REPOSITORY_ROOT / "data/lua/manifest.json"
EXAMPLE_ROOT = REPOSITORY_ROOT / "data/lua/examples/api_v5_mod"
EXAMPLE_MANIFEST = EXAMPLE_ROOT / "lua/manifest.json"
EXAMPLE_MODINFO = EXAMPLE_ROOT / "modinfo.json"
EXAMPLE_CONTRACT_IDS = {
    "events.emit",
    "events.on",
    "game.action_menu.register",
    "game.actions.context_snapshot",
    "game.add_msg",
    "game.hooks.on",
    "game.native_events.on",
    "game.time.snapshot",
    "game.weather.current",
    "i18n.gettext",
    "modules.source_id",
    "registry.list",
    "scheduler.after",
    "scheduler.now",
    "services.call",
    "services.provide",
    "sidebar.register_widget",
    "state.character.get",
    "state.character.set",
    "state.page.get",
    "state.page.set",
    "ui.open",
    "ui.page",
}


def load_json(path: Path) -> object:
    return json.loads(path.read_text(encoding="utf-8"))


def validate_manifest(path: Path) -> dict[str, object]:
    schema = load_json(MANIFEST_SCHEMA)
    manifest = load_json(path)
    if not isinstance(schema, dict) or not isinstance(manifest, dict):
        raise RuntimeError(f"{path} and its Schema must contain JSON objects")
    try:
        import jsonschema
    except ImportError:
        required = schema.get("required", [])
        missing = [name for name in required if name not in manifest]
        if missing:
            raise RuntimeError(f"{path} lacks required fields {missing}")
        capabilities = manifest.get("capabilities")
        allowed = schema["properties"]["capabilities"]["items"]["enum"]
        if (not isinstance(capabilities, list) or
                not set(capabilities) <= set(allowed)):
            raise RuntimeError(f"{path} has invalid capabilities")
    else:
        jsonschema.Draft202012Validator.check_schema(schema)
        jsonschema.validate(manifest, schema)
    return manifest


def validate_example_mod() -> dict[str, int]:
    manifest = validate_manifest(EXAMPLE_MANIFEST)
    modinfo = load_json(EXAMPLE_MODINFO)
    if not isinstance(modinfo, list) or len(modinfo) != 1:
        raise RuntimeError(
            "example modinfo.json must contain exactly one MOD_INFO")
    entry = modinfo[0]
    if not isinstance(entry, dict) or entry.get("type") != "MOD_INFO":
        raise RuntimeError(
            "example modinfo.json does not contain a MOD_INFO object")
    if entry.get("id") != manifest.get("id"):
        raise RuntimeError("example Mod id and Lua manifest id must match")
    if entry.get("version") != manifest.get("version"):
        raise RuntimeError("example Mod and Lua manifest versions must match")
    if not (EXAMPLE_ROOT / "lua/main.lua").is_file():
        raise RuntimeError("example Mod lacks lua/main.lua")
    if not (EXAMPLE_ROOT / "lua/lib/model.lua").is_file():
        raise RuntimeError("example Mod lacks its source-local module")
    contract = load_json(DEFAULT_OUTPUT)
    if not isinstance(contract, dict):
        raise RuntimeError("public contract inventory must be an object")
    contract_entries = {
        entry["id"]: entry
        for section in ("functions", "methods")
        for entry in contract.get(section, [])
        if isinstance(entry, dict) and isinstance(entry.get("id"), str)
    }
    missing_symbols = sorted(EXAMPLE_CONTRACT_IDS - set(contract_entries))
    if missing_symbols:
        raise RuntimeError(
            f"example references missing public symbols {missing_symbols}"
        )
    capabilities = set(manifest.get("capabilities", []))
    missing_capabilities = {
        identity: sorted(
            set(contract_entries[identity].get("capabilities", [])) -
            capabilities
        )
        for identity in sorted(EXAMPLE_CONTRACT_IDS)
        if set(contract_entries[identity].get("capabilities", [])) -
        capabilities
    }
    if missing_capabilities:
        raise RuntimeError(
            "example manifest lacks capabilities for its public calls: "
            f"{missing_capabilities}"
        )
    return {
        "modinfo_entries": len(modinfo),
        "capabilities": len(manifest["capabilities"]),
        "lua_files": 2,
        "contract_symbols": len(EXAMPLE_CONTRACT_IDS),
    }


if __name__ == "__main__":
    raise SystemExit(main())