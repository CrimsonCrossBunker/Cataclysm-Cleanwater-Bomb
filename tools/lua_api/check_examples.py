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


def tracked_lua_files() -> list[Path]:
    result = subprocess.run(
        ["git", "ls-files", "-z", "--", "data/lua"],
        cwd=REPOSITORY_ROOT,
        check=True,
        capture_output=True,
    )
    names = result.stdout.decode("utf-8").split("\0")
    return [
        REPOSITORY_ROOT / name
        for name in names
        if name.endswith(".lua")
    ]


def check_lua_syntax(require_luac: bool) -> tuple[int, str]:
    executable = shutil.which("luac")
    if executable is None:
        if require_luac:
            raise RuntimeError("luac is required but was not found")
        return 0, "not-installed"
    files = tracked_lua_files()
    if not files:
        raise RuntimeError("no tracked Lua files were found")
    for path in files:
        result = subprocess.run(
            [executable, "-p", str(path)],
            cwd=REPOSITORY_ROOT,
            capture_output=True,
            text=True,
        )
        if result.returncode != 0:
            details = (result.stderr or result.stdout).strip()
            raise RuntimeError(f"Lua syntax failed for {path}: {details}")
    version = subprocess.run(
        [executable, "-v"], capture_output=True, text=True, check=True
    )
    return len(files), (version.stdout or version.stderr).strip()


def check(require_luac: bool = False) -> dict[str, object]:
    validate_manifest(BUILTIN_MANIFEST)
    example = validate_example_mod()
    lua_files, luac_version = check_lua_syntax(require_luac)
    return {
        "manifests": 2,
        "example_lua_files": example["lua_files"],
        "example_contract_symbols": example["contract_symbols"],
        "tracked_lua_files": lua_files,
        "luac": luac_version,
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--require-luac",
        action="store_true",
        help="fail instead of reporting when the Lua compiler is unavailable",
    )
    arguments = parser.parse_args()
    summary = check(arguments.require_luac)
    print(
        "Lua examples verified: "
        f"{summary['manifests']} manifests, "
        f"{summary['example_lua_files']} example source files, "
        f"{summary['example_contract_symbols']} public symbol references, "
        f"{summary['tracked_lua_files']} tracked Lua syntax checks "
        f"({summary['luac']})"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
